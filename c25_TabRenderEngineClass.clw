              Member

                        Include('c25_TabRenderEngineClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                        End

c25_TabRenderEngineClass.Construct                                  Procedure()


ClassStarter   &c25_ClassStarter

Code

    Self.ClassTypeName = 'c25_TabRenderEngineClass'

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(Self.ClassTypeName))
    Dispose(ClassStarter)

    Self.SQLiteAsyncConnection &= Self.ProgramHandlerClass.SQLiteAsyncConnections

    Self.GradientRect                           &= NEW WindowRect_TYPE()
    Self.BitConverterClass                      &= NEW c25_BitConverterClass()
    Self.NanoSync                               &= NEW c25_NanoSyncClass()
    Self.WindowRect                             &= NEW WindowRect_TYPE()
    Self.SomeRect                               &= NEW WindowRect_TYPE()
    Self.TabCloseButtonRect                     &= NEW WindowRect_TYPE()
    Self.DrawStringRectF                        &= NEW RectF_TYPE()
    Self.MeasureStringOutRectF                  &= NEW RectF_TYPE()
    Self.TabHeaderTitleRectF                    &= NEW RectF_TYPE()

    Self.TabHeaderWidthMinimum = 233
    
    Self.GdiPlusSolidBrushQ                     &= NEW GdiPlusSolidBrush_TYPE
    !Self.GdiPlusClass                           &= NEW c25_GdiPlusClass()
    Self.GdiPlusClass &= NEW c25_GdiPlusClass()
    
    !Self.GdiPlusClass &= Self.ProgramHandlerClass.GdiPlusClass
    Self.GlobalAlpha = 255
    
    
    !Self.stLog &= NEW StringTheory()
    !Self.stLogFileName = 'm:\c25_TabRenderEngineClass.txt'
    !Remove(!Self.stLogFileName)
    !Self.stLog.SetValue('c25_TabRenderEngineClass.Construct' & '<13><10>')
    !Self.stLog.SaveFile(!Self.stLogFileName, true)

    
c25_TabRenderEngineClass.Init           Procedure(*c25_TabClass _tabClass)    

CODE

    
    Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabRenderEngineClass.Init - START')
    
    
    Self.TabClass &= _tabClass
    If Self.TabClass.Name &= NULL
        Self.TabClass.Name &= Self.BitConverterClass.BinaryCopy(Self.TabClass.Id)
    End
    
!TabClass                                                                            &c25_TabClass
    !Self.TabRenderEngineClass &=                                                                &c25_TabRenderEngineClass    
    
    
    !Self.stLogFileName = 'm:\c25_TabRenderEngineClass_' & Self.TabClass.Name & '.txt'
    !Remove(!Self.stLogFileName)
    !Self.stLog.Start()
    !Self.stLog.SetValue('INIT' & '<13><10>')
    !Self.stLog.SaveFile(!Self.stLogFileName)

    Self.CreateCanvas(CanvasState:Normal)
    Self.CreateCanvas(CanvasState:NormalDimmed)
    Self.Paint()
!    Self.CreateCanvas(CanvasState:Normal)
!    Self.CreateCanvas(CanvasState:Hot)
!    Self.CreateCanvas(CanvasState:Pushed)
!    Self.CreateCanvas(CanvasState:Selected)
!    Self.CreateCanvas(CanvasState:Disabled)
!    
    
    Self.ProgramHandlerClass.RootLog.WriteLog('c25_TabRenderEngineClass.Init - END')
    Return 0
    
    
    
c25_TabRenderEngineClass.Paint           Procedure()    

CODE

    If Self.ProgramHandlerClass &= NULL
        return 0
    End
    If Self.TabClass &= NULL
        Return 0
    End
    Self.TabClass.PaintingDone = 0
    Self.ProgramHandlerClass.UpdateWindowRect()
    
    ! draw only dimmed or not
    Self.DrawTabHeader(CanvasState:Normal)
    Self.DrawTabHeader(CanvasState:NormalDimmed)
    
!    ! change state
!    I# = 0
!    LOOP
!        I# = I# + 1
!        Get(Self.con
    
    
!    Self.DrawTabHeader(Self.CanvasGraphics[CanvasState:Normal], WindowAppState:Active)
!    Self.DrawTabHeader(Self.CanvasGraphics[CanvasState:Hot], WindowAppState:Active)
!    Self.DrawTabHeader(Self.CanvasGraphics[CanvasState:Pushed], WindowAppState:Active)
!    Self.DrawTabHeader(Self.CanvasGraphics[CanvasState:Selected], WindowAppState:Active)
!    Self.DrawTabHeader(Self.CanvasGraphics[CanvasState:Disabled], WindowAppState:Active)

    Self.TabClass.PaintingDone = True
    Return True
    
    
    
c25_TabRenderEngineClass.CreateCanvas       Procedure(long _canvasState)

CanvasWidth                     Long
CanvasHeight                    Long
CanvasGraphics                  Long
CanvasImagePtr                  Long
CanvasScan0                     Long
CanvasBitmapAllocSize           Long
CanvasStride                    Long
CanvasPixelFormat               Long

OldCanvasWidth                  Long
OldCanvasHeight                 Long
OldCanvasGraphics               Long
OldCanvasImagePtr               Long
OldCanvasScan0                  Long
OldCanvasBitmapAllocSize        Long
OldCanvasStride                 Long
OldCanvasPixelFormat            Long

Code


    Self.CanvasReady                = False 
    OldCanvasWidth                  = Self.CanvasWidth[_canvasState]
    OldCanvasHeight                 = Self.CanvasHeight[_canvasState]
    OldCanvasGraphics               = Self.CanvasGraphics[_canvasState]
    OldCanvasImagePtr               = Self.CanvasImagePtr[_canvasState]
    OldCanvasScan0                  = Self.CanvasScan0[_canvasState]
    OldCanvasBitmapAllocSize        = Self.CanvasBitmapAllocSize[_canvasState]
    OldCanvasStride                 = Self.CanvasStride[_canvasState]
    OldCanvasPixelFormat            = Self.CanvasPixelFormat[_canvasState]
    
    CanvasWidth                     = Self.ProgramHandlerClass.DisplayWidth !.TabClass.ControlRect.Width !+ 100 !4000
    CanvasHeight                    = Self.ProgramHandlerClass.DisplayHeight !Self.TabClass.ControlRect.Height !+ 100 !2400
    CanvasGraphics                  = 0
    CanvasImagePtr                  = 0
    CanvasScan0                     = 0
    CanvasBitmapAllocSize           = 0
    CanvasStride                    = 0
    CanvasPixelFormat               = 0

    Self.GdiPlusClass.CreateCanvas(CanvasWidth, CanvasHeight, CanvasGraphics, CanvasImagePtr, CanvasScan0, CanvasBitmapAllocSize, CanvasStride, CanvasPixelFormat, DisplayStateMode:Buffer, Self.GdiPlusClass.GetColorMacro(255,255,255,255) )
    !Self.GdiPlusClass.CreateCanvas(Self.NewCanvasWidth, Self.NewCanvasHeight, Self.NewCanvasGraphics, Self.NewCanvasImagePtr, Self.NewCanvasScan0, Self.NewCanvasBitmapAllocSize, Self.NewCanvasStride, Self.NewCanvasPixelFormat, DisplayStateMode:Buffer, Self.GdiPlusClass.GetColorMacro(255,255,200,200) )
    Self.CanvasWidth[_canvasState]              = CanvasWidth
    Self.CanvasHeight[_canvasState]             = CanvasHeight
    Self.CanvasGraphics[_canvasState]           = CanvasGraphics
    Self.CanvasImagePtr[_canvasState]           = CanvasImagePtr
    Self.CanvasScan0[_canvasState]              = CanvasScan0
    Self.CanvasBitmapAllocSize[_canvasState]    = CanvasBitmapAllocSize
    Self.CanvasStride[_canvasState]             = CanvasStride
    Self.CanvasPixelFormat[_canvasState]        = CanvasPixelFormat

    Self.CanvasReady = True  
    
!    c25_GdipGetDC(Self.CanvasGraphics[_canvasState], Address(Self.CanvasDC[_canvasState]))

    Self.GdiPlusClass.DeleteCanvas(OldCanvasGraphics, OldCanvasImagePtr, OldCanvasScan0, OldCanvasBitmapAllocSize)
    
    Return 0
        
    
c25_TabRenderEngineClass.GetDC                          Procedure(long _canvasState)

CanvasDC long

CODE
        
    If _canvasState < 1 Or _canvasState > 16
        Return 0
    End
    If Self.CanvasGraphics[_canvasState] <> 0
        c25_GdipGetDC(Self.CanvasGraphics[_canvasState], Address(CanvasDC))
        Self.CanvasDC[_canvasState] = CanvasDC
    End
    Return Self.CanvasDC[_canvasState]


c25_TabRenderEngineClass.ReleaseDC                       Procedure(long _canvasState)   
    
CODE
        
    If _canvasState < 1 Or _canvasState > 16
        Return 0
    End    
    If Self.CanvasDC[_canvasState] <> 0
        c25_GdipReleaseDC(Self.CanvasGraphics[_canvasState], Self.CanvasDC[_canvasState])
    End
    Self.CanvasDC[_canvasState] = 0

c25_TabRenderEngineClass.Resize                         Procedure()


Code

    If Self.TabClass &= NULL
        Return 0
    END
    If Self.TabClass.ControlRect &= NULL
        return 0
    End
    Return 0    
    
   

c25_TabRenderEngineClass.Destruct                                   Procedure()

Code

    Dispose(Self.BitConverterClass)
    Dispose(Self.SqliteClass)
    Dispose(Self.NanoSync)


!c25_TabRenderEngineClass.WndProc_Process                            Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam, bool Processed, *long ReturnVal, <*bool PostProcess>)
!
!    Code
!        
!!    Case _message
!!    Of C25_Wm_Sizing
!!    OrOf C25_Wm_Size
!!        Self.ProgramHandlerClass.UpdateWindowRect()
!!        !Self.stLog.Append('WndProc_Process _message: ' & _message & '<13><10>')
!!        !Self.stLog.Append('Self.ProgramHandlerClass.WindowRect.Width : ' & Self.ProgramHandlerClass.WindowRect.Width & '<13><10>')
!!        !Self.stLog.Append('Self.ProgramHandlerClass.WindowRect.Height : ' & Self.ProgramHandlerClass.WindowRect.Height & '<13><10>')
!!        !Self.stLog.SaveFile(!Self.stLogFileName, true)
!!    End

c25_TabRenderEngineClass.GetColorMacro                              Procedure(<Byte _A>, <Byte _R>, <Byte _G>, <Byte _B>)

    Code

        Self.ColorARGB.A = _A
        Self.ColorARGB.B = _B
        Self.ColorARGB.G = _G
        Self.ColorARGB.R = _R
        Return Self.ColorOverARGB

c25_TabRenderEngineClass.DrawTabHeader                              Procedure(long _canvasState)

TabWidthTop                     long
TabWidth                        long
TabHeight                       long
CurveWidth                      long
CurveHeight                     long
TabHeightSideV                  Long
TabSearchBarWidth               long
TabSearchBarHeight              long
X0                              Long
Y0                              Long
StartX                          long
StartY                          long
X1                              Long
Y1                              Long
X2                              Long
Y2                              Long
TabCloseButtonRectLeft          Long
Graphics                       Long

CODE

    
    If Self.TabClass &= NULL
        Return 0
    END
    
    If Self.TabClass.ControlRect &= NULL
        Return 0
    End
    
    Graphics = Self.CanvasGraphics[_canvasState]

    !Self.GdiPlusClass.NewSolidBrush( ,Self.ProgramHandlerClass.TabHeaderColorDimmed)
    
    
    !Self.GdiPlusClass.FillRectangleI(Graphics, Self.GdiPlusClass.NewSolidBrush( , , 255, 255,255,255), 0, 0, Self.CanvasWidth[_canvasState], Self.CanvasHeight[_canvasState])
    Self.GdiPlusClass.FillRectangleI(Graphics, Self.GdiPlusClass.NewSolidBrush( , , 255, 255,255,255), 0, 0, Self.ProgramHandlerClass.WindowRect.Width, Self.ProgramHandlerClass.WindowRect.Height)
    
    If Self.TabHeaderIcon[_canvasState] = 0   
        Self.TabHeaderIconFilenameW[_canvasState] = Self.BitConverterClass.AnsiToUtf16Str('Home.ico',,true)
        C25_GdipLoadImageFromFile( Address(Self.TabHeaderIconFilenameW[_canvasState]) , Address(Self.TabHeaderIcon[_canvasState]))
        If Self.TabHeaderIcon[_canvasState] = 0 Or Self.TabHeaderIcon[_canvasState] = -1
            !Message('error loading file ')
            return 0
        End
    End

    If Self.TabHeaderFontFamily[_canvasState] = 0
        Self.TabHeaderFontFamilyNameW[_canvasState] = Self.BitConverterClass.AnsiToUtf16Str('Arial',,True)
        c25_GdipCreateFontFamilyFromName(Address(Self.TabHeaderFontFamilyNameW[_canvasState]), 0, Address(Self.TabHeaderFontFamily[_canvasState]))
        If Self.TabHeaderFontFamily[_canvasState] = 0
            !Message('error creating font family')
            return 0
        End
    End

!%FontStyleRegular = 0
!
!%FontStyleBold = 1
!
!%FontStyleItalic = 2
!
!%FontStyleBoldItalic = 3
!
!%FontStyleUnderline = 4
!
!%FontStyleStrikeout = 8    
    
    
    If Self.TabHeaderFont[_canvasState] = 0
        Self.TabHeaderFontSize[_canvasState] = 12
        c25_GdipCreateFont(Self.TabHeaderFontFamily[_canvasState], Self.TabHeaderFontSize[_canvasState], 1, 2, Address(Self.TabHeaderFont[_canvasState]))
        If Self.TabHeaderFont[_canvasState] = 0
            !Message('error create font')
            return 0
        End
    End
    If Self.TabHeaderStringFormat[_canvasState] = 0
        c25_GdipCreateStringFormat(StringFormatFlagsNoWrap, 0, Address(Self.TabHeaderStringFormat[_canvasState]))
        If Self.TabHeaderStringFormat[_canvasState] = 0
            return 0
        End
    End
    
    If Self.TabHeaderFontBrush[_canvasState] = 0
        Self.TabHeaderFontBrush[_canvasState] = Self.GdiPlusClass.NewSolidBrush(, , 255, 28, 28, 28)
    End
    
    If Self.TabBackdropBrush[_canvasState] = 0
        Case _canvasState
        Of CanvasState:Normal
            Self.TabBackdropBrush[_canvasState]     = Self.GdiPlusClass.NewSolidBrush( ,Self.ProgramHandlerClass.TabBackdropColorActive)
        Of CanvasState:NormalDimmed
            Self.TabBackdropBrush[_canvasState]     = Self.GdiPlusClass.NewSolidBrush( ,Self.ProgramHandlerClass.TabBackdropColorDimmed)
        End
    End
    If Self.TabHeaderBrush[_canvasState] = 0
        Case _canvasState
        Of CanvasState:Normal
            Self.TabHeaderBrush[_canvasState]     = Self.GdiPlusClass.NewSolidBrush( ,Self.ProgramHandlerClass.TabHeaderColorActive)
        Of CanvasState:NormalDimmed
            Self.TabHeaderBrush[_canvasState]     = Self.GdiPlusClass.NewSolidBrush( ,Self.ProgramHandlerClass.TabHeaderColorDimmed)
        End
    End
    
    c25_GdipFillRectangleI(Graphics, Self.TabBackdropBrush[_canvasState], 0, 0, Self.CanvasWidth[_canvasState], Self.ProgramHandlerClass.RibbonHeight)

    !C25_GdipFillPath(_canvasGraphic, Self.TabHeaderBackgroundBrush, Self.PathHandle)
    !return 0
    
    If Self.TabHeaderTitleWidthCalc = 0
        !-----------------------------------------------
        If not Self.TabHeaderTextTestW &= NULL
            Dispose(Self.TabHeaderTextTestW)
        End
        Self.TabHeaderTextTestW &= Self.BitConverterClass.BinaryCopy(Self.TabClass.TabHeaderTextW)
        
        Self.DrawStringRectF.Left      = 0
        Self.DrawStringRectF.Top       = 0
        Self.DrawStringRectF.Right     = 1000
        Self.DrawStringRectF.Bottom    = 100
        
        !https://referencesource.microsoft.com/#System.Drawing/commonui/System/Drawing/Advanced/Gdiplus.cs,2c96b9fc0470c478,references
        !GdipStringFormatGetGenericDefault
        !GdipStringFormatGetGenericTypographic
        
        If Self.TabHeaderStringFormatTest <> 0
            c25_GdipDeleteStringFormat(Self.TabHeaderStringFormatTest)
            Self.TabHeaderStringFormatTest = 0
        End
        
        c25_GdipCreateStringFormat(StringFormatFlagsNoWrap, 0, Address(Self.TabHeaderStringFormatTest))
        !C25_GdipMeasureString(Graphics, Address(Self.TabHeaderTextTestW), 5, Self.TabHeaderFont[_canvasState], Address(Self.DrawStringRectF), Self.TabHeaderStringFormat[_canvasState], Address(Self.MeasureStringOutRectF) , Address(Self.MeasureStringCodePointsFitted), 0)
        
        C25_GdipMeasureString(Graphics, Address(Self.TabHeaderTextTestW), -1, Self.TabHeaderFont[_canvasState], Address(Self.DrawStringRectF), Self.TabHeaderStringFormatTest, Address(Self.DrawStringRectF) , Address(Self.MeasureStringCodePointsFitted), 0)
        
        !Self.GdiPlusClass.SetRenderType(Graphics, GdiplusRenderType:Text)
        Self.TabHeaderTitleWidthCalc = Self.DrawStringRectF.Right - Self.DrawStringRectF.Left
        
        Self.TabHeaderTitleWidth = Self.TabHeaderTitleWidthCalc
        
        If Self.TabHeaderTitleWidthCalc < 180
            Self.TabHeaderTitleWidth = 180
        Else
            Self.TabHeaderTitleWidth = Self.TabHeaderTitleWidthCalc !+ 78
        End
        
        !Self.TabHeaderTitleWidth = Self.TabHeaderTitleWidthCalc
        !W# = Round(Self.WidthF,1)
        !-----------------------------------------------
        
        c25_GdipCreateStringFormat(StringFormatFlagsNoWrap, 0, Address(Self.TabHeaderStringFormat[_canvasState]))
        
        If not Self.TabHeaderTextW &= NULL
            Dispose(Self.TabHeaderTextW)
        End
        Self.TabHeaderTextW &= Self.BitConverterClass.BinaryCopy(Self.TabClass.TabHeaderTextW) ! todo crop etc
        
        !Self.TabHeaderTextW = Self.BitConverterClass.AnsiToUtf16Str('W#: ' & W# & ', ' & Clip(Format(Self.TabHeaderTitleWidthCalc[_canvasState],@N_5.2)) ,,True)
        
        Self.TabHeaderTitleRectF.Left      = 56
        Self.TabHeaderTitleRectF.Top       = 14
        Self.TabHeaderTitleRectF.Right     = 1000
        Self.TabHeaderTitleRectF.Bottom    = 100    

    End
    TabWidth = Self.TabHeaderTitleWidth
    
    

    TabSearchBarWidth   = Self.TabClass.ControlRect.Width
    TabSearchBarHeight  = 44

    CurveWidth  = 13
    CurveHeight = 13

    !TabWidth  = 223
    

    TabHeight = 14
    TabHeightSideV = 5
    TabWidthTop = TabWidth - (2 * CurveWidth)

    X0 = 4
    Y0 = 4

    X1 = X0 + CurveWidth
    Y1 = Y0

!    Self.SomeRect.Left     = 0
!    Self.SomeRect.Top      = 0
!    Self.SomeRect.Right    = 300
!    Self.SomeRect.Bottom   = 80
!
!    Self.GdiPlusClass.NewSolidBrush(Self.SolidFillHandle, , 255,50,50,50)

    !return 0
!    c25_GdipGetSmoothingMode(Graphics, Address(Self.CanvasSmoothingMode[_canvasState]))
!    If Self.CanvasSmoothingMode[_canvasState] <> 4
!        c25_GdipSetSmoothingMode(Graphics, 4)
!        !Self.stLog.SetValue('c25_GdipSetSmoothingMode' & '<13><10>')
!        !Self.stLog.SaveFile(!Self.stLogFileName, true)
!    End
    !Return 0 
    

    Self.GdiPlusClass.NewPen(Self.PenHandle,1,,255, 226, 230, 234)
    Self.GdiPlusClass.NewPath(Self.PathHandle)
    
    If Self.PathHandle = 0
        Message('error Self.PathHandle = 0')
    END
    
    
    

    X1 = X0 + CurveWidth
    Y1 = Y0

    C25_GdipAddPathArcI(Self.PathHandle, X1, Y1, CurveWidth, CurveHeight, -180, 90)

    X1 = X1 + CurveWidth
    Y1 = Y1

    X2 = X1 + TabWidthTop
    Y2 = Y1

    C25_GdipAddPathlineI(Self.PathHandle, X1, Y1, X2, Y2)

    X1 = X2
    Y1 = Y2
    TabCloseButtonRectLeft = X1 - 10
    C25_GdipAddPathArcI(Self.PathHandle, X1, Y1, CurveWidth, CurveHeight, -90, 90)

    X1 = X1 + CurveWidth
    Y1 = Y1 + CurveHeight

    X2 = X1
    Y2 = Y1 + TabHeightSideV

    C25_GdipAddPathlineI(Self.PathHandle, X1, Y1, X2, Y2)

    X1 = X2
    Y1 = Y2
    C25_GdipAddPathArcI(Self.PathHandle, X1, Y1, CurveWidth, CurveHeight, -180, -90)

    X1 = X1 + CurveWidth
    Y1 = Y1 + CurveHeight

    X2 = TabSearchBarWidth + 1
    Y2 = Y1

    C25_GdipAddPathlineI(Self.PathHandle, X1, Y1, X2, Y2)

    X1 = X2
    Y1 = Y2

    X2 = X1
    Y2 = Y1 + TabSearchBarHeight

    C25_GdipAddPathlineI(Self.PathHandle, X1, Y1, X2, Y2)

    X1 = X2
    Y1 = Y2

    X2 = -1
    Y2 = Y1

    C25_GdipAddPathlineI(Self.PathHandle, X1, Y1, X2, Y2)

    X1 = X2
    Y1 = Y2

    X2 = X1
    Y2 = Y1 - TabSearchBarHeight

    C25_GdipAddPathlineI(Self.PathHandle, X1, Y1, X2, Y2)

    X1 = X2
    Y1 = Y2

    X2 = X0
    Y2 = Y1

    C25_GdipAddPathlineI(Self.PathHandle, X1, Y1, X2, Y2)

    X1 = X2
    Y1 = Y2 - CurveHeight

    C25_GdipAddPathArcI(Self.PathHandle, X1, Y1, CurveWidth, CurveHeight, 90, -90)

    C25_GdipClosePathFigure(Self.PathHandle)

    C25_GdipFillPath(Graphics, Self.TabHeaderBrush[_canvasState], Self.PathHandle)
    
    Case _canvasState
    Of CanvasState:Normal
        Self.GdiPlusClass.NewPen(Self.PenHandle,1,,255, 193, 209, 220)
    Of CanvasState:NormalDimmed
        Self.GdiPlusClass.NewPen(Self.PenHandle,1,,255, 218, 218, 218)
    End
    c25_GdipDrawPath(Graphics, Self.PenHandle, Self.PathHandle)
    
    
!    GradientRect.Left       = 0
!    GradientRect.Top        = 0
!    GradientRect.Right      = _w
!    GradientRect.Bottom     = _h
!    
!    c25_GdipCreateLineBrushFromRectI(Address(GradientRect), Self.GetColorMacro(255,210,Random(100,255),210), Self.GetColorMacro(255,210,Random(100,255),210), LinearGradientMode:Vertical, 0, Address(LinearGradientBrush ))
!    c25_GdipFillRectangleI(Graphics, LinearGradientBrush, 0, 0, _w, _h)    

    

    
    Self.GdiPlusClass.NewPen(Self.TabCloseButtonPen,1,,255, 56, 55, 55)
    
    Self.TabCloseButtonRect.Left        = TabWidth - 1
    Self.TabCloseButtonRect.Right       = Self.TabCloseButtonRect.Left + 7
    Self.TabCloseButtonRect.Top         = 14
    Self.TabCloseButtonRect.Bottom      = Self.TabCloseButtonRect.Top + 7
    
    c25_GdipDrawLineI(Graphics, Self.TabCloseButtonPen, Self.TabCloseButtonRect.Left, Self.TabCloseButtonRect.Top,  Self.TabCloseButtonRect.Right, Self.TabCloseButtonRect.Bottom)
    c25_GdipDrawLineI(Graphics, Self.TabCloseButtonPen, Self.TabCloseButtonRect.Left, Self.TabCloseButtonRect.Bottom,  Self.TabCloseButtonRect.Right, Self.TabCloseButtonRect.Top)
    

    C25_GdipResetPath(Self.PathHandle)

    X1 = X0 + CurveWidth
    Y1 = Y0

    X1 = X1 + CurveWidth - 5
    Y1 = Y1

    X2 = X1 + TabWidthTop + 10
    Y2 = Y1

    C25_GdipAddPathlineI(Self.PathHandle, X1, Y1, X2, Y2)

    c25_GdipsetPenColor(Self.PenHandle, Self.GetColorMacro(255, 234,234,234))
    c25_GdipDrawPath(Graphics, Self.PenHandle, Self.PathHandle)

    If Self.TabHeaderIcon[_canvasState] <> 0
        !C25_GdipDrawImageRectI(Graphics, Self.TabHeaderIcon[_canvasState], 26, 0, 31,31)
        C25_GdipDrawImageRectI(Graphics, Self.TabHeaderIcon[_canvasState], 26, 12, 16,16)
    End

    
    C25_GdipResetPath(Self.PathHandle)
    
    ! bar
    X1 = 0
    Y1 = Self.ProgramHandlerClass.RibbonHeight + Self.ProgramHandlerClass.RibbonShortCutBarHeight

    X2 = Self.TabClass.ControlRect.Width !Self.ProgramHandlerClass.WindowRect.Width
    Y2 = Self.ProgramHandlerClass.RibbonHeight + Self.ProgramHandlerClass.RibbonShortCutBarHeight

    c25_GdipsetPenColor(Self.PenHandle, Self.GetColorMacro(255, 214,214,214))
    C25_GdipAddPathlineI(Self.PathHandle, X1, Y1, X2, Y2)
    c25_GdipDrawPath(Graphics, Self.PenHandle, Self.PathHandle)
!    
!    If not Self.TabHeaderStringW &= NULL
!        Dispose(Self.TabHeaderStringW)
!    End
!    If not Self.TabHeaderIconFilenameW &= NULL
!        Dispose(Self.TabHeaderIconFilenameW)
!    End
    
    
    c25_GdipDrawString(Graphics, Address(Self.TabHeaderTextW),-1, Self.TabHeaderFont[_canvasState], Address(Self.TabHeaderTitleRectF), Self.TabHeaderStringFormat[_canvasState] , Self.TabHeaderFontBrush[_canvasState])
    
    
    
    
    
    Return 0
