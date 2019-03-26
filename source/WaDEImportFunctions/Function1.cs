using System;
using System.IO;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Linq;
using WesternStatesWater.WaDE.Contracts.Import;

namespace WaDEImportFunctions
{
    public class Function1
    {
        public Function1(IWaterAllocationManager waterAllocationManager)
        {
            WaterAllocationManager = waterAllocationManager;
        }

        private IWaterAllocationManager WaterAllocationManager { get; set; }

        [FunctionName(FunctionNames.LoadWaterAllocationDataOrchestration)]
        public async Task<IActionResult> LoadWaterAllocationDataOrchestration([OrchestrationTrigger] DurableOrchestrationContextBase context, ILogger log)
        {
            log.LogInformation("Load Water Orchestration");

            var runId = context.GetInput<string>();
            var parallelTasks = new [] {
                context.CallActivityAsync<bool>(FunctionNames.LoadOrganizations, runId),
                context.CallActivityAsync<bool>(FunctionNames.LoadSites, runId),
                context.CallActivityAsync<bool>(FunctionNames.LoadWaterSources, runId),
                context.CallActivityAsync<bool>(FunctionNames.LoadVariablesSpecific, runId),
                context.CallActivityAsync<bool>(FunctionNames.LoadMethods, runId)
            };

            await Task.WhenAll(parallelTasks);

            if (parallelTasks.All(a=>a.IsCompletedSuccessfully && a.Result))
            {
                await context.CallActivityAsync(FunctionNames.LoadWaterAllocation, runId);
            }
            else
            {
                throw new Exception("Some stuff failed");
            }

            return new OkObjectResult("OK");
        }

        [FunctionName(FunctionNames.LoadOrganizations)]
        public async Task<bool> LoadOrganizations([ActivityTrigger] DurableActivityContextBase context, ILogger log)
        {
            var runId = context.GetInput<string>();
            return await WaterAllocationManager.LoadOrganizations(runId);
        }

        [FunctionName(FunctionNames.LoadSites)]
        public async Task<bool> LoadSites([ActivityTrigger] DurableActivityContextBase context, ILogger log)
        {
            await Task.Delay(TimeSpan.FromSeconds(context.GetInput<int>()));
            return true;
        }

        [FunctionName(FunctionNames.LoadWaterSources)]
        public async Task<bool> LoadWaterSources([ActivityTrigger] DurableActivityContextBase context, ILogger log)
        {
            await Task.Delay(TimeSpan.FromSeconds(context.GetInput<int>()));
            return true;
        }

        [FunctionName(FunctionNames.LoadVariablesSpecific)]
        public async Task<bool> LoadVariablesSpecific([ActivityTrigger] DurableActivityContextBase context, ILogger log)
        {
            await Task.Delay(TimeSpan.FromSeconds(context.GetInput<int>()));
            return true;
        }

        [FunctionName(FunctionNames.LoadMethods)]
        public async Task<bool> LoadMethods([ActivityTrigger] DurableActivityContextBase context, ILogger log)
        {
            await Task.Delay(TimeSpan.FromSeconds(context.GetInput<int>()));
            return true;
        }

        [FunctionName(FunctionNames.LoadWaterAllocation)]
        public async Task<bool> LoadWaterAllocation([ActivityTrigger] DurableActivityContextBase context, ILogger log)
        {
            await Task.Delay(TimeSpan.FromSeconds(context.GetInput<int>()));
            return true;
        }

        [FunctionName(FunctionNames.LoadWaterAllocationData)]
        public async Task<IActionResult> LoadWaterAllocationData([HttpTrigger(AuthorizationLevel.Function, "get")]HttpRequest req, [OrchestrationClient]DurableOrchestrationClient starter, ILogger log)
        {
            return new OkObjectResult(await starter.StartNewAsync(FunctionNames.LoadWaterAllocationDataOrchestration, req.Query["runId"].ToString()));
        }

        [FunctionName(FunctionNames.GetLoadWaterOrchestrationStatus)]
        public async Task<IActionResult> GetLoadWaterOrchestrationStatus([HttpTrigger(AuthorizationLevel.Function, "get")]HttpRequest req, [OrchestrationClient]DurableOrchestrationClient starter, ILogger log)
        {
            var instanceId = req.Query["instanceId"];
            var status = await starter.GetStatusAsync(instanceId);
            dynamic resultStatus = new System.Dynamic.ExpandoObject();
            if (status.RuntimeStatus == OrchestrationRuntimeStatus.Completed)
            {
                resultStatus.Status = 1;
            }
            else if(status.RuntimeStatus==OrchestrationRuntimeStatus.ContinuedAsNew || status.RuntimeStatus == OrchestrationRuntimeStatus.Pending || status.RuntimeStatus == OrchestrationRuntimeStatus.Running)
            {
                resultStatus.Status = 0;
            }
            else
            {
                resultStatus.Status = 2;
            }
            return new OkObjectResult(resultStatus);
        }
    }

    internal static class FunctionNames
    {
        public const string LoadWaterAllocationData = "LoadWaterAllocationData";
        public const string LoadWaterAllocationDataOrchestration = "LoadWaterAllocationDataOrchestration";
        public const string GetLoadWaterOrchestrationStatus = "GetLoadWaterOrchestrationStatus";
        public const string LoadOrganizations = "LoadOrganizations";
        public const string LoadSites = "LoadSites";
        public const string LoadWaterSources = "LoadWaterSources";
        public const string LoadVariablesSpecific = "LoadVariablesSpecific";
        public const string LoadMethods = "LoadMethods";
        public const string LoadWaterAllocation = "LoadWaterAllocation";
    }
}
