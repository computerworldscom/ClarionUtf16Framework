                        Member

                        Include('c25_ControlButtonRenderClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                        End


c25_ControlButtonRenderClass.Construct                                   Procedure()

!ClassTypeName cstring(128)
!ClassStarter   &c25_ClassStarter

Code

!    ClassTypeName = 'c25_ControlButtonRenderClass'
!
!    ClassStarter &= NEW c25_ClassStarter()
!    Self.ProgramHandlerClass &= (ClassStarter.Start(ClassTypeName))
!    Dispose(ClassStarter)
!    
!    Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlButtonRenderClass.Construct - START')
!    
    Self.GdiPlusClass &= NEW c25_GdiPlusClass()
    
    Self.BitConverterClass &= NEW c25_BitConverterClass()
    
!    Self.SomeRectF &= NEW RectF_TYPE()
!    Self.SomeRectI &= NEW RectI_TYPE()
!    Self.DrawStringRectF &= NEW RectF_TYPE()
!    Self.DrawStringRectCalcF &= NEW RectF_TYPE()
!    Self.TextTitleRectF  &= NEW RectF_TYPE()
    
!    !Self.stLog &= NEW StringTheory()
!    !Self.stLogFileName = 'm:\c25_ControlButtonRenderClass.txt'
!    Remove(!Self.stLogFileName)
!    !Self.stLog.SetValue('c25_ControlButtonRenderClass.Construct' & '<13><10>')
!    !Self.stLog.SaveFile(!Self.stLogFileName, true)
    !Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlButtonRenderClass.Construct - END')

c25_ControlButtonRenderClass.Destruct                                    Procedure()

Code

c25_ControlButtonRenderClass.Init                                    Procedure(*c25_ControlButtonClass _controlButton)

Code

    Self.ControlButtonClass &= _controlButton
    Self.ProgramHandlerClass &= Self.ControlButtonClass.ProgramHandlerClass
    !Self.BitConverterClass &= Self.ControlButtonClass.BitConverterClass
    !Self.GdiPlusClass &= NEW c25_GdiPlusClass()
    !Self.GdiPlusClass &= Self.ProgramHandlerClass.GdiPlusClass
    
    Self.SomeRectF &= NEW RectF_TYPE()
    Self.SomeRectI &= NEW RectI_TYPE()
    Self.DrawStringRectF &= NEW RectF_TYPE()
    Self.DrawStringRectCalcF &= NEW RectF_TYPE()
    Self.TextTitleRectF  &= NEW RectF_TYPE()    
    return 0
    
    
c25_ControlButtonRenderClass.Paint                                       Procedure(long _canvasState)

TabControlContainer   &c25_TabClass

Code

    If Self.ProgramHandlerClass &= NULL
        Return 0
    End
    
    If Self.ControlButtonClass &= NULL
        Return 0
    END
    
!    If Self.ProgramHandlerClass &= NULL
!        Self.ProgramHandlerClass &= Self.ControlButtonClass.ProgramHandlerClass
!    END
!    If Self.BitConverterClass &= NULL
!        Self.BitConverterClass &= Self.ControlButtonClass.BitConverterClass
!    End
!    If Self.GdiPlusClass &= null
!        Self.GdiPlusClass &= NEW c25_GdiPlusClass()
!    End
    
    Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlButtonRenderClass.Paint - START')

    If _canvasState < 1 Or _canvasState > 16
        Return 0
    End
    
    If Self.ControlButtonClass &= NULL
        Return 0
    End
    If Self.ControlButtonClass.State < 1 Or Self.ControlButtonClass.State > 15
        Return 0
    End    
    If Self.ControlButtonClass.BaseControl &= NULL
        Return 0
    End
    
    Case Self.ControlButtonClass.BaseControl.ContainerType
    Of ContainerType:TabClass
        If Self.ControlButtonClass.BaseControl.ContainerClassPtr = 0
            Return 0
        End
        TabControlContainer &= (Self.ControlButtonClass.BaseControl.ContainerClassPtr)
        If TabControlContainer.TabRenderEngineClass &= NULL
            Return 0
        End
        If TabControlContainer.TabRenderEngineClass.CanvasGraphics[_canvasState] = 0
            Return 0
        End
        Self.Graphics = TabControlContainer.TabRenderEngineClass.CanvasGraphics[_canvasState]
        If Self.Graphics = 0
            Return 0
        End
    End
    If Self.IconHandle[_canvasState, Self.ControlButtonClass.State] = 0
        Case Self.ControlButtonClass.State
        Of ButtonState:Normal
            Case _canvasState
            Of CanvasState:Normal
            OrOf CanvasState:NormalDimmed
                
                Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlButtonRenderClass.Paint - C25_GdipLoadImageFromFile CanvasState:NormalDimmed - START')
                C25_GdipLoadImageFromFile(Address(Self.ControlButtonClass.IconFileName_Normal), Address(Self.IconHandle[_canvasState, Self.ControlButtonClass.State]))
                Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlButtonRenderClass.Paint - C25_GdipLoadImageFromFile CanvasState:NormalDimmed - END')
            End
        Of ButtonState:Hot
            Case _canvasState
            Of CanvasState:Normal
                Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlButtonRenderClass.Paint - C25_GdipLoadImageFromFile CanvasState:Normal - START')
                C25_GdipLoadImageFromFile(Address(Self.ControlButtonClass.IconFileName_Hot), Address(Self.IconHandle[_canvasState, Self.ControlButtonClass.State]))
                Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlButtonRenderClass.Paint - C25_GdipLoadImageFromFile CanvasState:Normal - END')
            Of CanvasState:NormalDimmed
                Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlButtonRenderClass.Paint - C25_GdipLoadImageFromFile CanvasState:NormalDimmed - START')
                C25_GdipLoadImageFromFile(Address(Self.ControlButtonClass.IconFileName_HotDimmed), Address(Self.IconHandle[_canvasState, Self.ControlButtonClass.State]))
                Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlButtonRenderClass.Paint - C25_GdipLoadImageFromFile CanvasState:NormalDimmed - END')
            End
        End
        If Self.IconHandle[_canvasState, Self.ControlButtonClass.State] = 0 Or Self.IconHandle[_canvasState, Self.ControlButtonClass.State] = -1
            
        End
    End
   
    If Self.TextFontFamily[Self.ControlButtonClass.State] = 0
        Self.TextFontFamilyNameW[Self.ControlButtonClass.State] = Self.BitConverterClass.AnsiToUtf16Str('Arial',,True)
        c25_GdipCreateFontFamilyFromName(Address(Self.TextFontFamilyNameW[Self.ControlButtonClass.State]), 0, Address(Self.TextFontFamily[Self.ControlButtonClass.State]))
        If Self.TextFontFamily[Self.ControlButtonClass.State] = 0
            Message('error creating font family')
        End
    End

    If Self.TextFont[Self.ControlButtonClass.State] = 0
        Self.TextFontSize[Self.ControlButtonClass.State] = 12
        c25_GdipCreateFont(Self.TextFontFamily[Self.ControlButtonClass.State], Self.TextFontSize[Self.ControlButtonClass.State], 0, 2, Address(Self.TextFont[Self.ControlButtonClass.State]))
        If Self.TextFont[Self.ControlButtonClass.State] = 0
            Message('error create font')
        End
    End
    If Self.TextStringFormat[Self.ControlButtonClass.State] = 0
        c25_GdipCreateStringFormat(StringFormatFlagsNoWrap, 0, Address(Self.TextStringFormat[Self.ControlButtonClass.State]))
    End

    If Self.TextFontBrush[Self.ControlButtonClass.State] = 0
        Self.TextFontBrush[Self.ControlButtonClass.State] = Self.GdiPlusClass.NewSolidBrush(, , 255, 28, 28, 28)
    End

    Self.SomeRectF.Left     = Self.ControlButtonClass.BaseControl.ControlRect.Left
    Self.SomeRectF.Top      = Self.ControlButtonClass.BaseControl.ControlRect.Top
    Self.SomeRectF.Right    = Self.ControlButtonClass.BaseControl.ControlRect.Right
    Self.SomeRectF.Bottom   = Self.ControlButtonClass.BaseControl.ControlRect.Bottom

    Self.SomeRectI.Left     = Self.ControlButtonClass.BaseControl.ControlRect.Left
    Self.SomeRectI.Top      = Self.ControlButtonClass.BaseControl.ControlRect.Top
    Self.SomeRectI.Right    = Self.ControlButtonClass.BaseControl.ControlRect.Right
    Self.SomeRectI.Bottom   = Self.ControlButtonClass.BaseControl.ControlRect.Bottom
    Self.SomeRectI.Width    = Self.ControlButtonClass.BaseControl.ControlRect.Width
    Self.SomeRectI.Height   = Self.ControlButtonClass.BaseControl.ControlRect.Height

    Self.ProgramHandlerClass.GdiPlusClass.CalcRectI_WH(Self.SomeRectI)

    If Self.TextTitleWidthCalc = 0 Or Self.TextTextW <> Self.ControlButtonClass.TextW Or Self.ControlButtonClass.ForceRedraw
        Self.ControlButtonClass.ForceRedraw = 0
        If not Self.TextTextTestW &= NULL
            Dispose(Self.TextTextTestW)
        End
        Self.TextTextTestW &= Self.BitConverterClass.BinaryCopy(Self.ControlButtonClass.TextW)

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
        C25_GdipMeasureString(Self.Graphics, Address(Self.TextTextTestW), -1, Self.TextFont[Self.ControlButtonClass.State], Address(Self.DrawStringRectF), Self.TextStringFormatTest, Address(Self.DrawStringRectCalcF) , Address(Self.MeasureStringCodePointsFitted), 0)

        Self.TextTitleWidthCalc = Self.DrawStringRectCalcF.Right - Self.DrawStringRectCalcF.Left

        !Self.stLog.SetValue('Self.TextTitleWidthCalc: ' & Self.TextTitleWidthCalc & '<13><10>')
        !Self.stLog.SaveFile(!Self.stLogFileName, true)

        Self.TextTitleWidth = Self.TextTitleWidthCalc

        If Self.TextTitleWidthCalc < 300
            Self.TextTitleWidth = 300
        Else
            Self.TextTitleWidth = Self.TextTitleWidthCalc + 78
        End

        c25_GdipCreateStringFormat(StringFormatFlagsNoWrap, 0, Address(Self.TextStringFormat[Self.ControlButtonClass.State]))

        If not Self.TextTextW &= NULL
            Dispose(Self.TextTextW)
        End
        Self.TextTextW &= Self.BitConverterClass.BinaryCopy(Self.ControlButtonClass.TextW)

    End

    Self.GdiPlusClass.NewSolidBrush(Self.SomeBrush,Self.ProgramHandlerClass.ThemeManagerClass.GetBackgroundColor(ControlType:Button, Self.ControlButtonClass.BaseControl.Name, Self.ControlButtonClass.State))

    If Self.SomeBrush = 0
    End

    Self.TextTitleRectF = Self.SomeRectF

    c25_GdipFillRectangleI(Self.Graphics, Self.SomeBrush, Self.SomeRectI.Left, Self.SomeRectI.Top, Self.SomeRectI.Width, Self.SomeRectI.Height)

    If Self.IconHandle[_canvasState, Self.ControlButtonClass.State] <> 0
        C25_GdipDrawImageRectI(Self.Graphics, Self.IconHandle[_canvasState, Self.ControlButtonClass.State], Self.SomeRectI.Left, Self.SomeRectI.Top, Self.SomeRectI.Width, Self.SomeRectI.Height)
    Else
        If Self.IconHandle[1, 1] <> 0
            C25_GdipDrawImageRectI(Self.Graphics, Self.IconHandle[1, 1], Self.SomeRectI.Left, Self.SomeRectI.Top, Self.SomeRectI.Width, Self.SomeRectI.Height)
        End
    End

    c25_GdipDrawString(Self.Graphics, Address(Self.TextTextW),-1, Self.TextFont[Self.ControlButtonClass.State], Address(Self.TextTitleRectF), Self.TextStringFormat[Self.ControlButtonClass.State] , Self.TextFontBrush[Self.ControlButtonClass.State])

    
    Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlButtonRenderClass.Paint - END')
    
    Return 0
