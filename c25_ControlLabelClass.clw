                        Member

                        Include('c25_ControlLabelClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                        End


c25_ControlLabelClass.Construct                                  Procedure()

!ClassTypeName cstring(128)
!ClassStarter   &c25_ClassStarter

Code

!    ClassTypeName = 'c25_ControlLabelClass'
!
!    ClassStarter &= NEW c25_ClassStarter()
!    Self.ProgramHandlerClass &= (ClassStarter.Start(ClassTypeName))
!    Dispose(ClassStarter)
!    Self.ControlLabelRenderClass &= NEW c25_ControlLabelRenderClass()
!    Self.ControlLabelRenderClass.ControlLabelClass &= Self
    Self.TextW &= NEW StringTheory()
    Self.TextW.Start()

c25_ControlLabelClass.Destruct                                  Procedure()

Code


    


c25_ControlLabelClass.Init                                         Procedure(*c25_ControlClass _controlClass)

Code

    Self.BaseControl &= _controlClass
    
    Self.ProgramHandlerClass &= Self.BaseControl.ProgramHandlerClass
    
    !Self.SetText(Self.ProgramHandlerClass.ThemeManagerClass.GetText(ControlType:Label, Self.BaseControl.Name))
    
    Self.ControlLabelRenderClass &= NEW c25_ControlLabelRenderClass()
    Self.ControlLabelRenderClass.Init(self)
    
    Self.SetText(,'test label')
    Self.Paint(CanvasState:Normal)
    Self.Paint(CanvasState:NormalDimmed)    
    Return 0    
    
    
!c25_ControlLabelClass.Init                                  Procedure()
!
!Code
!
!    Self.SetText(,'test label')
!    Self.Paint(CanvasState:Normal)
!    Self.Paint(CanvasState:NormalDimmed)
!    
!    Return 0
!    
    
c25_ControlLabelClass.Paint                               Procedure(long _canvasState)

Code

    Self.ControlLabelRenderClass.Paint(_canvasState)
    
    Return 0
    
c25_ControlLabelClass.SetText                              Procedure(<string _textW>, <string _textA>)

Code

    If omitted(_textA) = False
        Self.TextW.SetValue(_textA)
        Self.TextW.ToUnicode(st:EncodeUtf16)
    ElsIf omitted(_textW) = False
        Self.TextW.SetValue(_textW)
    End
    Return 0
    
