using EPiServer;
using EPiServer.Core;
using EPiServer.Data.Dynamic;
using EPiServer.DataAnnotations;
using EPiServer.Framework.Cache;
using EPiServer.Framework.Initialization;
using EPiServer.Security;
using EPiServer.ServiceLocation;
using EPiServer.Web;
using Mediachase.Commerce.Catalog;
using Mediachase.Commerce.Customers;
using Mediachase.Commerce.Initialization;
using Mediachase.Commerce.Marketing;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Security;
using StructureMap;
using System;
using System.Reflection;
using System.Threading;
using Xunit;
using InitializationModule = EPiServer.Framework.Initialization.InitializationModule;

namespace EPiCommerce.Integration.Sample.TestSupport
{
    public class TestBase : IClassFixture<TestFixture>
    {
        protected static ReferenceConverter ReferenceConverter
        {
            get { return ServiceLocator.Current.GetInstance<ReferenceConverter>(); }
        }

        protected static IContentRepository ContentRepository
        {
            get { return ServiceLocator.Current.GetInstance<IContentRepository>(); }
        }
    }

    public class TestFixture : IDisposable
    {
        public TestFixture()
        {
            WaitForFrameworkInitialization();
            RestoreBackups();
            PrincipalInfo.CurrentPrincipal = PrincipalInfo.CreatePrincipal("TestUser");
            new Global(); // The constructor in Global register the CMS routes.
        }

        private void WaitForFrameworkInitialization()
        {
            AssemblyContext.Current.Initialize();
        }

        public void Dispose()
        {
            ReInitializeCommerceInitializationModule();
            DataFactoryCache.Clear();
            CacheManager.Clear();
            ContentLanguageSettingsHandler.Clear();
            PermanentLinkMapStore.Clear();
            StoreDefinition.ClearCache();
            CatalogCache.Clear();
            CustomersCache.Clear();
            MarketingCache.Clear();
            OrderCache.Clear();
            SecurityCache.Clear();
            IObjectInstanceCache cache;
            if (ServiceLocator.Current.TryGetExistingInstance(out cache))
            {
                cache.Clear();
            }
        }

        private static void RestoreBackups()
        {
            for (int i = 0; i < 10; i++)
            {
                try
                {
                    Database.RestoreFromBackups();
                    break;
                }
                catch (Exception)
                {
                    if (i > 8)
                    {
                        throw;
                    }
                    Thread.Sleep(100);
                }
            }
        }

        /// <summary>
        /// Runs Uninitialize, ConfigureContainer, and Initialize on the class <see cref="CommerceInitialization"/>.
        /// </summary>
        /// <remarks>
        /// This is needed because EPiServer.Commerce have singletons that holds data. 
        /// When restoring the database, the data in the singelton will contain data from previous tests.
        /// That is why these tests needs to reinitialize EPiServer Commerce
        /// </remarks>
        private static void ReInitializeCommerceInitializationModule()
        {
            if (_engine == null)
            {
                var engineFiledInfo = typeof(InitializationModule).GetField("_engine", BindingFlags.Static | BindingFlags.NonPublic);
                if (engineFiledInfo == null)
                {
                    throw new InvalidOperationException(
                        "The class 'EPiServer.Framework.Initialization.InitializationModule' didn't contain a private static field with the name '_engine'. " +
                        "This field has been changed or removed. The initialization of the integration tests needs to be updated.");
                }

                _engine = (InitializationEngine)engineFiledInfo.GetValue(null);
            }

            if (_serviceConfigurationContext == null)
            {
                var containerPropertyInfo = _engine.GetType().GetProperty("Container", BindingFlags.Instance | BindingFlags.NonPublic);
                if (containerPropertyInfo == null)
                {
                    throw new InvalidOperationException("The class 'EPiServer.Framework.Initialization.InitializationEngine' didn't contain an internal property with the name 'Container'. " +
                                                        "This property has been changed or removed. The initialization of the integration tests needs to be updated.");
                }

                var container = containerPropertyInfo.GetValue(_engine, null) as IContainer;
                _serviceConfigurationContext = new ServiceConfigurationContext(HostType.TestFramework, container);
            }

            if (_commerceInitialization == null)
            {
                _commerceInitialization = new CommerceInitialization();
            }

            _commerceInitialization.ConfigureContainer(_serviceConfigurationContext);
        }

        private static CommerceInitialization _commerceInitialization;
        private static InitializationEngine _engine;
        private static ServiceConfigurationContext _serviceConfigurationContext;
    }

    [ContentType]
    public class StartPage : PageData
    {

    }
}
