
    Include('c25_ProgramHandlerClass.inc'),Once

c25_ControlButtonClass                                                      Class(),type, Module('c25_ControlButtonClass.clw'), Link('c25_ControlButtonClass.clw',1),DLL(0)
Construct                                                                       Procedure()
Destruct                                                                        Procedure()

ForceRedraw                                                                     BOOL

ProgramHandlerClass                                                             &c25_ProgramHandlerClass

BaseControl                                                                     &c25_ControlClass
Init                                                                            Procedure(*c25_ControlClass _controlClass),Long,proc
Paint                                                                           Procedure(long _canvasType),Long,proc

ControlButtonRenderClass                                                        &c25_ControlButtonRenderClass

State                                                                           Long
BitConverterClass                                                               &c25_BitConverterClass
Counter                                                                         Long


TextW                                                                           &String

IconFileName_Normal                                                             &String
IconFileName_Hot                                                                &String
IconFileName_HotDimmed                                                          &String

NoText                                                                          BOOL


SetText                                                                         Procedure(<string _textW>,<string _textA>),long,PROC
ProcessEvent                                                                    Procedure(long _event),long,PROC
PaintContainer                                                                  Procedure(),long,PROC

                                                                            End

