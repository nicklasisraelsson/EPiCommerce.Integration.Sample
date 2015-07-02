using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using Microsoft.SqlServer.Management.Common;
using Microsoft.SqlServer.Management.Smo;
using System.Collections.Generic;
using Microsoft.Build.Utilities;
using System.Diagnostics;

namespace EPiCommerce.Integration.Sample.TestSupport
{
    public class Database
    {
        private const string ConnectionStringToMasterDb = "Data Source=(local);Database=master;Integrated Security=True";

        private static readonly Dictionary<string, string> ConnectionStringToDbScriptMap = new Dictionary<string, string>{
            {"EPiServerDB", "EPiServer.Cms.Core.sql"},
            {"EcfSqlConnection", "EPiServer.Commerce.Core.sql"}
        };

        private static string TargetDirectory { get; set; }

        public static void Initialize(string applicationPath)
        {
            var databaseScripts = new DatabaseScripts(applicationPath);
            databaseScripts.CopySqlScripts();
            DropDatabases();
            CreateDatabases();
        }

        public static void CreateBackups(string targetDirectory)
        {
            if (String.IsNullOrEmpty(targetDirectory))
            {
                throw new ArgumentNullException("targetDirectory");
            }

            TargetDirectory = targetDirectory;

            ExecuteOnDatabases(CreateBackup);
        }

        public static void RestoreFromBackups()
        {
            ExecuteOnDatabases(RestoreFromBackup);
        }

        public static void DeleteBackups()
        {
            ExecuteOnDatabases(DeleteBackup);
        }

        private static void CreateDatabases()
        {
            ExecuteOnDatabases(CreateDatabase);
            RunUpgradeScriptsOnCmsDatabase();
            ApplyAspNetMembershipProviderScripts();
            ApplyWindowsWorkflowFoundationScripts();
        }

        /// <summary>
        /// Commerce provides required updates to CMS database. We need to apply them.
        /// </summary>
        private static void RunUpgradeScriptsOnCmsDatabase()
        {
            var upgradeScriptDirectoryPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory,
                                             @"sql\upgrade\");
            var upgradeScripts = Directory.EnumerateFiles(upgradeScriptDirectoryPath);
            var cmsDbInfo = GetDbInfo("EPiServerDB");
            using (var connection = new SqlConnection(cmsDbInfo.ConnectionString))
            {
                connection.Open();
                foreach (var upgradeScript in upgradeScripts)
                {
                    var upgradeDbCmd = File.ReadAllText(upgradeScript);
                    ExecuteNonQuery(connection, upgradeDbCmd);
                }
                connection.Close();
            }
        }

        private static void CreateDatabase(string connectionStringId)
        {
            var dbInfo = GetDbInfo(connectionStringId);
            using (var connection = new SqlConnection(ConnectionStringToMasterDb))
            {
                connection.Open();
                CreateDb(dbInfo, connection);
                SetupUser(dbInfo, connection);
                connection.Close();
            }
            using (var connection = new SqlConnection(dbInfo.ConnectionString))
            {
                connection.Open();
                AddDbSchema(connection, connectionStringId);
                connection.Close();
            }
        }

        private static void CreateDb(SqlConnectionStringBuilder dbInfo, SqlConnection connection)
        {
            var createDbCommand = string.Format(@"
                    IF EXISTS (SELECT * FROM sys.databases WHERE NAME='{0}')
                    BEGIN
                        ALTER DATABASE {0} SET SINGLE_USER WITH ROLLBACK IMMEDIATE
                        DROP DATABASE {0};
                    END
                    CREATE DATABASE {0}", dbInfo.InitialCatalog);
            ExecuteNonQuery(connection, createDbCommand);
        }

        private static void SetupUser(SqlConnectionStringBuilder dbInfo, SqlConnection connection)
        {
            AddLogin(dbInfo, connection);
            AddUser(dbInfo, connection);
            SetUserAsDbOwner(dbInfo, connection);
        }

        private static void AddLogin(SqlConnectionStringBuilder dbInfo, SqlConnection connection)
        {
            var addLoginCommand = string.Format(@"
                    IF NOT EXISTS (SELECT loginname FROM master.dbo.syslogins 
                        WHERE name = '{0}')
                    EXEC sp_addlogin @loginame='{0}', @passwd='{1}', @defdb='{2}'",
                                                dbInfo.UserID,
                                                dbInfo.Password,
                                                dbInfo.InitialCatalog);
            ExecuteNonQuery(connection, addLoginCommand);
        }

        private static void AddUser(SqlConnectionStringBuilder dbInfo, SqlConnection connection)
        {
            var addUserCommand = string.Format(@"
                    USE [{0}];
                    EXEC sp_adduser @loginame='{1}'", dbInfo.InitialCatalog, dbInfo.UserID);
            ExecuteNonQuery(connection, addUserCommand);
        }

        private static void SetUserAsDbOwner(SqlConnectionStringBuilder dbInfo, SqlConnection connection)
        {
            var addDbOwnerRoleCommand = string.Format(@"
                    USE [{0}];
                    EXEC sp_addrolemember N'db_owner', N'{1}'", dbInfo.InitialCatalog, dbInfo.UserID);
            ExecuteNonQuery(connection, addDbOwnerRoleCommand);
        }

        private static void AddDbSchema(SqlConnection connection, string connectionStringId)
        {
            var dbScriptName = ConnectionStringToDbScriptMap[connectionStringId];
            var schemaPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory,
                                             @"sql\" + dbScriptName);
            var createDbCmd = File.ReadAllText(schemaPath);
            ExecuteNonQuery(connection, createDbCmd);
        }

        private static SqlConnectionStringBuilder GetDbInfo(string connectionStringId)
        {
            var connectionString = ConfigurationManager.ConnectionStrings[connectionStringId].ConnectionString;
            return new SqlConnectionStringBuilder(connectionString);
        }

        private static void ExecuteNonQuery(SqlConnection connection, string commandText)
        {
            var server = new Server(new ServerConnection(connection));
            server.ConnectionContext.ExecuteNonQuery(commandText);
        }

        private static void DropDatabases()
        {
            ExecuteOnDatabases(DropDatabase);
        }

        private static void DropDatabase(string connectionStringId)
        {
            var epiDbInfo = GetDbInfo(connectionStringId);
            SqlConnection.ClearAllPools();

            using (var connection = new SqlConnection(ConnectionStringToMasterDb))
            {
                connection.Open();
                DropDb(epiDbInfo, connection);
                DropUser(epiDbInfo, connection);
                connection.Close();
            }
            SqlConnection.ClearAllPools();
        }

        private static void DropDb(SqlConnectionStringBuilder epiDbInfo, SqlConnection connection)
        {
            var dropDbCommand = string.Format(@"
                    IF EXISTS (SELECT * FROM sys.databases WHERE NAME='{0}')
                    BEGIN
                        ALTER DATABASE {0} SET SINGLE_USER WITH ROLLBACK IMMEDIATE
                        DROP DATABASE {0};
                    END", epiDbInfo.InitialCatalog);
            ExecuteNonQuery(connection, dropDbCommand);
        }

        private static void DropUser(SqlConnectionStringBuilder epiDbInfo, SqlConnection connection)
        {
            var dropUserCommand = string.Format(@"
                    IF EXISTS (SELECT loginname FROM master.dbo.syslogins 
                        WHERE name = '{0}')
                    EXEC sp_droplogin @loginame='{0}'", epiDbInfo.UserID);
            ExecuteNonQuery(connection, dropUserCommand);
        }

        private static void ExecuteOnDatabases(Action<string> action)
        {
            foreach (var database in ConnectionStringToDbScriptMap.Keys)
            {
                action(database);
            }
            SqlConnection.ClearAllPools();
        }

        private static void CreateBackup(string connectionStringId)
        {
            var dbInfo = GetDbInfo(connectionStringId);

            using (var connection = new SqlConnection(dbInfo.ConnectionString))
            {
                connection.Open();

                var filePath = GetBackupFilePath(dbInfo.InitialCatalog);

                var command = new SqlCommand(string.Format(@"
                    BACKUP DATABASE {1} TO DISK = '{0}'
                    WITH FORMAT,
                          MEDIANAME = '{1}_backup',
                          NAME = 'Full Backup of {1}';
                    
                ", filePath,
                dbInfo.InitialCatalog), connection);

                command.ExecuteNonQuery();

                connection.Close();
            }
        }

        private static string GetBackupFilePath(string originalDbName)
        {
            return TargetDirectory + "\\" + originalDbName + ".bak";
        }

        private static void RestoreFromBackup(string connectionStringId)
        {
            var epiDbInfo = GetDbInfo(connectionStringId);
            using (var connection = new SqlConnection(ConnectionStringToMasterDb))
            {
                connection.Open();

                var filePath = GetBackupFilePath(epiDbInfo.InitialCatalog);

                var command = new SqlCommand(string.Format(@"
                ALTER DATABASE {1} SET single_user WITH ROLLBACK IMMEDIATE;
                RESTORE DATABASE {1} FROM DISK = '{0}' WITH REPLACE;
                ALTER DATABASE {1} SET MULTI_USER WITH NO_WAIT;
                ", filePath,
                epiDbInfo.InitialCatalog), connection);

                command.ExecuteNonQuery();

                connection.Close();
            }
        }

        private static void DeleteBackup(string connectionStringId)
        {
            var epiDbInfo = GetDbInfo(connectionStringId);
            var filePath = GetBackupFilePath(epiDbInfo.InitialCatalog);
            File.Delete(filePath);
        }

        private static void ApplyAspNetMembershipProviderScripts()
        {
            var frameworkPath =
               ToolLocationHelper.GetPathToDotNetFramework(TargetDotNetFrameworkVersion.Version20, DotNetFrameworkArchitecture.Bitness32);

            var command =
                Path.Combine(frameworkPath, "aspnet_regsql.exe");

            var database =
                GetDbInfo("EPiServerDB");

            var arguments =
                string.Format("-S {0} -d {1} -E -A all", database.DataSource, database.InitialCatalog);

            var process = new Process
            {
                StartInfo = new ProcessStartInfo()
                {
                    Arguments = arguments,
                    CreateNoWindow = true,
                    FileName = command,
                    UseShellExecute = false
                }
            };

            process.Start();
            process.WaitForExit();
        }

        private static void ApplyWindowsWorkflowFoundationScripts()
        {
            var workflowFoundationScripts = new[]
            {
                "SqlPersistenceService_Schema",
                "SqlPersistenceService_Logic"
            };

            var scriptsPath =
                Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "sql");

            var cmsDatabase = GetDbInfo("EPiServerDB");

            using (var connection = new SqlConnection(ConnectionStringToMasterDb))
            {
                connection.Open();
                connection.ChangeDatabase(cmsDatabase.InitialCatalog);

                foreach (var workflowFoundationScript in workflowFoundationScripts)
                {
                    var scriptPath =
                        Path.Combine(scriptsPath, workflowFoundationScript + ".sql");

                    var script = File.ReadAllText(scriptPath);

                    ExecuteNonQuery(connection, script);
                }

                connection.Close();
            }
        }
    }
}
