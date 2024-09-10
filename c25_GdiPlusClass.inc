    Include('c25_ProgramHandlerClass.inc'),Once

c25_GdiPlusClass                                                        Class(),Type, Module('c25_GdiPlusClass.clw'), Link('c25_GdiPlusClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                                                                   Procedure()
Destruct                                                                    Procedure()
GifEncoderGuid16                                    String(16)
GifEncoderGuid36                                    String(36)
ClassTypeName                                       cstring(128)
BmpEncoderGuid16                                    String(16)
BmpEncoderGuid36                                    String(36)
BufferBitmapObject                                  Long
BufferBitmapObjectLast                              Long
BufferGetDecodersSize                               Long
BufferGetEncodersSize                               Long
BufferGraphics                                      Long
BufferGraphicsLast                                  Long
BufferImagePtr                                      Long
BufferMemoryDC                                      Long
BufferMemoryPtr                                     Long
BufferMemoryPtr2                                    Long
BufferMemoryPtrLast                                 Long
JpgEncoderGuid16                                    String(16)
JpgEncoderGuid36                                    String(36)
PngEncoderGuid16                                    String(16)
PngEncoderGuid36                                    String(36)
NumDecoders                                         Long
NumEncoders                                         Long
ThemeHandle                                         Long
ThemeNameUtf16Path                                  String(2048)
TiffEncoderGuid16                                   String(16)
TiffEncoderGuid36                                   String(36)
GdiPlusToken                                        Long
GdiplusStartupInput                                 GROUP,PRE(GdiplusStartupInput)
Version                                                 ULong
DebugEventCallback                                      Long
SuppressBackgroundThread                                Byte
SuppressExternalCodecs                                  Byte
Reserved                                                Byte,Dim(100)
                                                    End
Graphics                                            Long
GetSolidBrushColorARGB                              Group,Pre(GetSolidBrushColorARGB)
B                                                       Byte
G                                                       Byte
R                                                       Byte
A                                                       Byte
                                                    End
ColorARGB                                           Group,Pre(ColorARGB)
B                                                       Byte
G                                                       Byte
R                                                       Byte
A                                                       Byte
                                                    End
ColorRGBA                                           Group,Pre(ColorRGBA)
R                                                       Byte
G                                                       Byte
B                                                       Byte
A                                                       Byte
                                                    End
BitConverterClass                                   &c25_BitConverterClass
ProgramHandlerClass                                 &c25_ProgramHandlerClass
BufferGetDecoders                                   &String
BufferGetEncoders                                   &String
GdiPlusSolidBrushQ                                  &GdiPlusSolidBrush_TYPE
ImgDecoderCodecInfoQ                                &ImageCodecInfo_TYPE
ImgEncoderCodecInfoQ                                &ImageCodecInfo_TYPE
PrintDriverInfo8                                    &PrintDriverInfo8_TYPE
PrintersInfo5                                       &PrintersInfo5_TYPE
ThemeNameUtf16                                      &String


FillCodecs                                                                  Procedure(),long,PROC

NewSolidBrush                                       Procedure(<*long _brush>, <long _color>, <byte _A>, <byte _R>, <byte _G>, <byte _B>),long,proc

NewPath                                             Procedure(<*long _path>),long,PROC

NewPen                                              Procedure(<*long _pen>, <sreal _thickness>, <long _color>, <byte _A>, <byte _R>, <byte _G>, <byte _B>),long,PROC

CalcRectF_WH                                        Procedure(*RectF_TYPE _RectF),string,proc
CalcRectI_WH                                        Procedure(*RectI_TYPE _RectI),string,proc

ARGBToRGBA                                          Procedure(long _colorARGB),Long
AddPathArc                                          Procedure(Long _gpPath, sreal _x, sreal _y, sreal _width, sreal _height, sreal _startAngle, sreal _sweepangle),Proc,Long
AddPathArcI                                         Procedure(Long _gpPath, Long _x, Long _y, Long _width, Long _height, sreal _startAngle, sreal _sweepangle),Proc,Long
AddPathBezier                                       Procedure(Long _Path, sreal x1, sreal y1, sreal x2, sreal y2, sreal x3, sreal y3, sreal x4, sreal y4),Proc,Long
AddPathBezierI                                      Procedure(Long _Path, Long x1, Long y1, Long x2, Long y2, Long x3, Long y3, Long x4, Long y4),Proc,Long
AddPathBeziers                                      Procedure(Long _Notimplemented),Proc,Long
AddPathBeziersI                                     Procedure(Long _Notimplemented),Proc,Long
AddPathClosedCurve                                  Procedure(Long _Notimplemented),Long,Proc
AddPathClosedCurve2                                 Procedure(Long _Notimplemented),Long,Proc
AddPathClosedCurve2I                                Procedure(Long _Notimplemented),Long,Proc
AddPathClosedCurveI                                 Procedure(Long _Notimplemented),Long,Proc
AddPathCurve                                        Procedure(Long _Notimplemented),Long,Proc
AddPathCurve2                                       Procedure(Long _Notimplemented),Long,Proc
AddPathCurve2I                                      Procedure(Long _Notimplemented),Long,Proc
AddPathCurve3                                       Procedure(Long _Notimplemented),Long,Proc
AddPathCurve3I                                      Procedure(Long _Notimplemented),Long,Proc
AddPathCurvei                                       Procedure(Long _Notimplemented),Long,Proc
AddPathEllipse                                      Procedure(Long _Notimplemented),Long,Proc
AddPathEllipseI                                     Procedure(Long ,Long,Long,Long,Long),Proc,Long
AddPathLine                                         Procedure(Long path, sreal x1, sreal y1, sreal x2, sreal y2),Long,Proc
AddPathLine2                                        Procedure(Long _Notimplemented),Long,Proc
AddPathLineI                                        Procedure(Long path, Long x1, Long y1, Long x2, Long y2),Long,Proc
AddPathPath                                         Procedure(Long _Notimplemented),Long,Proc
AddPathPie                                          Procedure(Long _Notimplemented),Long,Proc
AddPathPieI                                         Procedure(Long _Notimplemented),Long,Proc
AddPathPolygon                                      Procedure(Long _Notimplemented),Long,Proc
AddPathPolygonI                                     Procedure(Long _Notimplemented),Long,Proc
AddPathRectangle                                    Procedure(Long ,Sreal,Sreal,Sreal,Sreal),Proc,Long
AddPathRectangleI                                   Procedure(Long Path,Long X,Long Y,Long W,Long H),Proc,Long
AddPathRectangles                                   Procedure(Long _Notimplemented),Long,Proc
AddPathRectanglesI                                  Procedure(Long _Notimplemented),Long,Proc
AddPathString                                       Procedure(Long Path, Long Wchar, Long Length, Long FontFamily, Long Style, Sreal Emsize, Long LayoutRect, Long Stringformat),Proc,Long
AddPathStringI                                      Procedure(Long _Notimplemented),Long,Proc
AddPathline2I                                       Procedure(Long _Notimplemented),Long,Proc
Alloc                                               Procedure(Long ),Proc,Long
BeginContainer                                      Procedure(Long _Notimplemented),Long,Proc
BeginContainer2                                     Procedure(Long _Notimplemented),Long,Proc
BeginContainerI                                     Procedure(Long _Notimplemented),Long,Proc
BitBlt                                              Procedure(long _hdc, long _x, long _y, long _cx, long _cy, long _hdcSrc, long _x1, long _y1, long _rop),long,proc
BitmapApplyEffect                                   Procedure(Long _Notimplemented),Long,Proc
BitmapConvertFormat                                 Procedure(Long _Notimplemented),Long,Proc
BitmapCreateApplyEffect                             Procedure(Long _Notimplemented),Long,Proc
BitmapGetHistogram                                  Procedure(Long _Notimplemented),Long,Proc
BitmapGetHistogramSize                              Procedure(Long _Notimplemented),Long,Proc
BitmapGetPixel                                      Procedure(Long ,Long,Long,Long),Proc,Long
BitmapLockBits                                      Procedure(Long GpBitmap,Long GpRect,Long Flags,Long Pixelformat,Long Bitmapdata),Proc,Long
BitmapSetPixel                                      Procedure(Long ,Long,Long,Long),Proc,Long
BitmapSetResolution                                 Procedure(Long ,Long,Long),Proc,Long
BitmapUnlockBits                                    Procedure(Long ,Long),Proc,Long
ClearPathMarkers                                    Procedure(Long _Notimplemented),Long,Proc
CloneBitmapArea                                     Procedure(Real,Real,Real,Real,Long,Long,Long),Proc,Long
CloneBitmapAreaI                                    Procedure(Long _Notimplemented),Long,Proc
CloneBrush                                          Procedure(Long ,Long),Proc,Long
CloneCustomLineCap                                  Procedure(Long _Notimplemented),Long,Proc
CloneFont                                           Procedure(Long _Notimplemented),Long,Proc
CloneFontFamily                                     Procedure(Long _Notimplemented),Long,Proc
CloneImage                                          Procedure(Long _Notimplemented),Long,Proc
CloneImageAttributes                                Procedure(Long _Notimplemented),Long,Proc
CloneMatrix                                         Procedure(Long _Notimplemented),Long,Proc
ClonePath                                           Procedure(Long _Notimplemented),Long,Proc
ClonePen                                            Procedure(Long _Notimplemented),Long,Proc
CloneRegion                                         Procedure(Long _Notimplemented),Long,Proc
CloneStringFormat                                   Procedure(Long Pformat , Long Newformat),Proc,Long
ClosePathFigure                                     Procedure(Long Path),Proc,Long
ClosePathFigures                                    Procedure(Long Path),Proc,Long
CombineRegionPath                                   Procedure(Long _Notimplemented),Long,Proc
CombineRegionRect                                   Procedure(Long _Notimplemented),Long,Proc
CombineRegionRectI                                  Procedure(Long _Notimplemented),Long,Proc
CombineRegionRegion                                 Procedure(Long Region1,Long Region2, Long Combinemode ),Proc,Long
Comment                                             Procedure(Long _Notimplemented),Long,Proc
ConvertToEmfPlus                                    Procedure(Long _Notimplemented),Long,Proc
ConvertToEmfPlusToFile                              Procedure(Long _Notimplemented),Long,Proc
ConvertToEmfPlusToStream                            Procedure(Long _Notimplemented),Long,Proc
CreateAdjustableArrowCap                            Procedure(Long _Notimplemented),Long,Proc
CreateBitmapFromDiRectDrawSurface                   Procedure(Long _Notimplemented),Long,Proc
CreateBitmapFromFile                                Procedure(Long ,Long),Proc,Long
CreateBitmapFromFileIcm                             Procedure(Long _Notimplemented),Long,Proc
CreateBitmapFromGdiDib                              Procedure(Long GdiBitmapinfo,Long GdiBitmapdata,Long PBitmap),Proc,Long
CreateBitmapFromGraphics                            Procedure(Long _Width,Long _Height,Long _Graphic ,Long _Bitmapptr),Proc,Long
CreateBitmapFromHBitmap                             Procedure(Long Hbm,Long Hpal,Long PBitmap),Proc,Long
CreateBitmapFromHIcon                               Procedure(Long _Notimplemented),Long,Proc
CreateBitmapFromResource                            Procedure(Long ,Long,Long),Proc,Long
CreateBitmapFromScan0                               Procedure(Long _Width,Long _Height,Long _Stride,Long _Pixelformat, Long _Scan0, Long _GpBitmap),Proc,Long
CreateBitmapFromStream                              Procedure(Long _Notimplemented),Long,Proc
CreateBitmapFromStreamIcm                           Procedure(Long _Notimplemented),Long,Proc
CreateBmpFileAndDIBHeader                           Procedure(long _w, long _h, long _pixelArraySize),String
CreateCachedBitmap                                  Procedure(Long GpBitmap, Long GpGraphics,Long GpcachedBitmap),Proc,Long
CreateCanvas                                        Procedure(long _w, long _h, <*long _graphicsOut>, <*long _imagePtrOut>, <*long _scan0Out>, <*long _allocSizeOut>, <*long _strideOut>, <*long _pixelFormatOut>, <long _displayStateMode>, <long _backgroundColor>),string,PROC
CreateCustomLineCap                                 Procedure(Long _Notimplemented),Long,Proc
CreateEffect                                        Procedure(Long _Notimplemented),Long,Proc
CreateFont                                          Procedure(Long ,Sreal,Long,Long,Long),Proc,Long
CreateFontFamilyFromName                            Procedure(Long ,Long, Long),Proc,Long
CreateFontFromDC                                    Procedure(Long hDC, long pFont),Long,Proc
CreateFontFromLogFontA                              Procedure(Long ,Long,Long),Proc,Long
CreateFontFromLogFontW                              Procedure(Long ,Long,Long),Proc,Long
CreateFromHDc                                       Procedure(Long ,Long),Proc,Long
CreateFromHDc2                                      Procedure(Long _Notimplemented),Long,Proc
CreateFromHWnd                                      Procedure(Long ,Long),Proc,Long
CreateFromHWndIcm                                   Procedure(Long _Notimplemented),Long,Proc
CreateHBitmapFromBitmap                             Procedure(Long ,Long,Long),Proc,Long
CreateHIconFromBitmap                               Procedure(Long _Notimplemented),Long,Proc
CreateHalftonePalette                               Procedure(Long _Notimplemented),Long,Proc
CreateHatchBrush                                    Procedure(Long _Notimplemented),Long,Proc
CreateImageAttributes                               Procedure(Long _Notimplemented),Long,Proc
CreateLineBrush                                     Procedure(Long _Notimplemented),Long,Proc
CreateLineBrushFromRect                             Procedure(Long ,Long,Long,Long,Long,Long),Proc,Long
CreateLineBrushFromRectI                            Procedure(Long ,Long,Long,Long,Long,Long),Proc,Long
CreateLineBrushFromRectWithAngle                    Procedure(Long _Notimplemented),Long,Proc
CreateLineBrushFromRectWithAngleI                   Procedure(Long _Notimplemented),Long,Proc
CreateLineBrushI                                    Procedure(Long ,Long,Long,Long,Long,Long),Proc,Long
CreateMatrix                                        Procedure(Long _Notimplemented),Long,Proc
CreateMatrix2                                       Procedure(Sreal M11, Sreal M12, Sreal M21, Sreal M22, Sreal Dx, Sreal Dy, Long Matrix),Proc,Long
CreateMatrix3                                       Procedure(Long _Notimplemented),Long,Proc
CreateMatrix3I                                      Procedure(Long _Notimplemented),Long,Proc
CreateMetaFileFromEmf                               Procedure(Long ,Byte,Long),Proc,Long
CreateMetaFileFromFile                              Procedure(Long ,Long),Proc,Long
CreateMetaFileFromWmf                               Procedure(Long _Notimplemented),Long,Proc
CreateMetaFileFromWmfFile                           Procedure(Long _Notimplemented),Long,Proc
CreateMetaFileFromstream                            Procedure(Long _Notimplemented),Long,Proc
CreatePath                                          Procedure(<Long _brushMode>, <*Long _outPath>),Proc,Long
CreatePath2                                         Procedure(Long _Notimplemented),Long,Proc
CreatePath2I                                        Procedure(Long _Notimplemented),Long,Proc
CreatePathGradient                                  Procedure(Long _Notimplemented),Long,Proc
CreatePathGradientFromPath                          Procedure(Long _Notimplemented),Long,Proc
CreatePathGradientI                                 Procedure(Long _Notimplemented),Long,Proc
CreatePathIter                                      Procedure(Long _Notimplemented),Long,Proc
CreatePen1                                          Procedure(<Long _penColor>, <sreal _penWidth>, <Long _unit>, <*Long _outPenHandle>),Proc,Long
CreatePen2                                          Procedure(Long _Notimplemented),Long,Proc
CreateRegion                                        Procedure(Long _Notimplemented),Long,Proc
CreateRegionHRgn                                    Procedure(Long _Notimplemented),Long,Proc
CreateRegionPath                                    Procedure(Long Path,Long Region),Proc,Long
CreateRegionRect                                    Procedure(Long _Notimplemented),Long,Proc
CreateRegionRectI                                   Procedure(Long _Notimplemented),Long,Proc
CreateRegionRgnData                                 Procedure(Long _Notimplemented),Long,Proc
CreateSolidFill                                     Procedure(Long ,Long),Proc,Long
CreateStreamOnFile                                  Procedure(Long _Notimplemented),Long,Proc
CreateStringFormat                                  Procedure(Long Stringformatflags,Short Language,Long Pformat ),Proc,Long
CreateTexture                                       Procedure(Long PImage, Long _Wrapmode, Long _Texture),Proc,Long
CreateTexture2                                      Procedure(Long _Notimplemented),Long,Proc
CreateTexture2I                                     Procedure(Long _Notimplemented),Long,Proc
CreateTextureIa                                     Procedure(Long _Notimplemented),Long,Proc
CreateTextureIaI                                    Procedure(Long _Notimplemented),Long,Proc
DeleteBrush                                         Procedure(Long ),Proc,Long
DeleteCachedBitmap                                  Procedure(Long _Notimplemented),Long,Proc
DeleteCanvas                                        Procedure(long _OldCanvasGraphics, long _OldCanvasImagePtr, long _OldCanvasScan0, long _OldCanvasBitmapAllocSize),Proc,Long
DeleteCustomLineCap                                 Procedure(Long _Notimplemented),Long,Proc
DeleteEffect                                        Procedure(Long _Notimplemented),Long,Proc
DeleteFont                                          Procedure(Long Fonthandle),Proc,Long
DeleteFontFamily                                    Procedure(Long FontFamilyhandle),Proc,Long
DeleteGraphics                                      Procedure(Long ),Proc,Long
DeleteMatrix                                        Procedure(Long _Notimplemented),Long,Proc
DeletePath                                          Procedure(Long ),Proc,Long
DeletePathIter                                      Procedure(Long _Notimplemented),Long,Proc
DeletePen                                           Procedure(Long ),Proc,Long
DeletePrivateFontCollection                         Procedure(Long _Notimplemented),Long,Proc
DeleteRegion                                        Procedure(Long _Notimplemented),Long,Proc
DeleteStringFormat                                  Procedure(Long ),Proc,Long
DisposeImage                                        Procedure(Long ),Proc,Long
DisposeImageAttributes                              Procedure(Long _Notimplemented),Long,Proc
DrawArc                                             Procedure(Long _Notimplemented),Long,Proc
DrawArci                                            Procedure(Long _Notimplemented),Long,Proc
DrawBezier                                          Procedure(Long _Notimplemented),Long,Proc
DrawBezieri                                         Procedure(Long _Notimplemented),Long,Proc
DrawBeziers                                         Procedure(Long _Notimplemented),Long,Proc
DrawBeziersI                                        Procedure(Long _Notimplemented),Long,Proc
DrawCachedBitmap                                    Procedure(Long GpGraphics, Long GpcachedBitmap,Long X,Long Y),Proc,Long
DrawClosedCurve                                     Procedure(Long _Notimplemented),Long,Proc
DrawClosedCurve2                                    Procedure(Long _Notimplemented),Long,Proc
DrawClosedCurve2I                                   Procedure(Long _Notimplemented),Long,Proc
DrawClosedCurvei                                    Procedure(Long _Notimplemented),Long,Proc
DrawCurve                                           Procedure(Long _Notimplemented),Long,Proc
DrawCurve2                                          Procedure(Long _Notimplemented),Long,Proc
DrawCurve2I                                         Procedure(Long _Notimplemented),Long,Proc
DrawCurve3                                          Procedure(Long _Notimplemented),Long,Proc
DrawCurve3I                                         Procedure(Long _Notimplemented),Long,Proc
DrawCurvei                                          Procedure(Long _Notimplemented),Long,Proc
DrawDriverString                                    Procedure(Long _Notimplemented),Long,Proc
DrawEllipse                                         Procedure(Long ,Long,Sreal,Sreal,Sreal,Sreal),Proc,Long
DrawEllipseI                                        Procedure(Long _Notimplemented),Long,Proc
DrawImage                                           Procedure(Long ,Long,Sreal,Sreal),Proc,Long
DrawImageFx                                         Procedure(Long _Notimplemented),Long,Proc
DrawImageI                                          Procedure(Long Graphics,Long PImage,Long X,Long Y),Proc,Long
DrawImagePointRect                                  Procedure(Long _Notimplemented),Long,Proc
DrawImagePointRectI                                 Procedure(Long _Graphics, long _ImagePtr, long _x, long _y, long _srcX, long _srcY, long _srcWidth, long _srcHeight, long _scrUnit),Long,Proc
DrawImagePoints                                     Procedure(Long _Notimplemented),Long,Proc
DrawImagePointsI                                    Procedure(Long _Notimplemented),Long,Proc
DrawImagePointsRect                                 Procedure(Long _Notimplemented),Long,Proc
DrawImagePointsRectI                                Procedure(Long _Notimplemented),Long,Proc
DrawImageRect                                       Procedure(Long ,Long,Sreal,Sreal,Sreal,Sreal),Proc,Long
DrawImageRectI                                      Procedure(Long Graphics,Long pImage,Long x,Long y,Long dw,Long dh),Proc,Long
DrawImageRectRect                                   Procedure(Long _Notimplemented),Long,Proc
DrawImageRectRectI                                  Procedure(Long GpGraphics,Long GpImage,Long Dstx,Long Dsty,Long Dstwidth,Long Dstheight,Long Srcx, Long Srcy, Long Srcwidth, Long Srcheight, Long Gscrunit, Long ImageAttributes, Long Callback, Long Callbackdata),Proc,Long
DrawLine                                            Procedure(Long _Notimplemented),Long,Proc
DrawLineI                                           Procedure(Long Graphics,Long Pen,Long X1,Long Y1,Long X2,Long Y2),Proc,Long
DrawLines                                           Procedure(Long _Notimplemented),Long,Proc
DrawLinesI                                          Procedure(Long _Notimplemented),Long,Proc
DrawPath                                            Procedure(Long Grp,Long Pen,Long Path),Proc,Long
DrawPie                                             Procedure(Long _Notimplemented),Long,Proc
DrawPieI                                            Procedure(Long _Notimplemented),Long,Proc
DrawPolygon                                         Procedure(Long _Notimplemented),Long,Proc
DrawPolygonI                                        Procedure(Long _Notimplemented),Long,Proc
DrawRectangle                                       Procedure(Long Graphics,Long Pen,Sreal X,Sreal Y,Sreal W,Sreal Y),Proc,Long
DrawRectangleI                                      Procedure(Long Graphics,Long Pen,Long X,Long Y,Long W,Long H),Proc,Long
DrawRectangles                                      Procedure(Long _Notimplemented),Long,Proc
DrawRectanglesI                                     Procedure(Long _Notimplemented),Long,Proc
DrawString                                          Procedure(Long _Graphics, Long _PString, Long _Length, Long _PFont, Long _LayoutRect, Long _Stringformat, Long _Brush),Proc,Long
EmfToWmfBits                                        Procedure(Long _Notimplemented),Long,Proc
EndContainer                                        Procedure(Long _Notimplemented),Long,Proc
EnumerateMetaFileDestPoint                          Procedure(Long _Notimplemented),Long,Proc
EnumerateMetaFileDestPointI                         Procedure(Long _Notimplemented),Long,Proc
EnumerateMetaFileDestPoints                         Procedure(Long _Notimplemented),Long,Proc
EnumerateMetaFileDestPointsI                        Procedure(Long _Notimplemented),Long,Proc
EnumerateMetaFileDestRect                           Procedure(Long _Notimplemented),Long,Proc
EnumerateMetaFileDestRecti                          Procedure(Long _Notimplemented),Long,Proc
EnumerateMetaFileSrcRectDestPoint                   Procedure(Long _Notimplemented),Long,Proc
EnumerateMetaFileSrcRectDestPointi                  Procedure(Long _Notimplemented),Long,Proc
EnumerateMetaFileSrcRectDestPoints                  Procedure(Long _Notimplemented),Long,Proc
EnumerateMetaFileSrcRectDestPointsI                 Procedure(Long _Notimplemented),Long,Proc
EnumerateMetaFileSrcRectDestRect                    Procedure(Long _Notimplemented),Long,Proc
EnumerateMetaFileSrcRectDestRecti                   Procedure(Long _Notimplemented),Long,Proc
FillClosedCurve                                     Procedure(Long _Notimplemented),Long,Proc
FillClosedCurve2                                    Procedure(Long _Notimplemented),Long,Proc
FillClosedCurve2I                                   Procedure(Long _Notimplemented),Long,Proc
FillClosedCurvei                                    Procedure(Long _Notimplemented),Long,Proc
FillEllipse                                         Procedure(Long ,Long,Sreal,Sreal,Sreal,Sreal),Proc,Long
FillEllipsei                                        Procedure(Long ,Long,Long,Long,Long,Long),Proc,Long
FillPath                                            Procedure(Long Graphics,Long Brush, Long path),Proc,Long
FillPie                                             Procedure(Long _Notimplemented),Long,Proc
FillPiei                                            Procedure(Long _Notimplemented),Long,Proc
FillPolygon                                         Procedure(Long _Notimplemented),Long,Proc
FillPolygon2                                        Procedure(Long _Notimplemented),Long,Proc
FillPolygon2I                                       Procedure(Long _Notimplemented),Long,Proc
FillPolygoni                                        Procedure(Long _Notimplemented),Long,Proc
FillRectangle                                       Procedure(Long ,Long,Sreal,Sreal,Sreal,Sreal),Proc,Long
FillRectangleI                                      Procedure(Long Graphic,Long Brush,Long X,Long Y,Long W,Long H),Proc,Long
FillRectangles                                      Procedure(Long _Notimplemented),Long,Proc
FillRectanglesI                                     Procedure(Long _Notimplemented),Long,Proc
FillRegion                                          Procedure(Long Graphics, Long Brush,Long Region),Long
FindfirstImageItem                                  Procedure(Long _Notimplemented),Long,Proc
FindnextImageItem                                   Procedure(Long _Notimplemented),Long,Proc
FlattenPath                                         Procedure(Long Path, Long Matrix, Sreal Flatness),Proc,Long
Flush                                               Procedure(),Proc,Long
Free                                                Procedure(Long _Notimplemented),Long,Proc
GdiplusShutDown                                     Procedure(),Long,Proc
GdiplusStartUp                                      Procedure(),Long,Proc
Gdiplusnotificationhook                             Procedure(Long _Notimplemented),Long,Proc
Gdiplusnotificationunhook                           Procedure(Long _Notimplemented),Long,Proc
GetAdjustableArrowCapFillState                      Procedure(Long _Notimplemented),Long,Proc
GetAdjustableArrowCapHeight                         Procedure(Long _Notimplemented),Long,Proc
GetAdjustableArrowCapMiddleInset                    Procedure(Long _Notimplemented),Long,Proc
GetAdjustableArrowCapWidth                          Procedure(Long _Notimplemented),Long,Proc
GetAllPropertyItems                                 Procedure(Long _PImage,Long Totalbuffersize, Long Numproperties, Long Allitems),Proc,Long
GetBrushType                                        Procedure(Long _Notimplemented),Long,Proc
GetCellAscent                                       Procedure(Long _Notimplemented),Long,Proc
GetCellDescent                                      Procedure(Long _Notimplemented),Long,Proc
GetClip                                             Procedure(Long _Graphic, Long _Region),Proc,Long
GetClipBounds                                       Procedure(Long _Graphic,Long _Rect),Proc,Long
GetClipBoundsI                                      Procedure(Long _Graphic,Long _Rect),Proc,Long
GetColorByte                                        Procedure(long _color, string _name),string
GetColorMacro                                       Procedure(<Byte _A>, <Byte _R>, <Byte _G>, <Byte _B>),Long
GetColorMacroRGBA                                   Procedure(<Byte _R>, <Byte _G>, <Byte _B>, <Byte _A>),Long
GetCompositingMode                                  Procedure(Long _Notimplemented),Long,Proc
GetCompositingQuality                               Procedure(Long ,Long),Proc,Long
GetCustomLineCapBaseCap                             Procedure(Long _Notimplemented),Long,Proc
GetCustomLineCapBaseInset                           Procedure(Long _Notimplemented),Long,Proc
GetCustomLineCapStrokeCaps                          Procedure(Long _Notimplemented),Long,Proc
GetCustomLineCapStrokeJoin                          Procedure(Long _Notimplemented),Long,Proc
GetCustomLineCapType                                Procedure(Long _Notimplemented),Long,Proc
GetCustomLineCapWidthScale                          Procedure(Long _Notimplemented),Long,Proc
GetDc                                               Procedure(Long ,Long),Proc,Long
GetDpiX                                             Procedure(Long ,Long),Proc,Long
GetDpiY                                             Procedure(Long ,Long),Proc,Long
GetEffectParameterSize                              Procedure(Long _Notimplemented),Long,Proc
GetEffectParameters                                 Procedure(Long _Notimplemented),Long,Proc
GetEmHeight                                         Procedure(Long _Notimplemented),Long,Proc
GetEncoderParameterList                             Procedure(Long _pImage, long _clsidEncoder, long _psize, long _buffer),Long,Proc
GetEncoderParameterListSize                         Procedure(Long _pImage, long _clsidEncoder, long _psize),Long,Proc
GetFamily                                           Procedure(Long _Notimplemented),Long,Proc
GetFamilyName                                       Procedure(Long _Notimplemented),Long,Proc
GetFontCollectionFamilycount                        Procedure(Long _Notimplemented),Long,Proc
GetFontCollectionFamilylist                         Procedure(Long _Notimplemented),Long,Proc
GetFontHeight                                       Procedure(Long _Notimplemented),Long,Proc
GetFontHeightGivenDpi                               Procedure(Long _Notimplemented),Long,Proc
GetFontSize                                         Procedure(Long _Notimplemented),Long,Proc
GetFontStyle                                        Procedure(Long _Notimplemented),Long,Proc
GetFontUnit                                         Procedure(Long _Notimplemented),Long,Proc
GetGenericFontFamilyMonoSpace                       Procedure(Long _Notimplemented),Long,Proc
GetGenericFontFamilySansSerif                       Procedure(Long _Notimplemented),Long,Proc
GetGenericFontFamilySerif                           Procedure(Long _Notimplemented),Long,Proc
GetHEmfFromMetaFile                                 Procedure(Long ,Long),Proc,Long
GetHatchStyle                                       Procedure(Long _Notimplemented),Long,Proc
GetHatchbackGroundColor                             Procedure(Long _Notimplemented),Long,Proc
GetImageAttributesAdjustedPalette                   Procedure(Long _Notimplemented),Long,Proc
GetImageBounds                                      Procedure(Long _Notimplemented),Long,Proc
GetImageDecoders                                    Procedure(ULong _Numencoders ,ULong _Size,Long _BufferImagecodecinfo),Proc,Long
GetImageDecodersSize                                Procedure(Long ,Long),Proc,Long
GetImageDimension                                   Procedure(Long ,Long,Long),Proc,Long
GetImageEncoders                                    Procedure(ULong _Numencoders ,ULong _Size,Long _BufferImagecodecinfo),Proc,Long
GetImageEncodersSize                                Procedure(Long ,Long),Proc,Long
GetImageFlags                                       Procedure(Long ,Long),Proc,Long
GetImageGraphicsContext                             Procedure(Long _Image,Long _Graphics),Proc,Long
GetImageHeight                                      Procedure(Long ,Long),Proc,Long
GetImageHorizontalResolution                        Procedure(Long ,Long),Proc,Long
GetImageItemData                                    Procedure(Long _Notimplemented),Long,Proc
GetImagePalette                                     Procedure(Long _Notimplemented),Long,Proc
GetImagePaletteSize                                 Procedure(Long ,Long),Proc,Long
GetImagePixelFormat                                 Procedure(Long ,Long),Proc,Long
GetImageRawFormat                                   Procedure(Long _PImage,Long _Guid),Proc,Long
GetImageThumbnail                                   Procedure(Long _Notimplemented),Long,Proc
GetImageType                                        Procedure(Long _Notimplemented),Long,Proc
GetImageVerticalResolution                          Procedure(Long ,Long),Proc,Long
GetImageWidth                                       Procedure(Long ,Long),Proc,Long
GetImgDecoderCodecInfo                              Procedure(),Long,PROC
GetImgEncoderCodecInfo                              Procedure(),Long,PROC
GetInterpolationMode                                Procedure(Long _Notimplemented),Long,Proc
GetLineBlend                                        Procedure(Long _Notimplemented),Long,Proc
GetLineColors                                       Procedure(Long _Notimplemented),Long,Proc
GetLineGammaCorrection                              Procedure(Long _Notimplemented),Long,Proc
GetLinePresetBlend                                  Procedure(Long _Notimplemented),Long,Proc
GetLineSpacing                                      Procedure(Long _Notimplemented),Long,Proc
GetLogFontA                                         Procedure(Long _Notimplemented),Long,Proc
GetLogFontW                                         Procedure(Long _Notimplemented),Long,Proc
GetMatrixElements                                   Procedure(Long _Notimplemented),Long,Proc
GetMetaFileDownLevelRasterizationLimit              Procedure(Long _Notimplemented),Long,Proc
GetMetaFileHeaderFromEmf                            Procedure(Long ,Long),Proc,Long
GetMetaFileHeaderFromFile                           Procedure(Long _Notimplemented),Long,Proc
GetMetaFileHeaderFromMetaFile                       Procedure(Long _Notimplemented),Long,Proc
GetMetaFileHeaderFromStream                         Procedure(Long _Notimplemented),Long,Proc
GetMetaFileHeaderFromWmf                            Procedure(Long _Notimplemented),Long,Proc
GetNearestColor                                     Procedure(Long _Notimplemented),Long,Proc
GetPageScale                                        Procedure(Long ,Long),Proc,Long
GetPageUnit                                         Procedure(Long ,Long),Proc,Long
GetPathData                                         Procedure(Long _Notimplemented),Long,Proc
GetPathFillMode                                     Procedure(Long _Notimplemented),Long,Proc
GetPathGradientBlend                                Procedure(Long _Notimplemented),Long,Proc
GetPathGradientBlendcount                           Procedure(Long _Notimplemented),Long,Proc
GetPathGradientCenterPoint                          Procedure(Long _Notimplemented),Long,Proc
GetPathGradientCenterPointi                         Procedure(Long _Notimplemented),Long,Proc
GetPathGradientCentercolor                          Procedure(Long _Notimplemented),Long,Proc
GetPathGradientGammacorRection                      Procedure(Long _Notimplemented),Long,Proc
GetPathGradientPointcount                           Procedure(Long _Notimplemented),Long,Proc
GetPathGradientRect                                 Procedure(Long _Notimplemented),Long,Proc
GetPathGradientRecti                                Procedure(Long _Notimplemented),Long,Proc
GetPathGradientfocusscales                          Procedure(Long _Notimplemented),Long,Proc
GetPathGradientpresetBlend                          Procedure(Long _Notimplemented),Long,Proc
GetPathGradientpresetBlendcount                     Procedure(Long _Notimplemented),Long,Proc
GetPathGradientsurroundcolorcount                   Procedure(Long _Notimplemented),Long,Proc
GetPathGradientsurroundcolorswithcount              Procedure(Long _Notimplemented),Long,Proc
GetPathGradientwrapmode                             Procedure(Long _Notimplemented),Long,Proc
GetPathPoints                                       Procedure(Long _Notimplemented),Long,Proc
GetPathPointsi                                      Procedure(Long _Notimplemented),Long,Proc
GetPathlastPoint                                    Procedure(Long _Notimplemented),Long,Proc
GetPathtypes                                        Procedure(Long _Notimplemented),Long,Proc
GetPathworldbounds                                  Procedure(Long ,Long,Long, Long),Proc,Long
GetPathworldboundsi                                 Procedure(Long _Notimplemented),Long,Proc
GetPointcount                                       Procedure(Long _Notimplemented),Long,Proc
GetRegionbounds                                     Procedure(Long _Notimplemented),Long,Proc
GetRegionboundsi                                    Procedure(Long _Notimplemented),Long,Proc
GetRegiondata                                       Procedure(Long _Notimplemented),Long,Proc
GetRegiondatasize                                   Procedure(Long _Notimplemented),Long,Proc
GetRegionhrgn                                       Procedure(Long _Notimplemented),Long,Proc
GetRegionscans                                      Procedure(Long _Notimplemented),Long,Proc
GetRegionscanscount                                 Procedure(Long _Notimplemented),Long,Proc
GetRegionscansi                                     Procedure(Long _Notimplemented),Long,Proc
!GetSolidBrush                                       Procedure(<Long _color>, <Byte _A>, <Byte _R>, <Byte _G>, <Byte _B>),long,PROC
GetStringformatalign                                Procedure(Long _Notimplemented),Long,Proc
GetStringformatdigitsubstitution                    Procedure(Long _Notimplemented),Long,Proc
GetStringformatflags                                Procedure(Long Pformat , Long Flagsptr),Proc,Long
GetStringformathotkeyprefix                         Procedure(Long _Notimplemented),Long,Proc
GetStringformatlinealign                            Procedure(Long _Notimplemented),Long,Proc
GetStringformatmeasurablecharacterrangecount        Procedure(Long _Notimplemented),Long,Proc
GetStringformattabstopcount                         Procedure(Long _Notimplemented),Long,Proc
GetStringformattabstops                             Procedure(Long _Notimplemented),Long,Proc
GetStringformattrimming                             Procedure(Long _Notimplemented),Long,Proc
GetTextureImage                                     Procedure(Long _Notimplemented),Long,Proc
GetTexturetransform                                 Procedure(Long _Notimplemented),Long,Proc
GetTexturewrapmode                                  Procedure(Long _Notimplemented),Long,Proc
GetpenBrushfill                                     Procedure(Long _Notimplemented),Long,Proc
Getpencolor                                         Procedure(Long _Notimplemented),Long,Proc
Getpencompoundarray                                 Procedure(Long _Notimplemented),Long,Proc
Getpencompoundcount                                 Procedure(Long _Notimplemented),Long,Proc
Getpencustomendcap                                  Procedure(Long _Notimplemented),Long,Proc
Getpencustomstartcap                                Procedure(Long _Notimplemented),Long,Proc
Getpendasharray                                     Procedure(Long _Notimplemented),Long,Proc
Getpendashcap197819                                 Procedure(Long _Notimplemented),Long,Proc
Getpendashcount                                     Procedure(Long _Notimplemented),Long,Proc
Getpendashoffset                                    Procedure(Long _Notimplemented),Long,Proc
Getpendashstyle                                     Procedure(Long _Notimplemented),Long,Proc
Getpenendcap                                        Procedure(Long _Notimplemented),Long,Proc
Getpenfilltype                                      Procedure(Long _Notimplemented),Long,Proc
Getpenlinejoin                                      Procedure(Long _Notimplemented),Long,Proc
Getpenmiterlimit                                    Procedure(Long _Notimplemented),Long,Proc
Getpenmode                                          Procedure(Long _Notimplemented),Long,Proc
Getpenstartcap                                      Procedure(Long _Notimplemented),Long,Proc
Getpentransform                                     Procedure(Long _Notimplemented),Long,Proc
Getpenunit                                          Procedure(Long _Notimplemented),Long,Proc
Getpenwidth                                         Procedure(Long _Notimplemented),Long,Proc
Getpixeloffsetmode                                  Procedure(Long ,Long),Proc,Long
Getpropertycount                                    Procedure(Long _PImage,Long _Count),Proc,Long
Getpropertyidlist                                   Procedure(Long _PImage,Long _Numofproperty,Long _Propidlist),Proc,Long
Getpropertyitem                                     Procedure(Long _PImage,Long _Propid,Long _Propitemsize,Long _Propitemvalue),Proc,Long
Getpropertyitemsize                                 Procedure(Long _PImage,Long _Propid, Long _Propitemsize),Proc,Long
Getpropertysize                                     Procedure(Long _PImage,Long Totalbuffersize, Long Numproperties),Proc,Long
Getrenderingorigin                                  Procedure(Long _Notimplemented),Long,Proc
Getsmoothingmode                                    Procedure(Long ,Long),Proc,Long
Getsolidfillcolor                                   Procedure(Long _Notimplemented),Long,Proc
Gettextcontrast                                     Procedure(Long _Graphic, Long _Contrast),Proc,Long
Gettextrenderinghint                                Procedure(Long _Notimplemented),Long,Proc
Getvisibleclipbounds                                Procedure(Long ,Long),Proc,Long
Getvisibleclipboundsi                               Procedure(Long ,Long),Proc,Long
Getworldtransform                                   Procedure(Long _Notimplemented),Long,Proc
Graphicsclear                                       Procedure(Long _Notimplemented),Long,Proc
Graphicssetabort                                    Procedure(Long _Notimplemented),Long,Proc
Imageforcevalidation                                Procedure(Long _Notimplemented),Long,Proc
Imagegetframecount                                  Procedure(Long _Image,Long _Dimensionid, Long _Count),Proc,Long
Imagegetframedimensionscount                        Procedure(Long _Image,Long _Count),Proc,Long
Imagegetframedimensionslist                         Procedure(Long _Image, Long _Dimsids, Long _Count),Proc,Long
Imagerotateflip                                     Procedure(Long _Notimplemented),Long,Proc
Imageselectactiveframe                              Procedure(Long _Image, Long _Dimensionguid, ULong _Frameindex),Proc,Long
Imagesetabort                                       Procedure(Long _Notimplemented),Long,Proc
InitTheme                                           Procedure(Long _windowHandle, <String _ansiThemeName>),Long,proc
Initializepalette                                   Procedure(Long _Notimplemented),Long,Proc
InvertMatrix                                        Procedure(Long _Notimplemented),Long,Proc
IsClipEmpty                                         Procedure(Long _Notimplemented),Long,Proc
IsEmptyRegion                                       Procedure(Long _Notimplemented),Long,Proc
IsEqualRegion                                       Procedure(Long _Notimplemented),Long,Proc
IsMatrixEqual                                       Procedure(Long _Notimplemented),Long,Proc
IsMatrixidentity                                    Procedure(Long _Notimplemented),Long,Proc
IsMatrixinvertible                                  Procedure(Long _Notimplemented),Long,Proc
IsinfiniteRegion                                    Procedure(Long _Notimplemented),Long,Proc
IsoutlinevisiblePathPoint                           Procedure(Long _Notimplemented),Long,Proc
IsoutlinevisiblePathPointi                          Procedure(Long _Notimplemented),Long,Proc
Isstyleavailable                                    Procedure(Long _Notimplemented),Long,Proc
IsvisiblePathPoint                                  Procedure(Long _Notimplemented),Long,Proc
IsvisiblePathPointi                                 Procedure(Long _Notimplemented),Long,Proc
IsvisiblePoint                                      Procedure(Long _Notimplemented),Long,Proc
IsvisiblePointi                                     Procedure(Long _Notimplemented),Long,Proc
IsvisibleRect                                       Procedure(Long _Notimplemented),Long,Proc
IsvisibleRecti                                      Procedure(Long _Notimplemented),Long,Proc
IsvisibleRegionPoint                                Procedure(Long _Notimplemented),Long,Proc
IsvisibleRegionPointi                               Procedure(Long _Notimplemented),Long,Proc
IsvisibleRegionRect                                 Procedure(Long _Notimplemented),Long,Proc
IsvisibleRegionRecti                                Procedure(Long _Notimplemented),Long,Proc
Isvisibleclipempty                                  Procedure(Long _Notimplemented),Long,Proc
LoadImageFromFile                                   Procedure(Long _Filenamew,Long _GpImage),Proc,Long
LoadImageFromFileIcm                                Procedure(Long _Notimplemented),Long,Proc
LoadImageFromstream                                 Procedure(Long _Notimplemented),Long,Proc
LoadImageFromstreamicm                              Procedure(Long _Notimplemented),Long,Proc
MeasureString                                       Procedure(Long Graphics,Long PString,Long Length,Long PFont, Long LayoutRect,Long Stringformat, Long Boundingbox, Long CodePointsfitted, Long Linesfilled),Proc,Long
Measurecharacterranges                              Procedure(Long ,Long,Long,Long,Long,Long,Long),Proc,Long
MeasuredriverString                                 Procedure(Long ,Long,Long,Long,Long,Long,Long,Long,Long),Proc,Long
MultiplyMatrix                                      Procedure(Long _Notimplemented),Long,Proc
MultiplyTexturetransform                            Procedure(Long _Notimplemented),Long,Proc
Multiplypentransform                                Procedure(Long _Notimplemented),Long,Proc
Multiplyworldtransform                              Procedure(Long _Notimplemented),Long,Proc
NewinstalledFontcollection                          Procedure(Long _Notimplemented),Long,Proc
NewprivateFontcollection                            Procedure(Long _Notimplemented),Long,Proc
NotYetImplemented                                   Procedure(),string,PROC
OpenThemeData                                       Procedure(Long _windowHandle, String _className),Long,PROC
PaintBorderI                                        Procedure(long _graphic, long _x, long _y, long _w, long _h, long _color, sreal _borderW),long,proc
Pathitercopydata                                    Procedure(Long _Notimplemented),Long,Proc
Pathiterenumerate                                   Procedure(Long _Notimplemented),Long,Proc
Pathitergetcount                                    Procedure(Long _Notimplemented),Long,Proc
PathitergetsubPathcount                             Procedure(Long _Notimplemented),Long,Proc
PathiterhasCurve                                    Procedure(Long _Notimplemented),Long,Proc
Pathiterisvalid                                     Procedure(Long _Notimplemented),Long,Proc
PathiternextPathtype                                Procedure(Long _Notimplemented),Long,Proc
Pathiternextmarker                                  Procedure(Long _Notimplemented),Long,Proc
PathiternextmarkerPath                              Procedure(Long _Notimplemented),Long,Proc
PathiternextsubPath                                 Procedure(Long _Notimplemented),Long,Proc
PathiternextsubPathPath                             Procedure(Long _Notimplemented),Long,Proc
Pathiterrewind                                      Procedure(Long _Notimplemented),Long,Proc
RGBAToARGB                                          Procedure(long _colorRGBA),Long
SaveBmpBuffer2Png                                   Procedure(<String _utf8>),Long,proc
SaveGraphicToFile                                   Procedure(Long _graphicHandle, String _fileNameUtf8, Long _width, Long _height),Long,proc
SetDIBits                                           Procedure(long _hdc, long _hbm, long _start, long _cLines, long _lpBits, long _lpbmi, long _ColorUse),long,PROC
SetEffectParameters                                 Procedure(Long _Notimplemented),Long,Proc
SetEmpty                                            Procedure(Long _Notimplemented),Long,Proc
SetImageAttributesGamma                             Procedure(Long _Notimplemented),Long,Proc
SetImageAttributescachedbackground                  Procedure(Long _Notimplemented),Long,Proc
SetImageAttributescolorMatrix                       Procedure(Long _Notimplemented),Long,Proc
SetImageAttributescolorkeys                         Procedure(Long _Notimplemented),Long,Proc
SetImageAttributesnoop                              Procedure(Long _Notimplemented),Long,Proc
SetImageAttributesoutputchannel                     Procedure(Long _Notimplemented),Long,Proc
SetImageAttributesoutputchannelcolorproFile         Procedure(Long _Notimplemented),Long,Proc
SetImageAttributesremaptable                        Procedure(Long _Notimplemented),Long,Proc
SetImageAttributesthreshold                         Procedure(Long _Notimplemented),Long,Proc
SetImageAttributestoidentity                        Procedure(Long _Notimplemented),Long,Proc
SetImageAttributeswrapmode                          Procedure(Long _Notimplemented),Long,Proc
SetImagepalette                                     Procedure(Long _Notimplemented),Long,Proc
SetMatrixelements                                   Procedure(Long _Notimplemented),Long,Proc
SetPathGradientBlend                                Procedure(Long _Notimplemented),Long,Proc
SetPathGradientCenterPoint                          Procedure(Long _Notimplemented),Long,Proc
SetPathGradientCenterPointi                         Procedure(Long _Notimplemented),Long,Proc
SetPathGradientCentercolor                          Procedure(Long _Notimplemented),Long,Proc
SetPathGradientGammacorRection                      Procedure(Long _Notimplemented),Long,Proc
SetPathGradientPath                                 Procedure(Long _Notimplemented),Long,Proc
SetPathGradientfocusscales                          Procedure(Long _Notimplemented),Long,Proc
SetPathGradientlinearBlend                          Procedure(Long _Notimplemented),Long,Proc
SetPathGradientpresetBlend                          Procedure(Long _Notimplemented),Long,Proc
SetPathGradientsigmaBlend                           Procedure(Long _Notimplemented),Long,Proc
SetPathGradientsurroundcolorswithcount              Procedure(Long _Notimplemented),Long,Proc
SetPathGradientwrapmode                             Procedure(Long _Notimplemented),Long,Proc
SetPathfillmode                                     Procedure(Long Path, Long Mode),Proc,Long
SetPathmarker                                       Procedure(Long _Notimplemented),Long,Proc
SetRenderType                                       Procedure(long _graphics, long _gdiplusRenderType),LONG,PROC
SetStringformatalign                                Procedure(Long _Notimplemented),Long,Proc
SetStringformatdigitsubstitution                    Procedure(Long _Notimplemented),Long,Proc
SetStringformatflags                                Procedure(Long Pformat , Long Flags),Proc,Long
SetStringformathotkeyprefix                         Procedure(Long _Notimplemented),Long,Proc
SetStringformatlinealign                            Procedure(Long _Notimplemented),Long,Proc
SetStringformatmeasurablecharacterranges            Procedure(Long _Notimplemented),Long,Proc
SetStringformattabstops                             Procedure(Long _Notimplemented),Long,Proc
SetStringformattrimming                             Procedure(Long Pformat , Long Trimming),Proc,Long
SetTexturetransform                                 Procedure(Long _Notimplemented),Long,Proc
SetTexturewrapmode                                  Procedure(Long _Notimplemented),Long,Proc
Setadjustablearrowcapfillstate                      Procedure(Long _Notimplemented),Long,Proc
Setadjustablearrowcapheight                         Procedure(Long _Notimplemented),Long,Proc
Setadjustablearrowcapmiddleinset                    Procedure(Long _Notimplemented),Long,Proc
Setadjustablearrowcapwidth                          Procedure(Long _Notimplemented),Long,Proc
SetclipGraphics                                     Procedure(Long _Notimplemented),Long,Proc
SetclipPath                                         Procedure(Long _Notimplemented),Long,Proc
SetclipRect                                         Procedure(Long _Notimplemented),Long,Proc
SetclipRecti                                        Procedure(Long _Notimplemented),Long,Proc
SetclipRegion                                       Procedure(Long _Notimplemented),Long,Proc
Setcliphrgn                                         Procedure(Long _Notimplemented),Long,Proc
Setcompositingmode                                  Procedure(Long ,Long),Proc,Long
Setcompositingquality                               Procedure(Long ,Long),Proc,Long
Setcustomlinecapbasecap                             Procedure(Long _Notimplemented),Long,Proc
Setcustomlinecapbaseinset                           Procedure(Long _Notimplemented),Long,Proc
Setcustomlinecapstrokecaps                          Procedure(Long _Notimplemented),Long,Proc
Setcustomlinecapstrokejoin                          Procedure(Long _Notimplemented),Long,Proc
Setcustomlinecapwidthscale                          Procedure(Long _Notimplemented),Long,Proc
Setinfinite                                         Procedure(Long _Notimplemented),Long,Proc
Setinterpolationmode                                Procedure(Long ,Long),Proc,Long
SetlineBlend                                        Procedure(Long _Notimplemented),Long,Proc
SetlineGammacorRection                              Procedure(Long _Notimplemented),Long,Proc
Setlinecolors                                       Procedure(Long _Notimplemented),Long,Proc
SetlinepresetBlend                                  Procedure(Long _Notimplemented),Long,Proc
SetlinesigmaBlend                                   Procedure(Long _Notimplemented),Long,Proc
Setlinewrapmode                                     Procedure(Long _Notimplemented),Long,Proc
SetmetaFiledownlevelrasterizationlimit              Procedure(Long _Notimplemented),Long,Proc
Setpagescale                                        Procedure(Long ,Sreal),Proc,Long
Setpageunit                                         Procedure(Long ,Long),Proc,Long
SetpenBrushfill                                     Procedure(Long _Notimplemented),Long,Proc
Setpencolor                                         Procedure(Long Pen, Long Color),Proc,Long
Setpencompoundarray                                 Procedure(Long _Notimplemented),Long,Proc
Setpencustomendcap                                  Procedure(Long _Notimplemented),Long,Proc
Setpencustomstartcap                                Procedure(Long _Notimplemented),Long,Proc
Setpendasharray                                     Procedure(Long _Notimplemented),Long,Proc
Setpendashcap197819                                 Procedure(Long _Notimplemented),Long,Proc
Setpendashoffset                                    Procedure(Long _Notimplemented),Long,Proc
Setpendashstyle                                     Procedure(Long _Notimplemented),Long,Proc
Setpenendcap                                        Procedure(Long _Notimplemented),Long,Proc
Setpenlinecap197819                                 Procedure(Long _Notimplemented),Long,Proc
Setpenlinejoin                                      Procedure(Long _Notimplemented),Long,Proc
Setpenmiterlimit                                    Procedure(Long _Notimplemented),Long,Proc
Setpenmode                                          Procedure(Long _Notimplemented),Long,Proc
Setpenstartcap                                      Procedure(Long _Notimplemented),Long,Proc
Setpentransform                                     Procedure(Long _Notimplemented),Long,Proc
Setpenunit                                          Procedure(Long _Notimplemented),Long,Proc
Setpenwidth                                         Procedure(Long _Notimplemented),Long,Proc
Setpixeloffsetmode                                  Procedure(Long ,Long),Proc,Long
Setpropertyitem                                     Procedure(Long ,Long),Proc,Long
Setrenderingorigin                                  Procedure(Long _Notimplemented),Long,Proc
Setsmoothingmode                                    Procedure(Long ,Long),Proc,Long
Setsolidfillcolor                                   Procedure(Long ,Long),Proc,Long
Settextcontrast                                     Procedure(Long _Notimplemented),Long,Proc
Settextrenderinghint                                Procedure(Long ,Long),Proc,Long
Setworldtransform                                   Procedure(Long _Notimplemented),Long,Proc
Stringformatgetgenericdefault                       Procedure(Long _Notimplemented),Long,Proc
StringformatgetgenerictypoGraphic                   Procedure(Long _Notimplemented),Long,Proc
WriteDibBitsToBmp                                   Procedure(Long _dibBitsPtr, Long _length, String _filenameUtf8),Long,proc
playmetaFilerecord                                  Procedure(Long _Notimplemented),Long,Proc
playtsclientrecord                                  Procedure(Long _Notimplemented),Long,Proc
privateaddFontFile                                  Procedure(Long _Notimplemented),Long,Proc
privateaddmemoryFont                                Procedure(Long _Notimplemented),Long,Proc
recordmetaFile                                      Procedure(Long _Notimplemented),Long,Proc
recordmetaFileFilename                              Procedure(Long _Notimplemented),Long,Proc
recordmetaFileFilenamei                             Procedure(Long _Notimplemented),Long,Proc
recordmetaFilei                                     Procedure(Long _Notimplemented),Long,Proc
recordmetaFilestream                                Procedure(Long _Notimplemented),Long,Proc
recordmetaFilestreami                               Procedure(Long _Notimplemented),Long,Proc
releasedc                                           Procedure(Long Hwnd,Long Dc),Proc,Long
removepropertyitem                                  Procedure(Long _Notimplemented),Long,Proc
resetImageAttributes                                Procedure(Long _Notimplemented),Long,Proc
resetPath                                           Procedure(Long ),Proc,Long
resetTexturetransform                               Procedure(Long _Notimplemented),Long,Proc
resetclip                                           Procedure(Long ),Proc,Long
resetpagetransform                                  Procedure(Long _Notimplemented),Long,Proc
resetpentransform                                   Procedure(Long _Notimplemented),Long,Proc
resetworldtransform                                 Procedure(Long _Notimplemented),Long,Proc
restoreGraphics                                     Procedure(Long _Notimplemented),Long,Proc
reversePath                                         Procedure(Long Path),Proc,Long
rotateMatrix                                        Procedure(Long _Notimplemented),Long,Proc
rotateTexturetransform                              Procedure(Long _Notimplemented),Long,Proc
rotatepentransform                                  Procedure(Long _Notimplemented),Long,Proc
rotateworldtransform                                Procedure(Long _Notimplemented),Long,Proc
saveGraphics                                        Procedure(Long ,Long),Proc,Long
saveImagetoFile                                     Procedure(Long _PImage,Long _Filenameutf16,Long _Encoder,Long _Encoderparams),Proc,Long
saveImagetostream                                   Procedure(Long _Notimplemented),Long,Proc
saveadd                                             Procedure(Long _Notimplemented),Long,Proc
saveaddImage                                        Procedure(Long _Notimplemented),Long,Proc
scaleMatrix                                         Procedure(Long _Notimplemented),Long,Proc
scaleTexturetransform                               Procedure(Long _Notimplemented),Long,Proc
scalepentransform                                   Procedure(Long _Notimplemented),Long,Proc
scaleworldtransform                                 Procedure(Long _Notimplemented),Long,Proc
shearMatrix                                         Procedure(Long _Notimplemented),Long,Proc
startPathfigure                                     Procedure(Long Path),Proc,Long
testcontrol                                         Procedure(Long _Notimplemented),Long,Proc
transformMatrixPoints                               Procedure(Long _Notimplemented),Long,Proc
transformMatrixPointsi                              Procedure(Long _Notimplemented),Long,Proc
transformPath                                       Procedure(Long Path, Long Matrix),Proc,Long
transformPoints                                     Procedure(Long _Notimplemented),Long,Proc
transformPointsi                                    Procedure(Long _Notimplemented),Long,Proc
transformRegion                                     Procedure(Long _Notimplemented),Long,Proc
translateMatrix                                     Procedure(Long _Notimplemented),Long,Proc
translatePathGradienttransform                      Procedure(Long _Notimplemented),Long,Proc
translateRegion                                     Procedure(Long _Notimplemented),Long,Proc
translateRegioni                                    Procedure(Long _Notimplemented),Long,Proc
translateTexturetransform                           Procedure(Long _Notimplemented),Long,Proc
translateclip                                       Procedure(Long _Notimplemented),Long,Proc
translateclipi                                      Procedure(Long _Notimplemented),Long,Proc
translatepentransform                               Procedure(Long _Notimplemented),Long,Proc
translateworldtransform                             Procedure(Long _Notimplemented),Long,Proc
vectortransformMatrixPoints                         Procedure(Long _Notimplemented),Long,Proc
vectortransformMatrixPointsi                        Procedure(Long _Notimplemented),Long,Proc
warpPath                                            Procedure(Long _Notimplemented),Long,Proc
widenPath                                           Procedure(Long _Notimplemented),Long,Proc
windingmodeoutline                                  Procedure(Long _Notimplemented),Long,Proc

ColorOverARGB                                       long,over(ColorARGB)
ColorOverRGBA                                       Long,OVER(ColorRGBA)
GetSolidBrushColor                                  Long,over(GetSolidBrushColorARGB)


                                                                        End



