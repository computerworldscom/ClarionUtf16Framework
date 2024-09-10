                        Member

                        Include('c25_ControlButtonClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                        End


c25_ControlButtonClass.Construct                                    Procedure()

!ClassTypeName cstring(128)
!ClassStarter   &c25_ClassStarter

Code

!    ClassTypeName = 'c25_ControlButtonClass'
!
!    ClassStarter &= NEW c25_ClassStarter()
!    Self.ProgramHandlerClass &= (ClassStarter.Start(ClassTypeName))
!    Dispose(ClassStarter)
    
    Self.BitConverterClass &= NEW c25_BitConverterClass()

    Self.TextW &= NEW String(2)
    Self.TextW = Chr(0) & Chr(0)


c25_ControlButtonClass.Destruct                                     Procedure()

Code


c25_ControlButtonClass.Init                                         Procedure(*c25_ControlClass _controlClass)

Code

    Self.BaseControl &= _controlClass
    
    Self.ProgramHandlerClass &= Self.BaseControl.ProgramHandlerClass
    
    Self.SetText(Self.ProgramHandlerClass.ThemeManagerClass.GetText(ControlType:Button, Self.BaseControl.Name))
    
    Self.ControlButtonRenderClass &= NEW c25_ControlButtonRenderClass()
    Self.ControlButtonRenderClass.Init(self)
    Return 0
    
c25_ControlButtonClass.ProcessEvent                                 Procedure(long _event)

CODE
        
        
    Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlButtonClass.ProcessEvent - START')

    !CanvasState:NormalDimmed
    
    Self.PaintContainer()
    
    Self.Counter = Self.Counter + 1
    
    Case _event
    Of EVENT:MouseIn
        Self.State = ButtonState:Hot
        !Self.SetText(,'mouse in ' & Self.Counter )
    Of EVENT:MouseOut
        Self.State = ButtonState:Normal
        !Self.SetText(,'mouse out ' & Self.Counter)
    End
    Case Self.ProgramHandlerClass.WinAppState
    Of WindowAppState:Active
        Self.Paint(CanvasState:Normal)
    Of WindowAppState:NotActive
        Self.Paint(CanvasState:NormalDimmed)
    End
    Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlButtonClass.ProcessEvent - END')
    Return 0


c25_ControlButtonClass.PaintContainer                               Procedure()

TabClass &c25_TabClass
CODE
    
!Self.ProgramHandlerClass.RenderEngineClass.Draw
!Self.TabRenderEngineClass.Paint()
    
    Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlButtonClass.PaintContainer - START')
    
    
    If Self.BaseControl.ContainerClassPtr = 0
        Return 0
    End
    Case Self.BaseControl.ContainerType
    Of ContainerType:TabClass
        TabClass &= (Self.BaseControl.ContainerClassPtr)
        TabClass.TabRenderEngineClass.Paint()
        TabClass &= null
    End
    
    Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlButtonClass.PaintContainer - END')
    Return 0

c25_ControlButtonClass.Paint                               Procedure(long _canvasState)

Code
        
        
    Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlButtonClass.Paint - START')

    Self.ControlButtonRenderClass.Paint(_canvasState)
    
    Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlButtonClass.Paint - END')
    
    Return 0
    
c25_ControlButtonClass.SetText      Procedure(<string _textW>, <string _textA>)

OldString  &String
NewString  &String

Code
    
    If not Self.TextW &= NULL
        OldString &= Self.TextW
    End
    
    If omitted(_textA) = False
        NewString &= Self.BitConverterClass.AnsiToUtf16(_textA,,true)
    ElsIf omitted(_textW) = False
        NewString &= Self.BitConverterClass.BinaryCopy(_textW & Chr(0) & Chr(0) )
    End
    Self.TextW &= NewString
    If not OldString &= NULL
        Dispose(OldString)
    End    
    
    Return 0
    
