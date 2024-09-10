    Include('c25_ProgramHandlerClass.inc'),Once

c25_DataSourceClass                                                      Class(),type, Module('c25_DataSourceClass.clw'), Link('c25_DataSourceClass.clw',1),DLL(0)
Construct                                                                       Procedure()
Destruct                                                                        Procedure()


ConnectionString                                                                &String

ProgramHandlerClass                                                             &c25_ProgramHandlerClass
BitConverterClass                                                               &c25_BitConverterClass
Sqlite3Class                                                                    &c25_SqliteClass
BindingSourceClass                                                              &c25_BindingSourceClass
DataReflectionClass                                                             &c25_DataReflectionClass
ClarionFieldsQ                                                                  &ClarionFields_TYPE

ClarionSourceQ                                                                  &QUEUE
ClarionSourceQBytes                                                             &String

CurrentPageBufferClass                                                          &c25_PageBufferClass

PageFilled                                                                      BOOL
CurrentPageBufferGuidId                                                         string(36)

SourceDataColumns                                                               &c25_DataColumnsCollectionClass
SourceFieldsCount                                                               long
SourceIndex                                                                     Like(INT64)
SourceRowCount                                                                  Like(INT64)
SourceRowCountDecimal                                                           Decimal(20)

Init                                                                            Procedure(*c25_BindingSourceClass _bindingSourceClass),Long,proc
SetClarionQueue                                                                 Procedure(*Queue _queue),long,PROC
!SetDataRow                                                                      Procedure(*c25_DataRowClass _dataRowClass),string,PROC
!ResetDataRow                                                                    Procedure(*c25_DataRowClass _dataRowClass),string,PROC
AnalyzeClarionQueue                                                             Procedure(),string,PROC
SetConnectionString                                                             Procedure(string _connString),string,PROC
SetSourceRowCount                                                               Procedure(string _rowCount),string,PROC
SetPosition                                                                     Procedure(<ulong _index32>, <string _index64>, <string _indexI64>),string,PROC
FillPageBuffer                                                                  Procedure(*c25_PageBufferClass _pageBufferClass, string _startIndex, long _maxRows),string,proc
ClarionQRowToDataRow                                                            Procedure(ulong _index, *c25_DataRowClass _dataRowClass),long,PROC
SourceDataColumnAtIndex                                                         Procedure(long _index),*c25_DataColumnClass

                                                                           End

