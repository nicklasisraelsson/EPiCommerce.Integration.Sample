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
            if (!File.Exists(Path.Combine(applicationPath, "License.config")))
            {
                throw new LicenseException("You need to have a Licence.config to run these integration tests. " +
                                           "Put a License.config in the project root and it will be copied when the project is built.");
            }
            SetupDatabase(applicationPath);
            EPiServerInitializer.Initialize(applicationPath);
            DataContext.Current = new DataContext(ConfigurationManager.ConnectionStrings["EcfSqlConnection"].ConnectionString);
            // Auto install the meta model
            var thisCallIsOnlyUsedToMakeSureTheMetaDataModuleIsAutomaticallyInstalled = AssetContext.Current;

            // We need to make sure the OrderContext.Current has been executed before doing a snapshot.
            var thisCallIsOnlyUsedToMakeSureTheOrderContextIsAutomaticallyInstalled = OrderContext.Current;
            CatalogTestHelper.Initialize();
            Database.CreateSnapshots(applicationPath);
        }

        private static void SetupDatabase(string applicationPath)
        {
            CopyCmsSqlScript(applicationPath);
            Database.Initialize();
        }

        private static void CopyCmsSqlScript(string applicationPath)
        {
            var sqlDirectory = Path.Combine(applicationPath, "sql");
            if (!Directory.Exists(sqlDirectory))
            {
                Directory.CreateDirectory(sqlDirectory);
            }
            var packages = XDocument.Load(Path.Combine(applicationPath, "packages.config"));
            var cmsVersion =
                packages.Descendants("package")
                        .Where(element => element.Attribute("id").Value == "EPiServer.CMS.Core")
                        .Select(cmsElement => cmsElement.Attribute("version").Value)
                        .Single();
            File.Copy(
                Path.Combine(applicationPath,
                             @"..\..\packages\EPiServer.CMS.Core." + cmsVersion + @"\tools\EPiServer.Cms.Core.sql"),
                Path.Combine(sqlDirectory, "EPiServer.Cms.Core.sql"), true);
        }

        public void OnAssemblyComplete()
        {
            Database.DropSnapshots();
            if (DataContext.Current != null)
            {
                DataContext.Current.Dispose();
                DataContext.Current = null;
            }
        }
    }
}
