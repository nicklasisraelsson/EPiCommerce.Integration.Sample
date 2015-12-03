using System.Collections.Generic;
using System.Linq;
using EPiCommerce.Integration.Sample.TestSupport;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Core;
using EPiServer.DataAccess;
using EPiServer.Security;
using EPiServer.ServiceLocation;
using Mediachase.Commerce.Catalog;
using Mediachase.Commerce.Catalog.Dto;
using Xunit;

namespace EPiCommerce.Integration.Sample
{
    public class When_saving_and_getting_a_catalog_entry_with_datafactory : TestBase
    {
        private static CatalogContentBase catalogContent;
        private static CatalogEntryDto entry;
        
        public When_saving_and_getting_a_catalog_entry_with_datafactory()
        {
            var parentLink = ReferenceConverter.GetContentLink(CatalogTestHelper.DefaultCatalogNodeId,
                                                               CatalogContentType.CatalogNode, 0);
            var variation = ContentRepository.GetDefault<VariationContent>(parentLink);
            variation.Name = "My variation";
            var variationLink = ContentRepository.Save(variation, SaveAction.Publish, AccessLevel.NoAccess);
            var entryId = ReferenceConverter.GetObjectId(variationLink);
            var catalogSystem = ServiceLocator.Current.GetInstance<ICatalogSystem>();
            entry = catalogSystem.GetCatalogEntryDto(entryId);
            catalogContent = ContentRepository.Get<CatalogContentBase>(variationLink);
        }
        
        [Fact]
        public void It_should_have_same_name_as_the_entry_from_ECF()
        {
            Assert.Equal(catalogContent.Name, entry.CatalogEntry[0].Name);
        }
    }

    public class When_saving_a_new_entry_under_a_catalog : TestBase
    {
        private static IEnumerable<CatalogContentBase> newChildren;
        private static IEnumerable<CatalogContentBase> oldChildren;

        public When_saving_a_new_entry_under_a_catalog()
        {
            var parentLink = ReferenceConverter.GetContentLink(CatalogTestHelper.RootCatalogId,
                                                               CatalogContentType.Catalog, 0);
            oldChildren = ContentRepository.GetChildren<CatalogContentBase>(parentLink);
            var newEntry = ContentRepository.GetDefault<VariationContent>(parentLink);
            newEntry.Name = "My variation";
            ContentRepository.Save(newEntry, SaveAction.Save, AccessLevel.NoAccess);
            // We need to specify a language selector, otherwise non published content will not be included.
            newChildren = ContentRepository.GetChildren<CatalogContentBase>(parentLink, LanguageSelector.MasterLanguage()); 
        }

        [Fact]
        public void It_should_add_the_new_unpublished_entry_as_a_child_to_the_catalog()
        {
            Assert.NotInRange(newChildren.Count(), 0, oldChildren.Count());
        }
    }

    public class When_accessing_the_campaign_root : TestBase
    {
        [Fact]
        public void Should_not_be_null()
        {
            Assert.NotNull(CampaignFolder.CampaignRoot);
        }
    }
}
