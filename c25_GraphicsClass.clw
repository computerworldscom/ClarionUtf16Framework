        Member

        Map
            Include('i64.inc')
            Include('cwutil.inc')
            Include('c25_WinApiPrototypes.clw')
            !Include('c25Functions.inc')
!            GetColorFromARGB(long _a, long _r, long _g, long _b) !),Long
!            GetAFromColor(long _color),BYTE
!            GetRFromColor(long _color),BYTE
!            GetGFromColor(long _color),BYTE
!            GetBFromColor(long _color),BYTE
        End

        Include('c25_GraphicsClass.inc'),ONCE

c25_GraphicsClass.Construct                          Procedure()

Code

    Self.ProgramHandler &= NEW c25ProgramHandlerClass()
    Self.ProgramHandler &= Self.ProgramHandler.Singleton.GetPointer()
    Self.ProgramHandler.Singleton.Start()

!!!    Self.GdiPlusSolidBrush                      &= NEW GdiPlusSolidBrush_TYPE()
!!!    Self.ClaControlTEMP                         &= NEW ClaControl_TYPE()
!!!    Self.BitConverter                           &= NEW c25BitConverterClass()
!!!!    Self.CanvasQ                                &= NEW Canvas_TYPE()
!!!!    Self.CurrentCanvas                          &= NEW Canvas_TYPE()
!!!    Self.GdiPlusSolidBrushQ                     &= NEW GdiPlusSolidBrush_TYPE()
!!!    Self.LastRect                               &= NEW Rect_TYPE()
!!!    Self.NanoSync                               &= NEW c25NanoSyncClass()
!!!    Self.ProcessHeapHandle                      = c25_GetProcessHeap()
!!!    Self.Row                                    &= NEW Row_TYPE()
!!!    Self.RowTemplate                            &= NEW Row_TYPE()
!!!    
!!!    Self.CRLF = Chr(13) & Chr(10)
!!!
!!!    Self.ProcessHeapHandle          = c25_GetProcessHeap()
!!!    Self.GdiPlusSolidBrushQ         &= NEW GdiPlusSolidBrush_TYPE
!!!
!!!    Self.ImgEncoderCodecInfoQ       &= NEW ImageCodecInfo_TYPE
!!!    Self.ImgDecoderCodecInfoQ       &= NEW ImageCodecInfo_TYPE
!!!    self.bmpencoderguid36           = '557cf400-1a04-11d3-9a73-0000f81ef32e'
!!!    self.jpgencoderguid36           = '557cf401-1a04-11d3-9a73-0000f81ef32e'
!!!    self.gifencoderguid36           = '557cf402-1a04-11d3-9a73-0000f81ef32e'
!!!    self.tiffencoderguid36          = '557cf405-1a04-11d3-9a73-0000f81ef32e'
!!!    self.pngencoderguid36           = '557cf406-1a04-11d3-9a73-0000f81ef32e'
!!!    Self.BmpEncoderGuid16           = Self.BitConverter.UuidFromStringA(Self.BmpEncoderGuid36)
!!!    Self.JpgEncoderGuid16           = Self.BitConverter.UuidFromStringA(Self.JpgEncoderGuid36)
!!!    Self.GifEncoderGuid16           = Self.BitConverter.UuidFromStringA(Self.GifEncoderGuid36)
!!!    Self.TiffEncoderGuid16          = Self.BitConverter.UuidFromStringA(Self.TiffEncoderGuid36)
!!!    Self.PngEncoderGuid16           = Self.BitConverter.UuidFromStringA(Self.PngEncoderGuid36)
!!!
!!!    Self.GetImgEncoderCodecInfo()
!!!    Self.GetImgDecoderCodecInfo()
!!!
!!!    Self.BitConverter.QueueToJsonString(Self.ImgDecoderCodecInfoQ , , , , 'm:\ImgDecoderCodecInfoQ.json')

c25_GraphicsClass.Destruct   Procedure()

    Code  
        

        
!!!
!!!c25_GraphicsClass.SetRowTemplate     Procedure()
!!!
!!!Code
!!!
!!!!!!    Self.RowTemplate.Id = 0
!!!!!!    Self.RowTemplate.SourceId = 0
!!!!!!    Self.RowTemplate.SourceRowId = 0
!!!!!!    Self.RowTemplate.BackgroundColor_A = 255 ! <-- as you can see, it works fully with ALPHA (thus transparent levels)
!!!!!!    Self.RowTemplate.BackgroundColor_R = 255
!!!!!!    Self.RowTemplate.BackgroundColor_G = 255
!!!!!!    Self.RowTemplate.BackgroundColor_B = 255
!!!!!!    Self.RowTemplate.BackgroundColor = GetColorFromARGB(Self.RowTemplate.BackgroundColor_A,Self.RowTemplate.BackgroundColor_R, Self.RowTemplate.BackgroundColor_G, Self.RowTemplate.BackgroundColor_B)
!!!!!!
!!!!!!    Self.RowTemplate.SelBackgroundColor_A = 255
!!!!!!    Self.RowTemplate.SelBackgroundColor_R = 120
!!!!!!    Self.RowTemplate.SelBackgroundColor_G = 120
!!!!!!    Self.RowTemplate.SelBackgroundColor_B = 120
!!!!!!    Self.RowTemplate.SelBackgroundColor = GetColorFromARGB(Self.RowTemplate.SelBackgroundColor_A,Self.RowTemplate.SelBackgroundColor_R, Self.RowTemplate.SelBackgroundColor_G, Self.RowTemplate.SelBackgroundColor_B)
!!!!!!
!!!!!!    Self.RowTemplate.FontColor_A = 255
!!!!!!    Self.RowTemplate.FontColor_R = 0
!!!!!!    Self.RowTemplate.FontColor_G = 0
!!!!!!    Self.RowTemplate.FontColor_B = 0
!!!!!!    Self.RowTemplate.FontColor = GetColorFromARGB(Self.RowTemplate.FontColor_A,Self.RowTemplate.FontColor_R, Self.RowTemplate.FontColor_G, Self.RowTemplate.FontColor_B)
!!!!!!
!!!!!!    Self.RowTemplate.SelFontColor_A = 255
!!!!!!    Self.RowTemplate.SelFontColor_R = 0
!!!!!!    Self.RowTemplate.SelFontColor_G = 59
!!!!!!    Self.RowTemplate.SelFontColor_B = 161
!!!!!!    Self.RowTemplate.SelFontColor = GetColorFromARGB(Self.RowTemplate.SelFontColor_A,Self.RowTemplate.SelFontColor_R, Self.RowTemplate.SelFontColor_G, Self.RowTemplate.SelFontColor_B)
!!!!!!
!!!!!!    Self.RowTemplate.BackgroundImageId = 0
!!!!!!    Self.RowTemplate.BackgroundImageName &= null
!!!!!!    Self.RowTemplate.SelBackgroundImageId = 0
!!!!!!    Self.RowTemplate.SelBackgroundImageName &= null
!!!!!!
!!!!!!    Self.RowTemplate.FontFamilyNameA &= Self.BitConverter.BinaryCopy('Segoe UI Light')
!!!!!!    Self.RowTemplate.FontFamilyNameW &= Self.BitConverter.AnsiToUtf16(Self.RowTemplate.FontFamilyNameA,,True)
!!!!!!
!!!!!!    Self.RowTemplate.FontSize = 14
!!!!!!
!!!!!!    ! herewith the change (upgrade to high quality) the gdiplus rendering
!!!!!!    Self.RowTemplate.CompositingMode = c25_CompositingModeSourceOver !C25_Compositingqualityhighquality !+ C25_Compositingqualitygammacorrected!c25_CompositingModeSourceOver
!!!!!!!C25_Compositingmodesourcecopy                                                                                       Equate(1)
!!!!!!!C25_Compositingmodesourceover                                                                                       Equate(0)
!!!!!!!C25_Compositingqualityassumelinear                                                                                  Equate(4)
!!!!!!!C25_Compositingqualitydefault                                                                                       Equate(0)
!!!!!!!C25_Compositingqualitygammacorrected                                                                                Equate(3)
!!!!!!!C25_Compositingqualityhighquality                                                                                   Equate(2)
!!!!!!!C25_Compositingqualityhighspeed                                                                                     Equate(1)    
!!!!!!    
!!!!!!    Self.RowTemplate.InterpolationMode = C25_Interpolationmodenearestneighbor
!!!!!!!C25_Interpolationmodebicubic                                                                                        Equate(4)
!!!!!!!C25_Interpolationmodebilinear                                                                                       Equate(3)
!!!!!!!C25_Interpolationmodehighqualitybicubic                                                                             Equate(7)
!!!!!!!C25_Interpolationmodehighqualitybilinear                                                                            Equate(6)
!!!!!!!C25_Interpolationmodenearestneighbor                                                                                Equate(5)
!!!!!!    
!!!!!!    Self.RowTemplate.SmoothingMode = C25_Smoothingmodenone
!!!!!!!C25_Smoothingmodeantialias                                                                                          Equate(4)
!!!!!!!C25_Smoothingmodeantialias8X8                                                                                       Equate(5)
!!!!!!!C25_Smoothingmodenone                                                                                               Equate(3)    
!!!!!!    
!!!!!!    Self.RowTemplate.TextRenderingHint = C25_Textrenderinghintcleartypegridfit !C25_Textrenderinghintcleartypegridfit
!!!!!!!C25_Textrenderinghintantialias                                                                                      Equate(4)
!!!!!!!C25_Textrenderinghintantialiasgridfit                                                                               Equate(3)
!!!!!!!C25_Textrenderinghintcleartypegridfit                                                                               Equate(5)
!!!!!!!C25_Textrenderinghintsinglebitperpixel                                                                              Equate(2)
!!!!!!!C25_Textrenderinghintsinglebitperpixelgridfit                                                                       Equate(1)
!!!!!!!C25_Textrenderinghintsystemdefault                                                                                  Equate(0)
!!!!!!
!!!!!!    Self.RowTemplate.TextMarginHorizontal = 7
!!!!!!    Self.RowTemplate.TextMarginVertical = 5
!!!!!!
!!!!!!    Self.RowTemplate.Width = 100
!!!!!!    Self.RowTemplate.Height = 15
!!!!!!    
!!!!!!    Self.RowTemplate.Rect_Left = 0
!!!!!!    Self.RowTemplate.Rect_Top = 0
!!!!!!    Self.RowTemplate.Rect_Right = 0
!!!!!!    Self.RowTemplate.Rect_Bottom = 0
!!!!!!    Self.RowTemplate.RectFText_Left = 0
!!!!!!    Self.RowTemplate.RectFText_Top = 0
!!!!!!    Self.RowTemplate.RectFText_Right = 0
!!!!!!    Self.RowTemplate.RectFText_Bottom = 0
!!!!!!    Self.RowTemplate.TextA &= null
!!!!!!    Self.RowTemplate.TextW &= null
!!!
!!!    Return 0
!!!
!!!c25_GraphicsClass.RenderRow                          Procedure(long _canvasId, <long _rowId>, <*TreeNode_TYPE _treeNode>, <*Row_TYPE _row>)
!!!
!!!TreeBuffer    &TreeNode_TYPE
!!!
!!!Code
!!!
!!!    If Self.CurrentCanvasId <> _canvasId
!!!        Self.CurrentCanvasId = _canvasId
!!!        Self.CurrentCanvas = Self.GetCanvasById(Self.CurrentCanvasId)
!!!        Self.SetRowTemplate()
!!!        Self.Row = Self.RowTemplate
!!!    End
!!!
!!!    If omitted(_row) = FALSE
!!!        Self.Row = _row
!!!    End
!!!
!!!    Case Self.CurrentCanvas.ControlType
!!!    Of 2
!!!        If omitted(_treeNode) = FALSE
!!!            TreeBuffer &= _treeNode
!!!        ELSE
!!!            Return 0
!!!        END
!!!
!!!        Get(TreeBuffer, _rowId)
!!!        If Errorcode() <> 0
!!!            Return 0
!!!        End
!!!        If TreeBuffer.ROWID <> _rowId
!!!            F# = 0
!!!            I# = 0
!!!            R# = Records(TreeBuffer)
!!!            Loop R# Times
!!!                I# = I# + 1
!!!                Get(TreeBuffer,I#)
!!!                If TreeBuffer.ROWID = _rowId
!!!                    F# = 1
!!!                    Break
!!!                End
!!!            End
!!!            If F# = 0
!!!                Return -1
!!!            End
!!!        End
!!!        
!!!        !Message('Self.CurrentCanvas.Graphics ' & Self.CurrentCanvas.Graphics & ', ' &Self.CanvasQ.Graphics)
!!!        !Message('Self.CurrentCanvas.Graphics ' & Self.CurrentCanvas.Graphics & ', ' & Self.GetSolidBrush( ,155,0,128,255))
!!!
!!!        If Self.CurrentCanvas.CompositingMode <> Self.Row.CompositingMode
!!!            Self.CurrentCanvas.CompositingMode = Self.Row.CompositingMode
!!!            c25_GdipSetCompositingMode(Self.CurrentCanvas.Graphics,Self.CurrentCanvas.CompositingMode)
!!!        End
!!!        If Self.CurrentCanvas.CompositingQuality <> Self.Row.CompositingQuality
!!!            Self.CurrentCanvas.CompositingQuality = Self.Row.CompositingQuality
!!!            c25_GdipSetCompositingQuality(Self.CurrentCanvas.Graphics,Self.CurrentCanvas.CompositingQuality)
!!!        End
!!!        If Self.CurrentCanvas.InterpolationMode <> Self.Row.InterpolationMode
!!!            Self.CurrentCanvas.InterpolationMode = Self.Row.InterpolationMode
!!!            c25_GdipSetInterpolationMode(Self.CurrentCanvas.Graphics,7)
!!!        End
!!!        If Self.CurrentCanvas.SmoothingMode <> Self.Row.SmoothingMode
!!!            Self.CurrentCanvas.SmoothingMode = Self.Row.SmoothingMode
!!!            c25_GdipSetSmoothingMode(Self.CurrentCanvas.Graphics,7)
!!!        End
!!!        If Self.CurrentCanvas.TextRenderingHint <> Self.Row.TextRenderingHint
!!!            Self.CurrentCanvas.TextRenderingHint = Self.Row.TextRenderingHint
!!!            c25_GdipSetTextRenderingHint(Self.CurrentCanvas.Graphics,6)
!!!        End
!!!
!!!        Self.SomethingChanged = 0
!!!        If (Self.CurrentCanvas.FontFamilyNameW &= null)
!!!            Self.CurrentCanvas.FontFamilyNameW &= Self.BitConverter.BinaryCopy(Self.Row.FontFamilyNameW)
!!!            Self.SomethingChanged = True
!!!        ELSE
!!!            If Self.CurrentCanvas.FontFamilyNameW <> Self.Row.FontFamilyNameW
!!!                Dispose(Self.CurrentCanvas.FontFamilyNameW)
!!!                Self.CurrentCanvas.FontFamilyNameW &= Self.BitConverter.BinaryCopy(Self.Row.FontFamilyNameW)
!!!                Self.SomethingChanged = True
!!!            End
!!!        End
!!!
!!!        If Self.SomethingChanged = True
!!!            If Self.CurrentCanvas.FontFamilyHandle <> 0
!!!                c25_GdipDeleteFontFamily(Self.CurrentCanvas.FontFamilyHandle)
!!!                Self.CurrentCanvas.FontFamilyHandle = 0
!!!            End
!!!            c25_GdipCreateFontFamilyFromName(Address(Self.CurrentCanvas.FontFamilyNameW), 0, Address(Self.CurrentCanvas.FontFamilyHandle))
!!!        End
!!!
!!!        If Self.CurrentCanvas.FontSize <> Self.Row.FontSize Or Self.CurrentCanvas.FontObjectHandle = 0
!!!            Self.CurrentCanvas.FontSize = Self.Row.FontSize
!!!            C25_GdipDeleteFont(Self.CurrentCanvas.FontObjectHandle)
!!!            Self.CurrentCanvas.FontObjectHandle = 0
!!!            c25_GdipCreateFont(Self.CurrentCanvas.FontFamilyHandle, Self.CurrentCanvas.FontSize, 0, 2, Address(Self.CurrentCanvas.FontObjectHandle))
!!!        End
!!!        If Self.CurrentCanvas.StringFormatHandle = 0
!!!            c25_GdipCreateStringFormat(0, 0, Address(Self.CurrentCanvas.StringFormatHandle))
!!!        End
!!!
!!!        If Self.CurrentCanvas.BackgroundColor <> Self.Row.BackgroundColor Or Self.CurrentCanvas.BackgroundColorHandle = 0
!!!            If Self.CurrentCanvas.BackgroundColorHandle <> 0
!!!                c25_GdipDeleteBrush(Self.CurrentCanvas.BackgroundColorHandle)
!!!            End
!!!            Self.CurrentCanvas.BackgroundColor = Self.Row.BackgroundColor
!!!            c25_GdipCreateSolidFill(Self.CurrentCanvas.BackgroundColor,Address(Self.CurrentCanvas.BackgroundColorHandle))
!!!        End
!!!        
!!!        If Self.CurrentCanvas.FontColor <> Self.Row.FontColor Or Self.CurrentCanvas.FontColorHandle = 0
!!!            If Self.CurrentCanvas.FontColorHandle <> 0
!!!                c25_GdipDeleteBrush(Self.CurrentCanvas.FontColorHandle)
!!!            End
!!!            Self.CurrentCanvas.FontColor = Self.Row.FontColor
!!!            c25_GdipCreateSolidFill(Self.CurrentCanvas.FontColor,Address(Self.CurrentCanvas.FontColorHandle))
!!!        End 
!!!        
!!!      If Self.CurrentCanvas.SelFontColor <> Self.Row.SelFontColor Or Self.CurrentCanvas.SelFontColorHandle = 0
!!!            If Self.CurrentCanvas.SelFontColorHandle <> 0
!!!                c25_GdipDeleteBrush(Self.CurrentCanvas.SelFontColorHandle)
!!!            End
!!!            Self.CurrentCanvas.SelFontColor = Self.Row.SelFontColor
!!!            c25_GdipCreateSolidFill(Self.CurrentCanvas.SelFontColor,Address(Self.CurrentCanvas.SelFontColorHandle))
!!!        End          
!!!        
!!!        If NOT Self.CurrentCanvas.ClaControl &= null
!!!            Self.Row.Height = Self.CurrentCanvas.ClaControl.LineHeight
!!!        ELSE
!!!            Self.Row.Height = -1 !dynamimc
!!!        End
!!!        If Self.Row.Height > 0
!!!            OffsetY# = (_rowId * Self.Row.Height) - Self.Row.Height
!!!            c25_GdipFillRectangleI(Self.CanvasQ.Graphics, Self.CurrentCanvas.BackgroundColorHandle, 4, OffsetY#+3, Self.CurrentCanvas.Width, Self.Row.Height - 1)
!!!
!!!            If Self.Row.Cells &= null
!!!                Self.Row.TextW &= Self.BitConverter.BinaryCopy(Clip(TreeBuffer.Text_UTF8))
!!!
!!!                Self.Row.RectFText_Left      = 2
!!!                Self.Row.RectFText_Top       = OffsetY# + 3
!!!                Self.Row.RectFText_Right     = Self.CurrentCanvas.Width
!!!                Self.Row.RectFText_Bottom    = OffsetY# + 200
!!!                
!!!                R# = c25_GdipDrawString(Self.CanvasQ.Graphics, Address(Self.Row.TextW),-1, Self.CurrentCanvas.FontObjectHandle, Self.GetRectFAddrFromOffset(Address(Self.Row.RectFText_Left)), 0 , Self.CurrentCanvas.FontColorHandle)  
!!!                
!!!
!!!!%FontStyleBold = 1
!!!!%FontStyleBoldItalic = 3
!!!!%FontStyleItalic = 2
!!!!%FontStyleRegular = 0
!!!!%FontStyleStrikeout = 8                
!!!!%FontStyleUnderline = 4
!!!                
!!!                C25_GdipDeleteFont(Self.CurrentCanvas.FontObjectHandle)
!!!                Self.CurrentCanvas.FontObjectHandle = 0
!!!                If Self.CurrentCanvas.FontSize <> Self.Row.FontSize Or Self.CurrentCanvas.FontObjectHandle = 0
!!!                    Self.CurrentCanvas.FontSize = 11 !Self.Row.FontSize
!!!                    C25_GdipDeleteFont(Self.CurrentCanvas.FontObjectHandle)
!!!                    Self.CurrentCanvas.FontObjectHandle = 0
!!!                    c25_GdipCreateFont(Self.CurrentCanvas.FontFamilyHandle, Self.CurrentCanvas.FontSize, c25_FontStyleBold, 2, Address(Self.CurrentCanvas.FontObjectHandle))
!!!                End
!!!                
!!!                Self.Row.RectFText_Left      = 40
!!!                Self.Row.RectFText_Top       = OffsetY# + 3 + 14
!!!                Self.Row.RectFText_Right     = Self.CurrentCanvas.Width
!!!                Self.Row.RectFText_Bottom    = OffsetY# + 200
!!!                
!!!                R# = c25_GdipDrawString(Self.CanvasQ.Graphics, Address(Self.Row.TextW),-1, Self.CurrentCanvas.FontObjectHandle, Self.GetRectFAddrFromOffset(Address(Self.Row.RectFText_Left)), 0 , Self.CurrentCanvas.SelFontColorHandle)    
!!!            End
!!!        End
!!!        
!!!        Self.SaveCanvas(Self.CurrentCanvas)
!!!
!!!        TreeBuffer &= null
!!!    End
!!!
!!!    Return 0
!!!
!!!    
!!!c25_GraphicsClass.GetRectFAddrFromOffset                  Procedure(long _addr)
!!!
!!!Code
!!!        
!!!    C25_Memcpy(Address(Self.RectString16), _addr, 16)
!!!    Return Address(Self.RectString16)
!!!    
!!!c25_GraphicsClass.SaveCanvas                         Procedure(<*Canvas_TYPE _currentCanvas>)
!!!
!!!Id long
!!!
!!!Code
!!!
!!!    If omitted(_currentCanvas) = FALSE
!!!        Id = _currentCanvas.Id
!!!    Else
!!!        Id = Self.CurrentCanvas.Id
!!!    End
!!!
!!!    I# = 0
!!!    LOOP
!!!        I# = I# + 1
!!!        Get(Self.CanvasQ,I#)
!!!        If Errorcode() <> 0
!!!            Return 0
!!!        End
!!!        If Self.CanvasQ.Id <> Id
!!!            CYCLE
!!!        End
!!!        If Omitted(_currentCanvas) = FALSE
!!!            Self.CanvasQ = _currentCanvas
!!!        Else
!!!            Self.CanvasQ = Self.CurrentCanvas
!!!        End
!!!        Put(Self.CanvasQ)
!!!        Break
!!!    End
!!!    Return Id
!!!
!!!c25_GraphicsClass.GetCanvasById                      Procedure(long _canvasId)
!!!
!!!Code
!!!
!!!    I# = 0
!!!    LOOP
!!!        I# = I# + 1
!!!        Get(Self.CanvasQ,I#)
!!!        If Errorcode() <> 0
!!!            BREAK
!!!        END
!!!        If Self.CanvasQ.Id = _canvasId
!!!            Return Self.CanvasQ
!!!        END
!!!    END
!!!    Clear(Self.CanvasQ)
!!!    Return Self.CanvasQ
!!!
!!!c25_GraphicsClass.CreateCanvas                       Procedure(<*ClaControl_TYPE _claControl>, <long _w>, <long _h>, string _name, <long _x>, <long _y>, <long _controlType>)
!!!
!!!Code
!!!
!!!    
!!!    Clear(Self.CanvasQ)
!!!    Self.CanvasSeedId                   = Self.CanvasSeedId + 1
!!!    Self.CanvasQ.Id                     = Self.CanvasSeedId
!!!    Self.CanvasQ.Width                  = _w
!!!    Self.CanvasQ.Height                 = _h
!!!    Self.CanvasQ.ControlType            = _controlType
!!!
!!!    If Omitted(_claControl) = False
!!!        Self.CanvasQ.ClaControl &= NEW ClaControl_TYPE()
!!!        Self.CanvasQ.ClaControl = _claControl
!!!        Add(Self.CanvasQ.ClaControl)
!!!    End
!!!    
!!!    Self.CanvasQ.Id                     = 1
!!!    Self.CanvasQ.Name                  &= Self.BitConverter.BinaryCopy(Clip(_name))
!!!    Self.CanvasQ.Graphics               = 0
!!!    Self.CanvasQ.DC                     = 0
!!!    Self.CanvasQ.Margin                 = 0
!!!    Self.CanvasQ.Stride                 = Self.CanvasQ.Width * 4
!!!    Self.CanvasQ.PixelFormat            = c25_PixelFormat32bppARGB
!!!    Self.CanvasQ.Size                   = Self.CanvasQ.Width * Self.CanvasQ.Height * 4
!!!    Self.CanvasQ.Scan0                  = c25_HeapAlloc(Self.ProcessHeapHandle, 8, Self.CanvasQ.Size)
!!!    Self.CanvasQ.WorkX                  = Self.CanvasQ.Margin
!!!    Self.CanvasQ.WorkY                  = Self.CanvasQ.Margin
!!!    Self.CanvasQ.WorkWidth              = Self.CanvasQ.Width
!!!    Self.CanvasQ.WorkHeight             = Self.CanvasQ.Height
!!!
!!!    Self.BitMapObject.Width             = Self.CanvasQ.Width
!!!    Self.BitMapObject.Height            = Self.CanvasQ.Height
!!!    Self.BitMapObject.Stride            = Self.CanvasQ.Stride
!!!    Self.BitMapObject.PixelFormat       = Self.CanvasQ.PixelFormat
!!!    Self.BitMapObject.Scan0             = Self.CanvasQ.Scan0
!!!
!!!    C25_GdipCreateBitmapFromScan0(Self.CanvasQ.Width, Self.CanvasQ.Height, Self.CanvasQ.Stride, Self.CanvasQ.PixelFormat, Self.CanvasQ.Scan0, Address(Self.CanvasQ.ImagePtr) )
!!!    c25_GdipGetImageGraphicsContext(Self.CanvasQ.ImagePtr, Address(Self.CanvasQ.Graphics))
!!!    !c25_GdipFillRectangleI(Self.CanvasQ.Graphics, Self.GetSolidBrush( ,255,131,189,234), 0, 0, Self.CanvasQ.Width, Self.CanvasQ.Height)
!!!    !c25_GdipFillRectangleI(Self.CanvasQ.Graphics, Self.GetSolidBrush( ,255,225,225,225), 0, 0, Self.CanvasQ.Width, Self.CanvasQ.Height)
!!!
!!!    Add(Self.CanvasQ)
!!!    Return Self.CanvasQ.Id
!!!
!!!c25_GraphicsClass.GetCanvas_ImagePtr                 Procedure(string _name)
!!!
!!!Code
!!!
!!!    I# = 0
!!!    LOOP
!!!        I# = I# + 1
!!!        Get(Self.CanvasQ,I#)
!!!        If Errorcode() <> 0
!!!            BREAK
!!!        End
!!!        If lower(clip(Self.CanvasQ.Name)) <> lower(clip(_name))
!!!            CYCLE
!!!        End
!!!
!!!        Return Self.CanvasQ.ImagePtr
!!!    End
!!!
!!!    Return 0
!!!
!!!c25_GraphicsClass.ConvertEncoderParameters           Procedure(<*EncoderParameters_TYPE _encoderParameters>, <*EncoderParameterValues_TYPE _encoderParameterValues>, <*string _outputBlock>)
!!!
!!!EncoderParametersBlock          &STRING
!!!EncoderParametersBlockSize      LONG
!!!EncoderParameters_Count         Long
!!!EncoderParameters_CountStr4     String(4)
!!!
!!!EncoderParameterValues          &EncoderParameterValues_TYPE
!!!EncoderParameters               &EncoderParameters_TYPE
!!!
!!!EncoderParameterStruct          Group,Pre(EncoderParameterStruct)
!!!Guid16                              String(16)
!!!NumValues                           ULONG
!!!Type                                ULONG
!!!ValuePtr                            LONG
!!!                                End
!!!EncoderParametersBlockOffset    Long
!!!
!!!StringRefTemp                   &string
!!!EncoderParameterValuesBlock     &String
!!!
!!!Code
!!!
!!!    If Omitted(_encoderParameters) = False
!!!        EncoderParameters &= _encoderParameters
!!!    Else
!!!        EncoderParameters &= Self.EncoderParameters
!!!    End
!!!    If Omitted(_encoderParameterValues) = False
!!!        EncoderParameterValues &= _encoderParameterValues
!!!    Else
!!!        EncoderParameterValues &= Self.EncoderParameterValues
!!!    End
!!!
!!!    EncoderParameters_Count         = Records(EncoderParameters)
!!!    EncoderParametersBlockSize      = EncoderParameterStructSize * EncoderParameters_Count
!!!
!!!    If omitted(_outputBlock) = FALSE
!!!        EncoderParametersBlock &= NEW STRING(EncoderParametersBlockSize)
!!!    Else
!!!        EncoderParametersBlock &= NEW STRING(EncoderParametersBlockSize)
!!!    End
!!!    Clear(EncoderParametersBlock,-1)
!!!    C25_Memcpy(Address(EncoderParametersBlock), Address(EncoderParameters_Count) , 4)
!!!    EncoderParametersBlockOffset = 4
!!!
!!!    I# = 0
!!!    LOOP
!!!        I# = I# + 1
!!!        Get(EncoderParameters,I#)
!!!        If Errorcode() <> 0
!!!            BREAK
!!!        End
!!!        EncoderParameters.NumValues = 0
!!!        I2# = 0
!!!        Loop
!!!            I2# = I2# + 1
!!!            Get(EncoderParameterValues,I2#)
!!!            If Errorcode() <> 0
!!!                BREAK
!!!            END
!!!            If EncoderParameterValues.Guid16 <> EncoderParameters.Guid16
!!!                CYCLE
!!!            END
!!!            EncoderParameters.NumValues = EncoderParameters.NumValues + 1
!!!        End
!!!        Put(EncoderParameters)
!!!
!!!        Case EncoderParameters.TypeEnum
!!!        Of EncoderParameterValueTypeByte
!!!        Of EncoderParameterValueTypeASCII
!!!        Of EncoderParameterValueTypeShort
!!!        Of EncoderParameterValueTypeLong
!!!        Of EncoderParameterValueTypeRational
!!!        Of EncoderParameterValueTypeLongRange
!!!            EncoderParameters.ValuesSize = EncoderParameters.NumValues * (2*4)
!!!            EncoderParameters.Values &= Self.BitConverter.BinaryCopyByLen(EncoderParameters.ValuesSize)
!!!            EncoderParameters.ValuesPtr = Address(EncoderParameters.Values)
!!!            Offset# = 0
!!!            I2# = 0
!!!            Loop
!!!                I2# = I2# + 1
!!!                Get(EncoderParameterValues,I2#)
!!!                If Errorcode() <> 0
!!!                    BREAK
!!!                END
!!!                If EncoderParameterValues.Guid16 <> EncoderParameters.Guid16
!!!                    CYCLE
!!!                END
!!!                C25_Memcpy(Address(EncoderParameters.Values) + Offset#, Address(EncoderParameterValues.ValueIntA1),4)
!!!                Offset# = Offset# + 4
!!!                C25_Memcpy(Address(EncoderParameters.Values) + Offset#, Address(EncoderParameterValues.ValueIntA2),4)
!!!                Offset# = Offset# + 4
!!!            End
!!!            Put(EncoderParameters)
!!!
!!!            Clear(EncoderParameterStruct)
!!!            EncoderParameterStruct.Guid16           = EncoderParameterValues.Guid16
!!!            EncoderParameterStruct.NumValues        = EncoderParameters.NumValues
!!!            EncoderParameterStruct.Type             = EncoderParameterValueTypeLongRange
!!!            EncoderParameterStruct.ValuePtr         = EncoderParameters.ValuesPtr
!!!
!!!            C25_Memcpy(Address(EncoderParametersBlock) + EncoderParametersBlockOffset, Address(EncoderParameterStruct), Size(EncoderParameterStruct))
!!!
!!!        Of EncoderParameterValueTypeUndefined
!!!        Of EncoderParameterValueTypeRationalRange
!!!        Of EncoderParameterValueTypePointer
!!!        End
!!!    End
!!!
!!!    Self.BitConverter.st1.Start()
!!!    Self.BitConverter.st1.SetValue(EncoderParametersBlock)
!!!    Self.BitConverter.st1.SaveFile('m:\EncoderParametersBlock.txt')
!!!
!!!    EncoderParameters              &= null
!!!    EncoderParameterValues         &= null
!!!
!!!    If omitted(_outputBlock) = False
!!!        Return null
!!!    ELSE
!!!        Return EncoderParametersBlock
!!!    End
!!!
!!!c25_GraphicsClass.CreateEncoderParameters            Procedure(string _imageTypeGuid16, <bool _setDefaults>, <*EncoderParameters_TYPE _encoderParameters>, <*EncoderParameterValues_TYPE _encoderParameterValues>)
!!!
!!!EncoderParameters                               &EncoderParameters_TYPE
!!!EncoderParameterValues                          &EncoderParameterValues_TYPE
!!!
!!!EncoderParameterStruct                          Group,Pre(EncoderParameterStruct)
!!!Guid                                                String(16)
!!!                                                End
!!!
!!!Code
!!!
!!!    If omitted(_encoderParameters) = False
!!!        EncoderParameters &= _encoderParameters
!!!    Else
!!!        EncoderParameters &= Self.EncoderParameters
!!!    End
!!!    If omitted(_encoderParameterValues) = False
!!!        EncoderParameterValues &= _encoderParameterValues
!!!    Else
!!!        EncoderParameterValues &= Self.EncoderParameterValues
!!!    End
!!!
!!!    Case _imageTypeGuid16
!!!    Of Self.BmpEncoderGuid16
!!!    Of Self.JpgEncoderGuid16
!!!        Clear(EncoderParameterValues)
!!!        EncoderParameterValues.Guid16           = Self.BitConverter.Guid16FromGuid36(EncoderQuality_Guid36)
!!!        EncoderParameterValues.ValueIntA1       = 100
!!!        Add(EncoderParameterValues)
!!!
!!!        Clear(EncoderParameters)
!!!        EncoderParameters.Guid16                = Self.BitConverter.Guid16FromGuid36(EncoderQuality_Guid36)
!!!        EncoderParameters.TypeEnum              = EncoderParameterValueTypeLongRange
!!!        Add(EncoderParameters)
!!!
!!!    Of Self.GifEncoderGuid16
!!!    Of Self.TiffEncoderGuid16
!!!    Of Self.PngEncoderGuid16
!!!    End
!!!
!!!    EncoderParameters  &= NULL
!!!    EncoderParameterValues &= NULL
!!!
!!!    Return ''
!!!
!!!c25_GraphicsClass.ClearEncoderParameters             Procedure()
!!!
!!!Code
!!!
!!!    If not Self.EncoderParameters &= NULL
!!!        I# = 0
!!!        Loop
!!!            I# = I# + 1
!!!            Get(Self.EncoderParameters,I#)
!!!            If Errorcode() <> 0
!!!                BREAK
!!!            End
!!!            If Not Self.EncoderParameters.Values &= NULL
!!!                Dispose(Self.EncoderParameters.Values)
!!!            End
!!!            Clear(Self.EncoderParameters)
!!!            Put(Self.EncoderParameters)
!!!        END
!!!        Free(Self.EncoderParameters)
!!!    Else
!!!        Self.EncoderParameters  &= NEW EncoderParameters_TYPE()
!!!    End
!!!
!!!    If not Self.EncoderParameterValues &= NULL
!!!        I# = 0
!!!        Loop
!!!            I# = I# + 1
!!!            Get(Self.EncoderParameterValues,I#)
!!!            If Errorcode() <> 0
!!!                BREAK
!!!            End
!!!            If Not Self.EncoderParameterValues.Value &= NULL
!!!                Dispose(Self.EncoderParameterValues.Value)
!!!            End
!!!            If Not Self.EncoderParameterValues.ValueEnumString &= NULL
!!!                Dispose(Self.EncoderParameterValues.ValueEnumString)
!!!            End
!!!            Clear(Self.EncoderParameterValues)
!!!            Put(Self.EncoderParameterValues)
!!!        END
!!!        Free(Self.EncoderParameterValues)
!!!    Else
!!!        Self.EncoderParameterValues  &= NEW EncoderParameterValues_TYPE()
!!!    End
!!!
!!!    Return 0
!!!
!!!c25_GraphicsClass.RetrieveEncoderParameters          Procedure(long imagePtr, string _imageTypeGuid16)
!!!
!!!EncoderParameterValues                              &EncoderParameterValues_TYPE
!!!EncoderParameters                                   &EncoderParameters_TYPE
!!!EncoderParametersStructuresCount                    Long
!!!EncoderParametersId                                 Long
!!!EncoderParametersOrdinal                            Long
!!!
!!!EncoderParameterValuesId                            Long
!!!
!!!Code
!!!
!!!    EncoderParameterValues  &= NEW EncoderParameterValues_TYPE()
!!!    EncoderParameters       &= NEW EncoderParameters_TYPE()
!!!
!!!    EncoderParameters.ImageId = 0
!!!
!!!    C25_GdipGetEncoderParameterListSize(Self.FileImagePtr, Address(_imageTypeGuid16), Address(Self.EncoderParameterListSize))
!!!
!!!    If Self.EncoderParameterListSize < 5
!!!        Return 0
!!!    End
!!!
!!!    If not Self.EncoderParameterListBuffer &= NULL
!!!        Dispose(Self.EncoderParameterListBuffer)
!!!    End
!!!    Self.EncoderParameterListBuffer &= NEW String(Self.EncoderParameterListSize)
!!!
!!!    C25_GdipGetEncoderParameterList(Self.FileImagePtr, Address(_imageTypeGuid16), Self.EncoderParameterListSize, Address(Self.EncoderParameterListBuffer))
!!!
!!!    C25_Memcpy(Address(EncoderParametersStructuresCount),Address(Self.EncoderParameterListBuffer),4)
!!!
!!!    EncoderParametersId = 0
!!!    EncoderParametersOrdinal = 0
!!!
!!!    I# = 5
!!!    LOOP
!!!        EncoderParametersId = EncoderParametersId + 1
!!!        EncoderParametersOrdinal = EncoderParametersOrdinal + 1
!!!        If EncoderParametersOrdinal > EncoderParametersStructuresCount
!!!            BREAK
!!!        End
!!!        Clear(EncoderParameters)
!!!
!!!        EncoderParameters.Id            = EncoderParametersId
!!!        EncoderParameters.ImagePtr      = imagePtr
!!!        EncoderParameters.Ordinal       = EncoderParametersOrdinal
!!!
!!!        EncoderParameters.Guid16 = Self.EncoderParameterListBuffer[I# : I# + 15]
!!!        EncoderParameters.Guid36 = Self.BitConverter.Guid36FromGuid16(EncoderParameters.Guid16)
!!!        Case UPPER(EncoderParameters.Guid36)
!!!        Of EncoderChrominanceTable_Guid36
!!!            EncoderParameters.GuidName = 'ChrominanceTable'
!!!        Of EncoderColorDepth_Guid36
!!!            EncoderParameters.GuidName = 'ColorDepth'
!!!        Of EncoderColorSpace_Guid36
!!!            EncoderParameters.GuidName = 'ColorSpace'
!!!        Of EncoderCompression_Guid36
!!!            EncoderParameters.GuidName = 'Compression'
!!!        Of EncoderImageItems_Guid36
!!!            EncoderParameters.GuidName = 'ImageItems'
!!!        Of EncoderLuminanceTable_Guid36
!!!            EncoderParameters.GuidName = 'LuminanceTable'
!!!        Of EncoderQuality_Guid36
!!!            EncoderParameters.GuidName = 'Quality'
!!!        Of EncoderRenderMethod_Guid36
!!!            EncoderParameters.GuidName = 'RenderMethod'
!!!        Of EncoderSaveAsCMYK_Guid36
!!!            EncoderParameters.GuidName = 'SaveAsCMYK'
!!!        Of EncoderSaveFlag_Guid36
!!!            EncoderParameters.GuidName = 'SaveFlag'
!!!        Of EncoderScanMethod_Guid36
!!!            EncoderParameters.GuidName = 'ScanMethod'
!!!        Of EncoderTransformation_Guid36
!!!            EncoderParameters.GuidName = 'Transformation'
!!!        Of EncoderVersion_Guid36
!!!            EncoderParameters.GuidName = 'Version'
!!!        End
!!!        I# = I# + 16
!!!        C25_Memcpy(Address(EncoderParameters.NumValues),Address(Self.EncoderParameterListBuffer) + I# - 1, 4)
!!!        I# = I# + 4
!!!        C25_Memcpy(Address(EncoderParameters.TypeEnum), Address(Self.EncoderParameterListBuffer) + I# -1 , 4)
!!!        I# = I# + 4
!!!        C25_Memcpy(Address(EncoderParameters.ValuesPtr), Address(Self.EncoderParameterListBuffer) + I# -1 , 4)
!!!        I# = I# + 4
!!!
!!!        Case EncoderParameters.TypeEnum
!!!        Of EncoderParameterValueTypeByte
!!!            EncoderParameters.TypeName = 'Byte'
!!!        Of EncoderParameterValueTypeASCII
!!!            EncoderParameters.TypeName = 'ASCII'
!!!        Of EncoderParameterValueTypeShort
!!!            EncoderParameters.TypeName = 'Short'
!!!        Of EncoderParameterValueTypeLong
!!!            EncoderParameters.TypeName = 'Long'
!!!        Of EncoderParameterValueTypeRational
!!!            EncoderParameters.TypeName = 'Rational'
!!!        Of EncoderParameterValueTypeLongRange
!!!            EncoderParameters.TypeName = 'LongRange'
!!!        Of EncoderParameterValueTypeUndefined
!!!            EncoderParameters.TypeName = 'Undefined'
!!!        Of EncoderParameterValueTypeRationalRange
!!!            EncoderParameters.TypeName = 'RationalRange'
!!!        Of EncoderParameterValueTypePointer
!!!            EncoderParameters.TypeName = 'Pointer'
!!!        End
!!!
!!!        Case EncoderParameters.TypeEnum
!!!        Of EncoderParameterValueTypeByte
!!!        OrOf EncoderParameterValueTypeUndefined
!!!            Ordinal# = 0
!!!            Offset# = 0
!!!            Loop
!!!                Ordinal# = Ordinal# + 1
!!!                If Ordinal# > EncoderParameters.NumValues
!!!                    BREAK
!!!                End
!!!                C25_Memcpy(Address(Self.SomeByte), EncoderParameters.ValuesPtr + Offset#, 1)
!!!                Clear(EncoderParameterValues)
!!!                EncoderParameterValuesId = EncoderParameterValuesId + 1
!!!                EncoderParameterValues.Id           = EncoderParameterValuesId
!!!                EncoderParameterValues.Ordinal      = Ordinal#
!!!                EncoderParameterValues.ImageId      = EncoderParameters.ImageId
!!!                EncoderParameterValues.ImagePtr     = EncoderParameters.ImagePtr
!!!                EncoderParameterValues.EncoderParameterId = EncoderParameters.Id
!!!                EncoderParameterValues.ValueType    = EncoderParameters.TypeEnum
!!!                EncoderParameterValues.ValueIntA1    = Self.SomeByte
!!!                Add(EncoderParameterValues)
!!!
!!!                Offset# = Offset# + 1
!!!            End
!!!
!!!        Of EncoderParameterValueTypeASCII
!!!
!!!            Ordinal# = 0
!!!            Offset# = 0
!!!            Loop 1 Times
!!!                Ordinal# = Ordinal# + 1
!!!                If Ordinal# > EncoderParameters.NumValues
!!!                    BREAK
!!!                End
!!!
!!!                P# = -1
!!!                Loop 1 Times
!!!                    P# = P# + 1
!!!                    C25_Memcpy(Address(Self.SomeByte), EncoderParameters.ValuesPtr + Offset# + P#, 1)
!!!                    If Self.SomeByte = 0
!!!                        Break
!!!                    End
!!!                End
!!!                If P# > 2
!!!                    Clear(EncoderParameterValues)
!!!                    EncoderParameterValuesId = EncoderParameterValuesId + 1
!!!                    EncoderParameterValues.Id           = EncoderParameterValuesId
!!!                    EncoderParameterValues.Ordinal              = Ordinal#
!!!                    EncoderParameterValues.ImageId              = EncoderParameters.ImageId
!!!                    EncoderParameterValues.ImagePtr             = EncoderParameters.ImagePtr
!!!                    EncoderParameterValues.EncoderParameterId   = EncoderParameters.Id
!!!                    EncoderParameterValues.ValueType            = EncoderParameters.TypeEnum
!!!                    EncoderParameterValues.ValueIntA1            = 0
!!!                    EncoderParameterValues.ValueIntA2            = 0
!!!                    EncoderParameterValues.ValueIntB1            = 0
!!!                    EncoderParameterValues.ValueIntB2            = 0
!!!                    EncoderParameterValues.Value                &= NEW STRING(P#-1)
!!!                    C25_Memcpy(Address(EncoderParameterValues.Value), EncoderParameters.ValuesPtr + Offset#, P# -1)
!!!
!!!                    Add(EncoderParameterValues)
!!!
!!!                End
!!!                Offset# = Offset# + P# + 1
!!!
!!!            End
!!!
!!!        Of EncoderParameterValueTypeShort
!!!
!!!            Ordinal# = 0
!!!            Offset# = 0
!!!            Loop
!!!                Ordinal# = Ordinal# + 1
!!!                If Ordinal# > EncoderParameters.NumValues
!!!                    BREAK
!!!                End
!!!                C25_Memcpy(Address(Self.SomeShort), EncoderParameters.ValuesPtr + Offset#, 2)
!!!                Clear(EncoderParameterValues)
!!!                EncoderParameterValuesId            = EncoderParameterValuesId + 1
!!!                EncoderParameterValues.Id           = EncoderParameterValuesId
!!!                EncoderParameterValues.Ordinal      = Ordinal#
!!!                EncoderParameterValues.ImageId      = EncoderParameters.ImageId
!!!                EncoderParameterValues.ImagePtr     = EncoderParameters.ImagePtr
!!!                EncoderParameterValues.EncoderParameterId = EncoderParameters.Id
!!!                EncoderParameterValues.ValueType    = EncoderParameters.TypeEnum
!!!                EncoderParameterValues.ValueIntA1    = Self.SomeShort
!!!                Add(EncoderParameterValues)
!!!
!!!                Offset# = Offset# + 2
!!!            End
!!!
!!!        Of EncoderParameterValueTypeLong
!!!        OrOf EncoderParameterValueTypePointer
!!!
!!!            Ordinal# = 0
!!!            Offset# = 0
!!!            Loop
!!!                Ordinal# = Ordinal# + 1
!!!                If Ordinal# > EncoderParameters.NumValues
!!!                    BREAK
!!!                End
!!!                C25_Memcpy(Address(Self.SomeLong), EncoderParameters.ValuesPtr + Offset#, 4)
!!!
!!!                Clear(EncoderParameterValues)
!!!                EncoderParameterValuesId                    = EncoderParameterValuesId + 1
!!!                EncoderParameterValues.Id                   = EncoderParameterValuesId
!!!                EncoderParameterValues.Ordinal              = Ordinal#
!!!                EncoderParameterValues.ImageId              = EncoderParameters.ImageId
!!!                EncoderParameterValues.ImagePtr             = EncoderParameters.ImagePtr
!!!                EncoderParameterValues.EncoderParameterId   = EncoderParameters.Id
!!!                EncoderParameterValues.ValueType            = EncoderParameters.TypeEnum
!!!                EncoderParameterValues.ValueIntA1            = Self.SomeLong
!!!
!!!                EncoderParameterValues.ValueEnumString      &= Self.EncoderParametersTypeEnumToString(EncoderParameterValues.ValueIntA1)
!!!                Add(EncoderParameterValues)
!!!
!!!                Offset# = Offset# + 4
!!!            End
!!!
!!!        Of EncoderParameterValueTypeRational
!!!        OrOf EncoderParameterValueTypeLongRange
!!!
!!!            Ordinal# = 0
!!!            Offset# = 0
!!!            Loop
!!!                Ordinal# = Ordinal# + 1
!!!                If Ordinal# > EncoderParameters.NumValues
!!!                    BREAK
!!!                End
!!!
!!!                Clear(EncoderParameterValues)
!!!                EncoderParameterValuesId                    = EncoderParameterValuesId + 1
!!!                EncoderParameterValues.Id                   = EncoderParameterValuesId
!!!                EncoderParameterValues.Ordinal              = Ordinal#
!!!                EncoderParameterValues.ImageId              = EncoderParameters.ImageId
!!!                EncoderParameterValues.ImagePtr             = EncoderParameters.ImagePtr
!!!                EncoderParameterValues.EncoderParameterId   = EncoderParameters.Id
!!!                EncoderParameterValues.ValueType            = EncoderParameters.TypeEnum
!!!
!!!                C25_Memcpy(Address(Self.SomeLong), EncoderParameters.ValuesPtr + Offset#, 4)
!!!                EncoderParameterValues.ValueIntA1            = Self.SomeLong
!!!                Offset# = Offset# + 4
!!!
!!!                C25_Memcpy(Address(Self.SomeLong), EncoderParameters.ValuesPtr + Offset#, 4)
!!!                EncoderParameterValues.ValueIntA2           = Self.SomeLong
!!!                Offset# = Offset# + 4
!!!
!!!                Add(EncoderParameterValues)
!!!            End
!!!        Of EncoderParameterValueTypeRationalRange
!!!            Ordinal# = 0
!!!            Offset# = 0
!!!            Loop
!!!                Ordinal# = Ordinal# + 1
!!!                If Ordinal# > EncoderParameters.NumValues
!!!                    BREAK
!!!                End
!!!
!!!                Clear(EncoderParameterValues)
!!!                EncoderParameterValuesId                    = EncoderParameterValuesId + 1
!!!                EncoderParameterValues.Id                   = EncoderParameterValuesId
!!!                EncoderParameterValues.Ordinal              = Ordinal#
!!!                EncoderParameterValues.ImageId              = EncoderParameters.ImageId
!!!                EncoderParameterValues.ImagePtr             = EncoderParameters.ImagePtr
!!!                EncoderParameterValues.EncoderParameterId   = EncoderParameters.Id
!!!                EncoderParameterValues.ValueType            = EncoderParameters.TypeEnum
!!!
!!!                C25_Memcpy(Address(Self.SomeShort), EncoderParameters.ValuesPtr + Offset#, 4)
!!!                EncoderParameterValues.ValueIntA1           = Self.SomeLong
!!!                Offset# = Offset# + 4
!!!
!!!                C25_Memcpy(Address(Self.SomeShort), EncoderParameters.ValuesPtr + Offset#, 4)
!!!                EncoderParameterValues.ValueIntB1           = Self.SomeLong
!!!                Offset# = Offset# + 4
!!!
!!!                Add(EncoderParameterValues)
!!!
!!!            End
!!!        End
!!!
!!!        Add(EncoderParameters)
!!!    End
!!!
!!!    Self.BitConverter.QueueToJsonString(EncoderParameters,,,,'m:\EncoderParameters.json')
!!!    Self.BitConverter.QueueToJsonString(EncoderParameterValues,,,,'m:\EncoderParameterValues.json')
!!!
!!!    Return 0
!!!
!!!c25_GraphicsClass.EncoderParametersTypeEnumToString  Procedure(long _typeEnum)
!!!
!!!ValueEnumString  &STRING
!!!
!!!CODE
!!!
!!!    Case _typeEnum
!!!    Of EncoderValueColorTypeCMYK
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('ColorTypeCMYK')
!!!    Of EncoderValueColorTypeYCCK
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('ColorTypeYCCK')
!!!    Of EncoderValueCompressionLZW
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('CompressionLZW')
!!!    Of EncoderValueCompressionCCITT3
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('CompressionCCITT3')
!!!    Of EncoderValueCompressionCCITT4
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('CompressionCCITT4')
!!!    Of EncoderValueCompressionRle
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('CompressionRle')
!!!    Of EncoderValueCompressionNone
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('CompressionNone')
!!!    Of EncoderValueScanMethodInterlaced
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('ScanMethodInterlaced')
!!!    Of EncoderValueScanMethodNonInterlaced
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('ScanMethodNonInterlaced')
!!!    Of EncoderValueVersionGif87
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('VersionGif87')
!!!    Of EncoderValueVersionGif89
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('VersionGif89')
!!!    Of EncoderValueRenderProgressive
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('RenderProgressive')
!!!    Of EncoderValueRenderNonProgressive
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('RenderNonProgressive')
!!!    Of EncoderValueTransformRotate90
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('TransformRotate90')
!!!    Of EncoderValueTransformRotate180
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('TransformRotate180')
!!!    Of EncoderValueTransformRotate270
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('TransformRotate270')
!!!    Of EncoderValueTransformFlipHorizontal
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('TransformFlipHorizontal')
!!!    Of EncoderValueTransformFlipVertical
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('TransformFlipVertical')
!!!    Of EncoderValueMultiFrame
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('MultiFrame')
!!!    Of EncoderValueLastFrame
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('LastFrame')
!!!    Of EncoderValueFlush
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('Flush')
!!!    Of EncoderValueFrameDimensionTime
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('FrameDimensionTime')
!!!    Of EncoderValueFrameDimensionResolution
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('FrameDimensionResolution')
!!!    Of EncoderValueFrameDimensionPage
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('FrameDimensionPage')
!!!    Else
!!!        ValueEnumString &= Self.BitConverter.BinaryCopy('unknown')
!!!    End
!!!
!!!    Return ValueEnumString
!!!
!!!c25_GraphicsClass.WM_ConvertMedia                    Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam)
!!!
!!!FileQ   QUEUE,PRE(FileQ),TYPE
!!!name        STRING(FILE:MAXFILENAME)
!!!shortname   STRING(13)
!!!date        LONG
!!!time        LONG
!!!size        LONG
!!!attrib      BYTE
!!!          END
!!!
!!!Code
!!!
!!!    RETURN 0
!!!
!!!c25_GraphicsClass.GetImgEncoderCodecInfo             Procedure()
!!!
!!!ImageCodecInfoStruct                                    Group,Pre(ImageCodecInfoStruct)
!!!ClassID                                                     String(16)
!!!FormatID                                                    String(16)
!!!CodecNamePtr                                                Long
!!!DllNamePtr                                                  Long
!!!FormatDescriptionPtr                                        Long
!!!FilenameExtensionPtr                                        Long
!!!MimeTypePtr                                                 Long
!!!Flags                                                       Long
!!!Version                                                     Long
!!!SigCount                                                    Long
!!!SigSize                                                     Long
!!!SigPatternPtr                                               Long
!!!SigMaskPtr                                                  Long
!!!                                                        End
!!!    Code
!!!
!!!        Dispose(Self.ImgEncoderCodecInfoQ)
!!!        Self.ImgEncoderCodecInfoQ &= NEW ImageCodecInfo_TYPE()
!!!        c25_GdipGetImageEncodersSize(Address(Self.NumEncoders) , Address(Self.BufferGetEncodersSize) )
!!!        If Self.BufferGetEncodersSize < 0
!!!            Return -1
!!!        End
!!!        Self.BufferGetEncoders &= NEW String(Self.BufferGetEncodersSize+64000)
!!!        c25_GdipGetImageEncoders(Self.NumEncoders, Self.BufferGetEncodersSize, Address(Self.BufferGetEncoders))
!!!        P# = 1
!!!        LOOP Self.NumEncoders Times
!!!            Clear(ImageCodecInfoStruct)
!!!            ImageCodecInfoStruct = Self.BufferGetEncoders[P# : P# + Size(ImageCodecInfoStruct) - 1]
!!!            P# = P# + Size(ImageCodecInfoStruct)
!!!            Clear(Self.ImgEncoderCodecInfoQ)
!!!            Self.ImgEncoderCodecInfoQ.ClassID16 = ImageCodecInfoStruct.ClassID
!!!            Self.ImgEncoderCodecInfoQ.ClassID36 = Self.BitConverter.UuidToString(Self.ImgEncoderCodecInfoQ.ClassID16)
!!!            Case Lower(Self.ImgEncoderCodecInfoQ.ClassID36)
!!!            Of Self.BmpEncoderGuid36
!!!                Self.ImgEncoderCodecInfoQ.NameAnsi &= Self.BitConverter.AnsiToAnsi('BMP')
!!!            Of Self.JpgEncoderGuid36
!!!                Self.ImgEncoderCodecInfoQ.NameAnsi &= Self.BitConverter.AnsiToAnsi('JPG')
!!!            Of Self.GifEncoderGuid36
!!!                Self.ImgEncoderCodecInfoQ.NameAnsi &= Self.BitConverter.AnsiToAnsi('GIF')
!!!            Of Self.TiffEncoderGuid36
!!!                Self.ImgEncoderCodecInfoQ.NameAnsi &= Self.BitConverter.AnsiToAnsi('TIFF')
!!!            Of Self.PngEncoderGuid36
!!!                Self.ImgEncoderCodecInfoQ.NameAnsi &= Self.BitConverter.AnsiToAnsi('PNG')
!!!            ELSE
!!!                Self.ImgEncoderCodecInfoQ.NameAnsi &= Self.BitConverter.AnsiToAnsi('OTHER')
!!!            End
!!!            If ImageCodecInfoStruct.CodecNamePtr <> 0
!!!                Self.ImgEncoderCodecInfoQ.CodecNameAnsi &= Self.BitConverter.Utf16ToAnsi(Self.BitConverter.ParseZeroTerminatedUtf16String(ImageCodecInfoStruct.CodecNamePtr,0, True) )
!!!            End
!!!            If ImageCodecInfoStruct.DllNamePtr <> 0
!!!                Self.ImgEncoderCodecInfoQ.DllNameAnsi &= Self.BitConverter.Utf16ToAnsi(Self.BitConverter.ParseZeroTerminatedUtf16String(ImageCodecInfoStruct.DllNamePtr,0, True) )
!!!            End
!!!            If ImageCodecInfoStruct.FormatDescriptionPtr <> 0
!!!                Self.ImgEncoderCodecInfoQ.FormatDescriptionAnsi &= Self.BitConverter.Utf16ToAnsi(Self.BitConverter.ParseZeroTerminatedUtf16String(ImageCodecInfoStruct.FormatDescriptionPtr,0, True) )
!!!            End
!!!            If ImageCodecInfoStruct.FilenameExtensionPtr <> 0
!!!                Self.ImgEncoderCodecInfoQ.FilenameExtensionAnsi &= Self.BitConverter.Utf16ToAnsi(Self.BitConverter.ParseZeroTerminatedUtf16String(ImageCodecInfoStruct.FilenameExtensionPtr,0, True) )
!!!            End
!!!            If ImageCodecInfoStruct.MimeTypePtr <> 0
!!!                Self.ImgEncoderCodecInfoQ.MimeTypeAnsi &= Self.BitConverter.Utf16ToAnsi(Self.BitConverter.ParseZeroTerminatedUtf16String(ImageCodecInfoStruct.MimeTypePtr,0, True) )
!!!            End
!!!            Self.ImgEncoderCodecInfoQ.Flags = ImageCodecInfoStruct.Flags
!!!            If BAND(Self.ImgEncoderCodecInfoQ.Flags,c25_ImageCodecFlagsEncoder)
!!!                Self.ImgEncoderCodecInfoQ.IsEncoder = TRUE
!!!            End
!!!            If BAND(Self.ImgEncoderCodecInfoQ.Flags,c25_ImageCodecFlagsDecoder)
!!!                Self.ImgEncoderCodecInfoQ.IsDecoder = TRUE
!!!            End
!!!            If BAND(Self.ImgEncoderCodecInfoQ.Flags,c25_ImageCodecFlagsSupportBitmap)
!!!                Self.ImgEncoderCodecInfoQ.SupportBitmap = TRUE
!!!            End
!!!            If BAND(Self.ImgEncoderCodecInfoQ.Flags,c25_ImageCodecFlagsSupportVector)
!!!                Self.ImgEncoderCodecInfoQ.SupportVector = TRUE
!!!            End
!!!            If BAND(Self.ImgEncoderCodecInfoQ.Flags,c25_ImageCodecFlagsSeekableEncode)
!!!                Self.ImgEncoderCodecInfoQ.SeekableEncode = TRUE
!!!            End
!!!            If BAND(Self.ImgEncoderCodecInfoQ.Flags,c25_ImageCodecFlagsBlockingDecode)
!!!                Self.ImgEncoderCodecInfoQ.BlockingDecode = TRUE
!!!            End
!!!            If BAND(Self.ImgEncoderCodecInfoQ.Flags,c25_ImageCodecFlagsBuiltin)
!!!                Self.ImgEncoderCodecInfoQ.BuiltinGdip = TRUE
!!!            End
!!!            If BAND(Self.ImgEncoderCodecInfoQ.Flags,c25_ImageCodecFlagsSystem)
!!!                Self.ImgEncoderCodecInfoQ.System = TRUE
!!!            End
!!!            If BAND(Self.ImgEncoderCodecInfoQ.Flags,c25_ImageCodecFlagsUser)
!!!                Self.ImgEncoderCodecInfoQ.User = TRUE
!!!            End
!!!            Self.ImgEncoderCodecInfoQ.Version           = ImageCodecInfoStruct.Version
!!!            Self.ImgEncoderCodecInfoQ.SigCount          = ImageCodecInfoStruct.SigCount
!!!            Self.ImgEncoderCodecInfoQ.SigSize           = ImageCodecInfoStruct.SigSize
!!!            Self.ImgEncoderCodecInfoQ.SigPatternPtr     = ImageCodecInfoStruct.SigPatternPtr
!!!            Self.ImgEncoderCodecInfoQ.SigMaskPtr        = ImageCodecInfoStruct.SigMaskPtr
!!!            Add(Self.ImgEncoderCodecInfoQ)
!!!        End
!!!        Return 0
!!!
!!!c25_GraphicsClass.GetImgDecoderCodecInfo             Procedure()
!!!
!!!ImageCodecInfoStruct                                    Group,Pre(ImageCodecInfoStruct)
!!!ClassID                                                     String(16)
!!!FormatID                                                    String(16)
!!!CodecNamePtr                                                Long
!!!DllNamePtr                                                  Long
!!!FormatDescriptionPtr                                        Long
!!!FilenameExtensionPtr                                        Long
!!!MimeTypePtr                                                 Long
!!!Flags                                                       Long
!!!Version                                                     Long
!!!SigCount                                                    Long
!!!SigSize                                                     Long
!!!SigPatternPtr                                               Long
!!!SigMaskPtr                                                  Long
!!!                                                        End
!!!
!!!                                                        Code
!!!        Dispose(Self.ImgDecoderCodecInfoQ)
!!!        Self.ImgDecoderCodecInfoQ &= NEW ImageCodecInfo_TYPE()
!!!        c25_GdipGetImageDecodersSize(Address(Self.NumDecoders) , Address(Self.BufferGetDecodersSize) )
!!!        If Self.BufferGetDecodersSize < 0
!!!            Return -1
!!!        End
!!!        Self.BufferGetDecoders &= NEW String(Self.BufferGetDecodersSize+64000)
!!!        c25_GdipGetImageDecoders(Self.NumDecoders, Self.BufferGetDecodersSize, Address(Self.BufferGetDecoders))
!!!        P# = 1
!!!        LOOP Self.NumDecoders Times
!!!            Clear(ImageCodecInfoStruct)
!!!            ImageCodecInfoStruct = Self.BufferGetDecoders[P# : P# + Size(ImageCodecInfoStruct) - 1]
!!!            P# = P# + Size(ImageCodecInfoStruct)
!!!            If Self.ImgDecoderCodecInfoQ &= NULL
!!!                Message('Self.ImgDecoderCodecInfoQ is null')
!!!            End
!!!            Clear(Self.ImgDecoderCodecInfoQ)
!!!            Self.ImgDecoderCodecInfoQ.ClassID16 = ImageCodecInfoStruct.ClassID
!!!            Self.ImgDecoderCodecInfoQ.ClassID36 = Self.BitConverter.UuidToString(Self.ImgDecoderCodecInfoQ.ClassID16)
!!!            Case Lower(Self.ImgDecoderCodecInfoQ.ClassID36)
!!!            Of Self.BmpEncoderGuid36
!!!                Self.ImgDecoderCodecInfoQ.NameAnsi &= Self.BitConverter.AnsiToAnsi('BMP')
!!!            Of Self.JpgEncoderGuid36
!!!                Self.ImgDecoderCodecInfoQ.NameAnsi &= Self.BitConverter.AnsiToAnsi('JPG')
!!!            Of Self.GifEncoderGuid36
!!!                Self.ImgDecoderCodecInfoQ.NameAnsi &= Self.BitConverter.AnsiToAnsi('GIF')
!!!            Of Self.TiffEncoderGuid36
!!!                Self.ImgDecoderCodecInfoQ.NameAnsi &= Self.BitConverter.AnsiToAnsi('TIFF')
!!!            Of Self.PngEncoderGuid36
!!!                Self.ImgDecoderCodecInfoQ.NameAnsi &= Self.BitConverter.AnsiToAnsi('PNG')
!!!            ELSE
!!!                Self.ImgDecoderCodecInfoQ.NameAnsi &= Self.BitConverter.AnsiToAnsi('OTHER')
!!!            End
!!!            If ImageCodecInfoStruct.CodecNamePtr <> 0
!!!                Self.ImgDecoderCodecInfoQ.CodecNameAnsi &= Self.BitConverter.Utf16ToAnsi(Self.BitConverter.ParseZeroTerminatedUtf16String(ImageCodecInfoStruct.CodecNamePtr,0, True) )
!!!            End
!!!            If ImageCodecInfoStruct.DllNamePtr <> 0
!!!                Self.ImgDecoderCodecInfoQ.DllNameAnsi &= Self.BitConverter.Utf16ToAnsi(Self.BitConverter.ParseZeroTerminatedUtf16String(ImageCodecInfoStruct.DllNamePtr,0, True) )
!!!            End
!!!            If ImageCodecInfoStruct.FormatDescriptionPtr <> 0
!!!                Self.ImgDecoderCodecInfoQ.FormatDescriptionAnsi &= Self.BitConverter.Utf16ToAnsi(Self.BitConverter.ParseZeroTerminatedUtf16String(ImageCodecInfoStruct.FormatDescriptionPtr,0, True) )
!!!            End
!!!            If ImageCodecInfoStruct.FilenameExtensionPtr <> 0
!!!                Self.ImgDecoderCodecInfoQ.FilenameExtensionAnsi &= Self.BitConverter.Utf16ToAnsi(Self.BitConverter.ParseZeroTerminatedUtf16String(ImageCodecInfoStruct.FilenameExtensionPtr,0, True) )
!!!            End
!!!            If ImageCodecInfoStruct.MimeTypePtr <> 0
!!!                Self.ImgDecoderCodecInfoQ.MimeTypeAnsi &= Self.BitConverter.Utf16ToAnsi(Self.BitConverter.ParseZeroTerminatedUtf16String(ImageCodecInfoStruct.MimeTypePtr,0, True) )
!!!            End
!!!            Self.ImgDecoderCodecInfoQ.Flags = ImageCodecInfoStruct.Flags
!!!            If BAND(Self.ImgDecoderCodecInfoQ.Flags,c25_ImageCodecFlagsDecoder)
!!!                Self.ImgDecoderCodecInfoQ.IsDecoder         = TRUE
!!!            End
!!!            If BAND(Self.ImgDecoderCodecInfoQ.Flags,c25_ImageCodecFlagsDecoder)
!!!                Self.ImgDecoderCodecInfoQ.IsDecoder         = TRUE
!!!            End
!!!            If BAND(Self.ImgDecoderCodecInfoQ.Flags,c25_ImageCodecFlagsSupportBitmap)
!!!                Self.ImgDecoderCodecInfoQ.SupportBitmap     = TRUE
!!!            End
!!!            If BAND(Self.ImgDecoderCodecInfoQ.Flags,c25_ImageCodecFlagsSupportVector)
!!!                Self.ImgDecoderCodecInfoQ.SupportVector     = TRUE
!!!            End
!!!            If BAND(Self.ImgDecoderCodecInfoQ.Flags,c25_ImageCodecFlagsSeekableEncode)
!!!                Self.ImgDecoderCodecInfoQ.SeekableEncode    = TRUE
!!!            End
!!!            If BAND(Self.ImgDecoderCodecInfoQ.Flags,c25_ImageCodecFlagsBlockingDecode)
!!!                Self.ImgDecoderCodecInfoQ.BlockingDecode    = TRUE
!!!            End
!!!            If BAND(Self.ImgDecoderCodecInfoQ.Flags,c25_ImageCodecFlagsBuiltin)
!!!                Self.ImgDecoderCodecInfoQ.BuiltinGdip       = TRUE
!!!            End
!!!            If BAND(Self.ImgDecoderCodecInfoQ.Flags,c25_ImageCodecFlagsSystem)
!!!                Self.ImgDecoderCodecInfoQ.System            = TRUE
!!!            End
!!!            If BAND(Self.ImgDecoderCodecInfoQ.Flags,c25_ImageCodecFlagsUser)
!!!                Self.ImgDecoderCodecInfoQ.User              = TRUE
!!!            End
!!!            Self.ImgDecoderCodecInfoQ.Version           = ImageCodecInfoStruct.Version
!!!            Self.ImgDecoderCodecInfoQ.SigCount          = ImageCodecInfoStruct.SigCount
!!!            Self.ImgDecoderCodecInfoQ.SigSize           = ImageCodecInfoStruct.SigSize
!!!            Self.ImgDecoderCodecInfoQ.SigPatternPtr     = ImageCodecInfoStruct.SigPatternPtr
!!!            Self.ImgDecoderCodecInfoQ.SigMaskPtr        = ImageCodecInfoStruct.SigMaskPtr
!!!            Add(Self.ImgDecoderCodecInfoQ)
!!!        End
!!!        Return 0
!!!
!!!c25_GraphicsClass.SaveBmpBuffer2Png                  Procedure(<String _utf8>)
!!!
!!!OutFileNameAnsi     &String
!!!OutFileNameUtf16    &String
!!!
!!!    Code
!!!
!!!        If Self.BufferBitmapObject = 0
!!!            Return 0
!!!        End
!!!
!!!        If omitted(_utf8) = False
!!!            OutFileNameAnsi &= Self.BitConverter.AnsiToAnsi(Clip(_utf8) & Chr(0) )
!!!        Else
!!!            OutFileNameAnsi &= Self.BitConverter.AnsiToAnsi('BmpBuffer' & Clock() & '.png' & Chr(0) )
!!!        End
!!!
!!!        OutFileNameUtf16 &= Self.BitConverter.AnsiToUtf16(Clip(OutFileNameAnsi) & Chr(0))
!!!        OutFileNameUtf16 = Clip(OutFileNameUtf16) & Chr(0) & Chr(0)
!!!
!!!        c25_GdipSaveImageToFile(Self.BufferBitmapObject, Address(OutFileNameUtf16) , Address(Self.PngEncoderGuid16), 0 )
!!!
!!!        Dispose(OutFileNameAnsi)
!!!        Dispose(OutFileNameUtf16)
!!!
!!!        Return 0
!!!
!!!c25_GraphicsClass.WriteDibBitsToBmp                  Procedure(Long _sourcePtr, Long _length, String _filenameUtf8)
!!!
!!!MemBufferPtr    Long
!!!WriteHandle     Long
!!!FullPathAnsi    &String
!!!FullPathUtf8    &String
!!!FullPathUtf16   &String
!!!stLog           &StringTheory
!!!
!!!Code
!!!
!!!        stLog &= NEW StringTheory()
!!!        stLog.Start()
!!!        If _length < 1 Or _sourcePtr = 0 Or _sourcePtr = -1 or Len(_filenameUtf8) < 1
!!!            Return 0
!!!        End
!!!        FullPathAnsi &= Self.BitConverter.AnsiToAnsi(clip(_filenameUtf8) & Chr(0))
!!!        FullPathUtf16 &= Self.BitConverter.AnsiToUtf16(Clip(FullPathAnsi) & Chr(0) & Chr(0))
!!!        WriteHandle = c25_CreateFileW(Address(FullPathUtf16),c25_GENERIC_WRITE + c25_GENERIC_READ, c25_FILE_SHARE_WRITE,0, c25_CREATE_NEW,080h,0)
!!!        If WriteHandle <> 0 And WriteHandle <> -1
!!!            stLog.Append('WriteHandle ' & WriteHandle & Chr(13) & Chr(10) )
!!!            MemBufferPtr = c25_HeapAlloc(Self.ProcessHeapHandle,8,_length)
!!!            stLog.Append('MemBufferPtr: ' & MemBufferPtr & Chr(13) & Chr(10) )
!!!            c25_MemCpy(MemBufferPtr,_sourcePtr,_length)
!!!            R# = c25_WriteFile(WriteHandle,_sourcePtr,_length,0,0)
!!!            c25_CloseHandle(WriteHandle)
!!!            c25_HeapFree(Self.ProcessHeapHandle,0,MemBufferPtr)
!!!        Else
!!!            stLog.Append('error WriteHandle ' & WriteHandle & ', ' & c25_getlasterror() & Chr(13) & Chr(10) )
!!!        End
!!!        Dispose(FullPathAnsi)
!!!        Dispose(FullPathUtf16)
!!!        dispose(stLog)
!!!    Return 0
!!!
!!!c25_GraphicsClass.SaveBitmapObject                   Procedure(long _bitmapObject, string _filename)
!!!
!!!FileNameUtf8 string(2048)
!!!FileNameUtf16 string(2048)
!!!
!!!Code
!!!
!!!    FileNameUtf8 = clip(_filename) & Chr(0) & Chr(0)
!!!    FileNameUtf16 = Self.BitConverter.AnsiToUtf16Str(FileNameUtf8)
!!!    FileNameUtf16 = Clip(FileNameUtf16)  & Chr(0) & Chr(0)
!!!
!!!    C25_GdipSaveImageToFile(_bitmapObject, Address(FileNameUtf16), Address(Self.BmpEncoderGuid16), 0)
!!!    return 0
!!!
!!!c25_GraphicsClass.SaveGraphicToFile                  Procedure(Long _graphicHandle, <String _fileNameUtf8>, <Long _width>, <Long _height>)
!!!
!!!Code
!!!
!!!     Return 0
!!!
!!!!c25_GraphicsClass.GetSolidBrush                      Procedure(<Long _color>, <Byte _A>, <Byte _R>, <Byte _G>, <Byte _B>)
!!!!
!!!!Code
!!!!
!!!!    Clear(Self.GdiPlusSolidBrushQ)
!!!!    If OMITTED(_color) = False
!!!!        Self.GdiPlusSolidBrushQ.Color = _color
!!!!    Else
!!!!        Self.SolidBrushColorBGRA.A = _A
!!!!        Self.SolidBrushColorBGRA.B = _B
!!!!        Self.SolidBrushColorBGRA.G = _G
!!!!        Self.SolidBrushColorBGRA.R = _R
!!!!        Self.GdiPlusSolidBrushQ.Color = Self.SolidBrushColor
!!!!    End
!!!!
!!!!    Get(Self.GdiPlusSolidBrushQ,+Self.GdiPlusSolidBrushQ.Color)
!!!!    If Errorcode() = 0
!!!!        Self.GdiPlusSolidBrushQ.ReferenceCount = Self.GdiPlusSolidBrushQ.ReferenceCount + 1
!!!!        Put(Self.GdiPlusSolidBrushQ)
!!!!        Return Self.GdiPlusSolidBrushQ.Handle
!!!!    ELSE
!!!!        c25_GdipCreateSolidFill(Self.GdiPlusSolidBrushQ.Color,Address(Self.GdiPlusSolidBrushQ.Handle))
!!!!        Self.GdiPlusSolidBrushQ.ReferenceCount = 1
!!!!        Add(Self.GdiPlusSolidBrushQ)
!!!!        Return Self.GdiPlusSolidBrushQ.Handle
!!!!    End
!!!!    Return 0
!!!
!!!!!c25_GraphicsClass.GetSolidBrush        Procedure(<long _color>, <byte _A>, <byte _R>, <byte _G>, <byte _B>, <string _name>)
!!!!!
!!!!!ColorInt        long,auto
!!!!!ColorNameUpper  &string,auto
!!!!!
!!!!!Code 
!!!!!    
!!!!!!!    I# = 0
!!!!!!!    R# = Records(Self.GdiPlusSolidBrush)    
!!!!!!!    T# = 0
!!!!!!!    
!!!!!!!    If omitted(_name) = False
!!!!!!!        ColorNameUpper &= NEW STRING(Size(_name))
!!!!!!!        ColorNameUpper = UPPER(_name)
!!!!!!!        Loop R# Times
!!!!!!!            I# = I# + 1
!!!!!!!            Get(Self.GdiPlusSolidBrush,I#)
!!!!!!!            If ColorNameUpper <> Self.GdiPlusSolidBrush.NameUpper
!!!!!!!                Cycle
!!!!!!!            End
!!!!!!!            Dispose(ColorNameUpper)
!!!!!!!            Return Self.GdiPlusSolidBrush.Handle
!!!!!!!        End
!!!!!!!    End
!!!!!!!
!!!!!!!    If omitted(_color) = FALSE
!!!!!!!        ColorInt = _color
!!!!!!!    Else
!!!!!!!        ColorInt = GetColorFromARGB(_A, _R, _G, _B)
!!!!!!!    End
!!!!!!!    
!!!!!!!    I# = 0
!!!!!!!    Loop R# Times
!!!!!!!        I# = I# + 1
!!!!!!!        Get(Self.GdiPlusSolidBrush,I#)
!!!!!!!        If Self.GdiPlusSolidBrush.Color <> ColorInt
!!!!!!!            Cycle
!!!!!!!        End
!!!!!!!        Return Self.GdiPlusSolidBrush.Handle
!!!!!!!    End
!!!!!!!    
!!!!!!!    Clear(Self.GdiPlusSolidBrush)
!!!!!!!    c25_GdipCreateSolidFill(ColorInt,Address(Self.GdiPlusSolidBrush.Handle))
!!!!!!!    
!!!!!!!    If omitted(_name) = False
!!!!!!!        Self.GdiPlusSolidBrush.Name         &= NEW String(Size(_name))
!!!!!!!        Self.GdiPlusSolidBrush.Name         = _name
!!!!!!!        Self.GdiPlusSolidBrush.NameUpper    &= NEW String(Size(_name))
!!!!!!!        Self.GdiPlusSolidBrush.NameUpper    = UPPER(_name)
!!!!!!!    End
!!!!!!!    Self.GdiPlusSolidBrush.Color = ColorInt
!!!!!!!    Self.GdiPlusSolidBrush.A = GetAFromColor(ColorInt)
!!!!!!!    Self.GdiPlusSolidBrush.R = GetRFromColor(ColorInt)
!!!!!!!    Self.GdiPlusSolidBrush.G = GetGFromColor(ColorInt)
!!!!!!!    Self.GdiPlusSolidBrush.B = GetBFromColor(ColorInt)
!!!!!!!    Self.GdiPlusSolidBrush.ColorHex = LongToHex(ColorInt,0)
!!!!!!!    Add(Self.GdiPlusSolidBrush)
!!!!!    
!!!!!    Return Self.GdiPlusSolidBrush.Handle
!!!!!
!!!!!    
!!!    
!!!!GetColorFromARGB    Function(long _a, long _r, long _g, long _b)
!!!!
!!!!CODE
!!!!    
!!!!    Return (_a * 16777216) + (_r * 65536) + (_g * 256) + _b
!!!!    
!!!!GetAFromColor    Function(long _color)
!!!!
!!!!ColByte byte
!!!!
!!!!CODE
!!!!    
!!!!    C25_Memcpy(Address(ColByte),Address(_color)+3,1)
!!!!    Return ColByte
!!!!    
!!!!GetRFromColor    Function(long _color)
!!!!
!!!!ColByte byte
!!!!
!!!!CODE
!!!!    
!!!!    C25_Memcpy(Address(ColByte),Address(_color)+2,1)
!!!!    Return ColByte
!!!!    
!!!!GetGFromColor    Function(long _color)
!!!!
!!!!ColByte byte
!!!!
!!!!CODE
!!!!    
!!!!    C25_Memcpy(Address(ColByte),Address(_color)+1,1)
!!!!    Return ColByte
!!!!    
!!!!GetBFromColor    Function(long _color)
!!!!
!!!!ColByte byte
!!!!
!!!!CODE
!!!!    
!!!!    C25_Memcpy(Address(ColByte),Address(_color),1)
!!!!    Return ColByte
!!!!        
!!!    
!!!
!!!!GetColorFromARGB    Function(long _a, long _r, long _g, long _b)
!!!!
!!!!CODE
!!!!    
!!!!    Return (_a * 16777216) + (_r * 65536) + (_g * 256) + _b
!!!!            