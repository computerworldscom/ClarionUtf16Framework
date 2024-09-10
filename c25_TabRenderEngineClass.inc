Include('c25_ProgramHandlerClass.inc'),Once

c25_TabRenderEngineClass                                                        Class(),Type, Module('c25_TabRenderEngineClass.clw'), Link('c25_TabRenderEngineClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)

Construct                                                                           Procedure()
Destruct                                                                            Procedure()

GlobalAlpha                                                                         Byte

MeasureStringW                                                                      &String
MeasureStringOutRectF                                                               &RectF_TYPE
MeasureStringOutRectFX                                                              string(100)
MeasureStringCodePointsFitted                                                       Long
WidthF                                                                              SREAL

CanvasSmoothingMode                                                                 long,dim(16)
CanvasBitmapAllocSize                                                               Long,dim(16)
CanvasGraphics                                                                      Long,dim(16)
CanvasHeight                                                                        Long,dim(16)
CanvasImagePtr                                                                      Long,dim(16)
CanvasPixelFormat                                                                   Long,dim(16)
CanvasDC                                                                            long,dim(16)
CanvasReady                                                                         BOOL
CanvasScan0                                                                         Long,dim(16)
CanvasStride                                                                        Long,dim(16)
CanvasWidth                                                                         Long,dim(16)
ClassTypeName                                                                       cstring(128)
ControlsPopulated                                                                   Byte
LinearGradientBrush                                                                 Long
PathHandle                                                                          long
PenHandle                                                                           long
SolidBrushHandle                                                                    Long
SolidFillHandle                                                                     Long
SomeColor                                                                           Long
SomePenHandle                                                                       Long
SomeSReal                                                                           SREAL
stLogFileName                                                                       cstring(1024)
TabCloseButtonPen                                                                   Long

TabBackdropBrush                                                                    long,dim(16)
!TabBackdropBrushActive                                                              long,dim(16)
TabHeaderBrush                                                                      long,dim(16)
!TabHeaderBrushActive                                                                long,dim(16)

TabHeaderWidthMinimum                                                               Long

TabHeaderFont                                                                       Long,dim(16)
TabHeaderFontBrush                                                                  Long,dim(16)
TabHeaderFontFamily                                                                 Long,dim(16)
TabHeaderFontSize                                                                   Long,dim(16)
TabHeaderFontSizeF                                                                  SREAL,dim(16)
TabHeaderIcon                                                                       Long,dim(16)
TabHeaderStringFormat                                                               Long,dim(16)
TabHeaderStringFormatTest                                                           Long
TabHeaderFontFamilyNameW                                                            String(1024),dim(16)
TabHeaderIconFilenameW                                                              String(1024),dim(16)
TabHeaderTextTestW                                                                  &string
TabHeaderTextW                                                                      &string
TabHeaderTitleWidthCalc                                                             sreal
TabHeaderTitleWidth                                                                 Long
TabHeaderTitleRectF                                                                 &RectF_TYPE
!TabHeaderTitleRectF                                                                 Group,Pre(TabHeaderTitleRectF),dim(16)
!RectF                                                                                   &RectF_TYPE
!                                                                                    End


DrawStringRectF                                                                     &RectF_TYPE

GetDC                                                                               Procedure(long _canvasState),LONG
ReleaseDC                                                                           Procedure(long _canvasState),long,proc


GetSolidBrushColorARGB                                                              Group,Pre(GetSolidBrushColorARGB)
B                                                                                       Byte
G                                                                                       Byte
R                                                                                       Byte
A                                                                                       Byte
                                                                                    End
ColorARGB                                                                           Group,Pre(ColorARGB)
B                                                                                       Byte
G                                                                                       Byte
R                                                                                       Byte
A                                                                                       Byte
                                                                                    End
BitConverterClass                                                                   &c25_BitConverterClass
GdiPlusClass                                                                        &c25_GdiPlusClass
GdiPlusSolidBrushQ                                                                  &GdiPlusSolidBrush_TYPE
GradientRect                                                                        &WindowRect_TYPE
NanoSync                                                                            &c25_NanoSyncClass
ProgramHandlerClass                                                                 &c25_ProgramHandlerClass
RectTemp                                                                            &WindowRect_TYPE
SomeRect                                                                            &WindowRect_TYPE
SQLiteAsyncConnection                                                               &SQLiteAsyncConnection_TYPE
SqliteClass                                                                         &C25_SqliteClass
stLog                                                                               &StringTheory
TabClass                                                                            &c25_TabClass
TabCloseButtonRect                                                                  &WindowRect_TYPE

WindowRect                                                                          &WindowRect_TYPE
CreateCanvas                                                                        Procedure(long _canvasState),long,PROC
DrawTabHeader                                                                       Procedure(long _canvasState),long,proc
GetColorMacro                                                                       Procedure(<Byte _A>, <Byte _R>, <Byte _G>, <Byte _B>),Long
!GetSolidBrush                                                                       Procedure(<Long _color>, <Byte _A>, <Byte _R>, <Byte _G>, <Byte _B>),long
Init                                                                                Procedure(*c25_TabClass _tabClass),long,PROC
Resize                                                                              Procedure(),long,PROC
Paint                                                                               Procedure(),long,PROC
ColorOverARGB                                                                       long,over(ColorARGB)
GetSolidBrushColor                                                                  Long,over(GetSolidBrushColorARGB)
                                                                                End



