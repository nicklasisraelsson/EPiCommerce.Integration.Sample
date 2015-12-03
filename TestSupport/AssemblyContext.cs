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
using Mediachase.BusinessFoundation.Data;
using Mediachase.Commerce.Assets;
using Mediachase.Commerce.Orders;
using Microsoft.Build.Utilities;

namespace EPiCommerce.Integration.Sample.TestSupport
{
    /// <summary>
    /// Shamelessly stolen from http://stackoverflow.com/questions/13829737/xunit-run-code-before-and-after-all-tests/14950904#14950904
    /// </summary>
    public sealed class AssemblyContext
    {
        private static readonly Lazy<AssemblyContext> _lazyInstance =
            new Lazy<AssemblyContext>(() => new AssemblyContext());

        private bool _initialized;

        public static AssemblyContext Current { get { return _lazyInstance.Value; } }

        private AssemblyContext() { }

        public void Initialize()
        {
            if (_initialized)
            {
                return;
            }
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
            _initialized = true;
        }

        ~AssemblyContext()
        {
            Dispose();
        }

        public void Dispose()
        {
            GC.SuppressFinalize(this);
            Database.DeleteBackups();
            if (DataContext.Current != null)
            {
                DataContext.Current.Dispose();
                DataContext.Current = null;
            }
        }
    }
}