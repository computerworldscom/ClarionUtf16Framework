    Include('c25_ProgramHandlerClass.inc'),Once

c25_TreeViewClass                                                               Class(),Type, Module('c25_TreeViewClass.clw'), Link('c25_TreeViewClass.clw',1),DLL(0)

Construct                                                                           Procedure()
Destruct                                                                            Procedure()

BorderWidth                                                                         Long
ClassTypeName                                                                       cstring(128)



CanvasWidth                                                                         Long
CanvasHeigth                                                                        Long
CanvasGraphics                                                                      Long
CanvasImagePtr                                                                      Long
CanvasScan0                                                                         Long
CanvasBitmapAllocSize                                                               Long
CanvasStride                                                                        Long
CanvasPixelFormat                                                                   Long

DesktopMouseXY                                                                      Long
Disabled_Font                                                                       Long
Disabled_FontBrush                                                                  Long
Disabled_FontFamily                                                                 Long
Disabled_FontSize                                                                   SREAL
Disabled_StringFormat                                                               Long
DrawSeperator                                                                       BOOL
ForceRepaint                                                                        BOOL
GraphicsHandle                                                                      Long
IconImageHandle                                                                     Long
IsFirstNode                                                                         BOOL
IsLastNode                                                                          BOOL
LastDesktopMouseXY                                                                  long
LastField                                                                           BOOL
LastNodeType                                                                        Long
LinearGradientBrush                                                                 Long
MouseMoved                                                                          BOOL
MouseOffsetX                                                                        Long
MouseOffsetY                                                                        Long
MouseOver_Font                                                                      Long
MouseOver_FontBrush                                                                 Long
MouseOver_FontFamily                                                                Long
MouseOver_FontSize                                                                  SREAL
MouseOver_StringFormat                                                              Long
NodeType                                                                            Long
Normal_Font                                                                         Long
Normal_FontBrush                                                                    Long
Normal_FontFamily                                                                   Long
Normal_FontSize                                                                     SREAL
Normal_StringFormat                                                                 Long
PaintGraphics                                                                       Long
PathHandle                                                                          Long
PenHandle                                                                           Long
RowHeight                                                                           Long
Selected_Font                                                                       Long
Selected_FontBrush                                                                  Long
Selected_FontFamily                                                                 Long
Selected_FontSize                                                                   SREAL
Selected_StringFormat                                                               Long
SomeColor                                                                           Long
SomeCString                                                                         cstring(128)
SomeLong                                                                            Long
StLogFileName                                                                       cstring(1024)
ThemeHandle                                                                         Long
X                                                                                   Long
Y                                                                                   Long
DesktopMousePos                                                                     Group,Pre(DesktopMousePos),Over(DesktopMouseXY)
X                                                                                       short
Y                                                                                       short
                                                                                    End
MouseAppPos                                                                         Group,Pre(MouseAppPos)
MouseX                                                                                  short
MouseY                                                                                  short
                                                                                    End

BitConverter                                                                        &c25_BitConverterClass
DataTable                                                                           &c25_DataTableClass
DictImageCache                                                                      &c25_DictionaryClass
GdiPlusClass                                                                        &c25_GdiPlusClass
HardwareClass                                                                       &c25_HardwareClass
MessageOnlyWindowClass                                                              &c25_MessageOnlyWindowClass
ObjectClass                                                                         &c25_ObjectClass
ProgramHandlerClass                                                                 &C25_ProgramHandlerClass
SqliteClass                                                                         &c25_SqliteClass
BaseControl                                                                         &c25_ControlClass
Disabled_FontFamilyNameW                                                            &STRING
GradientRect                                                                        &WindowRect_TYPE
IconFilenameW                                                                       &STRING
MouseOver_FontFamilyNameW                                                           &STRING
NavTreeRecord                                                                       &NavigationTree_TYPE
NavigationTree                                                                      &NavigationTree_TYPE
Normal_FontFamilyNameW                                                              &STRING
PaintPages                                                                          &PaintPage_TYPE
Selected_FontFamilyNameW                                                            &STRING
SomeRect                                                                            &WindowRect_TYPE
SomeStringRef                                                                       &STRING
St1                                                                                 &StringTheory
StLog                                                                               &StringTheory
StringW                                                                             &STRING
TextRectF                                                                           &RectF_TYPE
UpdateRect                                                                          &WindowRect_TYPE
stBuffer                                                                            &StringTheory

CreateCanvas                                                                        Procedure(),long,PROC
CreatePage                                                                          Procedure(),long,PROC
Init                                                                                Procedure(),long,PROC
RenderPages                                                                         Procedure(),long,PROC
ResetPaintPages                                                                     Procedure(),long,proc
UpdateLayout                                                                        Procedure(),long,PROC
WndProc_Process                                                                     Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam, bool Processed, *long ReturnVal, <*bool PostProcess>)

                                                                                End

