                        Member

                        Include('c25_ControlTreeViewRenderClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                        End

c25_ControlTreeViewRenderClass.Construct                                   Procedure()

Code

    Self.GdiPlusClass &= NEW c25_GdiPlusClass()

c25_ControlTreeViewRenderClass.Destruct                                    Procedure()

Code

c25_ControlTreeViewRenderClass.Init                                        Procedure(*c25_ControlTreeViewClass _controlTreeViewClass)

CODE

    Self.ControlTreeViewClass &= _controlTreeViewClass
    Self.ProgramHandlerClass &= Self.ControlTreeViewClass.ProgramHandlerClass
    Self.BitConverterClass &= Self.ControlTreeViewClass.BitConverterClass
    Self.TabRenderEngineClass &= Self.ControlTreeViewClass.BaseControl.ContainerTabClass.TabRenderEngineClass ! todo, if container is indeed a TAB
    If Self.TabRenderEngineClass &= null
        Message('Self.TabRenderEngineClass is null')
    End
    Self.SomeRectF &= NEW RectF_TYPE()
    Self.SomeRectI &= NEW RectI_TYPE()
    Self.DrawStringRectF &= NEW RectF_TYPE()
    Self.DrawStringRectCalcF &= NEW RectF_TYPE()
    Self.TextTitleRectF  &= NEW RectF_TYPE()
    
    
    !SetCanvasWorkAreaSize
    return 0

c25_ControlTreeViewRenderClass.Paint                                       Procedure(long _canvasState)

TabControlContainer   &c25_TabClass
XOffset                                                                         LONG
YOffset                                                                         LONG
LineHeight                                                                      LONG
MyQ                                                                             &queue

IconFileNameW                                                                   &string
IconFileNameHandle                                                              LONG

DataRow                                                                         &c25_DataRowClass
DataCell                                                                        &c25_DataCellClass


Code
        
        
        
    !Return 0
    If Self.Graphics[_canvasState] = 0
        If Self.ProgramHandlerClass &= NULL
            return 0
        End
        If Self.ControlTreeViewClass &= NULL
            Return 0
        End
        If Self.BindingSourceClass &= NULL
            If Self.ControlTreeViewClass &= NULL
                Return 0
            End
            If Self.ControlTreeViewClass.BindingSourceClass &= NULL
                return 0
            End
            Self.BindingSourceClass &= Self.ControlTreeViewClass.BindingSourceClass
        End
        If Self.DataSourceClass &= NULL
            If Self.BindingSourceClass.DataSourceClass &= NULL
                return 0
            End
            Self.DataSourceClass &= Self.BindingSourceClass.DataSourceClass
        End

        If Self.DataSourceClass.CurrentPageBufferClass.GuidId <> Self.CurrentPageBufferGuidId And Self.DataSourceClass.PageFilled = False
            Self.CurrentPageBufferGuidId = Self.DataSourceClass.CurrentPageBufferClass.GuidId
            Self.DataSourceClass.FillPageBuffer(Self.DataSourceClass.CurrentPageBufferClass, 1, 20)
            
            Self.DataSourceClass.CurrentPageBufferClass.SetCanvasSize(Self.ControlTreeViewClass.BaseControl.ControlRect.Width, Self.ControlTreeViewClass.BaseControl.ControlRect.Height)
            Self.DataSourceClass.PageFilled = True
            !Message('done page')
        End
        
        If Self.TabRenderEngineClass &= NULL
            Return 0
        End

        If _canvasState < 1 Or _canvasState > 16
            Return 0
        End

        If Self.ControlTreeViewClass.BaseControl &= NULL
            Return 0
        End
        
        Self.Graphics[_canvasState] = Self.TabRenderEngineClass.CanvasGraphics[_canvasState]
        
        If Self.Graphics[_canvasState] = 0
            Return 0
        End
    End
    
    
    If Self.ControlTreeViewClass.BaseControl.ControlRect <> Self.DataSourceClass.CurrentPageBufferClass.ControlRect
        Self.DataSourceClass.CurrentPageBufferClass.SetCanvasSize(Self.ControlTreeViewClass.BaseControl.ControlRect.Width, Self.ControlTreeViewClass.BaseControl.ControlRect.Height)
    End
    
    
    !c25_GdipDrawImageRectRectI(Self.Graphics[_canvasState], Self.DataSourceClass.CurrentPageBufferClass.CanvasImagePtr[_canvasState], 0,0,100,100,0,0,100,100, UnitPixel, 0,0,0)
    
    c25_GdipDrawImageRectRectI(Self.Graphics[_canvasState], Self.DataSourceClass.CurrentPageBufferClass.CanvasImagePtr[_canvasState], | &
        Self.ControlTreeViewClass.BaseControl.ControlRect.Left, | &
        Self.ControlTreeViewClass.BaseControl.ControlRect.Top + 1, | &
        Self.DataSourceClass.CurrentPageBufferClass.PageAreaWidth, | &
        Self.DataSourceClass.CurrentPageBufferClass.PageAreaHeight, | &
        Self.DataSourceClass.CurrentPageBufferClass.PageAreaOffsetX, | &
        Self.DataSourceClass.CurrentPageBufferClass.PageAreaOffsetY, | &
        Self.DataSourceClass.CurrentPageBufferClass.PageAreaWidth, | &
        Self.DataSourceClass.CurrentPageBufferClass.PageAreaHeight, | &
        UnitPixel, 0,0,0)
    
        
!    Clear(Self.BufferBitmapInfo)
!    Self.BufferBitmapInfo.Size              = 40
!    Self.BufferBitmapInfo.Width             = Self.ControlTreeViewClass.BaseControl.ControlRect.Width
!    Self.BufferBitmapInfo.Height            = Self.ControlTreeViewClass.BaseControl.ControlRect.Height * -1
!    Self.BufferBitmapInfo.Planes            = 1
!    Self.BufferBitmapInfo.BitCount          = 32
!    Self.BufferBitmapInfo.Compression       = 0
!    Self.BufferBitmapInfo.SizeImage         = 0
!    Self.BufferBitmapInfo.XpelsPerMeter     = 0
!    Self.BufferBitmapInfo.YPelsPerMeter     = 0
!    Self.BufferBitmapInfo.ClrUsed           = 0
!    Self.BufferBitmapInfo.ClrImportant      = 0   
!        
!    !c25_GdipGetDC(Self.CanvasGraphics[_canvasState], Address(Self.CanvasDC[_canvasState]))
!        
!       !X# =  Self.TabRenderEngineClass.GetDC(_canvasState)
!        
!        !Self.TabRenderEngineClass.ReleaseDC(_canvasState)
!        
!    Self.GdiPlusClass.NewSolidBrush(Self.SomeBrush, ,255, 204, 232, 255)
!
!    LineHeight = 21
!    XOffset = Self.ControlTreeViewClass.BaseControl.ControlRect.Left
!    YOffset = Self.ControlTreeViewClass.BaseControl.ControlRect.Top
!
!    Self.SomeRectI.Left     = Self.ControlTreeViewClass.BaseControl.ControlRect.Left
!    Self.SomeRectI.Top      = Self.ControlTreeViewClass.BaseControl.ControlRect.Top
!    Self.SomeRectI.Right    = Self.ControlTreeViewClass.BaseControl.ControlRect.Right
!    Self.SomeRectI.Bottom   = Self.ControlTreeViewClass.BaseControl.ControlRect.Bottom
!    Self.SomeRectI.Width    = Self.ControlTreeViewClass.BaseControl.ControlRect.Width
!    Self.SomeRectI.Height   = Self.ControlTreeViewClass.BaseControl.ControlRect.Height
!
!    c25_GdipFillRectangleI(Self.Graphics, Self.SomeBrush, Self.SomeRectI.Left, Self.SomeRectI.Top, Self.SomeRectI.Width, Self.SomeRectI.Height)        
        
        
!    If Self.TabRenderEngineClass.CanvasDC[_canvasState] <> 0
!            
!        Case Self.ProgramHandlerClass.WinAppState
!        Of WindowAppState:Active
!            C25_SetDIBitsToDevice(Self.TabRenderEngineClass.CanvasDC[_canvasState] , 0, 0, Self.ControlTreeViewClass.BaseControl.ControlRect.Width, Self.ControlTreeViewClass.BaseControl.ControlRect.Height,0,0,0, Self.ControlTreeViewClass.BaseControl.ControlRect.Height, Self.DataSourceClass.CurrentPageBufferClass.CanvasScan0[CanvasState:Normal],Address(Self.BufferBitmapInfo), c25_DIB_RGB_COLORS)
!        Of WindowAppState:NotActive
!            C25_SetDIBitsToDevice(Self.TabRenderEngineClass.CanvasDC[_canvasState] , 0, 0, Self.ControlTreeViewClass.BaseControl.ControlRect.Width, Self.ControlTreeViewClass.BaseControl.ControlRect.Height,0,0,0, Self.ControlTreeViewClass.BaseControl.ControlRect.Height, Self.DataSourceClass.CurrentPageBufferClass.CanvasScan0[CanvasState:NormalDimmed],Address(Self.BufferBitmapInfo), c25_DIB_RGB_COLORS)
!        End        
!     
!    End
    Return 0
        
        
        
        
        
        
        

    If Self.TextFontFamily[_canvasState] = 0
        Self.TextFontFamilyNameW[_canvasState] = Self.BitConverterClass.AnsiToUtf16Str('Arial',,True)
        c25_GdipCreateFontFamilyFromName(Address(Self.TextFontFamilyNameW[_canvasState]), 0, Address(Self.TextFontFamily[_canvasState]))
        If Self.TextFontFamily[_canvasState] = 0
            return 0
        End
    End

    If Self.TextFont[_canvasState] = 0
        Self.TextFontSize[_canvasState] = 12
        c25_GdipCreateFont(Self.TextFontFamily[_canvasState], Self.TextFontSize[_canvasState], 0, 2, Address(Self.TextFont[_canvasState]))
        If Self.TextFont[_canvasState] = 0
            Return 0
        End
    End
    If Self.TextStringFormat[_canvasState] = 0
        c25_GdipCreateStringFormat(StringFormatFlagsNoWrap, 0, Address(Self.TextStringFormat[_canvasState]))
    End

    If Self.TextFontBrush[_canvasState] = 0
        Self.TextFontBrush[_canvasState] = Self.GdiPlusClass.NewSolidBrush(, , 255, 28, 28, 28)
    End

    
    Self.GdiPlusClass.NewSolidBrush(Self.SomeBrush, ,255, 204, 232, 255)

    LineHeight = 21
    XOffset = Self.ControlTreeViewClass.BaseControl.ControlRect.Left
    YOffset = Self.ControlTreeViewClass.BaseControl.ControlRect.Top

    Self.SomeRectI.Left     = Self.ControlTreeViewClass.BaseControl.ControlRect.Left
    Self.SomeRectI.Top      = Self.ControlTreeViewClass.BaseControl.ControlRect.Top
    Self.SomeRectI.Right    = Self.ControlTreeViewClass.BaseControl.ControlRect.Right
    Self.SomeRectI.Bottom   = Self.ControlTreeViewClass.BaseControl.ControlRect.Bottom
    Self.SomeRectI.Width    = Self.ControlTreeViewClass.BaseControl.ControlRect.Width
    Self.SomeRectI.Height   = Self.ControlTreeViewClass.BaseControl.ControlRect.Height

    c25_GdipFillRectangleI(Self.Graphics[_canvasState], Self.SomeBrush, Self.SomeRectI.Left, Self.SomeRectI.Top, Self.SomeRectI.Width, Self.SomeRectI.Height)

    XOffset = XOffset + 20
    YOffset = YOffset + 20

    Self.SomeRectF.Left     = XOffset
    Self.SomeRectF.Top      = YOffset
    Self.SomeRectF.Right    = Self.ControlTreeViewClass.BaseControl.ControlRect.Right
    Self.SomeRectF.Bottom   = Self.ControlTreeViewClass.BaseControl.ControlRect.Bottom
    Self.SomeRectF.Width    = Self.ControlTreeViewClass.BaseControl.ControlRect.Width
    Self.SomeRectF.Height   = Self.ControlTreeViewClass.BaseControl.ControlRect.Height

    Self.TextTitleRectF = Self.SomeRectF

    IconFileNameW &= Self.BitConverterClass.AnsiToUtf16('Folder16x16Closed_Normal.png',,true)

    C25_GdipLoadImageFromFile(Address(IconFileNameW), Address(IconFileNameHandle))
    Dispose(IconFileNameW)

    Case Self.BindingSourceClass.DataSourceProviderType
    Of DataSourceProviderType:ClarionQueue
        If Self.DataSourceClass.ClarionSourceQ &= NULL
            Return 0
        END

        If Self.DataSourceClass.CurrentPageBufferClass &= null
            Return 0
        END

        I# = 0
        Loop Self.DataSourceClass.CurrentPageBufferClass.DataRowsCount Times
            I# = I# + 1

            If YOffset + LineHeight > Self.ControlTreeViewClass.BaseControl.ControlRect.Bottom
                BREAK
            End

            Get(Self.DataSourceClass.ClarionSourceQ,I#)
            If Errorcode() <> 0
                BREAK
            End

            If not Self.TextTextW &= NULL
                Dispose(Self.TextTextW)
            END

            DataRow &= Self.DataSourceClass.CurrentPageBufferClass.DataRowFromIndex(I#)
            If DataRow &= NULL
                BREAK
            End

            DataCell &= DataRow.CellByName('NodeLevel')
            Level# = DataCell.ValueObjectClass.GetValueInt32()

            Self.SomeRectI.Width    = 16
            Self.SomeRectI.Height   = 16

            Self.SomeRectI.Left     = XOffset + (Level# * 40)
            Self.SomeRectI.Top      = YOffset
            Self.SomeRectI.Right    = Self.SomeRectI.Left + Self.SomeRectI.Width
            Self.SomeRectI.Bottom   = Self.SomeRectI.Top + Self.SomeRectI.Height

            C25_GdipDrawImageRectI(Self.Graphics[_canvasState], IconFileNameHandle, Self.SomeRectI.Left, Self.SomeRectI.Top, Self.SomeRectI.Width, Self.SomeRectI.Height)

            DataCell &= DataRow.CellByName('LineText')
            If DataCell &= NULL
                Self.TextTextW &= Self.BitConverterClass.AnsiToUtf16('DataCell &= NULL', ,true)
            Else
                If DataCell.ValueObjectClass &= null
                    Self.TextTextW &= Self.BitConverterClass.AnsiToUtf16('error DataCell.ValueObjectClass &= null', ,true)
                Else
                    Self.TextTextW &= Self.BitConverterClass.BinaryCopy(DataCell.ValueObjectClass.GetValueFormatted())
                End
            END

            Self.SomeRectF.Left     = XOffset + 20 + (Level# * 40)
            Self.SomeRectF.Top      = YOffset
            Self.SomeRectF.Right    = Self.ControlTreeViewClass.BaseControl.ControlRect.Right
            Self.SomeRectF.Bottom   = Self.ControlTreeViewClass.BaseControl.ControlRect.Bottom
            Self.SomeRectF.Width    = Self.ControlTreeViewClass.BaseControl.ControlRect.Width
            Self.SomeRectF.Height   = Self.ControlTreeViewClass.BaseControl.ControlRect.Height

            Self.TextTitleRectF = Self.SomeRectF
            c25_GdipDrawString(Self.Graphics[_canvasState], Address(Self.TextTextW),-1, Self.TextFont[_canvasState], Address(Self.TextTitleRectF), Self.TextStringFormat[_canvasState] , Self.TextFontBrush[_canvasState])

            YOffset = YOffset + LineHeight
        END
    END

    Return 0

    If Self.IconHandle[_canvasState, _canvasState] = 0
        Case _canvasState
        Of ButtonState:Normal
            Case _canvasState
            Of CanvasState:Normal
            OrOf CanvasState:NormalDimmed
                C25_GdipLoadImageFromFile(Address(Self.ControlTreeViewClass.IconFileName_Normal), Address(Self.IconHandle[_canvasState, _canvasState]))
            End
        Of ButtonState:Hot
            Case _canvasState
            Of CanvasState:Normal
                C25_GdipLoadImageFromFile(Address(Self.ControlTreeViewClass.IconFileName_Hot), Address(Self.IconHandle[_canvasState, _canvasState]))
            Of CanvasState:NormalDimmed
                C25_GdipLoadImageFromFile(Address(Self.ControlTreeViewClass.IconFileName_HotDimmed), Address(Self.IconHandle[_canvasState, _canvasState]))
            End
        End
        If Self.IconHandle[_canvasState, _canvasState] = 0 Or Self.IconHandle[_canvasState, _canvasState] = -1

        End
    End

    If Self.TextFontFamily[_canvasState] = 0
        Self.TextFontFamilyNameW[_canvasState] = Self.BitConverterClass.AnsiToUtf16Str('Arial',,True)
        c25_GdipCreateFontFamilyFromName(Address(Self.TextFontFamilyNameW[_canvasState]), 0, Address(Self.TextFontFamily[_canvasState]))
        If Self.TextFontFamily[_canvasState] = 0
            Message('error creating font family')
        End
    End

    If Self.TextFont[_canvasState] = 0
        Self.TextFontSize[_canvasState] = 12
        c25_GdipCreateFont(Self.TextFontFamily[_canvasState], Self.TextFontSize[_canvasState], 0, 2, Address(Self.TextFont[_canvasState]))
        If Self.TextFont[_canvasState] = 0
            Message('error create font')
        End
    End
    If Self.TextStringFormat[_canvasState] = 0
        c25_GdipCreateStringFormat(StringFormatFlagsNoWrap, 0, Address(Self.TextStringFormat[_canvasState]))
    End

    If Self.TextFontBrush[_canvasState] = 0
        Self.TextFontBrush[_canvasState] = Self.GdiPlusClass.NewSolidBrush(, , 255, 28, 28, 28)
    End

    Self.SomeRectF.Left     = Self.ControlTreeViewClass.BaseControl.ControlRect.Left
    Self.SomeRectF.Top      = Self.ControlTreeViewClass.BaseControl.ControlRect.Top
    Self.SomeRectF.Right    = Self.ControlTreeViewClass.BaseControl.ControlRect.Right
    Self.SomeRectF.Bottom   = Self.ControlTreeViewClass.BaseControl.ControlRect.Bottom

    Self.SomeRectI.Left     = Self.ControlTreeViewClass.BaseControl.ControlRect.Left
    Self.SomeRectI.Top      = Self.ControlTreeViewClass.BaseControl.ControlRect.Top
    Self.SomeRectI.Right    = Self.ControlTreeViewClass.BaseControl.ControlRect.Right
    Self.SomeRectI.Bottom   = Self.ControlTreeViewClass.BaseControl.ControlRect.Bottom
    Self.SomeRectI.Width    = Self.ControlTreeViewClass.BaseControl.ControlRect.Width
    Self.SomeRectI.Height   = Self.ControlTreeViewClass.BaseControl.ControlRect.Height

    Self.ProgramHandlerClass.GdiPlusClass.CalcRectI_WH(Self.SomeRectI)

    If Self.TextTitleWidthCalc = 0 Or Self.TextTextW <> Self.ControlTreeViewClass.TextW Or Self.ControlTreeViewClass.ForceRedraw
        Self.ControlTreeViewClass.ForceRedraw = 0
        If not Self.TextTextTestW &= NULL
            Dispose(Self.TextTextTestW)
        End
        Self.TextTextTestW &= Self.BitConverterClass.BinaryCopy(Self.ControlTreeViewClass.TextW)

        Self.DrawStringRectF.Left      = 0
        Self.DrawStringRectF.Top       = 0
        Self.DrawStringRectF.Right     = 1000
        Self.DrawStringRectF.Bottom    = 100

        If Self.TextStringFormatTest <> 0
            c25_GdipDeleteStringFormat(Self.TextStringFormatTest)
            Self.TextStringFormatTest = 0
        End

        c25_GdipCreateStringFormat(StringFormatFlagsNoWrap, 0, Address(Self.TextStringFormatTest))

        Clear(Self.DrawStringRectCalcF)
        C25_GdipMeasureString(Self.Graphics[_canvasState], Address(Self.TextTextTestW), -1, Self.TextFont[_canvasState], Address(Self.DrawStringRectF), Self.TextStringFormatTest, Address(Self.DrawStringRectCalcF) , Address(Self.MeasureStringCodePointsFitted), 0)

        Self.TextTitleWidthCalc = Self.DrawStringRectCalcF.Right - Self.DrawStringRectCalcF.Left

        Self.TextTitleWidth = Self.TextTitleWidthCalc

        If Self.TextTitleWidthCalc < 300
            Self.TextTitleWidth = 300
        Else
            Self.TextTitleWidth = Self.TextTitleWidthCalc + 78
        End

        c25_GdipCreateStringFormat(StringFormatFlagsNoWrap, 0, Address(Self.TextStringFormat[_canvasState]))

        If not Self.TextTextW &= NULL
            Dispose(Self.TextTextW)
        End
        Self.TextTextW &= Self.BitConverterClass.BinaryCopy(Self.ControlTreeViewClass.TextW)

    End

    Self.GdiPlusClass.NewSolidBrush(Self.SomeBrush,Self.ProgramHandlerClass.ThemeManagerClass.GetBackgroundColor(ControlType:Button, Self.ControlTreeViewClass.BaseControl.Name, _canvasState))

    If Self.SomeBrush = 0
    End

    Self.TextTitleRectF = Self.SomeRectF

    c25_GdipFillRectangleI(Self.Graphics[_canvasState], Self.SomeBrush, Self.SomeRectI.Left, Self.SomeRectI.Top, Self.SomeRectI.Width, Self.SomeRectI.Height)

    If Self.IconHandle[_canvasState, _canvasState] <> 0
        C25_GdipDrawImageRectI(Self.Graphics[_canvasState], Self.IconHandle[_canvasState, _canvasState], Self.SomeRectI.Left, Self.SomeRectI.Top, Self.SomeRectI.Width, Self.SomeRectI.Height)
    Else
        If Self.IconHandle[1, 1] <> 0
            C25_GdipDrawImageRectI(Self.Graphics[_canvasState], Self.IconHandle[1, 1], Self.SomeRectI.Left, Self.SomeRectI.Top, Self.SomeRectI.Width, Self.SomeRectI.Height)
        End
    End

    c25_GdipDrawString(Self.Graphics[_canvasState], Address(Self.TextTextW),-1, Self.TextFont[_canvasState], Address(Self.TextTitleRectF), Self.TextStringFormat[_canvasState] , Self.TextFontBrush[_canvasState])

    Return 0

