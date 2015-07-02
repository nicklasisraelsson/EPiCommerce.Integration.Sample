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
using Microsoft.Build.Utilities;

namespace EPiCommerce.Integration.Sample.TestSupport
{
    public class AssemblyContext : IAssemblyContext
    {
        public void OnAssemblyStart()
        {
            var applicationPath = AppDomain.CurrentDomain.SetupInformation.ApplicationBase;
            Database.Initialize(applicationPath);
            EPiServerInitializer.Initialize(applicationPath);
            DataContext.Current = new DataContext(ConfigurationManager.ConnectionStrings["EcfSqlConnection"].ConnectionString);
            // Auto install the meta model
            var thisCallIsOnlyUsedToMakeSureTheMetaDataModuleIsAutomaticallyInstalled = AssetContext.Current;

            // We need to make sure the OrderContext.Current has been executed before doing a snapshot.
            var thisCallIsOnlyUsedToMakeSureTheOrderContextIsAutomaticallyInstalled = OrderContext.Current;
            CatalogTestHelper.Initialize();
            Database.CreateBackups(applicationPath);
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
