    Include('c25_ProgramHandlerClass.inc'),Once

c25_DataControlStyleClass                                                       Class(),type, Module('c25_DataControlStyleClass.clw'), Link('c25_DataControlStyleClass.clw',1),DLL(0)
Construct                                                                           Procedure()
Destruct                                                                            Procedure()


!ControlType                                                                         LONG

GdiPlusClass                                                                        &c25_GdiPlusClass



AltRowsEven_BackgroundColorARGB                                                   Group,Pre(AltRowsEven_BackgroundColorARGB)
B                                                                                       Byte
G                                                                                       Byte
R                                                                                       Byte
A                                                                                       Byte
                                                                                    End
AltRowsEven_BackgroundColor                                                         LONG,Over(AltRowsEven_BackgroundColorARGB)
AltRowsEven_BackgroundSolidBrush                                                    LONG

AltRowsRowsColoring                                                                 BOOL

AltRowsEven_BackgroundColorARGB                                                     Group,Pre(AltRowsEven_BackgroundColorARGB)
B                                                                                       Byte
G                                                                                       Byte
R                                                                                       Byte
A                                                                                       Byte
                                                                                    End
AltRowsEven_BackgroundColor                                                         LONG,Over(AltRowsEven_BackgroundColorARGB)
AltRowsEven_BackgroundSolidBrush                                                    LONG

AltRowsOdd_BackgroundColorARGB                                                      Group,Pre(AltRowsOdd_BackgroundColorARGB)
B                                                                                       Byte
G                                                                                       Byte
R                                                                                       Byte
A                                                                                       Byte
                                                                                    End
AltRowsOdd_BackgroundColor                                                          LONG,Over(AltRowsOdd_BackgroundColorARGB)
AltRowsOdd_BackgroundSolidBrush                                                     LONG


ConnectionString                                                                    &String

ProgramHandlerClass                                                                 &c25_ProgramHandlerClass
BitConverterClass                                                                   &c25_BitConverterClass
!Sqlite3Class                                                                       &c25_SqliteClass
!BindingSourceClass                                                                 &c25_BindingSourceClass
!DataReflectionClass                                                                &c25_DataReflectionClass
BaseControlClass                                                                    &c25_ControlClass


Init                                                                                Procedure(*c25_ControlClass _controlClass),Long,proc

                                                                                End

