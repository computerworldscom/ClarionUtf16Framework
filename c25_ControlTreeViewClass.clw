                        Member

                        Include('c25_ControlTreeViewClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                        End


c25_ControlTreeViewClass.Construct                                  Procedure()

!ClassTypeName cstring(128)
!ClassStarter   &c25_ClassStarter

Code

!    ClassTypeName = 'c25_ControlTreeViewClass'
!
!    ClassStarter &= NEW c25_ClassStarter()
!    Self.ProgramHandlerClass &= (ClassStarter.Start(ClassTypeName))
!    Dispose(ClassStarter)
    Self.BitConverterClass &= NEW c25_BitConverterClass()
    
    Self.DataControlStyleClass &= NEW c25_DataControlStyleClass()

    
!    Self.ControlTreeViewRenderClass &= NEW c25_ControlTreeViewRenderClass()
!    Self.ControlTreeViewRenderClass.ControlTreeViewClass &= Self
!    
!    Self.BindingSourceClass &= NEW c25_BindingSourceClass()
    
    Self.CurrentPageNo = 1
    Self.TextW &= NEW String(2)
    Self.TextW = Chr(0) & Chr(0)

c25_ControlTreeViewClass.Destruct                                  Procedure()

Code


c25_ControlTreeViewClass.Init                                  Procedure(*c25_ControlClass _controlClass)

Code

    !Self.SetText(Self.ProgramHandlerClass.ThemeManagerClass.GetText(ControlType:TreeView, Self.BaseControl.Name))
    !Message('c25_ControlTreeViewClass.Init')
    
    Self.BaseControl &= _controlClass
    Self.ProgramHandlerClass &= Self.BaseControl.ProgramHandlerClass
    
!    Self.BitConverterClass &= NEW c25_BitConverterClass()
    
    Self.ControlTreeViewRenderClass &= NEW c25_ControlTreeViewRenderClass()
    Self.ControlTreeViewRenderClass.Init(Self)
    !Self.ControlTreeViewRenderClass.ControlTreeViewClass &= Self
    
    Self.BindingSourceClass &= NEW c25_BindingSourceClass()
    
    Self.DataControlStyleClass.Init(Self.BaseControl)
    
    !Self.BindingSourceClass.Init()
    
    Return 0
    
c25_ControlTreeViewClass.ProcessEvent      Procedure(long _event)


CODE

    !CanvasState:NormalDimmed
    Message('c25_ControlTreeViewClass.ProcessEvent ' & _event)
    
    Self.PaintContainer()
    
!    Self.Counter = Self.Counter + 1
!    Case _event
!    Of EVENT:MouseIn
!        Self.State = ButtonState:Hot
!        !Self.SetText(,'mouse in ' & Self.Counter )
!    Of EVENT:MouseOut
!        Self.State = ButtonState:Normal
!        !Self.SetText(,'mouse out ' & Self.Counter)
!    End
    
    Case Self.ProgramHandlerClass.WinAppState
    Of WindowAppState:Active
        Self.Paint(CanvasState:Normal)
    Of WindowAppState:NotActive
        Self.Paint(CanvasState:NormalDimmed)
    End
    Return 0


c25_ControlTreeViewClass.PaintContainer       Procedure()

TabClass    &c25_TabClass

CODE
    

    If Self.BaseControl.ContainerClassPtr = 0
        Return 0
    End
    Case Self.BaseControl.ContainerType
    Of ContainerType:TabClass
        TabClass &= (Self.BaseControl.ContainerClassPtr)
        TabClass.TabRenderEngineClass.Paint()
        TabClass &= null
    End
    Return 0

c25_ControlTreeViewClass.Paint                               Procedure(long _canvasState)

Code

    Self.ControlTreeViewRenderClass.Paint(_canvasState)
    
    Return 0
    
c25_ControlTreeViewClass.Resize                               Procedure()

Code

    Self.ProgramHandlerClass.UpdateWindowRect()
    
    Self.BaseControl.ControlRect.Left        = 1
    Self.BaseControl.ControlRect.Top         = Self.ProgramHandlerClass.RibbonHeight + Self.ProgramHandlerClass.RibbonShortCutBarHeight
    Self.BaseControl.ControlRect.Width       = (Self.ProgramHandlerClass.WindowRect.Width / 3) * 1
    Self.BaseControl.ControlRect.Height      = Self.ProgramHandlerClass.WindowRect.Height - (Self.ProgramHandlerClass.RibbonHeight + Self.ProgramHandlerClass.RibbonShortCutBarHeight) - Self.ProgramHandlerClass.StatusBarHeight
    Self.BaseControl.ControlRect.Right       = Self.BaseControl.ControlRect.Left + Self.BaseControl.ControlRect.Width
    Self.BaseControl.ControlRect.Bottom      = Self.BaseControl.ControlRect.Top + Self.BaseControl.ControlRect.Height    
    Self.Paint(CanvasState:Normal)
    Self.Paint(CanvasState:NormalDimmed)
    Return 0    
    
c25_ControlTreeViewClass.SetText      Procedure(<string _textW>, <string _textA>)

OldString  &String
NewString  &String

Code
    
!    If not Self.TextW &= NULL
!        OldString &= Self.TextW
!    End
!    
!    If omitted(_textA) = False
!        NewString &= Self.BitConverterClass.AnsiToUtf16(_textA,,true)
!    ElsIf omitted(_textW) = False
!        NewString &= Self.BitConverterClass.BinaryCopy(_textW & Chr(0) & Chr(0) )
!    End
!    Self.TextW &= NewString
!    If not OldString &= NULL
!        Dispose(OldString)
!    End    
    
    Return 0
    
