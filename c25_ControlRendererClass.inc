    Include('c25_ProgramHandlerClass.inc'),Once

c25_ControlRendererClass                                                        Class(),type, Module('c25_ControlRendererClass.clw'), Link('c25_ControlRendererClass.clw',1),DLL(0)
Construct                                                                           Procedure()
Destruct                                                                            Procedure()

ProgramHandlerClass                                                                 &c25_ProgramHandlerClass
stLogFileName                                                                       cstring(255)
stLog                                                                               &StringTheory

ControlClass                                                                        &c25_ControlClass ! parent
GdiPlusClass                                                                        &c25_GdiPlusClass

CanvasWidth                                                                         Long
CanvasHeight                                                                        Long
CanvasGraphics                                                                      Long
CanvasImagePtr                                                                      Long
CanvasScan0                                                                         Long
CanvasBitmapAllocSize                                                               Long
CanvasStride                                                                        Long
CanvasPixelFormat                                                                   Long

Init                                                                                Procedure(*c25_ControlClass _controlClass),long,PROC
CreateCanvas                                                                        Procedure(),long,PROC
                                                                                End


