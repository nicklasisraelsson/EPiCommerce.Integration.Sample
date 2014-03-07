using System;
using System.Data;
using System.Globalization;
using EPiServer.ServiceLocation;
using Mediachase.Commerce;
using Mediachase.Commerce.Catalog;
using Mediachase.Commerce.Catalog.Dto;
using Mediachase.Commerce.Catalog.Managers;
using Mediachase.Commerce.Core;
using Mediachase.Commerce.Markets;
using Mediachase.MetaDataPlus.Configurator;

namespace EPiCommerce.Integration.Sample.TestSupport
{
    public class CatalogTestHelper
    {
        public static IMarket UsMarket { get; set; }
        public static IMarket EuMarket { get; set; }
        public static int RootCatalogId { get; set; }
        public static int DefaultCatalogNodeId { get; set; }
        public const string DefaultMetaDataClassName = "DefaultMetadataClass";

        public static void Initialize()
        {
            CreateMarkets();
            CreateRootCatalog();
            CreateDefaultCatalogNode();
        }

        public static CatalogNodeDto CreateNode(
            string code = "NODECODE",
            bool active = true,
            string name = "NODENAME",
            int? parentNodeId = null,
            string seoUri = "")
        {
            var catalogNodeDto =
                CatalogContext.Current.GetCatalogNodeDto(
                    code,
                    new CatalogNodeResponseGroup(CatalogNodeResponseGroup.ResponseGroup.CatalogNodeInfo));

            if (catalogNodeDto.CatalogNode.Count == 0)
            {
                var metaClass = MetaClass.Load(CatalogContext.MetaDataContext, "CatalogNodeEx");
                CatalogNodeDto.CatalogNodeRow catalogNodeRow = catalogNodeDto.CatalogNode.NewCatalogNodeRow();
                catalogNodeRow.CatalogId = RootCatalogId;
                catalogNodeRow.StartDate = DateTime.Now;
                catalogNodeRow.EndDate = DateTime.Now.AddYears(2);
                catalogNodeRow.Name = name;
                catalogNodeRow.Code = code;
                catalogNodeRow.ParentNodeId = parentNodeId ?? DefaultCatalogNodeId;
                catalogNodeRow.IsActive = active;
                catalogNodeRow.SortOrder = 0;
                catalogNodeRow.ApplicationId = AppContext.Current.ApplicationId;
                // hardcoded for now
                catalogNodeRow.TemplateName = "NodeEntriesTemplate";
                catalogNodeRow.MetaClassId = metaClass.Id;
                catalogNodeDto.CatalogNode.AddCatalogNodeRow(catalogNodeRow);

                if (!string.IsNullOrEmpty(seoUri))
                {
                    var newSeoRow = catalogNodeDto.CatalogItemSeo.NewCatalogItemSeoRow();
                    newSeoRow.ApplicationId = AppContext.Current.ApplicationId;
                    newSeoRow.CatalogNodeId = catalogNodeDto.CatalogNode[0].CatalogNodeId;
                    newSeoRow.Description = "DESCRIPTION";
                    newSeoRow.LanguageCode = "en";
                    newSeoRow.Uri = seoUri;
                    if (newSeoRow.RowState == DataRowState.Detached)
                        catalogNodeDto.CatalogItemSeo.AddCatalogItemSeoRow(newSeoRow);
                }

                CatalogContext.Current.SaveCatalogNode(catalogNodeDto);
            }
            return catalogNodeDto;
        }

        private static void CreateDefaultCatalogNode()
        {
            var dto = CreateNode("TESTCATALOGNODE", true, "TEST CATALOG NODE", 0);
            DefaultCatalogNodeId = dto.CatalogNode[0].CatalogNodeId;
        }

        private static int CreateRootCatalog(int? rootId = null)
        {
            var catalogDto =
                CatalogContext.Current.GetCatalogDto(
                    rootId ?? RootCatalogId, new CatalogResponseGroup(CatalogResponseGroup.ResponseGroup.CatalogInfo));

            if (!rootId.HasValue || catalogDto.Catalog.Count == 0)
            {
                var catalogId = CreateCatalog("TESTCATALOG");

                if (rootId == null)
                {
                    RootCatalogId = catalogId;
                }

                return catalogId;
            }

            return rootId.Value;
        }

        public static int CreateCatalog(string catalogName)
        {
            var catalogDto = new CatalogDto();
            var newCatalogRow = catalogDto.Catalog.NewCatalogRow();
            newCatalogRow.Name = catalogName;
            newCatalogRow.StartDate = DateTime.Now;
            newCatalogRow.EndDate = DateTime.Now.AddYears(2);
            newCatalogRow.IsActive = true;
            newCatalogRow.SortOrder = 0;
            newCatalogRow.ApplicationId = AppContext.Current.ApplicationId;
            newCatalogRow.Created = DateTime.Now;
            newCatalogRow.Modified = DateTime.Now;

            // hardcoded for test:
            newCatalogRow.IsPrimary = false;
            newCatalogRow.DefaultCurrency = "eur";
            newCatalogRow.WeightBase = "kgs";
            newCatalogRow.DefaultLanguage = "en";
            catalogDto.Catalog.AddCatalogRow(newCatalogRow);

            AddCatalogLanguage(catalogDto, catalogDto.Catalog[0], "en");
            AddCatalogLanguage(catalogDto, catalogDto.Catalog[0], "sv");

            CatalogContext.Current.SaveCatalog(catalogDto);

            return newCatalogRow.CatalogId;
        }

        private static void AddCatalogLanguage(int catalogId, string languageCode)
        {
            var dto = CatalogContext.Current.GetCatalogDto(catalogId);
            AddCatalogLanguage(dto, dto.Catalog[0], languageCode);
            CatalogContext.Current.SaveCatalog(dto);
        }

        private static void AddCatalogLanguage(CatalogDto workingDto, CatalogDto.CatalogRow catalogRow, string languageCode)
        {
            CatalogDto.CatalogLanguageRow languageRow = workingDto.CatalogLanguage.NewCatalogLanguageRow();
            languageRow.LanguageCode = languageCode;
            languageRow.CatalogId = catalogRow.CatalogId;
            workingDto.CatalogLanguage.AddCatalogLanguageRow(languageRow);
        }

        private static void CreateMarkets()
        {
            var usMarketId = new MarketId("US");
            var euMarketId = new MarketId("EU");

            var marketService = ServiceLocator.Current.GetInstance<IMarketService>();

            UsMarket = marketService.GetMarket(usMarketId);
            if (UsMarket == null)
            {
                marketService.CreateMarket(new MarketImpl(usMarketId)
                {
                    DefaultCurrency = Currency.USD,
                    DefaultLanguage = new CultureInfo("en"),
                    MarketName = "United States",
                    MarketDescription = String.Empty
                });
                UsMarket = marketService.GetMarket(usMarketId);
            }

            EuMarket = marketService.GetMarket(euMarketId);
            if (EuMarket == null)
            {
                marketService.CreateMarket(new MarketImpl(euMarketId)
                {
                    DefaultCurrency = Currency.EUR,
                    DefaultLanguage = new CultureInfo("en"),
                    MarketName = "European Union",
                    MarketDescription = String.Empty
                });
                EuMarket = marketService.GetMarket(euMarketId);
            }
        }
    }
}