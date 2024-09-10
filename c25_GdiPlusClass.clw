    Member

    Include('c25_GdiPlusClass.inc'),Once
    Map
        Include('i64.inc')
        Include('c25_WinApiPrototypes.inc')
        Module('c25_GdiPlusClass.clw')
        End
    End

c25_GdiPlusClass.Construct                              Procedure()

ClassStarter    &c25_ClassStarter

Code

    Self.ClassTypeName = 'c25_GdiPlusClass'

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(Self.ClassTypeName))
    Dispose(ClassStarter)

    Self.GdiPlusSolidBrushQ &= NEW GdiPlusSolidBrush_TYPE()
    Self.BitConverterClass &= NEW c25_BitConverterClass()

    Self.ImgEncoderCodecInfoQ &= NEW ImageCodecInfo_TYPE
    Self.ImgDecoderCodecInfoQ &= NEW ImageCodecInfo_TYPE
    Self.BmpEncoderGuid36 = '557CF400-1A04-11D3-9A73-0000F81EF32E'
    Self.JpgEncoderGuid36 = '557CF401-1A04-11D3-9A73-0000F81EF32E'
    Self.GifEncoderGuid36 = '557CF402-1A04-11D3-9A73-0000F81EF32E'
    Self.TiffEncoderGuid36 = '557CF405-1A04-11D3-9A73-0000F81EF32E'
    Self.PngEncoderGuid36 = '557CF406-1A04-11D3-9A73-0000F81EF32E'
    Self.BmpEncoderGuid16 = Self.BitConverterClass.Guid16FromGuid36(Self.BmpEncoderGuid36)
    Self.JpgEncoderGuid16 = Self.BitConverterClass.Guid16FromGuid36(Self.JpgEncoderGuid36)
    Self.GifEncoderGuid16 = Self.BitConverterClass.Guid16FromGuid36(Self.GifEncoderGuid36)
    Self.TiffEncoderGuid16 = Self.BitConverterClass.Guid16FromGuid36(Self.TiffEncoderGuid36)
    Self.PngEncoderGuid16 = Self.BitConverterClass.Guid16FromGuid36(Self.PngEncoderGuid36)

!    Self.GetImgEncoderCodecInfo()
!    Self.GetImgDecoderCodecInfo()


    
c25_GdiPlusClass.FillCodecs                              Procedure()

ClassStarter    &c25_ClassStarter

Code


    Self.ImgEncoderCodecInfoQ &= NEW ImageCodecInfo_TYPE
    Self.ImgDecoderCodecInfoQ &= NEW ImageCodecInfo_TYPE
    Self.BmpEncoderGuid36 = '557CF400-1A04-11D3-9A73-0000F81EF32E'
    Self.JpgEncoderGuid36 = '557CF401-1A04-11D3-9A73-0000F81EF32E'
    Self.GifEncoderGuid36 = '557CF402-1A04-11D3-9A73-0000F81EF32E'
    Self.TiffEncoderGuid36 = '557CF405-1A04-11D3-9A73-0000F81EF32E'
    Self.PngEncoderGuid36 = '557CF406-1A04-11D3-9A73-0000F81EF32E'
    Self.BmpEncoderGuid16 = Self.BitConverterClass.Guid16FromGuid36(Self.BmpEncoderGuid36)
    Self.JpgEncoderGuid16 = Self.BitConverterClass.Guid16FromGuid36(Self.JpgEncoderGuid36)
    Self.GifEncoderGuid16 = Self.BitConverterClass.Guid16FromGuid36(Self.GifEncoderGuid36)
    Self.TiffEncoderGuid16 = Self.BitConverterClass.Guid16FromGuid36(Self.TiffEncoderGuid36)
    Self.PngEncoderGuid16 = Self.BitConverterClass.Guid16FromGuid36(Self.PngEncoderGuid36)

    Self.GetImgEncoderCodecInfo()
    Self.GetImgDecoderCodecInfo()
    Return 0
    
c25_GdiPlusClass.Destruct Procedure()

Code

    
    
c25_GdiPlusClass.GdiplusStartup Procedure()

Code

    If Self.GdiplusToken = 0
        Clear(Self.GdiplusStartupInput)
        Self.GdiplusStartupInput.Version = 2
        R# = c25_GdiplusStartup(Address(Self.GdiplusToken),Address(Self.GdiplusStartupInput),0)
        If R# <> 0
            !Message('Severe Error GDIPlus Startup ' & R# & ', ' & C25_GetLastError() )
        End
    End

    Return Self.GdiplusToken


c25_GdiPlusClass.GdiplusShutdown Procedure()

Code

    If Self.GdiPlusToken <> 0
        c25_GdiplusShutdown(Self.GdiPlusToken)
    End
    Self.GdiPlusToken = 0
    Return 0
    
c25_GdiPlusClass.NotYetImplemented  Procedure()    

    CODE
        
        Return 0
        
        
c25_GdiPlusClass.GetColorMacro                              Procedure(<Byte _A>, <Byte _R>, <Byte _G>, <Byte _B>)

Code

    Self.ColorARGB.A = _A
    Self.ColorARGB.B = _B
    Self.ColorARGB.G = _G
    Self.ColorARGB.R = _R
    Return Self.ColorOverARGB
        
c25_GdiPlusClass.GetColorMacroRGBA                            Procedure(<Byte _R>, <Byte _G>, <Byte _B>, <Byte _A>)

CODE

    Self.ColorRGBA.A = _A
    Self.ColorRGBA.B = _B
    Self.ColorRGBA.G = _G
    Self.ColorRGBA.R = _R
    Return Self.ColorOverRGBA
               
        
c25_GdiPlusClass.RGBAToARGB                                     Procedure(long _colorRGBA)

CODE
    
    Self.ColorOverRGBA = _colorRGBA
    Self.ColorARGB.A = Self.ColorRGBA.A
    Self.ColorARGB.B = Self.ColorRGBA.B
    Self.ColorARGB.G = Self.ColorRGBA.G
    Self.ColorARGB.R = Self.ColorRGBA.R
  
    Return Self.ColorOverARGB


c25_GdiPlusClass.ARGBToRGBA                                     Procedure(long _colorARGB)

CODE
    
    Self.ColorOverARGB = _colorARGB
    
    Self.ColorRGBA.A = Self.ColorARGB.A
    Self.ColorRGBA.B = Self.ColorARGB.B
    Self.ColorRGBA.G = Self.ColorARGB.G
    Self.ColorRGBA.R = Self.ColorARGB.R
    
    Return Self.ColorOverRGBA
        
        
c25_GdiPlusClass.BitBlt                                     Procedure(long _hdc, long _x, long _y, long _cx, long _cy, long _hdcSrc, long _x1, long _y1, long _rop)

ReturnVal long

CODE

    ReturnVal = C25_BitBlt(_hdc, _x, _y, _cx, _cy, _hdcSrc, _x1, _y1, _rop)
    
    Return ReturnVal
    
    
c25_GdiPlusClass.SetDIBits                                           Procedure(long _hdc, long _hbm, long _start, long _cLines, long _lpBits, long _lpbmi, long _ColorUse)    
  
ReturnVal long

CODE

    ReturnVal = C25_SetDIBits(_hdc, _hbm, _start, _cLines, _lpBits, _lpbmi, _ColorUse)
    
    Return ReturnVal
    
    
    
c25_GdiPlusClass.CreateBmpFileAndDIBHeader              Procedure(long _w, long _h, long _pixelArraySize)

BmpFileHeader                                           Group,Pre(BmpFileHeader)
Magic                                                       string(2)
FileSize                                                    Long
Reserved                                                    Long
OffsetPixelArray                                            Long
                                                        End
BmpFileHeaderOver                                       String(14),Over(BmpFileHeader)

BmpInfoHeader                                           Group,Pre(BmpInfoHeader)
Size                                                        Long,Name('Size')
Width                                                       Long,Name('Width')
Height                                                      Long,Name('Height')
Planes                                                      Short,Name('Planes')
BitCount                                                    Short,Name('BitCount')
Compression                                                 Long,Name('Compression')
SizeImage                                                   Long,Name('SizeImage')
XpelsPerMeter                                               Long,Name('XpelsPerMeter')
YPelsPerMeter                                               Long,Name('YPelsPerMeter')
ClrUsed                                                     Long,Name('ClrUsed')
ClrImportant                                                Long,Name('ClrImportant')
                                                        End
BmpInfoHeaderOver                                       String(40),Over(BmpInfoHeader)


CODE

    BmpFileHeader.Magic                 = 'BM'
    BmpFileHeader.FileSize              = _pixelArraySize + 54
    BmpFileHeader.OffsetPixelArray      = 54
    
    BmpInfoHeader.Size                  = 40
    BmpInfoHeader.Width                 = _w
    BmpInfoHeader.Height                = _h
    If BmpInfoHeader.Height > 0
        BmpInfoHeader.Height = BmpInfoHeader.Height * -1
    End
    BmpInfoHeader.Planes                = 1
    BmpInfoHeader.BitCount              = 32
    BmpInfoHeader.Compression           = 0
    BmpInfoHeader.SizeImage             = 0
    BmpInfoHeader.Planes                = 0
    
    Return BmpFileHeaderOver & BmpInfoHeaderOver
    
    
    
c25_GdiPlusClass.GetColorByte      Procedure(long _color, string _name)

!ColorValue                              Long
!ColorARGB                       Group,Pre(ColorARGB)
!B                                   Byte
!G                                   Byte
!R                                   Byte
!A                                   Byte
!                                End
!ColorOverARGB                                                               long,over(ColorARGB)
    CODE
        
        Self.ColorOverARGB = _color
        Case UPPER(_name)
        Of 'ALPHA'
        OrOf 'A'
            Return Self.ColorARGB.A
        Of 'RED'
        OrOf 'R'
            Return Self.ColorARGB.R
        Of 'GREEN'
        OrOf 'G'
            Return Self.ColorARGB.G
        Of 'BLUE'
        OrOf 'B'
            Return Self.ColorARGB.B
        Of 'ARGB'
            Return Format(Self.ColorARGB.A,@N03) & ',' &  Format(Self.ColorARGB.R,@N03) & ',' &  Format(Self.ColorARGB.G,@N03) & ',' &  Format(Self.ColorARGB.B,@N03)
        Of 'HEX'
            Return Self.ProgramHandlerClass.BitConverterClass.FastHexFromLong(Self.ColorOverARGB)
        End
        Return 0
    
c25_GdiPlusClass.DeleteCanvas    Procedure(long _OldCanvasGraphics, long _OldCanvasImagePtr, long _OldCanvasScan0, long _OldCanvasBitmapAllocSize)

CODE
        
    If _OldCanvasImagePtr <> 0
        C25_Gdipdisposeimage(_OldCanvasImagePtr)
    End
    If _OldCanvasScan0 <> 0
        c25_HeapFree(C25_Getprocessheap(), 0,  _OldCanvasScan0)
    End
    If _OldCanvasGraphics <> 0
        C25_Gdipdeletegraphics(_OldCanvasGraphics)
    End
    Return 0

c25_GdiPlusClass.CreateCanvas                           Procedure(long _w, long _h,  <*long _graphicsOut>, <*long _imagePtrOut>, <*long _scan0Out>, <*long _allocSizeOut>, <*long _strideOut>, <*long _pixelFormatOut>, <long _displayStateMode>, <long _backgroundColor>)

Stride                                                  Long
PixelFormat                                             Long
Scan0                                                   Long
ImagePtr                                                Long
AllocSize                                               Long
Graphics                                                Long
Tuple                                                   Like(Tuple2_TYPE)
GradientRect                                            Group(WindowRect_TYPE),Pre(GradientRect)
                                                        End
LinearGradientBrush                                     long
!BufferDc                                                    Long

Code
        
    Stride      = _w * 4
    PixelFormat = c25_PixelFormat32bppPARGB
    AllocSize   = _w  * _h * 4
    Scan0       = c25_HeapAlloc( C25_Getprocessheap() , 8, AllocSize)
    ImagePtr    = 0
    c25_GdipCreateBitmapFromScan0(_w, _h, Stride, PixelFormat, Scan0, Address(ImagePtr) )

    c25_GdipGetImageGraphicsContext(ImagePtr, Address(Graphics))
    
!!    c25_GdipSetTextRenderingHint(Graphics, TextRenderingHintClearTypeGridFit)
!!    c25_GdipSetSmoothingMode(Graphics, SmoothingModeNone)
!!    c25_GdipSetCompositingQuality(Graphics,CompositingQualityHighQuality)
!!    c25_GdipSetInterpolationMode(Graphics,InterpolationModeBilinear )
!!    c25_GdipSetPixelOffsetMode(Graphics,PixelOffsetModeNone )
    
    If omitted(_backgroundColor) = False  
        
        !!Self.FillRectangleI(Graphics, Self.GetSolidBrush(_backgroundColor), 0, 0, _w, _h) 
        Self.FillRectangleI(Graphics, Self.NewSolidBrush(,_backgroundColor), 0, 0, _w, _h) 
    Else
        !!Self.FillRectangleI(Graphics, Self.GetSolidBrush( , 255, 255,255,255), 0, 0, _w, _h) 
        Self.FillRectangleI(Graphics, Self.NewSolidBrush( , , 255, 255,255,255), 0, 0, _w, _h) 
    End
    !Self.FillRectangleI(Graphics, Self.NewSolidBrush( , , 255, 255,155,255), 0, 0, _w, _h) 
    
    If omitted(_strideOut) = FALSE
        _strideOut = Stride
    End
    If omitted(_pixelFormatOut) = FALSE
        _pixelFormatOut = PixelFormat
    End
    If omitted(_allocSizeOut) = FALSE
        _allocSizeOut = AllocSize
    End
    If omitted(_scan0Out) = FALSE
        _scan0Out = Scan0
    End
    If omitted(_graphicsOut) = FALSE
        _graphicsOut = Graphics
    End
    If omitted(_imagePtrOut) = FALSE
        _imagePtrOut = ImagePtr
    End

!    C25_GdipGetDC(Graphics, Address(BufferDc))
!    Message('BufferDc : ' & BufferDc)
!    If BufferDc <> 0
!        C25_GdipReleaseDC(Graphics, BufferDc)
!    END
    
    Tuple.V1 = Graphics
    Tuple.V2 = ImagePtr
    Return Tuple

c25_GdiPlusClass.CalcRectI_WH       Procedure(*RectI_TYPE _rectI)

    CODE
        
        _rectI.Width = _rectI.Right - _rectI.Left
        _rectI.Height = _rectI.Bottom - _rectI.Top
        Return _rectI

c25_GdiPlusClass.CalcRectF_WH       Procedure(*RectF_TYPE _rectF)

    CODE
        
        _rectF.Width = _rectF.Right - _rectF.Left
        _rectF.Height = _rectF.Bottom - _rectF.Top
        Return _rectF
        
c25_GdiPlusClass.NewPath     Procedure(<*long _path>)

PathHandle                    Long

CODE
    
    If omitted(_path) = FALSE And _path <> 0
        C25_GdipResetPath(_path)
    End
    c25_GdipCreatePath(0, Address(PathHandle))
    If omitted(_path) = FALSE 
        _path = PathHandle
    End
    Return PathHandle

c25_GdiPlusClass.NewPen              Procedure(<*long _pen>, <sreal _thickness>, <long _color>, <byte _A>, <byte _R>, <byte _G>, <byte _B>)

Thickness                                   SREAL
ColorInt                                    Long
PenHandle                                   Long

CODE
    
    If omitted(_pen) = FALSE
        PenHandle = _pen
    End
    If PenHandle <> 0
        c25_GdipDeletePen(PenHandle)
        PenHandle = 0
    End
    If omitted(_thickness) = FALSE
        Thickness = _thickness
    ELSE
        Thickness = 1
    End
    If _color <> 0
        ColorInt = _color
    Else
        ColorInt = Self.GetColorMacro(_A, _R, _G, _B)
    End
    c25_GdipCreatePen1(ColorInt, Thickness, 0,  Address(PenHandle))
    If omitted(_pen) = FALSE
        _pen = PenHandle
    End    
    Return PenHandle
    
c25_GdiPlusClass.NewSolidBrush          Procedure(<*long _brush>, <long _color>, <byte _A>, <byte _R>, <byte _G>, <byte _B>)

BrushHandle                             Long
ColorInt                                Long
ColorIntOut                             Long

CODE

    If omitted(_brush) = False
        BrushHandle = _brush
    End
    If _color <> 0
        ColorInt = _color
    Else
        ColorInt = Self.GetColorMacro(_A, _R, _G, _B)
    End
    If BrushHandle <> 0
        c25_GdipGetSolidFillColor(BrushHandle, Address(ColorIntOut))
        If ColorIntOut <> ColorInt
            c25_GdipSetSolidFillColor(BrushHandle, ColorInt)
        End
    Else
        c25_GdipCreateSolidFill(ColorInt, Address(BrushHandle))    
    End
    If omitted(_brush) = False
        _brush = BrushHandle
    End    
    Return BrushHandle

    
c25_GdiPlusClass.SetRenderType                              Procedure(long _graphics, long _gdiplusRenderType)

!The InterpolationMode enumeration specifies the algorithm that is used when images are scaled or rotated.
!This enumeration is used by the GdipGetInterpolationMode and GdipSetInterpolationMode functions of the Graphics functions.
!InterpolationMode                                                           Itemize,pre(InterpolationMode)
!Invalid                                                                         EQUATE(-1)
!Default                                                                         EQUATE(0)
!LowQuality                                                                      EQUATE(1)
!HighQuality                                                                     EQUATE(2)
!Bilinear                                                                        EQUATE(3)
!Bicubic                                                                         EQUATE(4)
!NearestNeighbor                                                                 EQUATE(5)
!HighQualityBilinear                                                             EQUATE(6)
!HighQualityBicubic                                                              EQUATE(7)
!                                                                            End
!GdiplusRenderType                                                           Itemize,pre(GdiplusRenderType)
!LineArt                                                                         EQUATE
!Text                                                                            EQUATE
!Image                                                                           EQUATE
!Nothing                                                                         EQUATE
!                                                                            END
!QualityMode                                                                 Itemize,pre(QualityMode)
!Invalid                                                                         EQUATE(-1)
!Default                                                                         EQUATE(0)
!Low                                                                             EQUATE(1)
!High                                                                            EQUATE(2)
!                                                                            End
!SmoothingMode                                                               Itemize,pre(SmoothingMode)
!Invalid                                                                         EQUATE(-1)
!Default                                                                         EQUATE(0)
!HighSpeed                                                                       EQUATE
!HighQuality                                                                     EQUATE
!None                                                                            EQUATE(3)
!AntiAlias                                                                       EQUATE(4)
!                                                                            End
!The PixelOffsetMode enumeration specifies the pixel offset mode. This enumeration is used by the GdipGetPixelOffsetMode and GdipSetPixelOffsetMode methods of the Graphics class.
!PixelOffsetMode                                                             Itemize,pre(PixelOffsetMode)
!Invalid                                                                         EQUATE(-1)
!PDefault                                                                        EQUATE(0)
!HighSpeed                                                                       EQUATE
!HighQuality                                                                     EQUATE
!None                                                                            EQUATE(3)
!Half                                                                            EQUATE(4)
!                                                                            End
!CompositingMode                                                             Itemize,pre(CompositingMode)
!SourceOver                                                                      EQUATE(0)
!SourceCopy                                                                      EQUATE(1)
!                                                                            End
!The CompositingQuality enumeration specifies whether gamma correction is applied when colors are blended with background colors. This enumeration is used by the GdipGetCompositingQuality and GdipSetCompositingQuality functions.
!CompositingQuality                                                          Itemize,pre(CompositingQuality)
!Invalid                                                                         EQUATE(-1)
!Default                                                                         EQUATE(0)
!HighSpeed                                                                       EQUATE
!HighQuality                                                                     EQUATE
!GammaCorrected                                                                  EQUATE(3)
!AssumeLinear                                                                    EQUATE(4)
!                                                                            End

CODE
        
!    Case _gdiplusRenderType
!    Of GdiplusRenderType:LineArt
!        c25_GdipSetTextRenderingHint(_graphics              , TextRenderingHintClearTypeGridFit)
!        c25_GdipSetSmoothingMode(_graphics                  , SmoothingMode:None)
!        c25_GdipSetCompositingQuality(_graphics             , CompositingQuality:AssumeLinear)
!        c25_GdipSetInterpolationMode(_graphics              , InterpolationMode:Bilinear )
!        c25_GdipSetPixelOffsetMode(_graphics                , PixelOffsetMode:None )    
!    Of GdiplusRenderType:Text
!        c25_GdipSetTextRenderingHint(_graphics              , TextRenderingHintClearTypeGridFit)
!        c25_GdipSetSmoothingMode(_graphics                  , SmoothingMode:None)
!        c25_GdipSetCompositingQuality(_graphics             , CompositingQuality:HighQuality)
!        c25_GdipSetInterpolationMode(_graphics              , InterpolationMode:HighQualityBicubic )
!        c25_GdipSetPixelOffsetMode(_graphics                , PixelOffsetMode:HighQuality )
!    Of GdiplusRenderType:Image
!        c25_GdipSetTextRenderingHint(_graphics              , TextRenderingHintClearTypeGridFit)
!        c25_GdipSetSmoothingMode(_graphics                  , SmoothingMode:AntiAlias)
!        c25_GdipSetCompositingQuality(_graphics             , CompositingQuality:HighQuality)
!        c25_GdipSetInterpolationMode(_graphics              , InterpolationMode:HighQualityBicubic )
!        c25_GdipSetPixelOffsetMode(_graphics                , PixelOffsetMode:HighQuality )        
!    Else
!        Message('error sset render type')
!    End
    Return 0
        
!c25_GdiPlusClass.GetSolidBrush                             Procedure(<Long _color>, <Byte _A>, <Byte _R>, <Byte _G>, <Byte _B>)
!
!    Code
!
!    Clear(Self.GdiPlusSolidBrushQ)
!    If OMITTED(_color) = False
!        Self.GdiPlusSolidBrushQ.Color = _color
!    Else
!        Self.GetSolidBrushColorARGB.A = _A
!        Self.GetSolidBrushColorARGB.B = _B
!        Self.GetSolidBrushColorARGB.G = _G
!        Self.GetSolidBrushColorARGB.R = _R
!        Self.GdiPlusSolidBrushQ.Color = Self.GetSolidBrushColor
!    End
!
!    Get(Self.GdiPlusSolidBrushQ,+Self.GdiPlusSolidBrushQ.Color)
!    If Errorcode() = 0
!        Self.GdiPlusSolidBrushQ.ReferenceCount = Self.GdiPlusSolidBrushQ.ReferenceCount + 1
!        Put(Self.GdiPlusSolidBrushQ)
!        Return Self.GdiPlusSolidBrushQ.Handle
!    ELSE
!        c25_GdipCreateSolidFill(Self.GdiPlusSolidBrushQ.Color,Address(Self.GdiPlusSolidBrushQ.Handle))
!        Self.GdiPlusSolidBrushQ.ReferenceCount = 1
!        Add(Self.GdiPlusSolidBrushQ)
!        Return Self.GdiPlusSolidBrushQ.Handle
!    End
!    Return 0
!        
            

c25_GdiPlusClass.AddPathArc                                Procedure(Long GpPath,SREAL x,SREAL y,SREAL width,SREAL height,SREAL startAngle,SREAL sweepAngle)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathArcI                                         Procedure(Long _gpPath, Long _x, Long _y, Long _width, Long _height, sreal _startAngle, sreal _sweepangle)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathBezier                                       Procedure(Long _Path, sreal x1, sreal y1, sreal x2, sreal y2, sreal x3, sreal y3, sreal x4, sreal y4)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathBezierI                                      Procedure(Long _Path, Long x1, Long y1, Long x2, Long y2, Long x3, Long y3, Long x4, Long y4)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathBeziers                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathBeziersI                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathClosedCurve                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathClosedCurve2                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathClosedCurve2I                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathClosedCurveI                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathCurve                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathCurve2                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathCurve2I                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathCurve3                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathCurve3I                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathCurveI                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathEllipse                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathEllipseI                           Procedure(Long _param01, Long _param02, Long _param03, Long _param04, Long _param05)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathLine                               Procedure(Long path, sreal x1, sreal y1, sreal x2, sreal y2)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathLine2                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathLine2I                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathLineI                              Procedure(Long path, Long x1, Long y1, Long x2, Long y2)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathPath                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathPie                                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathPieI                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathPolygon                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathPolygonI                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathRectangle                          Procedure(Long _param01, SREAL _param02,SREAL _param03,SREAL _param04,SREAL _param05)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathRectangleI                         Procedure(Long _path, Long _x, Long _y, Long _w, Long _h)

ReturnVal Long

    Code
        
        ReturnVal = c25_gdipAddPathRectangleI(_path, _x, _y, _w, _h)
        
        Return ReturnVal

c25_GdiPlusClass.AddPathRectangles                         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathRectanglesI                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathString                             Procedure(Long _path, Long _wchar, Long _length, Long _fontFamily, Long _style, SREAL _emSize, Long _layoutRect, Long _STRINGFormat)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.AddPathStringI                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.Alloc                                     Procedure(Long _param01)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.BeginContainer                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.BeginContainer2                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.BeginContainerI                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.BitmapApplyEffect                         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.BitmapConvertFormat                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.BitmapCreateApplyEffect                   Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.BitmapGetHistogram                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.BitmapGetHistogramSize                    Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.BitmapGetPixel                            Procedure(Long _param01, Long _param02, Long _param03, Long _param04)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.BitmapLockBits                            Procedure(Long gpBitmap, Long gpRect, Long flags, Long pixelformat, Long bitmapdata)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.BitmapSetPixel                            Procedure(Long _param01, Long _param02, Long _param03, Long _param04)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.BitmapSetResolution                       Procedure(Long _param01, Long _param02, Long _param03)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.BitmapUnlockBits                          Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ClearPathMarkers                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CloneBitmapArea                           Procedure(Real _param01,Real _param02, Real _param03, Real _param04, Long _param05, Long _param06, Long _param07)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CloneBitmapAreaI                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CloneBrush                                Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CloneCustomLineCap                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CloneFont                                 Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CloneFontFamily                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CloneImage                                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CloneImageAttributes                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CloneMatrix                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ClonePath                                 Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ClonePen                                  Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CloneRegion                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CloneStringFormat                         Procedure(Long pFormat , Long newFormat)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ClosePathFigure                           Procedure(Long path)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ClosePathFigures                          Procedure(Long path)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CombineRegionPath                         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CombineRegionRect                         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CombineRegionRectI                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CombineRegionRegion                       Procedure(Long region1, Long region2, Long combineMode )

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.Comment                                   Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ConvertToEmfPlus                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ConvertToEmfPlusToFile                    Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ConvertToEmfPlusToStream                  Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateAdjustableArrowCap                  Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateBitmapFromDirectDrawSurface         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateBitmapFromFile                      Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateBitmapFromFileICM                   Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateBitmapFromGdiDib                    Procedure(Long GdiBitmapInfo, Long gdiBitmapData, Long pbitmap)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateBitmapFromGraphics                  Procedure(Long _width, Long _height, Long _graphic , Long _bitmapPtr)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateBitmapFromHBITMAP                   Procedure(Long hbm, Long hpal, Long pbitmap)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateBitmapFromHICON                     Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateBitmapFromResource                  Procedure(Long _param01, Long _param02, Long _param03)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateBitmapFromScan0                     Procedure(Long _width, Long _height, Long _stride, Long _pixelFormat, Long _scan0, Long _gpBitmap)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateBitmapFromStream                    Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateBitmapFromStreamICM                 Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateCachedBitmap                        Procedure(Long GpBitmap, Long GpGraphics, Long GpCachedBitmap)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateCustomLineCap                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateEffect                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateFont                                Procedure(Long _param01,SREAL _param02, Long _param03, Long _param04, Long _param05)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0


c25_GdiPlusClass.CreateFontFamilyFromName                  Procedure(Long _name, Long _fontCollection, Long _fontFamily)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateFontFromDC                          Procedure(Long hDC, long pFont)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateFontFromLogfontA                    Procedure(Long _param01, Long _param02, Long _param03)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateFontFromLogfontW                    Procedure(Long _param01, Long _param02, Long _param03)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateFromHDC                             Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateFromHDC2                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateFromHWND                            Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateFromHWNDICM                         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateHBITMAPFromBitmap                   Procedure(Long _param01, Long _param02, Long _param03)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateHICONFromBitmap                     Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateHalftonePalette                     Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateHatchBrush                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateImageAttributes                     Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateLineBrush                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateLineBrushFromRect                   Procedure(Long _param01, Long _param02, Long _param03, Long _param04, Long _param05, Long _param06)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateLineBrushFromRectI                  Procedure(Long _param01, Long _param02, Long _param03, Long _param04, Long _param05, Long _param06)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateLineBrushFromRectWithAngle          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateLineBrushFromRectWithAngleI         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateLineBrushI                          Procedure(Long _param01, Long _param02, Long _param03, Long _param04, Long _param05, Long _param06)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateMatrix                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateMatrix2                             Procedure(SREAL m11, SREAL m12, SREAL m21, SREAL m22, SREAL dx, SREAL dy, Long matrix)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateMatrix3                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateMatrix3I                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateMetafileFromEmf                     Procedure(Long _param01, Byte _param02, Long _param04)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateMetafileFromFile                    Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateMetafileFromStream                  Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateMetafileFromWmf                     Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateMetafileFromWmfFile                 Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

        
c25_GdiPlusClass.PaintBorderI                               Procedure(long _graphic, long _x, long _y, long _w, long _h, long _color, sreal _borderW)
        
PathHandle                                                      long
PenHandle                                                       long
BrushHandle                                                     Long

CODE
        
    PathHandle = Self.CreatePath()
    PenHandle = Self.CreatePen1()
    
    
    Self.AddPathRectangleI(PathHandle, _x, _y, _w, _h) 
    Self.DrawPath(_graphic, PenHandle, PathHandle)
    !GdipDrawRectangleI 
    
    
!    BrushHandle = Self.GetSolidBrush(_color)
!    Self.FillPath(_graphic, BrushHandle, PathHandle)
    
    C25_Gdipdeletepen(PenHandle)
    C25_GdipdeletePath(PathHandle)
    
    !
    
    Return 0


c25_GdiPlusClass.CreatePath                                Procedure(<Long _brushMode>, <*Long _outPath>)

PathHandle  long,AUTO

    Code

        If omitted(_outPath) = FALSE
            If _outPath <> 0
                C25_GdipResetPath(_outPath)
            END
        End
        
        If omitted(_brushMode) = True
            c25_GdipCreatePath(0, Address(PathHandle))
        Else
            c25_GdipCreatePath(_brushMode, Address(PathHandle))
        End
        If omitted(_outPath) = FALSE
            _outPath = PathHandle
        End
        Return PathHandle

c25_GdiPlusClass.CreatePath2                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreatePath2I                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreatePathGradient                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreatePathGradientFromPath                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreatePathGradientI                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreatePathIter                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreatePen1                                Procedure(<Long _penColor>, <sreal _penWidth>, <Long _unit>, <*Long _outPenHandle>)

PenWidth    sreal
PenColor    Long
Unit        Long
PenHandle   long

    Code
        
        If omitted(_penWidth) = False
            PenWidth = _penWidth
        Else
            PenWidth = 1
        End
        
        If omitted(_unit) = False
            Unit = _unit
        Else
            Unit = 0
        End        
        If omitted(_penColor) = False
            PenColor = _penColor
        Else
            PenColor = Self.GetColorMacro(255, 255, 255, 255)
        End
        
        c25_GdipCreatePen1(PenColor, PenWidth, Unit,  Address(PenHandle))
       
        If omitted(_outPenHandle) = FALSE
            if _outPenHandle <> 0
                C25_Gdipdeletepen(_outPenHandle)
            End
            _outPenHandle = PenHandle
        End

        Return PenHandle

c25_GdiPlusClass.CreatePen2                                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateRegion                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateRegionHrgn                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateRegionPath                          Procedure(Long path, Long region)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateRegionRect                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateRegionRectI                         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateRegionRgnData                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateSolidFill                           Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateStreamOnFile                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateStringFormat                        Procedure(Long StringFormatFlags,Short language, Long pFormat )

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateTexture                             Procedure(Long pImage, Long _wrapMode, Long _texture)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateTexture2                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateTexture2I                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateTextureIA                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.CreateTextureIAI                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DeleteBrush                               Procedure(Long _param01)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DeleteCachedBitmap                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DeleteCustomLineCap                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DeleteEffect                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DeleteFont                                Procedure(Long fonthandle)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DeleteFontFamily                          Procedure(Long fontfamilyhandle)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DeleteGraphics                            Procedure(Long _graphics)

ReturnVal Long

    Code

        If _graphics = 0
            Return 0
        End
        ReturnVal = C25_Gdipdeletegraphics(_graphics)
        Return 0

c25_GdiPlusClass.DeleteMatrix                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DeletePath                                Procedure(Long _param01)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DeletePathIter                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DeletePen                                 Procedure(Long _param01)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DeletePrivateFontCollection               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DeleteRegion                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DeleteStringFormat                        Procedure(Long _param01)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DisposeImage                              Procedure(Long _imagePtr)

ReturnVal Long

    Code

        ReturnVal = c25_GdipDisposeImage(_imagePtr)
        Return 0

c25_GdiPlusClass.DisposeImageAttributes                    Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawArc                                   Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawArcI                                  Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawBezier                                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawBezierI                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawBeziers                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawBeziersI                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawCachedBitmap                          Procedure(Long GpGraphics, Long GpCachedBitmap, Long x, Long y)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawClosedCurve                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawClosedCurve2                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawClosedCurve2I                         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawClosedCurveI                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawCurve                                 Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawCurve2                                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawCurve2I                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawCurve3                                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawCurve3I                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawCurveI                                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawDriverString                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawEllipse                               Procedure(Long _param01, Long _param02,SREAL _param03,SREAL _param04,SREAL _param05,SREAL _param06)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawEllipseI                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawImage                                 Procedure(Long _param01, Long _param02,SREAL _param03,SREAL _param04)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawImageFX                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawImageI                                Procedure(Long graphics, Long pImage, Long x, Long y)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawImagePointRect                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawImagePointRectI                       Procedure(Long _Graphics, long _ImagePtr, long _x, long _y, long _srcX, long _srcY, long _srcWidth, long _srcHeight, long _scrUnit)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawImagePoints                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawImagePointsI                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawImagePointsRect                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawImagePointsRectI                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawImageRect                             Procedure(Long _param01, Long _param02,SREAL _param03,SREAL _param04,SREAL _param05,SREAL _param06)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawImageRectI                            Procedure(Long _param01, Long _param02, Long _param03, Long _param04, Long _param05, Long _param06)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawImageRectRect                         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawImageRectRectI                        Procedure(Long GpGraphics, Long GpImage, Long dstx, Long dsty, Long dstwidth, Long dstheight, Long srcx, Long srcy, Long srcwidth, Long srcheight, Long gscrUnit, Long imageAttributes, Long callback, Long callbackData)

ReturnVal Long

    Code

!        ReturnVal = C25_GdipDrawImageRectRectI(GpGraphics, GpImage , dstx,dsty, dstwidth, dstheight, | &
!            srcx,  | &
!            srcy,  | &
!            srcwidth,  | &
!            srcheight,  | &
!            gscrUnit,  | &
!            imageAttributes,  | &
!            callback,  | &
!        callbackData)
        
        !ReturnVal = C25_GdipDrawImageRectRectI(GpGraphics, GpImage , 10, 10, 100, 100, | &
        
        ReturnVal = C25_GdipDrawImageRectRectI(GpGraphics, GpImage , dstx, dsty, dstwidth, dstheight, | & |
            srcx,  | &
            srcy,  | &
            srcwidth,  | &
            srcheight,  | &
            gscrUnit,  | &
            imageAttributes,  | &
            callback,  | &
            callbackData)
        
        
!            10,  | &
!            10,  | &
!            100,  | &
!            100,  | &
!            gscrUnit,  | &
!            imageAttributes,  | &
!            callback,  | &
!        callbackData)    
       
        Return ReturnVal

c25_GdiPlusClass.DrawLine                                  Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawLineI                                 Procedure(Long graphics, Long pen, Long x1, Long y1, Long x2, Long y2)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawLines                                 Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawLinesI                                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawPath                                  Procedure(Long _graphics, Long _penHandle, Long _path)

ReturnVal Long

    Code

        ReturnVal = c25_GdipDrawPath(_graphics, _penHandle, _path)
        Return ReturnVal

c25_GdiPlusClass.DrawPie                                   Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawPieI                                  Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawPolygon                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawPolygonI                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawRectangle                             Procedure(Long graphics, Long _pen,SREAL _x,SREAL _y,SREAL _w,SREAL _h)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawRectangleI                            Procedure(Long graphics, Long _pen, Long _x, Long _y, Long _w, Long _h)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawRectangles                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawRectanglesI                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.DrawString                                Procedure(Long _graphics, Long _pString, Long _length, Long _pFont, Long _layoutRect, Long _stringFormat, Long _brush)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.EmfToWmfBits                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.EndContainer                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.EnumerateMetafileDestPoint                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.EnumerateMetafileDestPointI               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.EnumerateMetafileDestPoints               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.EnumerateMetafileDestPointsI              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.EnumerateMetafileDestRect                 Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.EnumerateMetafileDestRectI                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.EnumerateMetafileSrcRectDestPoint         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.EnumerateMetafileSrcRectDestPointI        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.EnumerateMetafileSrcRectDestPoints        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.EnumerateMetafileSrcRectDestPointsI       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.EnumerateMetafileSrcRectDestRect          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.EnumerateMetafileSrcRectDestRectI         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.FillClosedCurve                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.FillClosedCurve2                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.FillClosedCurve2I                         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.FillClosedCurveI                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.FillEllipse                               Procedure(Long _param01, Long _param02,SREAL _param03,SREAL _param04,SREAL _param05,SREAL _param06)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.FillEllipseI                              Procedure(Long _param01, Long _param02, Long _param03, Long _param04, Long _param05, Long _param06)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.FillPath                                  Procedure(Long _param01, Long _param02, Long _param03)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.FillPie                                   Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.FillPieI                                  Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.FillPolygon                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.FillPolygon2                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.FillPolygon2I                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.FillPolygonI                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.FillRectangle                             Procedure(Long _param01, Long _param02,SREAL _param03,SREAL _param04,SREAL _param05,SREAL _param06)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.FillRectangleI                            Procedure(Long _graphic, Long _brush, Long _x, Long _y, Long _w, Long _h)

ReturnVal Long

    Code

        C25_GdipFillRectangleI(_graphic, _brush, _x, _y, _w, _h)
        Return 0

c25_GdiPlusClass.FillRectangles                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.FillRectanglesI                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.FillRegion                                Procedure(Long graphics, Long _brush, Long _region)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.FindFirstImageItem                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.FindNextImageItem                         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.FlattenPath                               Procedure(Long path, Long matrix, SREAL flatness)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.Flush                                     Procedure()

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.Free                                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetAdjustableArrowCapFillState            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetAdjustableArrowCapHeight               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetAdjustableArrowCapMiddleInset          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetAdjustableArrowCapWidth                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetAllPropertyItems                       Procedure(Long _pImage, Long totalBufferSize, Long numProperties, Long allItems)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetBrushType                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetCellAscent                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetCellDescent                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetClip                                   Procedure(Long _graphic, Long _region)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetClipBounds                             Procedure(Long _graphic, Long _rect)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetClipBoundsI                            Procedure(Long _graphic, Long _rect)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetCompositingMode                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetCompositingQuality                     Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetCustomLineCapBaseCap                   Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetCustomLineCapBaseInset                 Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetCustomLineCapStrokeCaps                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetCustomLineCapStrokeJoin                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetCustomLineCapType                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetCustomLineCapWidthScale                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetDC                                     Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetDpiX                                   Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetDpiY                                   Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetEffectParameterSize                    Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetEffectParameters                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetEmHeight                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetEncoderParameterList                   Procedure(Long _pImage, long _clsidEncoder, long _psize, long _buffer)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetEncoderParameterListSize               Procedure(Long _pImage, long _clsidEncoder, long _psize)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetFamily                                 Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetFamilyName                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetFontCollectionFamilyCount              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetFontCollectionFamilyList               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetFontHeight                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetFontHeightGivenDPI                     Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetFontSize                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetFontStyle                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetFontUnit                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetGenericFontFamilyMonospace             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetGenericFontFamilySansSerif             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetGenericFontFamilySerif                 Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetHatchBackgroundColor                   Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetHatchStyle                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetHemfFromMetafile                       Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetImageAttributesAdjustedPalette         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetImageBounds                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetImageDecoders                          Procedure(ULong _numEncoders ,ULong _size, Long _bufferImageCodecInfo)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetImageDecodersSize                      Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetImageDimension                         Procedure(Long _param01, Long _param02, Long _param03)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetImageEncoders                          Procedure(ULong _numEncoders ,ULong _size, Long _bufferImageCodecInfo)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetImageEncodersSize                      Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetImageFlags                             Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetImageGraphicsContext                   Procedure(Long _image, Long _graphics)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetImageHeight                            Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetImageHorizontalResolution              Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetImageItemData                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetImagePalette                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetImagePaletteSize                       Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetImagePixelFormat                       Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetImageRawFormat                         Procedure(Long _pImage, Long _GUID)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetImageThumbnail                         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetImageType                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetImageVerticalResolution                Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetImageWidth                             Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetInterpolationMode                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetLineBlend                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetLineColors                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetLineGammaCorrection                    Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetLinePresetBlend                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetLineSpacing                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetLogFontA                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetLogFontW                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetMatrixElements                         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetMetafileDownLevelRasterizationLimit    Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetMetafileHeaderFromEmf                  Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetMetafileHeaderFromFile                 Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetMetafileHeaderFromMetafile             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetMetafileHeaderFromStream               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetMetafileHeaderFromWmf                  Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetNearestColor                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPageScale                              Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPageUnit                               Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPathData                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPathFillMode                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPathGradientBlend                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPathGradientBlendCount                 Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPathGradientCenterColor                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPathGradientCenterPoint                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPathGradientCenterPointI               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPathGradientFocusScales                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPathGradientGammaCorrection            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPathGradientPointCount                 Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPathGradientPresetBlend                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPathGradientPresetBlendCount           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPathGradientRect                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPathGradientRectI                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPathGradientSurroundColorCount         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPathGradientSurroundColorsWithCount    Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPathGradientWrapMode                   Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPathLastPoint                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPathPoints                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPathPointsI                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPathTypes                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPathWorldBounds                        Procedure(Long _param01, Long _param02, Long _param03, Long _param04)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPathWorldBoundsI                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPenBrushFill                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPenColor                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPenCompoundArray                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPenCompoundCount                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPenCustomEndCap                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPenCustomStartCap                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPenDashArray                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPenDashCap197819                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPenDashCount                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPenDashOffset                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPenDashStyle                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPenEndCap                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPenFillType                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPenLineJoin                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPenMiterLimit                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPenMode                                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPenStartCap                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPenTransform                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPenUnit                                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPenWidth                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPixelOffsetMode                        Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPointCount                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPropertyCount                          Procedure(Long _pImage, Long _count)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPropertyIdList                         Procedure(Long _pImage, Long _numOfProperty, Long _propIdList)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPropertyItem                           Procedure(Long _pImage, Long _PropId, Long _propItemSize, Long _propItemValue)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPropertyItemSize                       Procedure(Long _pImage, Long _propId, Long _propItemSize)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetPropertySize                           Procedure(Long _pImage, Long totalBufferSize, Long numProperties)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetRegionBounds                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetRegionBoundsI                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetRegionData                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetRegionDataSize                         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetRegionHRgn                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetRegionScans                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetRegionScansCount                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetRegionScansI                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetRenderingOrigin                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetSmoothingMode                          Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetSolidFillColor                         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetStringFormatAlign                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetStringFormatDigitSubstitution          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetStringFormatFlags                      Procedure(Long pFormat , Long flagsPtr)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetStringFormatHotkeyPrefix               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetStringFormatLineAlign                  Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetStringFormatMeasurableCharacterRangeCount                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetStringFormatTabStopCount               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetStringFormatTabStops                   Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetStringFormatTrimming                   Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetTextContrast                           Procedure(Long _graphic, Long _contrast)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetTextRenderingHint                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetTextureImage                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetTextureTransform                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetTextureWrapMode                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetVisibleClipBounds                      Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetVisibleClipBoundsI                     Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetWorldTransform                         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GraphicsClear                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GraphicsSetAbort                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ImageForceValidation                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ImageGetFrameCount                        Procedure(Long _image, Long _dimensionId, Long _count)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ImageGetFrameDimensionsCount              Procedure(Long _image, Long _count)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ImageGetFrameDimensionsList               Procedure(Long _image, Long _dimsIds, Long _count)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ImageRotateFlip                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ImageSelectActiveFrame                    Procedure(Long _image, Long _dimensionGuid, ULong _frameIndex)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ImageSetAbort                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.InitializePalette                         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.InvertMatrix                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.IsClipEmpty                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.IsEmptyRegion                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.IsEqualRegion                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.IsInfiniteRegion                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.IsMatrixEqual                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.IsMatrixIdentity                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.IsMatrixInvertible                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.IsOutlineVisiblePathPoint                 Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.IsOutlineVisiblePathPointI                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.IsStyleAvailable                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.IsVisibleClipEmpty                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.IsVisiblePathPoint                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.IsVisiblePathPointI                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.IsVisiblePoint                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.IsVisiblePointI                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.IsVisibleRect                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.IsVisibleRectI                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.IsVisibleRegionPoint                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.IsVisibleRegionPointI                     Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.IsVisibleRegionRect                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.IsVisibleRegionRectI                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.LoadImageFromFile                         Procedure(Long _fileNameW, Long _gpImage)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.LoadImageFromFileICM                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.LoadImageFromStream                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.LoadImageFromStreamICM                    Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.MeasureCharacterRanges                    Procedure(Long _param01, Long _param02, Long _param03, Long _param04, Long _param05, Long _param06, Long _param07)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.MeasureDriverSTRING                       Procedure(Long _param01, Long _param02, Long _param03, Long _param04, Long _param05, Long _param06, Long _param07, Long _param08, Long _param09)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.MeasureString                             Procedure(Long _graphics, Long _pSTRING, Long _length, Long _pFont, Long _layoutRect, Long _STRINGFormat, Long _boundingBox, Long _codepointsFitted, Long _linesFilled)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.MultiplyMatrix                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.MultiplyPenTransform                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.MultiplyTextureTransform                  Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.MultiplyWorldTransform                    Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.NewInstalledFontCollection                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.NewPrivateFontCollection                  Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.PathIterCopyData                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.PathIterEnumerate                         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.PathIterGetCount                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.PathIterGetSubpathCount                   Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.PathIterHasCurve                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.PathIterIsValid                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.PathIterNextMarker                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.PathIterNextMarkerPath                    Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.PathIterNextPathType                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.PathIterNextSubpath                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.PathIterNextSubpathPath                   Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.PathIterRewind                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.PlayMetafileRecord                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.PlayTSClientRecord                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.PrivateAddFontFile                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.PrivateAddMemoryFont                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.RecordMetafile                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.RecordMetafileFileName                    Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.RecordMetafileFileNameI                   Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.RecordMetafileI                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.RecordMetafileStream                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.RecordMetafileStreamI                     Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ReleaseDC                                 Procedure(Long HWND, Long DC)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.RemovePropertyItem                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ResetClip                                 Procedure(Long _param01)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ResetImageAttributes                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ResetPageTransform                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ResetPath                                 Procedure(Long _param01)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ResetPenTransform                         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ResetTextureTransform                     Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ResetWorldTransform                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.RestoreGraphics                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ReversePath                               Procedure(Long path)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.RotateMatrix                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.RotatePenTransform                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.RotateTextureTransform                    Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.RotateWorldTransform                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SaveAdd                                   Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SaveAddImage                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SaveGraphics                              Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SaveImageToFile                           Procedure(Long _pImage, Long _fileNameUtf16, Long _encoder, Long _encoderParams)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SaveImageToStream                         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ScaleMatrix                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ScalePenTransform                         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ScaleTextureTransform                     Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ScaleWorldTransform                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetAdjustableArrowCapFillState            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetAdjustableArrowCapHeight               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetAdjustableArrowCapMiddleInset          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetAdjustableArrowCapWidth                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetClipGraphics                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetClipHrgn                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetClipPath                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetClipRect                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetClipRectI                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetClipRegion                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetCompositingMode                        Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetCompositingQuality                     Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetCustomLineCapBaseCap                   Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetCustomLineCapBaseInset                 Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetCustomLineCapStrokeCaps                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetCustomLineCapStrokeJoin                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetCustomLineCapWidthScale                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0
        
c25_GdiPlusClass.SetEffectParameters                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetEmpty                                  Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetImageAttributesCachedBackground        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetImageAttributesColorKeys               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetImageAttributesColorMatrix             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetImageAttributesGamma                   Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetImageAttributesNoOp                    Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetImageAttributesOutputChannel           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetImageAttributesOutputChannelColorProfile                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetImageAttributesRemapTable              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetImageAttributesThreshold               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetImageAttributesToIdentity              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetImageAttributesWrapMode                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetImagePalette                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetInfinite                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetInterpolationMode                      Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetLineBlend                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetLineColors                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetLineGammaCorrection                    Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetLinePresetBlend                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetLineSigmaBlend                         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetLineWrapMode                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetMatrixElements                         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetMetafileDownLevelRasterizationLimit    Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPageScale                              Procedure(Long _param01,SREAL _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPageUnit                               Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPathFillMode                           Procedure(Long path, Long _mode)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPathGradientBlend                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPathGradientCenterColor                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPathGradientCenterPoint                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPathGradientCenterPointI               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPathGradientFocusScales                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPathGradientGammaCorrection            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPathGradientLinearBlend                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPathGradientPath                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPathGradientPresetBlend                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPathGradientSigmaBlend                 Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPathGradientSurroundColorsWithCount    Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPathGradientWrapMode                   Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPathMarker                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPenBrushFill                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPenColor                               Procedure(Long pen, Long _color)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPenCompoundArray                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPenCustomEndCap                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPenCustomStartCap                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPenDashArray                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPenDashCap197819                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPenDashOffset                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPenDashStyle                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPenEndCap                              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPenLineCap197819                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPenLineJoin                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPenMiterLimit                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPenMode                                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPenStartCap                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPenTransform                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPenUnit                                Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPenWidth                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPixelOffsetMode                        Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetPropertyItem                           Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetRenderingOrigin                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetSmoothingMode                          Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetSolidFillColor                         Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetStringFormatAlign                      Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetStringFormatDigitSubstitution          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetStringFormatFlags                      Procedure(Long pFormat, Long _flags)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetStringFormatHotkeyPrefix               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetStringFormatLineAlign                  Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetStringFormatMeasurableCharacterRanges  Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetStringFormatTabStops                   Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetStringFormatTrimming                   Procedure(Long pFormat, Long _trimming)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetTextContrast                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetTextRenderingHint                      Procedure(Long _param01, Long _param02)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetTextureTransform                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetTextureWrapMode                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.SetWorldTransform                         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.ShearMatrix                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.StartPathFigure                           Procedure(Long path)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.StringFormatGetGenericDefault             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.StringFormatGetGenericTypographic         Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.TestControl                               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.TransformMatrixPoints                     Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.TransformMatrixPointsI                    Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.TransformPath                             Procedure(Long path, Long matrix)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.TransformPoints                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.TransformPointsI                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.TransformRegion                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.TranslateClip                             Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.TranslateClipI                            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.TranslateMatrix                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.TranslatePathGradientTransform            Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.TranslatePenTransform                     Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.TranslateRegion                           Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.TranslateRegionI                          Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.TranslateTextureTransform                 Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.TranslateWorldTransform                   Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.VectorTransformMatrixPoints               Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.VectorTransformMatrixPointsI              Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.WarpPath                                  Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.WidenPath                                 Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.WindingModeOutline                        Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GdiplusNotificationHook                       Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GdiplusNotificationUnhook                     Procedure(Long _NOTIMPLEMENTED)

ReturnVal Long

    Code

        ReturnVal = Self.NotYetImplemented()
        Return 0

c25_GdiPlusClass.GetImgEncoderCodecInfo                     Procedure()

ImageCodecInfoStruct                                    Group,Pre(ImageCodecInfoStruct)
ClassID                                                     String(16)
FormatID                                                    String(16)
CodecNamePtr                                                Long
DllNamePtr                                                  Long
FormatDescriptionPtr                                        Long
FilenameExtensionPtr                                        Long
MimeTypePtr                                                 Long
Flags                                                       Long
Version                                                     Long
SigCount                                                    Long
SigSize                                                     Long
SigPatternPtr                                               Long
SigMaskPtr                                                  Long
                                                        End
    Code


        If not Self.ImgEncoderCodecInfoQ &= NULL
            Dispose(Self.ImgEncoderCodecInfoQ)
        End
        Self.ImgEncoderCodecInfoQ &= NEW ImageCodecInfo_TYPE()

        c25_GdipGetImageEncodersSize(Address(Self.NumEncoders) , Address(Self.BufferGetEncodersSize) )
        If Self.BufferGetEncodersSize < 0
            Return -1
        End
        
        
        Self.BufferGetEncoders &= NEW String(Self.BufferGetEncodersSize+64000)
        c25_GdipGetImageEncoders(Self.NumEncoders, Self.BufferGetEncodersSize, Address(Self.BufferGetEncoders))
        P# = 1
        LOOP Self.NumEncoders Times
            Clear(ImageCodecInfoStruct)
            ImageCodecInfoStruct = Self.BufferGetEncoders[P# : P# + Size(ImageCodecInfoStruct) - 1]
            P# = P# + Size(ImageCodecInfoStruct)
            Clear(Self.ImgEncoderCodecInfoQ)
            Self.ImgEncoderCodecInfoQ.ClassID16 = ImageCodecInfoStruct.ClassID
            Self.ImgEncoderCodecInfoQ.ClassID36 = Self.BitConverterClass.UuidToString(Self.ImgEncoderCodecInfoQ.ClassID16)
            Case Lower(Self.ImgEncoderCodecInfoQ.ClassID36)
            Of Self.BmpEncoderGuid36
                Self.ImgEncoderCodecInfoQ.NameAnsi &= Self.BitConverterClass.AnsiToAnsi('BMP')
            Of Self.JpgEncoderGuid36
                Self.ImgEncoderCodecInfoQ.NameAnsi &= Self.BitConverterClass.AnsiToAnsi('JPG')
            Of Self.GifEncoderGuid36
                Self.ImgEncoderCodecInfoQ.NameAnsi &= Self.BitConverterClass.AnsiToAnsi('GIF')
            Of Self.TiffEncoderGuid36
                Self.ImgEncoderCodecInfoQ.NameAnsi &= Self.BitConverterClass.AnsiToAnsi('TIFF')
            Of Self.PngEncoderGuid36
                Self.ImgEncoderCodecInfoQ.NameAnsi &= Self.BitConverterClass.AnsiToAnsi('PNG')
            ELSE
                Self.ImgEncoderCodecInfoQ.NameAnsi &= Self.BitConverterClass.AnsiToAnsi('OTHER')
            End
            If ImageCodecInfoStruct.CodecNamePtr <> 0
                Self.ImgEncoderCodecInfoQ.CodecNameAnsi &= Self.BitConverterClass.Utf16ToAnsi(Self.BitConverterClass.ParseZeroTerminatedUtf16String(ImageCodecInfoStruct.CodecNamePtr,0, True) )
            End
            If ImageCodecInfoStruct.DllNamePtr <> 0
                Self.ImgEncoderCodecInfoQ.DllNameAnsi &= Self.BitConverterClass.Utf16ToAnsi(Self.BitConverterClass.ParseZeroTerminatedUtf16String(ImageCodecInfoStruct.DllNamePtr,0, True) )
            End
            If ImageCodecInfoStruct.FormatDescriptionPtr <> 0
                Self.ImgEncoderCodecInfoQ.FormatDescriptionAnsi &= Self.BitConverterClass.Utf16ToAnsi(Self.BitConverterClass.ParseZeroTerminatedUtf16String(ImageCodecInfoStruct.FormatDescriptionPtr,0, True) )
            End
            If ImageCodecInfoStruct.FilenameExtensionPtr <> 0
                Self.ImgEncoderCodecInfoQ.FilenameExtensionAnsi &= Self.BitConverterClass.Utf16ToAnsi(Self.BitConverterClass.ParseZeroTerminatedUtf16String(ImageCodecInfoStruct.FilenameExtensionPtr,0, True) )
            End
            If ImageCodecInfoStruct.MimeTypePtr <> 0
                Self.ImgEncoderCodecInfoQ.MimeTypeAnsi &= Self.BitConverterClass.Utf16ToAnsi(Self.BitConverterClass.ParseZeroTerminatedUtf16String(ImageCodecInfoStruct.MimeTypePtr,0, True) )
            End
            Self.ImgEncoderCodecInfoQ.Flags = ImageCodecInfoStruct.Flags
            If BAND(Self.ImgEncoderCodecInfoQ.Flags,ImageCodecFlagsEncoder)
                Self.ImgEncoderCodecInfoQ.IsEncoder = TRUE
            End
            If BAND(Self.ImgEncoderCodecInfoQ.Flags,ImageCodecFlagsDecoder)
                Self.ImgEncoderCodecInfoQ.IsDecoder = TRUE
            End
            If BAND(Self.ImgEncoderCodecInfoQ.Flags,ImageCodecFlagsSupportBitmap)
                Self.ImgEncoderCodecInfoQ.SupportBitmap = TRUE
            End
            If BAND(Self.ImgEncoderCodecInfoQ.Flags,ImageCodecFlagsSupportVector)
                Self.ImgEncoderCodecInfoQ.SupportVector = TRUE
            End
            If BAND(Self.ImgEncoderCodecInfoQ.Flags,ImageCodecFlagsSeekableEncode)
                Self.ImgEncoderCodecInfoQ.SeekableEncode = TRUE
            End
            If BAND(Self.ImgEncoderCodecInfoQ.Flags,ImageCodecFlagsBlockingDecode)
                Self.ImgEncoderCodecInfoQ.BlockingDecode = TRUE
            End
            If BAND(Self.ImgEncoderCodecInfoQ.Flags,ImageCodecFlagsBuiltin)
                Self.ImgEncoderCodecInfoQ.BuiltinGdip = TRUE
            End
            If BAND(Self.ImgEncoderCodecInfoQ.Flags,ImageCodecFlagsSystem)
                Self.ImgEncoderCodecInfoQ.System = TRUE
            End
            If BAND(Self.ImgEncoderCodecInfoQ.Flags,ImageCodecFlagsUser)
                Self.ImgEncoderCodecInfoQ.User = TRUE
            End
            Self.ImgEncoderCodecInfoQ.Version = ImageCodecInfoStruct.Version
            Self.ImgEncoderCodecInfoQ.SigCount = ImageCodecInfoStruct.SigCount
            Self.ImgEncoderCodecInfoQ.SigSize = ImageCodecInfoStruct.SigSize
            Self.ImgEncoderCodecInfoQ.SigPatternPtr = ImageCodecInfoStruct.SigPatternPtr
            Self.ImgEncoderCodecInfoQ.SigMaskPtr = ImageCodecInfoStruct.SigMaskPtr
            Add(Self.ImgEncoderCodecInfoQ)
        End
        Return 0

c25_GdiPlusClass.GetImgDecoderCodecInfo     Procedure()

ImageCodecInfoStruct                                    Group,Pre(ImageCodecInfoStruct)
ClassID                                                     String(16)
FormatID                                                    String(16)
CodecNamePtr                                                Long
DllNamePtr                                                  Long
FormatDescriptionPtr                                        Long
FilenameExtensionPtr                                        Long
MimeTypePtr                                                 Long
Flags                                                       Long
Version                                                     Long
SigCount                                                    Long
SigSize                                                     Long
SigPatternPtr                                               Long
SigMaskPtr                                                  Long
                                                        End

                                                        Code
        Dispose(Self.ImgDecoderCodecInfoQ)
        Self.ImgDecoderCodecInfoQ &= NEW ImageCodecInfo_TYPE()
        c25_GdipGetImageDecodersSize(Address(Self.NumDecoders) , Address(Self.BufferGetDecodersSize) )
        If Self.BufferGetDecodersSize < 0
            Return -1
        End
        Self.BufferGetDecoders &= NEW String(Self.BufferGetDecodersSize+64000)
        c25_GdipGetImageDecoders(Self.NumDecoders, Self.BufferGetDecodersSize, Address(Self.BufferGetDecoders))
        P# = 1
        LOOP Self.NumDecoders Times
            Clear(ImageCodecInfoStruct)
            ImageCodecInfoStruct = Self.BufferGetDecoders[P# : P# + Size(ImageCodecInfoStruct) - 1]
            P# = P# + Size(ImageCodecInfoStruct)
            If Self.ImgDecoderCodecInfoQ &= NULL
                Message('Self.ImgDecoderCodecInfoQ is null')
            End
            Clear(Self.ImgDecoderCodecInfoQ)
            Self.ImgDecoderCodecInfoQ.ClassID16 = ImageCodecInfoStruct.ClassID
            Self.ImgDecoderCodecInfoQ.ClassID36 = Self.BitConverterClass.UuidToString(Self.ImgDecoderCodecInfoQ.ClassID16)
            Case Lower(Self.ImgDecoderCodecInfoQ.ClassID36)
            Of Self.BmpEncoderGuid36
                Self.ImgDecoderCodecInfoQ.NameAnsi &= Self.BitConverterClass.AnsiToAnsi('BMP')
            Of Self.JpgEncoderGuid36
                Self.ImgDecoderCodecInfoQ.NameAnsi &= Self.BitConverterClass.AnsiToAnsi('JPG')
            Of Self.GifEncoderGuid36
                Self.ImgDecoderCodecInfoQ.NameAnsi &= Self.BitConverterClass.AnsiToAnsi('GIF')
            Of Self.TiffEncoderGuid36
                Self.ImgDecoderCodecInfoQ.NameAnsi &= Self.BitConverterClass.AnsiToAnsi('TIFF')
            Of Self.PngEncoderGuid36
                Self.ImgDecoderCodecInfoQ.NameAnsi &= Self.BitConverterClass.AnsiToAnsi('PNG')
            ELSE
                Self.ImgDecoderCodecInfoQ.NameAnsi &= Self.BitConverterClass.AnsiToAnsi('OTHER')
            End
            If ImageCodecInfoStruct.CodecNamePtr <> 0
                Self.ImgDecoderCodecInfoQ.CodecNameAnsi &= Self.BitConverterClass.Utf16ToAnsi(Self.BitConverterClass.ParseZeroTerminatedUtf16String(ImageCodecInfoStruct.CodecNamePtr,0, True) )
            End
            If ImageCodecInfoStruct.DllNamePtr <> 0
                Self.ImgDecoderCodecInfoQ.DllNameAnsi &= Self.BitConverterClass.Utf16ToAnsi(Self.BitConverterClass.ParseZeroTerminatedUtf16String(ImageCodecInfoStruct.DllNamePtr,0, True) )
            End
            If ImageCodecInfoStruct.FormatDescriptionPtr <> 0
                Self.ImgDecoderCodecInfoQ.FormatDescriptionAnsi &= Self.BitConverterClass.Utf16ToAnsi(Self.BitConverterClass.ParseZeroTerminatedUtf16String(ImageCodecInfoStruct.FormatDescriptionPtr,0, True) )
            End
            If ImageCodecInfoStruct.FilenameExtensionPtr <> 0
                Self.ImgDecoderCodecInfoQ.FilenameExtensionAnsi &= Self.BitConverterClass.Utf16ToAnsi(Self.BitConverterClass.ParseZeroTerminatedUtf16String(ImageCodecInfoStruct.FilenameExtensionPtr,0, True) )
            End
            If ImageCodecInfoStruct.MimeTypePtr <> 0
                Self.ImgDecoderCodecInfoQ.MimeTypeAnsi &= Self.BitConverterClass.Utf16ToAnsi(Self.BitConverterClass.ParseZeroTerminatedUtf16String(ImageCodecInfoStruct.MimeTypePtr,0, True) )
            End
            Self.ImgDecoderCodecInfoQ.Flags = ImageCodecInfoStruct.Flags
            If BAND(Self.ImgDecoderCodecInfoQ.Flags,ImageCodecFlagsDecoder)
                Self.ImgDecoderCodecInfoQ.IsDecoder         = TRUE
            End
            If BAND(Self.ImgDecoderCodecInfoQ.Flags,ImageCodecFlagsDecoder)
                Self.ImgDecoderCodecInfoQ.IsDecoder         = TRUE
            End
            If BAND(Self.ImgDecoderCodecInfoQ.Flags,ImageCodecFlagsSupportBitmap)
                Self.ImgDecoderCodecInfoQ.SupportBitmap     = TRUE
            End
            If BAND(Self.ImgDecoderCodecInfoQ.Flags,ImageCodecFlagsSupportVector)
                Self.ImgDecoderCodecInfoQ.SupportVector     = TRUE
            End
            If BAND(Self.ImgDecoderCodecInfoQ.Flags,ImageCodecFlagsSeekableEncode)
                Self.ImgDecoderCodecInfoQ.SeekableEncode    = TRUE
            End
            If BAND(Self.ImgDecoderCodecInfoQ.Flags,ImageCodecFlagsBlockingDecode)
                Self.ImgDecoderCodecInfoQ.BlockingDecode    = TRUE
            End
            If BAND(Self.ImgDecoderCodecInfoQ.Flags,ImageCodecFlagsBuiltin)
                Self.ImgDecoderCodecInfoQ.BuiltinGdip       = TRUE
            End
            If BAND(Self.ImgDecoderCodecInfoQ.Flags,ImageCodecFlagsSystem)
                Self.ImgDecoderCodecInfoQ.System            = TRUE
            End
            If BAND(Self.ImgDecoderCodecInfoQ.Flags,ImageCodecFlagsUser)
                Self.ImgDecoderCodecInfoQ.User              = TRUE
            End
            Self.ImgDecoderCodecInfoQ.Version           = ImageCodecInfoStruct.Version
            Self.ImgDecoderCodecInfoQ.SigCount          = ImageCodecInfoStruct.SigCount
            Self.ImgDecoderCodecInfoQ.SigSize           = ImageCodecInfoStruct.SigSize
            Self.ImgDecoderCodecInfoQ.SigPatternPtr     = ImageCodecInfoStruct.SigPatternPtr
            Self.ImgDecoderCodecInfoQ.SigMaskPtr        = ImageCodecInfoStruct.SigMaskPtr
            Add(Self.ImgDecoderCodecInfoQ)
        End
        Return 0

c25_GdiPlusClass.SaveBmpBuffer2Png                         Procedure(<String _utf8>)

OutFileNameAnsi     &String
OutFileNameUtf16    &String

Code

    Message('c25_GdiPlusClass.SaveBmpBuffer2Png')
    If Self.BufferBitmapObject = 0
        Return 0
    End

    If omitted(_utf8) = False
        OutFileNameAnsi &= Self.BitConverterClass.AnsiToAnsi(Clip(_utf8) & Chr(0) )
    Else
        OutFileNameAnsi &= Self.BitConverterClass.AnsiToAnsi('BmpBuffer' & Clock() & '.png' & Chr(0) )
    End

    OutFileNameUtf16 &= Self.BitConverterClass.AnsiToUtf16(Clip(OutFileNameAnsi) & Chr(0))
    OutFileNameUtf16 = Clip(OutFileNameUtf16) & Chr(0) & Chr(0)

    c25_GdipSaveImageToFile(Self.BufferBitmapObject, Address(OutFileNameUtf16) , Address(Self.PngEncoderGuid16), 0 )

    Dispose(OutFileNameAnsi)
    Dispose(OutFileNameUtf16)

    Return 0

c25_GdiPlusClass.WriteDibBitsToBmp                         Procedure(Long _sourcePtr, Long _length, String _filenameUtf8)

MemBufferPtr    Long
WriteHandle     Long
FullPathAnsi    &String
FullPathUtf8    &String
FullPathUtf16   &String
stLog           &StringTheory

Code

    Message('c25_GdiPlusClass.WriteDibBitsToBmp')

    stLog &= NEW StringTheory()
    stLog.Start()
    If _length < 1 Or _sourcePtr = 0 Or _sourcePtr = -1 or Len(_filenameUtf8) < 1
        Return 0
    End
    FullPathAnsi &= Self.BitConverterClass.AnsiToAnsi(clip(_filenameUtf8) & Chr(0))
    FullPathUtf16 &= Self.BitConverterClass.AnsiToUtf16(Clip(FullPathAnsi) & Chr(0) & Chr(0))
    WriteHandle = c25_CreateFileW(Address(FullPathUtf16),C25_GENERIC_WRITE + C25_GENERIC_READ, C25_FILE_SHARE_WRITE,0,C25_CREATE_NEW,080h,0)
    If WriteHandle <> 0 And WriteHandle <> -1
        stLog.Append('WriteHandle ' & WriteHandle & Chr(13) & Chr(10) )
        MemBufferPtr = c25_HeapAlloc(c25_GetProcessHeap(),8,_length)
        stLog.Append('MemBufferPtr: ' & MemBufferPtr & Chr(13) & Chr(10) )
        c25_MemCpy(MemBufferPtr,_sourcePtr,_length)
        R# = c25_WriteFile(WriteHandle,_sourcePtr,_length,0,0)
        c25_CloseHandle(WriteHandle)
        c25_HeapFree(c25_GetProcessHeap(),0,MemBufferPtr)
    Else
        stLog.Append('error WriteHandle ' & WriteHandle & ', ' & c25_getlasterror() & Chr(13) & Chr(10) )
    End
    Dispose(FullPathAnsi)
    Dispose(FullPathUtf16)
    dispose(stLog)
    Return 0

c25_GdiPlusClass.SaveGraphicToFile                         Procedure(Long _graphicHandle, String _fileNameUtf8, Long _width, Long _height)
BIH                                                     Group(BIHGROUP_TYPE),Pre(BIH)
                                                        End
GpStatus                                                Long
DIBitsPtr                                               Long
DIBits                                                  &String
DibHandle                                               Long
DibHandleOld                                            Long
st                                                      &StringTheory()
FileNameAnsi                                            &String
FileNameUtf16                                           &String
OutFileNameAnsi                                         &String
OutFileNameUtf16                                        &String
EncoderParameter                                        Group,Pre(EncoderParameter)
Guid                                                        String(16)
NumberOfValue                                               ULong
Type                                                        ULong
ValuePtr                                                    Long
                                                        End
EncoderParameters                                       Group,Pre(EncoderParameters)
Count                                                       ULong
EncoderParameter                                        GROUP,DIM(100)
                                                        End
                                                        End
pGraphics                                               Long
pImage                                                  Long
    Code

        Message('c25_GdiPlusClass.SaveGraphicToFile')

                                                            Return 0

c25_GdiPlusClass.InitTheme                                 Procedure(Long _windowHandle, <String _ansiThemeName>)

    Code

        If Self.ThemeHandle <> 0
        End

        Self.ThemeNameUtf16 &= Self.BitConverterClass.AnsiToUtf16('BUTTON;WINDOW;CLOCK;COMBOBOX;COMMUNICATIONS;CONTROLPANEL;DATEPICKER;DRAGDROP;EDIT;EXPLORERBAR;FLYOUT;GLOBALS;HEADER;LISTBOX;LISTVIEW;MENU;MENUBAND;NAVIGATION;PAGE;PROGRESS;REBAR;SCROLLBAR;SEARCHEDITBOX;SPIN;STARTPANEL;STATUS;TAB;TASKBAND;TASKBAR;TASKDIALOG;TEXTSTYLE;TOOLBAR;TOOLTIP;TRACKBAR;TRAYNOTIFY;TREEVIEW;WINDOW;CLOCK;COMBOBOX;COMMUNICATIONS;CONTROLPANEL;DATEPICKER;DRAGDROP;EDIT;EXPLORERBAR;FLYOUT;GLOBALS;HEADER;LISTBOX;LISTVIEW;MENU;MENUBAND;NAVIGATION;PAGE;PROGRESS;REBAR;SCROLLBAR;SEARCHEDITBOX;SPIN;STARTPANEL;STATUS;TAB;TASKBAND;TASKBAR;TASKDIALOG;TEXTSTYLE;TOOLBAR;TOOLTIP;TRACKBAR;TRAYNOTIFY;TREEVIEW;' & Chr(0))

        Self.ThemeNameUtf16Path = Clip(Self.ThemeNameUtf16) & Chr(0) & Chr(0)
        Self.ThemeHandle = c25_OpenThemeDataEx(_windowHandle,  Address(Self.ThemeNameUtf16Path) , C25_OTD_NONCLIENT)

        Return 0

c25_GdiPlusClass.OpenThemeData                             Procedure(Long _windowHandle, String _className)

    Code

        If Self.ThemeHandle <> 0
            c25_CloseThemeData(Self.ThemeHandle)
            Self.ThemeHandle = 0
        End
        If not Self.ThemeNameUtf16 &= NULL
            Dispose(Self.ThemeNameUtf16)
        End
        Self.ThemeNameUtf16         &= Self.BitConverterClass.AnsiToUtf16(Clip(_className) & Chr(0))
        Self.ThemeNameUtf16Path     = Clip(Self.ThemeNameUtf16) & Chr(0) & Chr(0)
        Self.ThemeHandle            = c25_OpenThemeDataEx(_windowHandle,  Address(Self.ThemeNameUtf16Path) , C25_OTD_NONCLIENT)
        Return Self.ThemeHandle