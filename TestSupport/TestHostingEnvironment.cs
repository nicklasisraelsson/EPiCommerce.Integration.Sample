using System;
using System.IO;
using System.Reflection;
using System.Web.Hosting;
using EPiServer.Web.Hosting;

namespace EPiCommerce.Integration.Sample.TestSupport
{
    public class TestHostingEnvironment : IHostingEnvironment
    {
        public void RegisterVirtualPathProvider(VirtualPathProvider virtualPathProvider)
        {
            // Sets up the provider chain
            var previousField = typeof(VirtualPathProvider).GetField("_previous", BindingFlags.NonPublic | BindingFlags.Instance);
            previousField.SetValue(virtualPathProvider, VirtualPathProvider);
            VirtualPathProvider = virtualPathProvider;
        }

        public VirtualPathProvider VirtualPathProvider { get; private set; }

        public string ApplicationID { get; set; }
        public string ApplicationPhysicalPath { get; set; }
        public string ApplicationVirtualPath { get; set; }

        public string MapPath(string virtualPath)
        {
            return Path.Combine(Environment.CurrentDirectory, virtualPath.Trim(' ', '~', '/').Replace('/', '\\'));
        }
    }
}