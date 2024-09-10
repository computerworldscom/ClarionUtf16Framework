                        Member

                        Include('c25_CanvasClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.clw')
                            Module('c25_CanvasClass.clw')
!WindowHandlerThread             Procedure(Long _paramA, Long _paramB),Long
                            End
                        End

c25CanvasClass.Construct                                                     Procedure()

Code


    Self.ProgramHandler &= NEW c25ProgramHandlerClass()
    Self.ProgramHandler &= Self.ProgramHandler.Singleton.GetPointer()
    Self.ProgramHandler.Singleton.Start()
    Self.BitConverter &= NEW c25BitConverterClass()
    Self.Graphics &= NEW c25GraphicsClass()


c25CanvasClass.Destruct                                                      Procedure()

Code
    
    Dispose(Self.Graphics)
    
    
c25CanvasClass.CreateCanvas                       Procedure(<string _name>, <long _w>, <long _h>, <Canvas_TYPE _canvas>)

Code

    Self.Id                             = Self.ProgramHandler.GetCanvasSeedId()
    If omitted(_w) = False
        Self.BitMapObject.Width = _w
    Else
         Self.BitMapObject.Width = 10000
    End
    If omitted(_h) = False
        Self.BitMapObject.Height = _h
    Else
         Self.BitMapObject.Height = 10000
    End    
    If omitted(_name) = False
        Self.Name &= Self.BitConverter.BinaryCopy(Clip(_name))
    End
    Self.DC                     = 0
    Self.Margin                 = 0
    Self.BitMapObject.Stride    = Self.BitMapObject.Width * 4
    Self.PixelFormat            = c25_PixelFormat32bppARGB
    Self.Size                   = Self.BitMapObject.Width * Self.BitMapObject.Height * 4
    Self.WorkX                  = Self.Margin
    Self.WorkY                  = Self.Margin
    Self.WorkWidth              = Self.BitMapObject.Width
    Self.WorkHeight             = Self.BitMapObject.Height

!    Self.BitMapObject.Width             = Self.Width
!    Self.BitMapObject.Height            = Self.Height
!    Self.BitMapObject.Stride            = Self.Stride
!    Self.BitMapObject.PixelFormat       = Self.PixelFormat
!    Self.BitMapObject.Scan0             = Self.Scan0

    C25_GdipCreateBitmapFromScan0(Self.BitMapObject.Width, Self.BitMapObject.Height, Self.BitMapObject.Stride, Self.PixelFormat, Self.BitMapObject.Scan0, Address(Self.ImagePtr) )
    c25_GdipGetImageGraphicsContext(Self.ImagePtr, Address(Self.GraphicsHandle))

    
!    c25_GdipFillRectangleI(Self.GraphicsHandle, Self.Graphics.GetSolidBrush(,255,225,225,225), 0, 0, Self.BitMapObject.Width, Self.BitMapObject.Height)

    Return 0
    
    
    