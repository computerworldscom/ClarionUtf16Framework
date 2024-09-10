    Include('c25_ProgramHandlerClass.inc'),Once
    Include('c25_ExtendedDataTypes.inc'),Once

c25_DataManagerClass                                                    Class(),type,Module('c25_DataManagerClass.clw'), Link('c25_DataManagerClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)

Construct                                                                   Procedure()
Destruct                                                                    Procedure()

ClassTypeName                                                               cstring(128)

INCLUDE('CWMVars.clw')

Buffer16K                                                                   String(17000)
CurrentDataTableId                                                          long
CurrentDataTableName                                                        cstring(255)
CurrentDataTablePtr                                                         PtrInt32
CurrentDataTableWinHandle                                                   PtrInt32
DataTableClassesSeedMemoryId                                                LONG
Int32Val                                                                    Int32
ReturnVal                                                                   Long
ReturnString                                                                &String

BitConverterClass                                                           &c25_BitConverterClass
CurrentDataTable                                                            &c25_DataTableClass
DataTableClasses                                                            &DataTableClasses_TYPE
DataTableClassTemp                                                          &c25_DataTableClass
!DllLoaderClass                                                              &c25_DllLoaderClass
MetaReflectionClass                                                         &c25_DataReflectionClass
NanoClock                                                                   &c25_NanoSyncClass
ObjectClass                                                                 &c25_ObjectClass
ProgramHandlerClass                                                         &c25_ProgramHandlerClass
DataCell                                                                    &c25_DataCellClass
Result                                                                      &c25_ResultClass

!CreateDataTableInstance                                                     Procedure(<string _name>, <bool _disposeIfExist>),Int32

GetDataTableMesOnlyWinHandle                                                Procedure(<long _dataTableId>, <string _name>),long
GetDataTableThreadHandle                                                    Procedure(<long _dataTableId>, <string _name>),long
CreateDataTableInstance                                                     Procedure(<string _tableNameOrJsonDef>, <string _columnsJsonDef>, <bool _replaceExistingTable>),Int32
CreateListboxFormatString                                                   Procedure(<Int32 _dataTableId>, <string _dataTableName>),string
CreateQueue                                                                 Procedure(<Int32 _dataTableId>, <string _dataTableName>, <string _jsonClarion>, <string _jsonClarionExtended>),Int32,Proc
DataTable_Exist                                                             Procedure(<string _name>, <bool _disposeIfExist>),BOOL
GetClaListboxFormatString                                                   Procedure(<long _id>, <string _name>),string
GetColumnValue                                                              Procedure(<bool _async>, string _dataTableNameOrId, string _rowIndex, string _columnNameOrOrdinal, <*PtrInt32 _returnPtr>, <*Int32 _returnSizeLo>, <*Int32 _returnSizeHi>),STRING,PASCAL
GetCreateQueueWinHandle                                                     Procedure(),Long
!GetDataTable_Handle                                                         Procedure(<Int32 _id>, <string _name>),Int32
GetDataTable_Id                                                             Procedure(string _name),PtrInt32
GetDataTableInstance                                                        Procedure(<Int32 _dataTableId>, <string _dataTableName>),PtrInt32
GetDataTableInstancePtr                                                     Procedure(<long _id>, <string _name>),PtrInt32
GetDataTableStructure                                                       Procedure(<long _id>, <string _name>),string
SetCellDataColumnInfo                                                       Procedure(*c25_DataTableClass _dataTable, *c25_DataCellClass _cell,  *string _columnNameOrOrdinal)
SetColumnValue                                                              Procedure(<bool _async>, string _dataTableNameOrId, string _rowIndex, string _columnNameOrOrdinal, <ByteArray _value>) ,string,PROC
RemoveDataRow                                                               Procedure(<bool _async>, string _dataTableNameOrId, string _rowIndex),string,PROC
DataRowAddNew                                                               Procedure(<bool _async>, string _dataTableNameOrId),string
AddClarionQRowsToDataRows                                                   Procedure(<bool _async>, string _dataTableNameOrId, *queue _qSource, <long _fromIndex>, <long _untilIndex>, <bool _updateRowIdSource>),long,PROC
AddClarionQRowToDataRow                                                     Procedure(<bool _async>, string _dataTableNameOrId, *queue _qSource, <bool _updateRowIdSource>),long,PROC
ExportDataRows                                                              Procedure(<bool _async>, string _dataTableNameOrId, string _databaseType, string _formatType, string _exportTarget),string,PROC
GetDataTableProperty                                                        Procedure(string _dataTableNameOrId, string _property),string,PROC
SetDataTableProperty                                                        Procedure(string _dataTableNameOrId, string _property, string _value, <long _propertyDataTypeEnum>),string,PROC
                                				                        End


