using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using System.Web.Routing;
using EPiServer.Commerce.Routing;
using EPiServer.Data.Configuration;
using EPiServer.Framework.Configuration;
using EPiServer.Framework.Initialization;
using EPiServer.Web.Hosting;

namespace EPiCommerce.Integration.Sample.TestSupport
{
    public class EPiServerInitializer
    {
        public static void Initialize(string applicationPath)
        {
            LoadAllAssembliesInFolder(applicationPath);
            SetupConfig();
            SetupHostingEnvironment(applicationPath);
            InitializationModule.FrameworkInitialization(HostType.TestFramework);
            CatalogRouteHelper.MapDefaultHierarchialRouter(RouteTable.Routes, false);
        }

        /// <summary>
        /// Loads all assemblies in specified folder.
        /// </summary>
        /// <param name="path">The folder path.</param>
        private static void LoadAllAssembliesInFolder(string path)
        {
            if (String.IsNullOrEmpty(path) || !Directory.Exists(path))
            {
                return;
            }
            var loadedAssemblies = new HashSet<string>(AppDomain.CurrentDomain.GetAssemblies().Select(a => a.FullName), StringComparer.OrdinalIgnoreCase);
            Parallel.ForEach(Directory.GetFileSystemEntries(path, "*.dll"), (file) =>
            {
                var assemblyName = AssemblyName.GetAssemblyName(file);
                // Skip assembly that is already loaded to current application domain
                if (loadedAssemblies.Contains(assemblyName.FullName))
                {
                    return;
                }
                // If there is a problem loading the assembly, silently ignore it...
                // The reason that this is considered (sort of) ok in this case is that this method
                // is only called as an extra precaution to get all assemblies loaded. If something
                // fails to load we will not consider it a fatal error at this point.
                try
                {
                    Assembly.Load(assemblyName);
                }
                catch (FileLoadException)
                {
                }
                catch (BadImageFormatException)
                {
                }
            });
        }

        private static void SetupConfig()
        {
            var fileMap = new ExeConfigurationFileMap { ExeConfigFilename = AppDomain.CurrentDomain.SetupInformation.ConfigurationFile };
            var config = ConfigurationManager.OpenMappedExeConfiguration(fileMap, ConfigurationUserLevel.None);

            EPiServerFrameworkSection.ConfigurationInstance = config;
            EPiServerDataStoreSection.ConfigurationInstance = config;
        }

        private static void SetupHostingEnvironment(string applicationPath)
        {
            var hostingEnvironment = new TestHostingEnvironment
            {
                ApplicationVirtualPath = "/",
                ApplicationPhysicalPath = applicationPath
            };
            GenericHostingEnvironment.Instance = hostingEnvironment;
            var fallbackMapPathVppConfig = new NameValueCollection
            {
                {"physicalPath", AppDomain.CurrentDomain.BaseDirectory}, 
                {"virtualPath", "~/"}
            };
            var fallbackVpp = new VirtualPathNonUnifiedProvider("fallbackMapPathVpp", fallbackMapPathVppConfig);
            hostingEnvironment.RegisterVirtualPathProvider(fallbackVpp);
        }
    }
}