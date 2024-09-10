    Include('c25_ProgramHandlerClass.inc'),Once
    Include('c25_ExtendedDataTypes.inc'),Once

c25_DataTableClass                                                      Class(),Type,Module('c25_DataTableClass.clw'), Link('c25_DataTableClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                                                                   Procedure()
Destruct                                                                    Procedure()

INCLUDE('CWMVars.clw')

Buffer16K                                                                   String(17000)
CallbackClassPtr                                                            long
CaseSensitive                                                               BOOL
ClarionFieldsCountOut                                                       long
ColumnsIdSeed                                                               long
CreateQueueWindowHandle                                                     Long

DataSetPtr                                                                  LONG
DCC_Count                                                                   Int32
DCC_RowAllocSize                                                            Int32
DCC_StructureLength                                                         Int32

MemoryId                                                                    Long
ParentClassPtr                                                              long
ProcessHeapHandle                                                           Long
ReturnVal                                                                   LONG
RowsCount                                                                   long
TransactionLocked                                                           BOOL
TransactionLockFromThreadHandle                                             long
TransactionLockTimeout                                                      Decimal(20,0)
TransactionLockTypeEnum                                                     long
LockEscalation                                                              cstring(128)
LockEscalationEnum                                                          Long


SqliteConnHandle                                                            Long
LastRowId                                                                   long
ClassTypeName                                                               cstring(128)


AWEClass                                                                    &c25_AWEClass
BitConverterClass                                                           &c25_BitConverterClass
DataReflectionClass                                                         &c25_DataReflectionClass
DllDataReflectionClass                                                      &c25_DataReflectionClass
DllLoaderClass                                                              &c25_DllLoaderClass
MessageOnlyWindowClass                                                      &c25_MessageOnlyWindowClass
NanoClockClass                                                              &c25_NanoSyncClass
ObjectClass                                                                 &c25_ObjectClass
ObjectClassDummy                                                            &c25_ObjectClass
ProgramHandlerClass                                                         &c25_ProgramHandlerClass
QueueCreateClass                                                            &C25_QueueCreateClass
SqliteClass                                                                 &C25_SqliteClass
DataRows                                                                    &DataRow_TYPE


!ChildRelations                                                              &DataTableChildRelation_TYPE
ClaListboxFormatString                                                      &STRING
ClaQueue                                                                    &QUEUE
ClaQueueByteArray                                                           &STRING
ClaQueueByteArrayNew                                                        &STRING
ClarionFieldsIn                                                             &ClarionFields_TYPE
ClarionFieldsOut                                                            &ClarionFields_TYPE
Columns                                                                     &DataColumnCollection_TYPE
Constraints                                                                 &DataConstraintCollection_TYPE
DataSet                                                                     &DataSetClass
JsonClarionExtStructure                                                     &JSONClass
JsonClarionExtStructureString                                               &StringTheory
JsonClarionStructure                                                        &JSONClass
JsonClarionStructureString                                                  &StringTheory
JsonOut                                                                     &STRING
Name                                                                        &String
QInfo                                                                       &Q_TYPE
stDLLQueueDeclaration                                                       &StringTheory
stLogTryCreateColumns                                                       &StringTheory
stNewDLLStructure                                                           &StringTheory
Q3                                                                          &Q3_TYPE
ClarionFieldsQ3                                                             &ClarionFields_TYPE
Rows                                                                        &DataRow_TYPE


SetRowCursor                                                                Procedure(string _rowId),string,proc

DataRowAddNew                                                               Procedure(),string
!DataRowAdd                                                                  Procedure(),string
AddQueueRow                                                                 Procedure(<*queue _q>, <ClarionFields_TYPE _clarionFields>),string,proc
CalculateDLLProperties                                                      Procedure(),string,proc
ClarionFieldsToColumnsCollection                                            Procedure(<ClarionFields_TYPE _clarionFields>),long,proc
CreateColumnsCollection                                                     Procedure()
CreateDLLQueueDeclaration                                                   Procedure(),long,PROC
CreateNewColumnOld                                                          Procedure(<string _name>, <string _dataType>, <string _dataLength>, <bool _allowDBNull>, <string _value>, <long _valueLen>, <long _valuePtr>, <long _valueSize>)
CreateSqliteMemoryTable                                                     Procedure(),Long,proc
DeleteDataRow                                                               Procedure(string _index64),string,PROC
DisposeColumnsCollection                                                    Procedure()
FlushClaQueue                                                               Procedure(),Long,proc
GetCreateQueueClassWindowHandle                                             Procedure(),Long,proc
GetDataCellValue                                                            Procedure(*c25_DataCellClass _dataCell),string,PROC
GetDummyQueueDll                                                            Procedure(),string
GetRowsCount                                                                Procedure(),long
JsonToClarionFields                                                         Procedure(<string _jsonString>),long,Proc
SetDataCellValue                                                            Procedure(*c25_DataCellClass _dataCell),long,PROC
WndProc_Process                                                             Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam, bool Processed, long ReturnVal, <*bool PostProcess>)
WriteNewDLLBlock                                                            Procedure(),long,PROC
AddClarionQueueRowToQ3Blob                                                  Procedure(*queue _qSource, <bool _isLast>),long,proc !*Queue _qRow, <ClarionFields_TYPE _clarionFields>),string
ClaQueueToDataTable                                                         Procedure(*queue _claQueue),long,proc
                                                                        End


