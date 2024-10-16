﻿using FluentAssertions;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Linq;
using System.Threading.Tasks;
using Telerik.JustMock;
using Telerik.JustMock.Helpers;
using WesternStatesWater.WaDE.Accessors.Contracts.Api;
using WesternStatesWater.WaDE.Contracts.Api;
using WesternStatesWater.WaDE.Managers.Api;
using WesternStatesWater.WaDE.Tests.Helpers.ModelBuilder.Accessor.Api;
using WesternStatesWater.WaDE.Utilities;
using ManagerApi = WesternStatesWater.WaDE.Contracts.Api;

namespace WesternStatesWater.WaDE.Managers.Tests
{
    [TestClass]
    public class ApiAggregratedAmountsManagerTests
    {
        private readonly IAggregatedAmountsAccessor AggregatedAmountsAccessorMock = Mock.Create<IAggregatedAmountsAccessor>(Behavior.Strict);

        [DataTestMethod]
        [DataRow(null, GeometryFormat.Wkt, null)]
        [DataRow(null, GeometryFormat.GeoJson, null)]
        [DataRow("POINT (-96.7014 40.8146)", GeometryFormat.Wkt, "POINT (-96.7014 40.8146)")]
        [DataRow("POINT (-96.7014 40.8146)", GeometryFormat.GeoJson, "{\"type\":\"Point\",\"coordinates\":[-96.7014,40.8146]}")]
        public async Task GetAggregatedAmountsAsync_ReportingUnitGeometries(string geometryString, GeometryFormat geometryFormat, string expectedResultString)
        {
            var accessorResult = AggregatedAmountsBuilder.Create();
            accessorResult.Organizations.First().ReportingUnits[0].ReportingUnitGeometry = GeometryExtensions.GetGeometryByWkt(geometryString);
            AggregatedAmountsAccessorMock.Arrange(a => a.GetAggregatedAmountsAsync(Arg.IsAny<Accessors.Contracts.Api.AggregatedAmountsFilters>(), 0, 1))
                                       .Returns(Task.FromResult(accessorResult));
            var sut = CreateAggregratedAmountsManager();
            var result = await sut.GetAggregatedAmountsAsync(new Contracts.Api.AggregatedAmountsFilters(), 0, 1, geometryFormat);
            result.Should().NotBeNull();

            var resultGeometry = result.Organizations.First().ReportingUnits[0].ReportingUnitGeometry;
            if (expectedResultString == null)
            {
                resultGeometry.Should().BeNull();
            }
            else
            {
                var expectedResult = geometryFormat == GeometryFormat.Wkt ? expectedResultString : Newtonsoft.Json.JsonConvert.DeserializeObject(expectedResultString);
                resultGeometry.ToString().Should().Be(expectedResult.ToString());
            }
        }

        [DataTestMethod]
        [DataRow(null, GeometryFormat.Wkt, null)]
        [DataRow(null, GeometryFormat.GeoJson, null)]
        [DataRow("POINT (-96.7014 40.8146)", GeometryFormat.Wkt, "POINT (-96.7014 40.8146)")]
        [DataRow("POINT (-96.7014 40.8146)", GeometryFormat.GeoJson, "{\"type\":\"Point\",\"coordinates\":[-96.7014,40.8146]}")]
        public async Task GetAggregatedAmountsAsync_WaterSourceGeometry(string geometryString, GeometryFormat geometryFormat, string expectedResultString)
        {
            var accessorResult = AggregatedAmountsBuilder.Create();
            accessorResult.Organizations.First().WaterSources[0].WaterSourceGeometry = GeometryExtensions.GetGeometryByWkt(geometryString);
            AggregatedAmountsAccessorMock.Arrange(a => a.GetAggregatedAmountsAsync(Arg.IsAny<Accessors.Contracts.Api.AggregatedAmountsFilters>(), 0, 1))
                                       .Returns(Task.FromResult(accessorResult));
            var sut = CreateAggregratedAmountsManager();
            var result = await sut.GetAggregatedAmountsAsync(new Contracts.Api.AggregatedAmountsFilters(), 0, 1, geometryFormat);
            result.Should().NotBeNull();

            var resultGeometry = result.Organizations.First().WaterSources[0].WaterSourceGeometry;
            if (expectedResultString == null)
            {
                resultGeometry.Should().BeNull();
            }
            else
            {
                var expectedResult = geometryFormat == GeometryFormat.Wkt ? expectedResultString : Newtonsoft.Json.JsonConvert.DeserializeObject(expectedResultString);
                resultGeometry.ToString().Should().Be(expectedResult.ToString());
            }
        }

        private ManagerApi.IAggregatedAmountsManager CreateAggregratedAmountsManager()
        {
            return new AggregratedAmountsManager(AggregatedAmountsAccessorMock);
        }
    }
}
