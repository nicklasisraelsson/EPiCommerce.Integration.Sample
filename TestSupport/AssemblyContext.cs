using System;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Xml.Linq;
using EPiServer;
using EPiServer.Core;
using EPiServer.DataAccess;
using EPiServer.Licensing;
using EPiServer.Security;
using EPiServer.ServiceLocation;
using EPiServer.Web;
using Machine.Specifications;
using Mediachase.BusinessFoundation.Data;
using Mediachase.Commerce.Assets;
using Mediachase.Commerce.Orders;

namespace EPiCommerce.Integration.Sample.TestSupport
{
    public class AssemblyContext : IAssemblyContext
    {
        public void OnAssemblyStart()
        {
            var applicationPath = AppDomain.CurrentDomain.SetupInformation.ApplicationBase;
            SetupDatabase(applicationPath);
            EPiServerInitializer.Initialize(applicationPath);
            DataContext.Current = new DataContext(ConfigurationManager.ConnectionStrings["EcfSqlConnection"].ConnectionString);
            // Auto install the meta model
            var thisCallIsOnlyUsedToMakeSureTheMetaDataModuleIsAutomaticallyInstalled = AssetContext.Current;

            // We need to make sure the OrderContext.Current has been executed before doing a snapshot.
            var thisCallIsOnlyUsedToMakeSureTheOrderContextIsAutomaticallyInstalled = OrderContext.Current;
            CatalogTestHelper.Initialize();
            Database.CreateBackups(applicationPath);
        }

        private static void SetupDatabase(string applicationPath)
        {
            CopySqlScripts(applicationPath);
            Database.Initialize();
        }

        private static void CopySqlScripts(string applicationPath)
        {
            var sqlDirectory = Path.Combine(applicationPath, "sql");
            if (!Directory.Exists(sqlDirectory))
            {
                Directory.CreateDirectory(sqlDirectory);
            }
            CopyCmsDatabase(applicationPath, sqlDirectory);
            CopyCommerceDatabase(applicationPath, sqlDirectory);
            CopyUpgradeScripts(applicationPath, sqlDirectory);
        }

        private static void CopyCmsDatabase(string applicationPath, string sqlDirectory)
        {
            var cmsVersion = GetPackageVersion(applicationPath, "EPiServer.CMS.Core");
            File.Copy(
                Path.Combine(applicationPath,
                             @"..\..\packages\EPiServer.CMS.Core." + cmsVersion + @"\tools\EPiServer.Cms.Core.sql"),
                Path.Combine(sqlDirectory, "EPiServer.Cms.Core.sql"), true);
        }

        private static void CopyCommerceDatabase(string applicationPath, string sqlDirectory)
        {
            var commerceVersion = GetPackageVersion(applicationPath, "EPiServer.Commerce.Core");
            File.Copy(
                Path.Combine(applicationPath,
                             @"..\..\packages\EPiServer.Commerce.Core." + commerceVersion + @"\tools\EPiServer.Commerce.sql"),
                Path.Combine(sqlDirectory, "EPiServer.Commerce.sql"), true);
        }

        private static void CopyUpgradeScripts(string applicationPath, string sqlDirectory)
        {
            var upgradeScriptsDestinationDirectoryPath = Path.Combine(sqlDirectory, "upgrade");
            if (!Directory.Exists(upgradeScriptsDestinationDirectoryPath))
            {
                Directory.CreateDirectory(upgradeScriptsDestinationDirectoryPath);
            }
            var commerceVersion = GetPackageVersion(applicationPath, "EPiServer.Commerce.Core");
            var upgradeScriptsSourcePath = Path.Combine(applicationPath,
                             @"..\..\packages\EPiServer.Commerce.Core." + commerceVersion + @"\tools\epiupdates_CMS\sql\");
            var sourceDirectory = new DirectoryInfo(upgradeScriptsSourcePath);
            var upgradeScripts = sourceDirectory.EnumerateFiles();
            foreach (var upgradeScript in upgradeScripts)
            {
                File.Copy(upgradeScript.FullName,
                     Path.Combine(upgradeScriptsDestinationDirectoryPath, upgradeScript.Name), true);
            }
        }

        private static string GetPackageVersion(string applicationPath, string packageId)
        {
            var packages = XDocument.Load(Path.Combine(applicationPath, "packages.config"));
            return packages.Descendants("package")
                        .Where(element => element.Attribute("id").Value == packageId)
                        .Select(cmsElement => cmsElement.Attribute("version").Value)
                        .Single();
        }

        public void OnAssemblyComplete()
        {
            Database.DeleteBackups();
            if (DataContext.Current != null)
            {
                DataContext.Current.Dispose();
                DataContext.Current = null;
            }
        }
    }
}
