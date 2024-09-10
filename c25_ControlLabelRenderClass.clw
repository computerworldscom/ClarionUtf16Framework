                        Member

                        Include('c25_ControlLabelRenderClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                        End


c25_ControlLabelRenderClass.Construct                                   Procedure()

!ClassTypeName cstring(128)
!ClassStarter   &c25_ClassStarter

Code

!    ClassTypeName = 'c25_ControlLabelRenderClass'
!
!    ClassStarter &= NEW c25_ClassStarter()
!    Self.ProgramHandlerClass &= (ClassStarter.Start(ClassTypeName))
!    Dispose(ClassStarter)
!    
!    !Self.GdiPlusClass &= NEW c25_GdiPlusClass()
!    !Self.GdiPlusClass &= Self.ProgramHandlerClass.GdiPlusClass
!    Self.GdiPlusClass &= NEW c25_GdiPlusClass()
!    
!    Self.SomeRectF &= NEW RectF_TYPE()
!    Self.SomeRectI &= NEW RectI_TYPE()
!
!    !Self.stLog &= NEW StringTheory()
!    !Self.stLogFileName = 'm:\c25_ControlLabelRenderClass.txt'
!    Remove(!Self.stLogFileName)
!    !Self.stLog.SetValue('c25_ControlLabelRenderClass.Construct' & '<13><10>')
!    !Self.stLog.SaveFile(!Self.stLogFileName, true)
    

c25_ControlLabelRenderClass.Destruct                                    Procedure()

Code


    
    
    
    
c25_ControlLabelRenderClass.Init                                        Procedure(*c25_ControlLabelClass _controlLabelClass)
    
CODE
        
        
    Self.ControlLabelClass &= _controlLabelClass
    Self.ProgramHandlerClass &= Self.ControlLabelClass.ProgramHandlerClass
    !Self.BitConverterClass &= Self.ControlButtonClass.BitConverterClass
    !Self.BitConverterClass &= Self.ControlButtonClass.BitConverterClass
    Self.GdiPlusClass &= NEW c25_GdiPlusClass()
    
    Self.SomeRectF &= NEW RectF_TYPE()
    Self.SomeRectI &= NEW RectI_TYPE()

    !Self.GdiPlusClass &= Self.ProgramHandlerClass.GdiPlusClass
    return 0
    
    
c25_ControlLabelRenderClass.Paint                                       Procedure(long _canvasState)

TabControlContainer   &c25_TabClass

Code


    If Self.ControlLabelClass &= NULL
        !Self.stLog.SetValue('self.ControlLabelClass &= NULL' & '<13><10>')
        !Self.stLog.SaveFile(!Self.stLogFileName, true)        
        Return 0
    END
    
    If Self.ControlLabelClass.BaseControl &= NULL
        !Self.stLog.SetValue('If Self.ControlLabelClass.BaseControl &= NULL' & '<13><10>')
        !Self.stLog.SaveFile(!Self.stLogFileName, true)         
        Return 0
    End
    
    Case Self.ControlLabelClass.BaseControl.ContainerType
    Of ContainerType:TabClass
    
        If Self.ControlLabelClass.BaseControl.ContainerClassPtr = 0 ! .TabControlContainer &= NULL
            !Self.stLog.SetValue('If Self.ControlLabelClass.BaseControl.ContainerClassPtr = 0' & '<13><10>')
            !Self.stLog.SaveFile(!Self.stLogFileName, true)          
            Return 0
        End
        
        TabControlContainer &= (Self.ControlLabelClass.BaseControl.ContainerClassPtr)
        
        If TabControlContainer.TabRenderEngineClass &= NULL
            !Self.stLog.SetValue('If Self.ControlLabelClass.BaseControl.TabControlContainer.TabRenderEngineClass &= NULL' & '<13><10>')
            !Self.stLog.SaveFile(!Self.stLogFileName, true)           
            Return 0
        End
        
        If TabControlContainer.TabRenderEngineClass.CanvasGraphics[_canvasState] = 0
            !Self.stLog.SetValue('Self.ControlLabelClass.BaseControl.TabControlContainer.TabRenderEngineClass.CanvasGraphics[CanvasState:Buffer] = 0' & '<13><10>')
            !Self.stLog.SaveFile(!Self.stLogFileName, true)           
            Return 0
        Else
            !Self.stLog.SetValue('Self.ControlLabelClass.BaseControl.TabControlContainer.TabRenderEngineClass.CanvasGraphics[CanvasState:Buffer] ; ' & TabControlContainer.TabRenderEngineClass.CanvasGraphics[_canvasState] & '<13><10>')
            !Self.stLog.SaveFile(!Self.stLogFileName, true)   
        End
        
        Self.Graphics = TabControlContainer.TabRenderEngineClass.CanvasGraphics[_canvasState]
     
    
        !Self.SomeBrush = Self.GdiPlusClass.NewSolidBrush( , , 25,0,0,0)
        Self.GdiPlusClass.NewSolidBrush(Self.SomeBrush, , 55,0,0,100)
        If Self.SomeBrush = 0
            Message('error Self.SomeBrush = 0')
        End
        !Self.SomeBrush = Self.ProgramHandlerClass.GdiPlusClass.GetSolidBrush( ,25,0,0,0)
        
        
    !    Self.ControlLabelClass.BaseControl.X = 20
    !    Self.ControlLabelClass.BaseControl.Y = 20
    !    Self.ControlLabelClass.BaseControl.Width = 300
    !    Self.ControlLabelClass.BaseControl.Height = 60
        
        Self.SomeRectF.Left     = Self.ControlLabelClass.BaseControl.ControlRect.Left
        Self.SomeRectF.Top      = Self.ControlLabelClass.BaseControl.ControlRect.Top
        Self.SomeRectF.Right    = Self.ControlLabelClass.BaseControl.ControlRect.Right
        Self.SomeRectF.Bottom   = Self.ControlLabelClass.BaseControl.ControlRect.Bottom

        Self.SomeRectI.Left     = Self.ControlLabelClass.BaseControl.ControlRect.Left
        Self.SomeRectI.Top      = Self.ControlLabelClass.BaseControl.ControlRect.Top
        Self.SomeRectI.Right    = Self.ControlLabelClass.BaseControl.ControlRect.Right
        Self.SomeRectI.Bottom   = Self.ControlLabelClass.BaseControl.ControlRect.Bottom
        Self.SomeRectI.Width    = Self.ControlLabelClass.BaseControl.ControlRect.Width
        Self.SomeRectI.Height   = Self.ControlLabelClass.BaseControl.ControlRect.Height
        
        Self.ProgramHandlerClass.GdiPlusClass.CalcRectI_WH(Self.SomeRectI)
        
        c25_GdipFillRectangleI(Self.Graphics, Self.SomeBrush, 0, 0, Self.SomeRectI.Width, Self.SomeRectI.Height)
        
        !Message('Self.ControlLabelClass.BaseControl.TabControlContainer.TabRenderEngineClass.CanvasGraphics[CanvasState:Normal] ' & Self.ControlLabelClass.BaseControl.TabControlContainer.TabRenderEngineClass.CanvasGraphics[CanvasState:Normal])
    END
    
    Return 0