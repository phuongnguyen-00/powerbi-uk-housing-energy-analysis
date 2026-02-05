//---------------------------------------------
// MASTER DATA IMPORT & CLEANING (Power Query)
// Author: Phuong Nguyen
// Description:
// This script loads master data files from a 
// SharePoint directory, cleans column names, 
// changes data types, and returns final tables.
//---------------------------------------------

//=============================================
// LOAD SHAREPOINT DIRECTORY
//=============================================

// Connect to a SharePoint folder (placeholder domain)
// Replace with your real URL when deploying
Source = SharePoint.Files("https://example.sharepoint.com/sites/dataset", [ApiVersion = 15]),


//=============================================
// FILTER: MASTER CUSTOMER DATA
//=============================================

// Filter for the "master_customer" folder
MasterCustomerFolder = 
    Table.SelectRows(Source, each Text.Contains([Folder Path], "master_customer")),

// Remove non-files (keep only real files)
MasterCustomerOnlyFiles =
    Table.SelectRows(MasterCustomerFolder, each [Extension] <> null),

// Import the CSV file
MasterCustomerImported = 
    Csv.Document(
        MasterCustomerOnlyFiles{0}[Content],
        [Delimiter=",", Columns=5, Encoding=65001, QuoteStyle=QuoteStyle.None]
    ),

// Promote the first row as header
MasterCustomerHeaders = Table.PromoteHeaders(MasterCustomerImported, [PromoteAllScalars=true]),

// Clean column names (lowercase + underscores)
MasterCustomerRename =
    Table.TransformColumnNames(MasterCustomerHeaders, Text.Lower),
MasterCustomerRenameUnderscore =
    Table.TransformColumnNames(MasterCustomerRename, each Text.Replace(_, " ", "_")),

// Convert data types
MasterCustomerTyped =
    Table.TransformColumnTypes(
        MasterCustomerRenameUnderscore,
        {
            {"customer_id", Int64.Type},
            {"customer_name", type text},
            {"customer_type", type text},
            {"address", type text},
            {"active_flag", Int64.Type}
        }
    ),


//=============================================
// FILTER: MASTER ITEMS DATA
//=============================================

MasterItemsFolder = 
    Table.SelectRows(Source, each Text.Contains([Folder Path], "master_items")),
MasterItemsOnlyFiles =
    Table.SelectRows(MasterItemsFolder, each [Extension] <> null),

MasterItemsImported = 
    Csv.Document(
        MasterItemsOnlyFiles{0}[Content],
        [Delimiter=",", Columns=6, Encoding=65001, QuoteStyle=QuoteStyle.None]
    ),

MasterItemsHeaders = Table.PromoteHeaders(MasterItemsImported, [PromoteAllScalars=true]),
MasterItemsRename =
    Table.TransformColumnNames(MasterItemsHeaders, Text.Lower),
MasterItemsRenameUnderscore =
    Table.TransformColumnNames(MasterItemsRename, each Text.Replace(_, " ", "_")),

MasterItemsTyped =
    Table.TransformColumnTypes(
        MasterItemsRenameUnderscore,
        {
            {"item_id", Int64.Type},
            {"item_name", type text},
            {"category", type text},
            {"unit", type text},
            {"price", type number},
            {"active_flag", Int64.Type}
        }
    ),


//=============================================
// FILTER: MASTER EMPLOYEE DATA
//=============================================

MasterEmployeeFolder = 
    Table.SelectRows(Source, each Text.Contains([Folder Path], "master_employee")),
MasterEmployeeOnlyFiles =
    Table.SelectRows(MasterEmployeeFolder, each [Extension] <> null),

MasterEmployeeImported = 
    Csv.Document(
        MasterEmployeeOnlyFiles{0}[Content],
        [Delimiter=",", Columns=4, Encoding=65001, QuoteStyle=QuoteStyle.None]
    ),

MasterEmployeeHeaders = Table.PromoteHeaders(MasterEmployeeImported, [PromoteAllScalars=true]),
MasterEmployeeRename =
    Table.TransformColumnNames(MasterEmployeeHeaders, Text.Lower),
MasterEmployeeRenameUnderscore =
    Table.TransformColumnNames(MasterEmployeeRename, each Text.Replace(_, " ", "_")),

MasterEmployeeTyped =
    Table.TransformColumnTypes(
        MasterEmployeeRenameUnderscore,
        {
            {"employee_id", Int64.Type},
            {"employee_name", type text},
            {"department", type text},
            {"active_flag", Int64.Type}
        }
    ),


//=============================================
// FILTER: MASTER INVENTORY DATA
//=============================================

MasterInventoryFolder = 
    Table.SelectRows(Source, each Text.Contains([Folder Path], "master_inventory")),
MasterInventoryOnlyFiles =
    Table.SelectRows(MasterInventoryFolder, each [Extension] <> null),

MasterInventoryImported = 
    Csv.Document(
        MasterInventoryOnlyFiles{0}[Content],
        [Delimiter=",", Columns=5, Encoding=65001, QuoteStyle=QuoteStyle.None]
    ),

MasterInventoryHeaders = Table.PromoteHeaders(MasterInventoryImported, [PromoteAllScalars=true]),
MasterInventoryRename =
    Table.TransformColumnNames(MasterInventoryHeaders, Text.Lower),
MasterInventoryRenameUnderscore =
    Table.TransformColumnNames(MasterInventoryRename, each Text.Replace(_, " ", "_")),

MasterInventoryTyped =
    Table.TransformColumnTypes(
        MasterInventoryRenameUnderscore,
        {
            {"item_id", Int64.Type},
            {"location", type text},
            {"quantity_on_hand", Int64.Type},
            {"quantity_reserved", Int64.Type},
            {"last_updated", type datetime}
        }
    )

in
    // Return a record containing all cleaned tables
    [
        MasterCustomer = MasterCustomerTyped,
        MasterItems = MasterItemsTyped,
        MasterEmployee = MasterEmployeeTyped,
        MasterInventory = MasterInventoryTyped
    ]