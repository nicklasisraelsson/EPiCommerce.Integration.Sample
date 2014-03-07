using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using Microsoft.SqlServer.Management.Common;
using Microsoft.SqlServer.Management.Smo;

namespace EPiCommerce.Integration.Sample.TestSupport
{
    public class Database
    {
        private const string ConnectionStringToMasterDb = "Data Source=(local);Database=master;Integrated Security=True";

        public static void Initialize()
        {
            DropSnapshots();
            DropCmsDatabase();
            DropCommerceDatabase();
            CreateCmsDatabase();
            CreateCommerceDatabase();
        }

        private static void CreateCmsDatabase()
        {
            CreateDatabase("EPiServerDB");
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
                AddCmsDbSchema(connection);
                AddEPiServerCommonDbSchema(connection);
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

        private static void AddCmsDbSchema(SqlConnection connection)
        {
            var cmsSchemaPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory,
                                             @"sql\EPiServer.Cms.Core.sql");
            var createDbCmd = File.ReadAllText(cmsSchemaPath);
            ExecuteNonQuery(connection, createDbCmd);
        }

        private static void AddEPiServerCommonDbSchema(SqlConnection connection)
        {
            var commonDb = File.ReadAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory,
                                                         @"sql\EPiServerCommon.sql"));
            ExecuteNonQuery(connection, commonDb);
        }

        private static void CreateCommerceDatabase()
        {
            using (var connection = new SqlConnection(ConnectionStringToMasterDb))
            {
                connection.Open();
                var createScriptPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory,
                                                    @"sql\ECFDatabase_Create.sql");
                var createEcfDb = File.ReadAllText(createScriptPath);
                ExecuteNonQuery(connection, createEcfDb);
            }
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

        private static void DropCmsDatabase()
        {
            DropDatabase("EPiServerDB");
        }

        private static void DropCommerceDatabase()
        {
            DropDatabase("EcfSqlConnection");
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

        private static string SnapshotDirectory { get; set; }

        public static void CreateSnapshots(string snapshotDirectory)
        {
            SnapshotDirectory = snapshotDirectory;

            var epiDbInfo = GetDbInfo("EPiServerDB");
            var commerceDbInfo = GetDbInfo("EcfSqlConnection");

            CreateSnapshot(epiDbInfo);
            CreateSnapshot(commerceDbInfo);
        }

        private static void CreateSnapshot(SqlConnectionStringBuilder epiDbInfo)
        {
            var snapshotName = epiDbInfo.InitialCatalog + "_snapshot";
            using (var con = new SqlConnection(ConnectionStringToMasterDb))
            {
                con.Open();

                var snapshotPath = SnapshotDirectory + "\\" + snapshotName + ".ss";

                var createSnapshotCmd = string.Format(@"
                    IF EXISTS (SELECT * FROM sys.databases WHERE NAME='{0}') 
                    BEGIN
                        DROP DATABASE {0};
                    END
                    CREATE DATABASE {0} ON
                    ( NAME = {2}, FILENAME = '{3}')
                    AS SNAPSHOT OF {1}
                ", snapshotName,
                epiDbInfo.InitialCatalog,
                epiDbInfo.InitialCatalog, snapshotPath);

                ExecuteNonQuery(con, createSnapshotCmd);

                con.Close();

                SqlConnection.ClearAllPools();
            }
        }

        public static void RestoreFromSnapshot()
        {
            var epiDbInfo = GetDbInfo("EPiServerDB");
            var commerceDbInfo = GetDbInfo("EcfSqlConnection");

            RestoreFromSnapshot(epiDbInfo);
            RestoreFromSnapshot(commerceDbInfo);
            // since full-text indexing is not supported on DB snapshot, we need to create MetaDataFullTextQueriesCatalog to prevent error.
            CreateMetaDataFullTextQueriesCatalog(commerceDbInfo.ConnectionString);
        }

        private static void CreateMetaDataFullTextQueriesCatalog(string connectionString)
        {
            using (var con = new SqlConnection(connectionString))
            {
                con.Open();
                ExecuteNonQuery(con, "create fulltext catalog MetaDataFullTextQueriesCatalog");
                con.Close();
                SqlConnection.ClearAllPools();
            }
        }

        private static void RestoreFromSnapshot(SqlConnectionStringBuilder epiDbInfo)
        {
            var snapshotName = epiDbInfo.InitialCatalog + "_snapshot";
            using (var con = new SqlConnection(ConnectionStringToMasterDb))
            {
                con.Open();

                var restoreCommand = string.Format(@"
                ALTER DATABASE {1} SET single_user WITH ROLLBACK IMMEDIATE;
                RESTORE DATABASE {1} FROM DATABASE_SNAPSHOT = '{0}';
                ALTER DATABASE {1} SET OFFLINE WITH ROLLBACK IMMEDIATE
                ALTER DATABASE {1} SET ONLINE
                ALTER DATABASE {1} SET MULTI_USER WITH NO_WAIT;
                ", snapshotName,epiDbInfo.InitialCatalog);

                ExecuteNonQuery(con, restoreCommand);

                con.Close();

                SqlConnection.ClearAllPools();
            }
        }

        public static void DropSnapshots()
        {
            var epiDbInfo = GetDbInfo("EPiServerDB");
            var commerceDbInfo = GetDbInfo("EcfSqlConnection");

            DropSnapshot(epiDbInfo);
            DropSnapshot(commerceDbInfo);
        }

        private static void DropSnapshot(SqlConnectionStringBuilder dbInfo)
        {
            var snapshotName = dbInfo.InitialCatalog + "_snapshot";
            using (var con = new SqlConnection(ConnectionStringToMasterDb))
            {
                con.Open();
                var dropCommand = string.Format(@"
                    IF EXISTS (SELECT * FROM sys.databases WHERE NAME='{0}') 
                    BEGIN
                        DROP DATABASE {0};
                    END", snapshotName);

                ExecuteNonQuery(con, dropCommand);

                con.Close();

                SqlConnection.ClearAllPools();
            }
        }
    }
}
