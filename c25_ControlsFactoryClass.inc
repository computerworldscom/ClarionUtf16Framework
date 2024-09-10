
    Include('c25_ProgramHandlerClass.inc'),Once

c25_ControlsFactoryClass                                                Class(),type, Module('c25_ControlsFactoryClass.clw'), Link('c25_ControlsFactoryClass.clw',1),DLL(0)
Construct                                                                   Procedure()
Destruct                                                                    Procedure()

ProgramHandlerClass                                                         &c25_ProgramHandlerClass
BitConverter                                                                &c25_BitConverterClass

!TabControlContainer                                                         &c25_TabClass
ControlContainerPtr                                                         Long
ControlContainerType                                                        Long

GetFreeI                                                                    LONG

ControlsArrayMaximum                                                        long
!ControlsArrayHighmark                                                       long
!Controls                                                                    Group,Pre(Controls),Dim(4000)
!Control                                                                         &c25_ControlClass
!                                                                            End
ControlsPtr                                                                 long,dim(4000)

CreateControl                                                               Procedure(*c25_ControlClass _controlClass),long,PROC
CreateControl                                                               Procedure(string _name, long _containerType, long _controlType, <long _left>, <long _top>, <long _right>, <long _bottom>, <long _width>, <long _height>),*c25_ControlClass,PROC
GetFree                                                                     Procedure(),long
                                                                        End


