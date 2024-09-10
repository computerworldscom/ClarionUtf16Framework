
    Include('c25_ProgramHandlerClass.inc'),Once

c25_ControlLabelClass                                                       Class(),type, Module('c25_ControlLabelClass.clw'), Link('c25_ControlLabelClass.clw',1),DLL(0)
Construct                                                                       Procedure()
Destruct                                                                        Procedure()

ProgramHandlerClass                                                             &c25_ProgramHandlerClass

BaseControl                                                                     &c25_ControlClass
Init                                                                            Procedure(*c25_ControlClass _controlClass),Long,proc
Paint                                                                           Procedure(long _canvasType),Long,proc

ControlLabelRenderClass                                                         &c25_ControlLabelRenderClass

TextW                                                                           &StringTheory
SetText                                                                         Procedure(<string _textW>,<string _textA>),long,PROC

                                                                            End


