using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;
using System;
using System.IO;
using System.Net;
using System.Threading.Tasks;
using WesternStatesWater.WaDE.Contracts.Api;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;

namespace WaDEApiFunctions.v1
{
    public class WaterAllocation_RegulatoryOverlay
    {
        public WaterAllocation_RegulatoryOverlay(IRegulatoryOverlayManager regulatoryOverlayManager)
        {
            RegulatoryOverlayManager = regulatoryOverlayManager;
        }

        private IRegulatoryOverlayManager RegulatoryOverlayManager { get; set; }

        [Function("WaterAllocation_RegulatoryOverlay_v1")]
        public async Task<HttpResponseData> Run([HttpTrigger(AuthorizationLevel.Function, "get", "post", Route = "v1/AggRegulatoryOverlay")] HttpRequestData req, ILogger log)
        {
            log.LogInformation($"Call to {nameof(WaterAllocation_RegulatoryOverlay)}");

            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            var data = JsonConvert.DeserializeObject<RegulatoryOverlayRequestBody>(requestBody);

            var reportingUnitUUID = ((string)req.Query["ReportingUnitUUID"]) ?? data?.reportingUnitUUID;
            var regulatoryOverlayUUID = ((string)req.Query["RegulatoryOverlayUUID"]) ?? data?.regulatoryOverlayUUID;
            var organizationUUID = ((string)req.Query["OrganizationUUID"]) ?? data?.organizationUUID;
            var statutoryEffectiveDate = RequestDataParser.ParseDate(((string)req.Query["StatutoryEffectiveDate"]) ?? data?.statutoryEffectiveDate);
            var statutoryEndDate = RequestDataParser.ParseDate(((string)req.Query["StatutoryEndDate"]) ?? data?.statutoryEndDate);
            var startDataPublicationDate = RequestDataParser.ParseDate(req.GetQueryString("StartPublicationDate") ?? data?.startPublicationDate);
            var endDataPublicationDate = RequestDataParser.ParseDate(req.GetQueryString("EndPublicationDate") ?? data?.endPublicationDate);
            var regulatoryStatusCV = ((string)req.Query["RegulatoryStatusCV"]) ?? data?.regulatoryStatusCV;
            var geometry = ((string)req.Query["SearchBoundary"]) ?? data?.searchBoundary;
            var state = ((string)req.Query["State"]) ?? data?.state;
            var startIndex = RequestDataParser.ParseInt(((string)req.Query["StartIndex"]) ?? data?.startIndex) ?? 0;
            var recordCount = RequestDataParser.ParseInt(((string)req.Query["RecordCount"]) ?? data?.recordCount) ?? 1000;
            var geoFormat = RequestDataParser.ParseGeometryFormat(req.GetQueryString("geoFormat")) ?? GeometryFormat.Wkt;

            if (startIndex < 0)
            {
                var badRequest = req.CreateResponse(HttpStatusCode.BadRequest);
                await badRequest.WriteStringAsync("Start index must be 0 or greater.");
                return badRequest;
            }

            if (recordCount < 1 || recordCount > 10000)
            {
                var badRequest = req.CreateResponse(HttpStatusCode.BadRequest);
                await badRequest.WriteStringAsync("Record count must be between 1 and 10000");
                return badRequest;
            }

            if (string.IsNullOrWhiteSpace(reportingUnitUUID) &&
                string.IsNullOrWhiteSpace(regulatoryOverlayUUID) &&
                string.IsNullOrWhiteSpace(organizationUUID) &&
                string.IsNullOrWhiteSpace(regulatoryStatusCV) &&
                string.IsNullOrWhiteSpace(geometry) &&
                string.IsNullOrWhiteSpace(state))
            {
                var badRequest = req.CreateResponse(HttpStatusCode.BadRequest);
                await badRequest.WriteStringAsync("At least one of the following filter parameters must be specified: reportingUnitUUID, regulatoryOverlayUUID, organizationUUID, regulatoryStatusCV, geometry, state");
                return badRequest;
            }
            
            var regulatoryReportingUnits = await RegulatoryOverlayManager.GetRegulatoryReportingUnitsAsync(new RegulatoryOverlayFilters
            {
                ReportingUnitUUID = reportingUnitUUID,
                RegulatoryOverlayUUID = regulatoryOverlayUUID,
                OrganizationUUID = organizationUUID,
                StatutoryEffectiveDate = statutoryEffectiveDate,
                StatutoryEndDate = statutoryEndDate,
                StartDataPublicationDate = startDataPublicationDate,
                EndDataPublicationDate = endDataPublicationDate,
                RegulatoryStatusCV = regulatoryStatusCV,
                Geometry = geometry,
                State = state
            }, startIndex, recordCount, geoFormat);
            
            var jsonResult = req.CreateResponse(HttpStatusCode.OK);
            var jsonToReturn = JsonConvert.SerializeObject(regulatoryReportingUnits);
            await jsonResult.WriteStringAsync(jsonToReturn);
            return jsonResult;
        }

        private sealed class RegulatoryOverlayRequestBody
        {
            public string reportingUnitUUID { get; set; }
            public string regulatoryOverlayUUID { get; set; }
            public string organizationUUID { get; set; }
            public string statutoryEffectiveDate { get; set; }
            public string statutoryEndDate { get; set; }
            public string startPublicationDate { get; set; }
            public string endPublicationDate { get; set; }
            public string regulatoryStatusCV { get; set; }
            public string searchBoundary { get; set; }
            public string state { get; set; }
            public string startIndex { get; set; }
            public string recordCount { get; set; }
        }
    }
}
