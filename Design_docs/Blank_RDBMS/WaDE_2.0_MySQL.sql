-- Adel Abdallah, Senior Hydroinformatics Specialist at the WSWC, Feb 2019

--This is a Data Definition Language (DDL) script that
--generates a blank schema of the Water Data Exchange Data Model (WaDE)
-- for Microsoft SQL Server database.

-- Generated by Adel Abdallah Feb, 2019 based on WaDE XML design named WaDE2.0_schema_star generated by DbWrench V4.04 @ http://www.dbwrench.com/
-- WaDE All rights reserved. See BSD 3-Clause Licence @ https://github.com/WSWCWaterDataExchange/WaDE2.0/blob/master/LICENSE 

-- Open MySQL Workbench, Create a New SQL Tab for Executing queries
-- Simply copy all this script and paste into the new window of "create query"
-- Then click execute. The script should run successfully and create the 41 empty tables of WaDE

--------------------------------------------------------------------------------------------------
DROP SCHEMA IF EXISTS WaDE;

CREATE SCHEMA IF NOT EXISTS WaDE;

/***************************************************************************/
/*********************** CREATE WADE2.0_SCHEMA_STAR ************************/
/***************************************************************************/
USE WaDE;

CREATE TABLE AggBridge_BeneficialUses_fact (
	AggBridgeID INT   NOT NULL PRIMARY KEY,
	BeneficialUseID INT   NOT NULL,
	AggregatedAmountID INT   NOT NULL
);

CREATE TABLE AggregatedAmounts_fact (
	AggregatedAmountID INT   NOT NULL PRIMARY KEY,
	OrganizationID INT   NOT NULL,
	ReportingUnitID INT   NOT NULL,
	VariableSpecificID INT   NOT NULL,
	BeneficialUseID INT   NOT NULL,
	WaterSourceID INT   NOT NULL,
	MethodID INT   NOT NULL,
	TimeframeStartID INT   NULL,
	TimeframeEndID INT   NULL,
	DataPublicationDate INT   NULL,
	ReportYear VARCHAR (4)  NULL,
	Amount FLOAT   NOT NULL,
	PopulationServed FLOAT   NULL,
	PowerGeneratedGWh FLOAT   NULL,
	IrrigatedAcreage FLOAT   NULL,
	InterbasinTransferToID VARCHAR (100)  NULL,
	InterbasinTransferFromID VARCHAR (100)  NULL
);

CREATE TABLE AllocationAmounts_fact (
	AllocationAmountID INT   NOT NULL PRIMARY KEY,
	OrganizationID INT   NOT NULL,
	AllocationID INT   NOT NULL,
	SiteID INT   NOT NULL,
	VariableSpecificID INT   NOT NULL,
	BeneficialUsesID INT   NOT NULL,
	WaterSourceID INT   NOT NULL,
	MethodID INT   NOT NULL,
	TimeframeStartDateID INT   NOT NULL,
	TimeframeEndDateID INT   NOT NULL,
	DataPublicationDateID INT   NOT NULL,
	ReportYear VARCHAR (4)  NOT NULL,
	AllocationCropDutyAmount FLOAT   NULL,
	AllocationAmount FLOAT   NULL,
	AllocationMaximum FLOAT   NULL,
	PopulationServed FLOAT   NULL,
	PowerGeneratedGWh FLOAT   NULL,
	IrrigatedAcreage FLOAT   NULL,
	AllocationCommunityWaterSupplySystem VARCHAR (250)  NULL,
	SDWISIdentifier VARCHAR (250)  NULL,
	InterbasinTransferFromID VARCHAR (250)  NULL,
	InterbasinTransferToID VARCHAR (250)  NULL,
	Geometry BLOB   NULL
);

CREATE TABLE AllocationBridge_BeneficialUses_fact (
	AllocationBridgeID INT   NOT NULL PRIMARY KEY,
	BeneficialUseID INT   NOT NULL,
	AllocationAmountID INT   NOT NULL
);

CREATE TABLE Allocations_dim (
	AllocationID INT   NOT NULL PRIMARY KEY,
	AllocationUUID VARCHAR (50)  NOT NULL,
	AllocationNativeID VARCHAR (250)  NOT NULL,
	AllocationOwner VARCHAR (255)  NOT NULL,
	AllocationBasisCV VARCHAR (250)  NULL,
	AllocationLegalStatusCV VARCHAR (50)  NOT NULL,
	AllocationApplicationDate INT   NULL,
	AllocationPriorityDate INT   NOT NULL,
	AllocationExpirationDate INT   NULL,
	AllocationChangeApplicationIndicator VARCHAR (100)  NULL,
	LegacyAllocationIDs VARCHAR (100)  NULL
);

CREATE TABLE BeneficialUses_dim (
	BeneficialUseID INT   NOT NULL PRIMARY KEY,
	BeneficialUseCategory VARCHAR (500)  NOT NULL,
	PrimaryUseCategory VARCHAR (250)  NULL,
	USGSCategoryNameCV VARCHAR (250)  NULL,
	NAICSCodeNameCV VARCHAR (250)  NULL
);

CREATE TABLE CVs_AggregationStatistic (
	Name VARCHAR (250)  NOT NULL PRIMARY KEY,
	Term VARCHAR (250)  NOT NULL,
	Definition VARCHAR (5000)  NULL,
	Category VARCHAR (250)  NULL,
	SourceVocabularyURI	 VARCHAR (250)  NULL
);

CREATE TABLE CVs_CropType (
	Name VARCHAR (250)  NOT NULL PRIMARY KEY,
	Term VARCHAR (250)  NULL,
	Definition VARCHAR (5000)  NULL,
	Category VARCHAR (250)  NULL,
	SourceVocabularyURI VARCHAR (250)  NULL
);

CREATE TABLE CVs_EPSGCode (
	Name VARCHAR (250)  NOT NULL PRIMARY KEY,
	Term VARCHAR (250)  NOT NULL,
	Definition VARCHAR (5000)  NULL,
	Category VARCHAR (250)  NULL,
	SourceVocabularyURI	 VARCHAR (250)  NULL
);

CREATE TABLE CVs_GNISFeatureName (
	Name VARCHAR (250)  NOT NULL PRIMARY KEY,
	Term VARCHAR (250)  NOT NULL,
	Definition VARCHAR (5000)  NULL,
	Category VARCHAR (250)  NULL,
	SourceVocabularyURI	 VARCHAR (250)  NULL
);

CREATE TABLE CVs_IrrigationMethod (
	Name VARCHAR (250)  NOT NULL PRIMARY KEY,
	Term VARCHAR (250)  NULL,
	Definition VARCHAR (5000)  NULL,
	Category VARCHAR (250)  NULL,
	SourceVocabularyURI VARCHAR (250)  NULL
);

CREATE TABLE CVs_LegalStatus (
	Name VARCHAR (250)  NOT NULL PRIMARY KEY,
	Term VARCHAR (250)  NOT NULL,
	Definition VARCHAR (5000)  NULL,
	Category VARCHAR (250)  NULL,
	SourceVocabularyURI	 VARCHAR (250)  NULL
);

CREATE TABLE CVs_MethodType (
	Name VARCHAR (250)  NOT NULL PRIMARY KEY,
	Term VARCHAR (250)  NOT NULL,
	Definition VARCHAR (5000)  NULL,
	Category VARCHAR (250)  NULL,
	SourceVocabularyURI	 VARCHAR (250)  NULL
);

CREATE TABLE CVs_NAICSCode (
	Name VARCHAR (250)  NOT NULL PRIMARY KEY,
	Term VARCHAR (250)  NOT NULL,
	Definition VARCHAR (5000)  NULL,
	Category VARCHAR (250)  NULL,
	SourceVocabularyURI	 VARCHAR (250)  NULL
);

CREATE TABLE CVs_NHDNetworkStatus (
	Name VARCHAR (250)  NOT NULL PRIMARY KEY,
	Term VARCHAR (250)  NOT NULL,
	Definition VARCHAR (5000)  NULL,
	Category VARCHAR (250)  NULL,
	SourceVocabularyURI	 VARCHAR (250)  NULL
);

CREATE TABLE CVs_NHDProduct (
	Name VARCHAR (250)  NOT NULL PRIMARY KEY,
	Term VARCHAR (250)  NOT NULL,
	Definition VARCHAR (5000)  NULL,
	Category VARCHAR (250)  NULL,
	SourceVocabularyURI	 VARCHAR (250)  NULL
);

CREATE TABLE CVs_RegulatoryStatus (
	Name VARCHAR (250)  NOT NULL PRIMARY KEY,
	Term VARCHAR (250)  NOT NULL,
	Definition VARCHAR (5000)  NULL,
	Category VARCHAR (250)  NULL,
	SourceVocabularyURI	 VARCHAR (250)  NULL
);

CREATE TABLE CVs_ReportingUnitType (
	Name VARCHAR (250)  NOT NULL PRIMARY KEY,
	Term VARCHAR (250)  NOT NULL,
	Definition VARCHAR (5000)  NULL,
	Category VARCHAR (250)  NULL,
	SourceVocabularyURI	 VARCHAR (250)  NULL
);

CREATE TABLE CVs_ReportYearCV (
	Name VARCHAR (4)  NOT NULL PRIMARY KEY,
	Term VARCHAR (250)  NOT NULL,
	Definition VARCHAR (5000)  NULL,
	Category VARCHAR (250)  NULL,
	SourceVocabularyURI	 VARCHAR (250)  NULL
);

CREATE TABLE CVs_ReportYearType (
	Name VARCHAR (250)  NOT NULL PRIMARY KEY,
	Term VARCHAR (250)  NOT NULL,
	Definition VARCHAR (5000)  NULL,
	Category VARCHAR (250)  NULL,
	SourceVocabularyURI	 VARCHAR (250)  NULL
);

CREATE TABLE CVs_Units (
	Name VARCHAR (250)  NOT NULL PRIMARY KEY,
	Term VARCHAR (250)  NOT NULL,
	Definition VARCHAR (5000)  NULL,
	Category VARCHAR (250)  NULL,
	SourceVocabularyURI	 VARCHAR (250)  NULL
);

CREATE TABLE CVs_USGSCategory (
	Name VARCHAR (250)  NOT NULL PRIMARY KEY,
	Term VARCHAR (250)  NOT NULL,
	Definition VARCHAR (5000)  NULL,
	Category VARCHAR (250)  NULL,
	SourceVocabularyURI	 VARCHAR (250)  NULL
);

CREATE TABLE CVs_Variable (
	Name VARCHAR (250)  NOT NULL PRIMARY KEY,
	Term VARCHAR (250)  NOT NULL,
	Definition VARCHAR (5000)  NULL,
	Category VARCHAR (250)  NULL,
	SourceVocabularyURI	 VARCHAR (250)  NULL
);

CREATE TABLE CVs_VariableSpecific (
	Name VARCHAR (250)  NOT NULL PRIMARY KEY,
	Term VARCHAR (250)  NOT NULL,
	Definition VARCHAR (5000)  NULL,
	Category VARCHAR (250)  NULL,
	SourceVocabularyURI VARCHAR (250)  NULL
);

CREATE TABLE CVs_WaterAllocationBasis (
	Name VARCHAR (250)  NOT NULL PRIMARY KEY,
	Term VARCHAR (250)  NOT NULL,
	Definition VARCHAR (5000)  NULL,
	Category VARCHAR (250)  NULL,
	SourceVocabularyURI	 VARCHAR (250)  NULL
);

CREATE TABLE CVs_WaterQualityIndicator (
	Name VARCHAR (250)  NOT NULL PRIMARY KEY,
	Term VARCHAR (250)  NOT NULL,
	Definition VARCHAR (5000)  NULL,
	Category VARCHAR (250)  NULL,
	SourceVocabularyURI	 VARCHAR (250)  NULL
);

CREATE TABLE CVs_WaterSourceType (
	Name VARCHAR (250)  NOT NULL PRIMARY KEY,
	Term VARCHAR (250)  NOT NULL,
	Definition VARCHAR (5000)  NULL,
	Category VARCHAR (250)  NULL,
	SourceVocabularyURI	 VARCHAR (250)  NULL
);

CREATE TABLE Date_dim (
	DateID INT   NOT NULL PRIMARY KEY,
	Date DATE   NOT NULL,
	Year VARCHAR (4)  NULL
);

CREATE TABLE Methods_dim (
	MethodID INT   NOT NULL PRIMARY KEY,
	MethodUUID VARCHAR (100)  NOT NULL,
	MethodName VARCHAR (50)  NOT NULL,
	MethodDescription TEXT   NOT NULL,
	MethodNEMILink VARCHAR (100)  NULL,
	ApplicableResourceTypeCV VARCHAR (100)  NOT NULL,
	MethodTypeCV VARCHAR (50)  NOT NULL,
	DataCoverageValue VARCHAR (100)  NULL,
	DataQualityValueCV VARCHAR (50)  NULL,
	DataConfidenceValue VARCHAR (50)  NULL
);

CREATE TABLE NHDMetadata (
	NHDMetadataID INT   NOT NULL PRIMARY KEY,
	NHDNetworkStatusCV VARCHAR (50)  NOT NULL,
	NHDProductCV VARCHAR (50)  NULL,
	NHDUpdateDate DATE   NULL,
	NHDReachCode VARCHAR (50)  NULL,
	NHDMeasureNumber VARCHAR (50)  NULL
);

CREATE TABLE Organizations_dim (
	OrganizationID INT   NOT NULL PRIMARY KEY,
	OrganizationUUID VARCHAR (250)  NOT NULL,
	OrganizationName VARCHAR (250)  NOT NULL,
	OrganizationPurview VARCHAR (250)  NULL,
	OrganizationWebsite VARCHAR (250)  NOT NULL,
	OrganizationPhoneNumber VARCHAR (250)  NOT NULL,
	OrganizationContactName VARCHAR (250)  NOT NULL,
	OrganizationContactEmail VARCHAR (250)  NOT NULL
);

CREATE TABLE RegulatoryOverlay_dim (
	RegulatoryOverlayID INT   NOT NULL PRIMARY KEY,
	RegulatoryOverlayUUID VARCHAR (250)  NULL,
	RegulatoryOverlayNativeID VARCHAR (250)  NULL,
	RegulatoryName VARCHAR (50)  NOT NULL,
	RegulatoryDescription TEXT   NOT NULL,
	RegulatoryStatusCV VARCHAR (50)  NOT NULL,
	OversightAgency VARCHAR (250)  NOT NULL,
	RegulatoryStatute VARCHAR (500)  NULL,
	RegulatoryStatuteLink VARCHAR (500)  NULL,
	TimeframeStartID INT   NOT NULL,
	TimeframeEndID INT   NOT NULL,
	ReportYearTypeCV VARCHAR (10)  NOT NULL,
	ReportYearStartMonth VARCHAR (5)  NOT NULL
);

CREATE TABLE RegulatoryReportingUnits_fact (
	BridgeID INT   NOT NULL PRIMARY KEY,
	RegulatoryOverlayID INT   NOT NULL,
	OrganizationID INT   NOT NULL,
	ReportingUnitID INT   NOT NULL,
	DataPublicationDateID INT   NOT NULL,
	ReportYearCV VARCHAR (4)  NOT NULL
);

CREATE TABLE ReportingUnits_dim (
	ReportingUnitID INT   NOT NULL PRIMARY KEY,
	ReportingUnitUUID VARCHAR (250)  NOT NULL,
	ReportingUnitNativeID VARCHAR (250)  NOT NULL,
	ReportingUnitName VARCHAR (250)  NOT NULL,
	ReportingUnitTypeCV VARCHAR (20)  NOT NULL,
	ReportingUnitUpdateDate DATE   NULL,
	ReportingUnitProductVersion VARCHAR (100)  NULL,
	StateCV VARCHAR (50)  NOT NULL,
	EPSGCodeCV VARCHAR (50)  NULL,
	Geometry BLOB   NULL
);

CREATE TABLE ReportYear_Dim (
	ReportYearId INT   NOT NULL PRIMARY KEY,
	ReportYearCV VARCHAR (4)  NOT NULL
);

CREATE TABLE Sites_dim (
	SiteID INT   NOT NULL PRIMARY KEY,
	SiteUUID VARCHAR (55)  NOT NULL,
	SiteNativeID VARCHAR (50)  NULL,
	SiteName VARCHAR (500)  NOT NULL,
	SiteTypeCV VARCHAR (100)  NULL,
	Longitude VARCHAR (50)  NOT NULL,
	Latitude VARCHAR (50)  NOT NULL,
	Geometry BLOB   NULL,
	CoordinateMethodCV VARCHAR (100)  NOT NULL,
	CoordinateAccuracy VARCHAR (255)  NULL,
	GNISCodeCV VARCHAR (50)  NULL,
	NHDMetadataID INT   NULL
);

CREATE TABLE SitesBridge_BeneficialUses_fact (
	SiteBridgeID INT   NOT NULL PRIMARY KEY,
	BeneficialUseID INT   NOT NULL,
	SiteVariableAmountID INT   NOT NULL
);

CREATE TABLE SiteVariableAmounts_fact (
	SiteVariableAmountID INT   NOT NULL PRIMARY KEY,
	OrganizationID INT   NOT NULL,
	AllocationID INT   NULL,
	SiteID INT   NOT NULL,
	VariableSpecificID INT   NOT NULL,
	BeneficialUseID INT   NOT NULL,
	WaterSourceID INT   NOT NULL,
	MethodID INT   NOT NULL,
	TimeframeStart INT   NOT NULL,
	TimeframeEnd INT   NOT NULL,
	DataPublicationDate INT   NOT NULL,
	ReportYear VARCHAR (4)  NULL,
	Amount FLOAT   NOT NULL,
	PopulationServed FLOAT   NULL,
	PowerGeneratedGWh FLOAT   NULL,
	IrrigatedAcreage FLOAT   NULL,
	IrrigationMethodCV VARCHAR (100)  NULL,
	CropTypeCV VARCHAR (100)  NULL,
	InterbasinTransferFromID VARCHAR (100)  NULL,
	InterbasinTransferToID VARCHAR (100)  NULL,
	Geometry BLOB   NULL
);

CREATE TABLE USGSCategory_dim (
	USGSId INT   NOT NULL PRIMARY KEY
);

CREATE TABLE Variables_dim (
	VariableSpecificID INT   NOT NULL PRIMARY KEY,
	VariableSpecificUUID VARCHAR (250)  NULL,
	VariableSpecificCV VARCHAR (250)  NOT NULL,
	VariableCV VARCHAR (250)  NOT NULL,
	AggregationStatisticCV VARCHAR (50)  NOT NULL,
	AggregationInterval  NUMERIC (10)  NOT NULL,
	AggregationIntervalUnitCV  VARCHAR (50)  NOT NULL,
	ReportYearStartMonth  VARCHAR (10)  NOT NULL,
	ReportYearTypeCV  VARCHAR (10)  NOT NULL,
	AmountUnitCV VARCHAR (250)  NOT NULL,
	MaximumAmountUnitCV VARCHAR (255)  NULL
);

CREATE TABLE WaterSources_dim (
	WaterSourceID INT   NOT NULL PRIMARY KEY,
	WaterSourceUUID VARCHAR (100)  NOT NULL,
	WaterSourceNativeID VARCHAR (250)  NULL,
	WaterSourceName VARCHAR (250)  NULL,
	WaterSourceTypeCV VARCHAR (100)  NOT NULL,
	WaterQualityIndicatorCV VARCHAR (100)  NOT NULL,
	GNISFeatureNameCV VARCHAR (250)  NULL,
	Geometry BLOB   NULL
);


ALTER TABLE AggBridge_BeneficialUses_fact ADD CONSTRAINT fk_AggBridge_BeneficialUses_fact_AggregatedAmounts_fact
FOREIGN KEY (AggregatedAmountID) REFERENCES AggregatedAmounts_fact (AggregatedAmountID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AggBridge_BeneficialUses_fact ADD CONSTRAINT fk_AggBridge_BeneficialUses_fact_BeneficialUses_dim
FOREIGN KEY (BeneficialUseID) REFERENCES BeneficialUses_dim (BeneficialUseID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AggregatedAmounts_fact ADD CONSTRAINT fk_AggregatedAmounts_Date_dim_end
FOREIGN KEY (TimeframeEndID) REFERENCES Date_dim (DateID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AggregatedAmounts_fact ADD CONSTRAINT fk_AggregatedAmounts_Date_dim_end_pub
FOREIGN KEY (DataPublicationDate) REFERENCES Date_dim (DateID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AggregatedAmounts_fact ADD CONSTRAINT fk_AggregatedAmounts_Date_dim_start
FOREIGN KEY (TimeframeStartID) REFERENCES Date_dim (DateID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AggregatedAmounts_fact ADD CONSTRAINT fk_AggregatedAmounts_fact_BeneficialUses_dim
FOREIGN KEY (BeneficialUseID) REFERENCES BeneficialUses_dim (BeneficialUseID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AggregatedAmounts_fact ADD CONSTRAINT fk_AggregatedAmounts_fact_CVs_ReportYearCV
FOREIGN KEY (ReportYear) REFERENCES CVs_ReportYearCV (Name)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AggregatedAmounts_fact ADD CONSTRAINT fk_AggregatedAmounts_fact_Methods_dim
FOREIGN KEY (MethodID) REFERENCES Methods_dim (MethodID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AggregatedAmounts_fact ADD CONSTRAINT fk_AggregatedAmounts_fact_Organizations_dim
FOREIGN KEY (OrganizationID) REFERENCES Organizations_dim (OrganizationID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AggregatedAmounts_fact ADD CONSTRAINT fk_AggregatedAmounts_fact_ReportingUnits_dim
FOREIGN KEY (ReportingUnitID) REFERENCES ReportingUnits_dim (ReportingUnitID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AggregatedAmounts_fact ADD CONSTRAINT fk_AggregatedAmounts_fact_Variables_dim
FOREIGN KEY (VariableSpecificID) REFERENCES Variables_dim (VariableSpecificID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AggregatedAmounts_fact ADD CONSTRAINT fk_AggregatedAmounts_fact_WaterSources_dim
FOREIGN KEY (WaterSourceID) REFERENCES WaterSources_dim (WaterSourceID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AllocationAmounts_fact ADD CONSTRAINT fk_AllocationAmounts_fact_Allocations_dim
FOREIGN KEY (AllocationID) REFERENCES Allocations_dim (AllocationID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AllocationAmounts_fact ADD CONSTRAINT fk_AllocationAmounts_fact_BeneficialUses_dim
FOREIGN KEY (BeneficialUsesID) REFERENCES BeneficialUses_dim (BeneficialUseID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AllocationAmounts_fact ADD CONSTRAINT fk_AllocationAmounts_fact_CVs_ReportYearCV
FOREIGN KEY (ReportYear) REFERENCES CVs_ReportYearCV (Name)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AllocationAmounts_fact ADD CONSTRAINT fk_AllocationAmounts_fact_Date_dim_end
FOREIGN KEY (TimeframeEndDateID) REFERENCES Date_dim (DateID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AllocationAmounts_fact ADD CONSTRAINT fk_AllocationAmounts_fact_Date_dim_start
FOREIGN KEY (TimeframeStartDateID) REFERENCES Date_dim (DateID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AllocationAmounts_fact ADD CONSTRAINT fk_AllocationAmounts_fact_Date_pub
FOREIGN KEY (DataPublicationDateID) REFERENCES Date_dim (DateID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AllocationAmounts_fact ADD CONSTRAINT fk_AllocationAmounts_fact_Methods_dim
FOREIGN KEY (MethodID) REFERENCES Methods_dim (MethodID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AllocationAmounts_fact ADD CONSTRAINT fk_AllocationAmounts_fact_Organizations_dim
FOREIGN KEY (OrganizationID) REFERENCES Organizations_dim (OrganizationID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AllocationAmounts_fact ADD CONSTRAINT fk_AllocationAmounts_fact_Sites_dim
FOREIGN KEY (SiteID) REFERENCES Sites_dim (SiteID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AllocationAmounts_fact ADD CONSTRAINT fk_AllocationAmounts_fact_Variables_dim
FOREIGN KEY (VariableSpecificID) REFERENCES Variables_dim (VariableSpecificID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AllocationAmounts_fact ADD CONSTRAINT fk_AllocationAmounts_fact_WaterSources_dim
FOREIGN KEY (WaterSourceID) REFERENCES WaterSources_dim (WaterSourceID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AllocationBridge_BeneficialUses_fact ADD CONSTRAINT fk_AllocationBridge_BeneficialUses_fact_AllocationAmounts_fact
FOREIGN KEY (AllocationAmountID) REFERENCES AllocationAmounts_fact (AllocationAmountID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE AllocationBridge_BeneficialUses_fact ADD CONSTRAINT fk_AllocationBridge_BeneficialUses_fact_BeneficialUses_dim
FOREIGN KEY (BeneficialUseID) REFERENCES BeneficialUses_dim (BeneficialUseID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE Allocations_dim ADD CONSTRAINT fk_Allocations_dim_Date_dim_app
FOREIGN KEY (AllocationApplicationDate) REFERENCES Date_dim (DateID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE Allocations_dim ADD CONSTRAINT fk_Allocations_dim_Date_dim_exp
FOREIGN KEY (AllocationExpirationDate) REFERENCES Date_dim (DateID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE Allocations_dim ADD CONSTRAINT fk_Allocations_dim_Date_dim_prio
FOREIGN KEY (AllocationPriorityDate) REFERENCES Date_dim (DateID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE BeneficialUses_dim ADD CONSTRAINT fk_BeneficialUses_dim_CVs_NAICSCode
FOREIGN KEY (NAICSCodeNameCV) REFERENCES CVs_NAICSCode (Name)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE BeneficialUses_dim ADD CONSTRAINT fk_BeneficialUses_dim_CVs_USGSCategory
FOREIGN KEY (USGSCategoryNameCV) REFERENCES CVs_USGSCategory (Name)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE RegulatoryOverlay_dim ADD CONSTRAINT fk_RegulatoryOverlay_dim_Date_dim_end
FOREIGN KEY (TimeframeEndID) REFERENCES Date_dim (DateID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE RegulatoryOverlay_dim ADD CONSTRAINT fk_RegulatoryOverlay_dim_Date_dim_start
FOREIGN KEY (TimeframeStartID) REFERENCES Date_dim (DateID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE RegulatoryReportingUnits_fact ADD CONSTRAINT fk_RegulatoryReportingUnits_fact_Date_dim
FOREIGN KEY (DataPublicationDateID) REFERENCES Date_dim (DateID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE RegulatoryReportingUnits_fact ADD CONSTRAINT fk_RegulatoryReportingUnits_fact_Organizations_dim
FOREIGN KEY (OrganizationID) REFERENCES Organizations_dim (OrganizationID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE RegulatoryReportingUnits_fact ADD CONSTRAINT fk_RegulatoryReportingUnits_fact_RegulatoryOverlay_dim
FOREIGN KEY (RegulatoryOverlayID) REFERENCES RegulatoryOverlay_dim (RegulatoryOverlayID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE RegulatoryReportingUnits_fact ADD CONSTRAINT fk_RegulatoryReportingUnits_fact_ReportingUnits_dim
FOREIGN KEY (ReportingUnitID) REFERENCES ReportingUnits_dim (ReportingUnitID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE Sites_dim ADD CONSTRAINT fk_Sites_NHDMetadata
FOREIGN KEY (NHDMetadataID) REFERENCES NHDMetadata (NHDMetadataID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE SitesBridge_BeneficialUses_fact ADD CONSTRAINT fk_SitesBridge_BeneficialUses_fact_BeneficialUses_dim
FOREIGN KEY (BeneficialUseID) REFERENCES BeneficialUses_dim (BeneficialUseID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE SitesBridge_BeneficialUses_fact ADD CONSTRAINT fk_SitesBridge_BeneficialUses_fact_SiteVariableAmounts_fact
FOREIGN KEY (SiteVariableAmountID) REFERENCES SiteVariableAmounts_fact (SiteVariableAmountID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE SiteVariableAmounts_fact ADD CONSTRAINT fk_SiteVariableAmounts_Date_dim_end
FOREIGN KEY (TimeframeEnd) REFERENCES Date_dim (DateID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE SiteVariableAmounts_fact ADD CONSTRAINT fk_SiteVariableAmounts_Date_dim_pub
FOREIGN KEY (DataPublicationDate) REFERENCES Date_dim (DateID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE SiteVariableAmounts_fact ADD CONSTRAINT fk_SiteVariableAmounts_Date_dim_start
FOREIGN KEY (TimeframeStart) REFERENCES Date_dim (DateID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE SiteVariableAmounts_fact ADD CONSTRAINT fk_SiteVariableAmounts_fact_Allocations_dim
FOREIGN KEY (AllocationID) REFERENCES Allocations_dim (AllocationID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE SiteVariableAmounts_fact ADD CONSTRAINT fk_SiteVariableAmounts_fact_BeneficialUses_dim
FOREIGN KEY (BeneficialUseID) REFERENCES BeneficialUses_dim (BeneficialUseID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE SiteVariableAmounts_fact ADD CONSTRAINT fk_SiteVariableAmounts_fact_CVs_ReportYearCV
FOREIGN KEY (ReportYear) REFERENCES CVs_ReportYearCV (Name)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE SiteVariableAmounts_fact ADD CONSTRAINT fk_SiteVariableAmounts_fact_Methods_dim
FOREIGN KEY (MethodID) REFERENCES Methods_dim (MethodID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE SiteVariableAmounts_fact ADD CONSTRAINT fk_SiteVariableAmounts_fact_Organizations_dim
FOREIGN KEY (OrganizationID) REFERENCES Organizations_dim (OrganizationID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE SiteVariableAmounts_fact ADD CONSTRAINT fk_SiteVariableAmounts_fact_Sites_dim
FOREIGN KEY (SiteID) REFERENCES Sites_dim (SiteID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE SiteVariableAmounts_fact ADD CONSTRAINT fk_SiteVariableAmounts_fact_Variables_dim
FOREIGN KEY (VariableSpecificID) REFERENCES Variables_dim (VariableSpecificID)
ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE SiteVariableAmounts_fact ADD CONSTRAINT fk_SiteVariableAmounts_fact_WaterSources_dim
FOREIGN KEY (WaterSourceID) REFERENCES WaterSources_dim (WaterSourceID)
ON UPDATE NO ACTION ON DELETE NO ACTION;