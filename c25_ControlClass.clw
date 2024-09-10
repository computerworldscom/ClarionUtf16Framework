                        Member

                        Include('c25_ControlClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                        End


c25_ControlClass.Construct                                  Procedure()

!ClassTypeName   cstring(128)
!ClassStarter   &c25_ClassStarter

Code

!    ClassTypeName = 'c25_ControlClass'
!
!    ClassStarter &= NEW c25_ClassStarter()
!    Self.ProgramHandlerClass &= (ClassStarter.Start(ClassTypeName))
!    Dispose(ClassStarter)
!    
    
    !Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlClass.Construct - START')
    
    
    Self.BitConverterClass &= NEW c25_BitConverterClass()
    
    Self.ControlRect &= NEW WindowRect_TYPE()
    Self.LastControlRect &= NEW WindowRect_TYPE()
    
!    Self.ControlRenderClass &= NEW c25_ControlRendererClass()
    
!    Self.MessageOnlyWindowClass &= NEW c25_MessageOnlyWindowClass()
!    Self.MessageOnlyWindowClass.InitWindow(c25ClassTypes:ControlClass , Address(Self))
!    Self.MessageOnlyWindowClass.OpenWindow()
    
    
    
    
    !Self.StLog              &= NEW StringTheory()
    !Self.StLogFileName      = 'm:\c25_ControlClass.txt'
    !Remove(!Self.StLogFileName)
    !Self.StLog.SetValue('c25_ControlClass.Construct' & '<13><10>')
    !Self.StLog.SaveFile(!Self.StLogFileName, true)
    !Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlClass.Construct - START')




c25_ControlClass.Destruct                                  Procedure()

Code


c25_ControlClass.Init                                      Procedure(long _containerPtr, long _containerType, <string _name>, <long _controlType>, <long _left>, <long _top>, <long _right>, <long _bottom>, <long _width>, <long _height>)

ControlTreeViewClass    &c25_ControlTreeViewClass
ControlLabelClass       &c25_ControlLabelClass
ControlButtonClass      &c25_ControlButtonClass

Code

    
    
    !SetClipboard(Self.ControlRect.Left & ',' &  Self.ControlRect.Top & ',' &  Self.ControlRect.Width & ',' &  Self.ControlRect.Height)
    
!    !Self.StLogFileName                      = 'm:\c25_ControlClass' & Self.Name & '.txt'
!    Remove(!Self.StLogFileName)
!    !Self.StLog.SetValue('INIT' & '<13><10>')
!    !Self.StLog.SaveFile(!Self.StLogFileName)
    
    Self.ContainerClassPtr = _containerPtr
    Self.ContainerType = _containerType
    
    
    Case Self.ContainerType
    Of ContainerType:WindowClass
        !Message('ContainerType:Window, not yet implemented in c25_ControlClass.Init ')
        !Self.TabControlContainer &= (Self.ContainerClassPtr)
    Of ContainerType:TabClass
        If Self.ContainerTabClass &= null
            Self.ContainerTabClass &= (Self.ContainerClassPtr)
            Self.ProgramHandlerClass &= Self.ContainerTabClass.ProgramHandlerClass
            If not Self.ProgramHandlerClass &= null
                Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlClass.Init - START')
            END
        End
        !Self.TabControlContainer &= (Self.ContainerClassPtr)
    End
    
    
    If omitted(_name) = False
        Self.Name &= Self.BitConverterClass.BinaryCopy(_name)
    End
    If omitted(_controlType) = False
        Self.TypeEnum = _controlType
    End
    If omitted(_left) = False And omitted(_top) = False And omitted(_right) = False And omitted(_bottom) = False
        Self.ControlRect.Left       = _left
        Self.ControlRect.Top        = _top
        Self.ControlRect.Right      = _right
        Self.ControlRect.Bottom     = _bottom
        Self.ControlRect.Width      = Self.ControlRect.Right + Self.ControlRect.Left
        Self.ControlRect.Height     = Self.ControlRect.Top + Self.ControlRect.Height
    ElsIf omitted(_left) = False And omitted(_top) = False And omitted(_width) = False And omitted(_height) = False
        Self.ControlRect.Left       = _left
        Self.ControlRect.Top        = _top
        Self.ControlRect.Width      = _width
        Self.ControlRect.Height     = _height  
        Self.ControlRect.Right      = Self.ControlRect.Left + Self.ControlRect.Width
        Self.ControlRect.Bottom     = Self.ControlRect.Top + Self.ControlRect.Height        
    End
    
    

    !Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlClass.Init - START Self.SetSize')
    Self.SetSize(Self.ControlRect.Left, Self.ControlRect.Top, Self.ControlRect.Right, Self.ControlRect.Bottom)
    !Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlClass.Init - END Self.SetSize')
    
    !Message(1)
    Case Self.TypeEnum
    Of ControlType:Button
        Self.ProgramHandlerClass.RootLog.WriteLog('ControlButtonClass &= NEW c25_ControlButtonClass() - START')
        ControlButtonClass                     &= NEW c25_ControlButtonClass()
        ControlButtonClass.Init(self)
        Self.ClassPtr                           = Address(ControlButtonClass)
        Self.ProgramHandlerClass.RootLog.WriteLog('ControlButtonClass.Init()  - END')
    Of ControlType:Label
        ControlLabelClass                       &= NEW c25_ControlLabelClass()
        ControlLabelClass.Init(self)
        Self.ClassPtr                           = Address(ControlLabelClass)
        
    Of ControlType:TreeView
        ControlTreeViewClass                    &= NEW c25_ControlTreeViewClass()
        ControlTreeViewClass.Init(self)
        Self.ClassPtr                           = Address(ControlTreeViewClass)
    End
    

    
    Self.ProgramHandlerClass.RootLog.WriteLog('Self.ControlRenderClass &= NEW c25_ControlRendererClass()  - START')
    
    Self.ControlRenderClass &= NEW c25_ControlRendererClass()
    
    Self.ProgramHandlerClass.RootLog.WriteLog('Self.ControlRenderClass.Init(Self)  - START')
    
    Self.ControlRenderClass.Init(Self)
    
    Self.ProgramHandlerClass.RootLog.WriteLog('Self.ControlRenderClass.Init(Self)  - END')
    
    Return 0
    
    
c25_ControlClass.SetSize                                Procedure(long _left, long _top, long _right, long _bottom)

CODE
        
    Self.ControlRect.Left                    = _left
    Self.ControlRect.Top                     = _top
    Self.ControlRect.Right                   = _right
    Self.ControlRect.Bottom                  = _bottom
    
    Self.ControlRect.Width                   = Self.ControlRect.Right - Self.ControlRect.Left
    Self.ControlRect.Height                  = Self.ControlRect.Bottom   - Self.ControlRect.Top
    
    If Self.ControlRect <> Self.LastControlRect
        Self.ControlRectChanged = TRUE
        Self.LastControlRect = Self.ControlRect
    End
    
        
    Return 0
    
c25_ControlClass.Paint                                Procedure(long _canvasState)

!TreeViewClass           &c25_TreeViewClass
ControlTreeViewClass    &c25_ControlTreeViewClass
ControlButtonClass      &c25_ControlButtonClass
ControlLabelClass       &c25_ControlLabelClass

CODE
        
    If Self.ClassPtr = 0
        Return 0
    End
    
    
    Case Self.TypeEnum
    Of ControlType:Button
        ControlButtonClass                       &= (Self.ClassPtr)
        ControlButtonClass.Paint(_canvasState)
        ControlButtonClass &= null    
    Of ControlType:Label
        ControlLabelClass                       &= (Self.ClassPtr)
        ControlLabelClass.Paint(_canvasState)
        ControlLabelClass &= null
    Of ControlType:TreeView
        ControlTreeViewClass                           &= (Self.ClassPtr)
        ControlTreeViewClass.Paint(_canvasState)
        ControlTreeViewClass &= null
    End
        
    Return 0
    
    
c25_ControlClass.WndProc_Process                                    Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam, bool Processed, *long ReturnVal, <*bool PostProcess>)

ControlTreeViewClass    &c25_ControlTreeViewClass
ControlButtonClass      &c25_ControlButtonClass
ControlLabelClass       &c25_ControlLabelClass

Code
        
!    If not !Self.StLog &= null
!        !Self.StLog.SetValue('c25_ControlClass.WndProc_Process ' & _message & '<13><10>')
!        !Self.StLog.SaveFile(!Self.StLogFileName, true)    
!    END
    
    Case _message
    Of C25_Wm_Sizing
    OrOf C25_Wm_Size
    OrOf C25_Wm_Input
        Case Self.TypeEnum
        Of ControlType:TreeView
            ControlTreeViewClass &= (Self.ClassPtr)
            ControlTreeViewClass.Resize()
            ControlTreeViewClass.WinMes = 'C25_Wm_Input'
            ControlTreeViewClass &= null
            
!            If not !Self.StLog &= null
!                !Self.StLog.SetValue('c25_ControlClass.WndProc_Process done resize treeview' & '<13><10>')
!                !Self.StLog.SaveFile(!Self.StLogFileName, true)    
!            END            
        END
        
        
!        ControlTreeViewClass                    &= NEW c25_ControlTreeViewClass()
!        ControlTreeViewClass.BaseControl        &= Self
!        Self.ClassPtr                           = Address(ControlTreeViewClass)
!        ControlTreeViewClass.Init()
    Of C25_Wm_Mousemove
!        Self.DesktopMouseXY = _lParam
!        If Self.LastDesktopMouseXY <> Self.DesktopMouseXY !and 1 > 2
!            !!Self.StLog.SaveFile(!Self.StLogFileName)
!            !Self.StLog.Start()
!            !Self.StLog.Append('Self.LastDesktopMouseXY : '       & Self.LastDesktopMouseXY & '<13><10>')
!            !Self.StLog.SaveFile(!Self.StLogFileName, true)
!            
!            Self.LastDesktopMouseXY = Self.DesktopMouseXY
!            Self.MouseMoved = TRUE
!
!            If Self.ProgramHandlerClass.WindowHandle <> 0
!
!                Self.ProgramHandlerClass.DC = C25_GetWindowDC(Self.ProgramHandlerClass.WindowHandle)
!                c25_GdipCreateFromHDC(Self.ProgramHandlerClass.DC ,Address(Self.PaintGraphics))
!
!!                Self.ProgramHandlerClass.WindowRect = Self.ProgramHandlerClass.WinApiClass.GetWindowRect( Self.ProgramHandlerClass.WindowHandle)
!!                Self.UpdateLayout() !Self.ThisControl, Self.ProgramHandlerClass.WindowRect)
!!                
!!                If Self.PaintPages.Normal_Graphics <> 0
!!                    Self.ResetPaintPages()
!!                    Self.RenderPages() !Self.PaintPages.Normal_Graphics, Self.ThisControl)
!!                End
!                If Self.CanvasImagePtr <> 0 And Self.ThisControl.ControlRect.Width > 0
!                    Self.GdiPlusClass.DrawImageRectRectI(Self.PaintGraphics, Self.CanvasImagePtr, Self.ThisControl.ControlRect.Left, Self.ThisControl.ControlRect.Top, Self.ThisControl.ControlRect.Width, Self.ThisControl.ControlRect.Height, | &
!                    0,      | &
!                    0,       | &
!                    Self.ThisControl.ControlRect.Width,     | &
!                    Self.ThisControl.ControlRect.Height,    | &
!                    UnitPixel,  | &
!                    0,  | &
!                    0,  | &
!                    0)
!                End
!                
!!        Self.GdiPlusClass.DrawImageRectRectI(_graphics, Self.PaintPages.Normal_ImagePtr, Control.Left, Control.Top, Control.Width, Control.Height, | &
!!        Self.PaintPages.Crop_Left,      | &
!!        Self.PaintPages.Crop_Top,       | &
!!        Self.PaintPages.Crop_Width-1,     | &
!!        Self.PaintPages.Crop_Height-1,    | &
!!        UnitPixel,  | &
!!        0,  | &
!!        0,  | &
!!        0)                
!
!                c25_GdipDeleteGraphics(Self.PaintGraphics)
!
!                c25_ReleaseDC(Self.ProgramHandlerClass.WindowHandle, Self.ProgramHandlerClass.DC)
!
!            End
!
!        ELSE
!            Self.MouseMoved = 0
!        End

    END
