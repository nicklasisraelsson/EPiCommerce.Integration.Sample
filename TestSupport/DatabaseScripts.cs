using Microsoft.Build.Utilities;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace EPiCommerce.Integration.Sample.TestSupport
{
    public class DatabaseScripts
    {
        private readonly string _applicationPath;
        
        public DatabaseScripts(string applicationPath)
        {
            _applicationPath = applicationPath;
        }

        public void CopySqlScripts()
        {
            var sqlDirectory = Path.Combine(_applicationPath, "sql");
            if (!Directory.Exists(sqlDirectory))
            {
                Directory.CreateDirectory(sqlDirectory);
            }
            CopyCmsDatabase(sqlDirectory);
            CopyCommerceDatabase(sqlDirectory);
            CopyUpgradeScripts(sqlDirectory);
        }

        private void CopyCmsDatabase(string sqlDirectory)
        {
            var cmsVersion = GetPackageVersion(_applicationPath, "EPiServer.CMS.Core");
            File.Copy(
                Path.Combine(_applicationPath,
                             @"..\..\packages\EPiServer.CMS.Core." + cmsVersion + @"\tools\EPiServer.Cms.Core.sql"),
                Path.Combine(sqlDirectory, "EPiServer.Cms.Core.sql"), true);
        }

        private void CopyCommerceDatabase(string sqlDirectory)
        {
            var commerceVersion = GetPackageVersion(_applicationPath, "EPiServer.Commerce.Core");
            File.Copy(
                Path.Combine(_applicationPath,
                             @"..\..\packages\EPiServer.Commerce.Core." + commerceVersion + @"\tools\EPiServer.Commerce.Core.sql"),
                Path.Combine(sqlDirectory, "EPiServer.Commerce.Core.sql"), true);
        }

        private void CopyUpgradeScripts(string sqlDirectory)
        {
            var upgradeScriptsDestinationDirectoryPath = Path.Combine(sqlDirectory, "upgrade");
            if (!Directory.Exists(upgradeScriptsDestinationDirectoryPath))
            {
                Directory.CreateDirectory(upgradeScriptsDestinationDirectoryPath);
            }
            var commerceVersion = GetPackageVersion(_applicationPath, "EPiServer.Commerce.Core");
            var upgradeScriptsSourcePath = Path.Combine(_applicationPath,
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
    }
}
