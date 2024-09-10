
    Include('c25_ProgramHandlerClass.inc'),Once

c25_ControlTreeViewClass                                                    Class(),type, Module('c25_ControlTreeViewClass.clw'), Link('c25_ControlTreeViewClass.clw',1),DLL(0)
Construct                                                                       Procedure()
Destruct                                                                        Procedure()

ForceRedraw                                                                     BOOL

ProgramHandlerClass                                                             &c25_ProgramHandlerClass

BaseControl                                                                     &c25_ControlClass
!Init                                                                            Procedure(),Long,proc
Paint                                                                           Procedure(long _canvasType),Long,proc


DataControlStyleClass                                                           &c25_DataControlStyleClass
ControlTreeViewRenderClass                                                      &c25_ControlTreeViewRenderClass
BindingSourceClass                                                              &c25_BindingSourceClass

!State                                                                           Long
BitConverterClass                                                               &c25_BitConverterClass
Counter                                                                         Long

WinMes                                                                          cstring(128)
WinMesEnum                                                                      LONG

TextW                                                                           &String

IconFileName_Normal                                                             &String
IconFileName_Hot                                                                &String
IconFileName_HotDimmed                                                          &String

NoText                                                                          BOOL
DisplayRowCount                                                                 LONG

CurrentPageNo                                                                   LONG

!DataSourceClass                                                                 &c25_DataSourceClass
Init                                                                            Procedure(*c25_ControlClass _controlClass),long,PROC

!Init                                                                            Procedure(*c25_ControlTreeViewClass _controlTreeViewClass),long,PROC
SetText                                                                         Procedure(<string _textW>,<string _textA>),long,PROC
ProcessEvent                                                                    Procedure(long _event),long,PROC
PaintContainer                                                                  Procedure(),long,PROC
ReSize                                                                          Procedure(),long,PROC

                                                                            End

