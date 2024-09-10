    Include('c25_ProgramHandlerClass.inc'),Once

c25_SqliteConnectionStringBuilderClass                                      Class(),type, Module('c25_SqliteConnectionStringBuilderClass.clw'), Link('c25_SqliteConnectionStringBuilderClass.clw',1),DLL(0)
Construct                                                                       Procedure()
Destruct                                                                        Procedure()

ProgramHandlerClass                                                             &c25_ProgramHandlerClass
BitConverterClass                                                               &c25_BitConverterClass
Init                                                                            Procedure(),Long,proc

Cache                                                                           LONG
DataSource                                                                      &String
DefaultTimeout                                                                  LONG
ForeignKeys                                                                     &QUEUE
Keys                                                                            &c25_DictionaryClass
Values                                                                          &c25_DictionaryClass
Mode                                                                            LONG
SqliteOpenMode                                                                  LONG
Password                                                                        &String
Pooling                                                                         BOOL
RecursiveTriggers                                                               BOOL

GetDataSource                                                                   Procedure(),String
SetDataSource                                                                   Procedure(string _dataSource),bool,PROC

Reset                                                                           Procedure(),long,PROC
ContainsKey                                                                     Procedure(string _keyword),BOOL
RemoveKey                                                                       Procedure(string _keyword),BOOL
ShouldSerialize                                                                 Procedure(string _keyword),BOOL
TryGetValue                                                                     Procedure(string _keyword,<string _outValue>),string,proc
                                                                            End

