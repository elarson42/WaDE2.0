# WaDE 2.0 
The next version of the Water Data Exchange (WaDE) program. An agreed upon metadata standard and information system for sharing water budget data in the US. Water budgets data include site specific and aggregated water rights, water supplies, use, return flows, and transfers at geospatial areas. 


## [A Design Document for the Water Data Exchange (WaDE) Program – Phase II](https://github.com/WSWCWaterDataExchange/WaDE2.0/tree/master/Design_docs)   
* Why WaDE 2.0?, use cases, and the conceptual design    
* WaDE 2.0 draft star schema for OLAP system   
* WaDE 2.0 blank database copies for RDBMS   
* Sample input data for WaDE 2.0   
* Use cases and SQL queries to test the design

## Conceptual workflow of the next WaDE 2.0 system
![](https://github.com/WSWCWaterDataExchange/WaDE2.0/blob/master/Design_docs/Diagrams/WaDE_workflow.jpg)


How to import data into the database, locally?
1.	Head to the https://github.com/WSWCWaterDataExchange/WaDE2.0 and clone it with the VS.

		Under the repository name, click Clone or download.
		In the Clone with HTTPs section, click the copy icon to copy the clone URL for the repository.
		Open Git Bash.
		Change the current working directory to the location where you want the cloned directory to be made.
		Type git clone, and then paste the URL you copied.
		Press Enter. Your local clone will be created.

2.	Download Microsoft Azure Storage Explorer from https://azure.microsoft.com/en-us/features/storage-explorer/ link and run it.
3.	Download Microsoft Azure Storage Emulator from https://docs.microsoft.com/en-us/azure/storage/common/storage-use-emulator link and run it.
4.	In the Microsoft Azure Storage Explorer window, head to the Storage Accounts/local-1 (key)/Blob Containers/normalizedimports and then the folder which is related to the import data.
5.	Make sure that the Csv file fields are in a good format. 

		Check if the Csv file fields order, matches the order of the fields in the related type table. 
		To check this, open the Microsoft SQL Server Management Studio, head to the Databases/WaDE2/programmability/Types/User-Defined Table Types and check the related table type.

		Make sure that the foreign key relationships are holding (if a value which is a foreign key, is going to be inserted, make sure it exists in the reference table as well).

6.	If you want to add a new Csv file, you can upload it through the Explorer window.
7.	Load the startup section of VS with WaDEImportFunctions and run it.
8.	Open a browser tab.
9.	Type http://localhost:7071/api/LoadWaterAllocationData?runid=   
10.	In front of the equal sign, type the name of the folder which the csv file exists inside, in the explorer window.
11.	press enter.
12.	The import function should run successfully. 




