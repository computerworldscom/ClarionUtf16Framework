Include('c25_ProgramHandlerClass.inc'),Once

c25CanvasClass                                          Class(),Type, Module('c25_CanvasClass.clw'), Link('c25_CanvasClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                                                   Procedure()
Destruct                                                    Procedure()

ProgramHandler                                              &c25ProgramHandlerClass
BitConverter                                                &c25BitConverterClass
Graphics                                                    &c25GraphicsClass



CreateCanvas                                                Procedure(<string _name>, <long _w>, <long _h>, <Canvas_TYPE _canvas>),Long


BackgroundColor_ARGB                                        Group,Pre(BackgroundColor_ARGB)
A                                                               Byte
B                                                               Byte
G                                                               Byte
R                                                               Byte
                                                            End
BackgroundColor                                             Long,OVER(BackgroundColor_ARGB)

BackgroundInActiveColor_ARGB                                Group,Pre(BackgroundInActiveColor_ARGB)
A                                                               Byte
B                                                               Byte
G                                                               Byte
R                                                               Byte
                                                            End
BackgroundInActiveColor                                     Long,OVER(BackgroundInActiveColor_ARGB)

BitMapObject                                                Group,Pre(BitMapObject)
Width                                                           Long
Height                                                          Long
Stride                                                          Long
PixelFormat                                                     Long
Scan0                                                           Long
Reserved                                                        Long
                                                            End
CompositingMode                                             Long
CompositingQuality                                          Long
ControlType                                                 Long
DC                                                          Long
FontFamilyHandle                                            Long
FontFamilyNameA                                             &String
FontFamilyNameW                                             &String
FontObjectHandle                                            Long
FontSize                                                    Sreal
GdipTextA                                                   &String
GdipTextBrushHandle                                         Long
GdipTextFillColor                                           Long
GdipTextW                                                   &String
GraphicsHandle                                              long
Id                                                          Long
ImagePtr                                                    Long
InterpolationMode                                           Long
LastOffsetBottom                                            Long
LastOffsetLeft                                              Long
LastOffsetRight                                             Long
LastOffsetTop                                               Long
Margin                                                      Long
Name                                                        &String
PixelFormat                                                 Long
RowHeight                                                   Long
Size                                                        Long
SmoothingMode                                               Long
StringFormatHandle                                          Long
TextRenderingHint                                           Long
Width                                                       Long
WorkHeight                                                  Long
WorkWidth                                                   Long
WorkX                                                       Long
WorkY                                                       Long

                                                End


