    Include('c25_ProgramHandlerClass.inc'),Once

c25_ControlLabelRenderClass                                                     Class(),type, Module('c25_ControlLabelRenderClass.clw'), Link('c25_ControlLabelRenderClass.clw',1),DLL(0)
Construct                                                                           Procedure()
Destruct                                                                            Procedure()
stLog                                                                               &StringTheory
stLogFileName                                                                       cstring(1024)

ProgramHandlerClass                                                                 &c25_ProgramHandlerClass
Init                                                                                Procedure(*c25_ControlLabelClass _controlLabelClass),long,PROC

BitConverterClass                                                                   &c25_BitConverterClass
GdiPlusClass                                                                        &c25_GdiPlusClass
ControlLabelClass                                                                   &c25_ControlLabelClass ! base
Paint                                                                               Procedure(long _canvasState),long,PROC
Graphics                                                                            Long
SomeBrush                                                                           Long
SomeRectF                                                                           &RectF_TYPE
SomeRectI                                                                           &RectI_TYPE
                                                                                End


