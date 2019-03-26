﻿using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Text;
using WesternStatesWater.WaDE.Accessors;
using WesternStatesWater.WaDE.Accessors.Contracts;
using AccessorApi = WesternStatesWater.WaDE.Accessors.Contracts.Api;
using AccessorImport = WesternStatesWater.WaDE.Accessors.Contracts.Import;
using ManagerApi = WesternStatesWater.WaDE.Contracts.Api;
using WesternStatesWater.WaDE.Managers;

[assembly: WebJobsStartup(typeof(WaDEApiFunctions.Startup))]

namespace WaDEApiFunctions
{

    public class Startup : IWebJobsStartup
    {
        public void Configure(IWebJobsBuilder builder)
        {
            var config = new ConfigurationBuilder()
                .SetBasePath(Environment.CurrentDirectory)
                .AddJsonFile("settings.json", optional: true, reloadOnChange: true)
                .AddJsonFile("settings.local.json", optional: true, reloadOnChange: true)
                .AddJsonFile($"settings.{Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT")}.json", optional: true, reloadOnChange: true)
                .AddJsonFile($"settings.{Environment.UserName}.json", optional: true, reloadOnChange: true)
                .AddEnvironmentVariables()
                .Build();

            builder.Services.AddSingleton<IConfiguration>(config);
            builder.Services.AddTransient<ManagerApi.IWaterAllocationManager, WaterAllocationManager>();
            builder.Services.AddTransient<AccessorApi.IWaterAllocationAccessor, WaterAllocationAccessor>();
            builder.Services.AddTransient<AccessorImport.IWaterAllocationAccessor, WaterAllocationAccessor>();
            builder.Services.AddTransient<AccessorImport.IWaterAllocationFileAccessor, WaterAllocationFileAccessor>();
        }
    }
}
