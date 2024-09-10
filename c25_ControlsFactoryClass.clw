                        Member

                        Include('c25_ControlsFactoryClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                        End


c25_ControlsFactoryClass.Construct                                  Procedure()

ClassTypeName cstring(128)
ClassStarter   &c25_ClassStarter
I               LONG
Code

    ClassTypeName = 'c25_ControlsFactoryClass'

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(ClassTypeName))
    Dispose(ClassStarter)

    Self.ControlsArrayMaximum = Maximum(Self.ControlsPtr,1)

    Clear(Self.ControlsPtr)
    I = 0
    Loop Self.ControlsArrayMaximum TIMES
        I = I + 1
        Self.ControlsPtr[I] = 0
    End
    Self.BitConverter &= NEW c25_BitConverterClass()

c25_ControlsFactoryClass.Destruct                                  Procedure()

Code

c25_ControlsFactoryClass.CreateControl      Procedure(*c25_ControlClass _controlClass)

Control    &c25_ControlClass
I          LONG

CODE
    
    !Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlsFactoryClass.CreateControl - START')
    
    I = Self.GetFree()
    If I = 0
        Message('error 1 c25_ControlsFactoryClass, too many controls')
        Return 0
    End
    
    Control &= _controlClass
    Self.ControlsPtr[I] = Address(Control)
    !SetClipboard(Control.ControlRect.Left & ',' &  Control.ControlRect.Top & ',' &  Control.ControlRect.Width & ',' &  Control.ControlRect.Height)
    !Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlsFactoryClass.CreateControl - START Control.Init(Self.ControlContainerPtr, Self.ControlContainerType)')
    
    Control.Init(Self.ControlContainerPtr, Self.ControlContainerType)
    
    
    !Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlsFactoryClass.CreateControl - END Control.Init(Self.ControlContainerPtr, Self.ControlContainerType)')
    Control &= null
    
    !Self.ProgramHandlerClass.RootLog.WriteLog('c25_ControlsFactoryClass.CreateControl - END')
    
    Return 0

c25_ControlsFactoryClass.CreateControl     Procedure(string _name, long _containerType, long _controlType, <long _left>, <long _top>, <long _right>, <long _bottom>, <long _width>, <long _height>)

Control &c25_ControlClass
I       LONG

Code

    I = Self.GetFree()
    If I = 0
        Message('error 2 c25_ControlsFactoryClass, too many controls')
        Return 0
    End
    
    Control &= NEW c25_ControlClass()

    Self.ControlsPtr[I]    = Address(Control)
    Control.ContainerType   = _containerType
    Control.TypeEnum        = _controlType
    Control.Name            &= Self.BitConverter.BinaryCopy(_name)
      
    If omitted(_left) = False And omitted(_top) = False And omitted(_right) = False And omitted(_bottom) = False
        Control.ControlRect.Left       = _left
        Control.ControlRect.Top        = _top
        Control.ControlRect.Right      = _right
        Control.ControlRect.Bottom     = _bottom
        Control.ControlRect.Width      = Control.ControlRect.Right + Control.ControlRect.Left
        Control.ControlRect.Height     = Control.ControlRect.Bottom + Control.ControlRect.Top
    ElsIf omitted(_left) = False And omitted(_top) = False And omitted(_width) = False And omitted(_height) = False
        Control.ControlRect.Left       = _left
        Control.ControlRect.Top        = _top
        Control.ControlRect.Width      = _width
        Control.ControlRect.Height     = _height  
        Control.ControlRect.Right      = Control.ControlRect.Left + Control.ControlRect.Width
        Control.ControlRect.Bottom     = Control.ControlRect.Top + Control.ControlRect.Height   
    End    
    
    
    
    Control.Init(Self.ControlContainerPtr, Self.ControlContainerType, Control.Name, Control.TypeEnum)
    
    Control &= null
    Return Control


c25_ControlsFactoryClass.GetFree                Procedure()



CODE
        
    !I = 0
    Loop Self.ControlsArrayMaximum TIMES
        Self.GetFreeI = Self.GetFreeI + 1
        If Self.GetFreeI > Self.ControlsArrayMaximum
            Self.GetFreeI = 1
        End
        If Self.ControlsPtr[Self.GetFreeI] = 0
            Self.ControlsPtr[Self.GetFreeI] = Self.GetFreeI
            Return Self.GetFreeI
        End
    End   
    Message('error no more controls possible in array c25_ControlsFactoryClass.GetFree')
    
    Return 0
    
    