    Include('c25_ProgramHandlerClass.inc'),Once

c25_PageBufferClass                                                             Class(),type, Module('c25_PageBufferClass.clw'), Link('c25_PageBufferClass.clw',1),DLL(0)
Construct                                                                           Procedure()
Destruct                                                                            Procedure()
ControlRect                                                                         &WindowRect_TYPE


AddNewRow                                                                           Procedure(),*c25_DataRowClass
BindingSourceClass                                                                  &c25_BindingSourceClass
BitConverterClass                                                                   &c25_BitConverterClass

PageIndex                                                                           LONG
GuidId                                                                              string(36)

ControlType                                                                         LONG
BaseControl                                                                         &c25_ControlClass
SomeBrush                                                                           Long
SomeRectF                                                                           &RectF_TYPE
SomeRectI                                                                           &RectI_TYPE

CanvasChanged                                                                       BOOL
CanvasReady                                                                         BOOL

CanvasBitmapAllocSize                                                               Long,dim(16)
CanvasGraphics                                                                      Long,dim(16)
CanvasImagePtr                                                                      Long,dim(16)
CanvasPixelFormat                                                                   Long,dim(16)
CanvasScan0                                                                         Long,dim(16)
CanvasSmoothingMode                                                                 long,dim(16)
CanvasStride                                                                        Long,dim(16)

CanvasWidth                                                                         Long
CanvasHeight                                                                        Long

GraphicsWidth                                                                       Long
GraphicsHeight                                                                      Long

PageAreaWidth                                                                       Long
PageAreaHeight                                                                      Long

PageAreaOffsetX                                                                     Long
PageAreaOffsetY                                                                     Long



CreateCanvas                                                                        Procedure(long _canvasState),long,proc
DataRow                                                                             &c25_DataRowClass
DataRowFromIndex                                                                    Procedure(long _index),*c25_DataRowClass
DataRows                                                                            long,dim(10000)
DataRowsCapacity                                                                    LONG
DataRowsCount                                                                       LONG
GdiPlusClass                                                                        &c25_GdiPlusClass
Init                                                                                Procedure(*c25_BindingSourceClass _bindingSourceClass),Long,proc
ProgramHandlerClass                                                                 &c25_ProgramHandlerClass
SetCanvasSize                                                                       Procedure(long _width, long _height),long,PROC
Paint                                                                               Procedure(long _canvasState),long,PROC

                                                                                End

