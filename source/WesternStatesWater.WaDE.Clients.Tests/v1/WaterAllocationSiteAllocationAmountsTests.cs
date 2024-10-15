using System;
using System.Net;
using System.Threading.Tasks;
using Bogus;
using FluentAssertions;
using Microsoft.Azure.Functions.Worker;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Telerik.JustMock;
using Telerik.JustMock.Helpers;
using WaDEApiFunctions.v1;
using WesternStatesWater.WaDE.Contracts.Api;

namespace WesternStatesWater.WaDE.Clients.Tests.v1
{
    [TestClass]
    public class WaterAllocationSiteAllocationAmountsTests : FunctionTestBase
    {
        private IWaterAllocationManager _waterAllocationManagerMock = null!;

        [TestInitialize]
        public void TestInitialize()
        {
            _waterAllocationManagerMock = Mock.Create<IWaterAllocationManager>(Behavior.Strict);
        }

        [DataTestMethod]
        [DataRow(null, GeometryFormat.Wkt)]
        [DataRow("", GeometryFormat.Wkt)]
        [DataRow(" ", GeometryFormat.Wkt)]
        [DataRow("\t", GeometryFormat.Wkt)]
        [DataRow("wkt", GeometryFormat.Wkt)]
        [DataRow("WKT", GeometryFormat.Wkt)]
        [DataRow("wKt", GeometryFormat.Wkt)]
        [DataRow("0", GeometryFormat.Wkt)]
        [DataRow("banana", GeometryFormat.Wkt)]
        [DataRow("geojson", GeometryFormat.GeoJson)]
        [DataRow("GEOJSON", GeometryFormat.GeoJson)]
        [DataRow("GeoJson", GeometryFormat.GeoJson)]
        [DataRow("1", GeometryFormat.GeoJson)]
        public async Task Run_GeometryFormat(string formatString, GeometryFormat expectedGeometryFormat)
        {
            var faker = new Faker();
            _waterAllocationManagerMock.Arrange(a => a.GetSiteAllocationAmountsAsync(Arg.IsAny<SiteAllocationAmountsFilters>(), 0, 1000, expectedGeometryFormat))
                .Returns(Task.FromResult(new WaterAllocations()));

            var context = Mock.Create<FunctionContext>();
            var request = new FakeHttpRequestData(context, new Uri($"http://localhost?SiteUUID={faker.Random.Uuid()}&geoFormat={formatString}"));

            var sut = CreateSiteAllocationAmountsFunction();
            var result = await sut.Run(request);
            result.StatusCode.Should().Be(HttpStatusCode.OK);

            _waterAllocationManagerMock.Assert(a => a.GetSiteAllocationAmountsAsync(Arg.IsAny<SiteAllocationAmountsFilters>(), 0, 1000, expectedGeometryFormat), Occurs.Once());
        }

        [DataTestMethod]
        [DataRow(null, HttpStatusCode.BadRequest)]
        [DataRow("", HttpStatusCode.BadRequest)]
        [DataRow(" ", HttpStatusCode.BadRequest)]
        [DataRow("\t", HttpStatusCode.BadRequest)]
        [DataRow("good one", HttpStatusCode.OK)]
        public async Task Run_SiteUuid(string siteUuid, HttpStatusCode expectedHttpStatusCode)
        {
            _waterAllocationManagerMock.Arrange(a => a.GetSiteAllocationAmountsAsync(Arg.IsAny<SiteAllocationAmountsFilters>(), 0, 1000, GeometryFormat.Wkt))
                .Returns(Task.FromResult(new WaterAllocations()));

            var context = Mock.Create<FunctionContext>();
            var request = new FakeHttpRequestData(context, new Uri($"http://localhost?SiteUUID={siteUuid}"));

            var sut = CreateSiteAllocationAmountsFunction();
            var result = await sut.Run(request);
            result.StatusCode.Should().Be(expectedHttpStatusCode);

            if (expectedHttpStatusCode == HttpStatusCode.BadRequest)
            {
                _waterAllocationManagerMock.Assert(a => a.GetSiteAllocationAmountsAsync(Arg.IsAny<SiteAllocationAmountsFilters>(), 0, 1000, GeometryFormat.Wkt), Occurs.Never());
            }
            else
            {
                _waterAllocationManagerMock.Assert(a => a.GetSiteAllocationAmountsAsync(Arg.IsAny<SiteAllocationAmountsFilters>(), 0, 1000, GeometryFormat.Wkt), Occurs.Once());
                _waterAllocationManagerMock.Assert(a => a.GetSiteAllocationAmountsAsync(Arg.Matches<SiteAllocationAmountsFilters>(f => f.SiteUuid == siteUuid), 0, 1000, GeometryFormat.Wkt), Occurs.Once());
            }
        }

        private WaterAllocation_SiteAllocationAmounts CreateSiteAllocationAmountsFunction()
        {
            return new WaterAllocation_SiteAllocationAmounts(
                _waterAllocationManagerMock,
                CreateLogger<WaterAllocation_SiteAllocationAmounts>()
            );
        }
    }
}