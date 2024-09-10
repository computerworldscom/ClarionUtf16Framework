
    Include('c25_ProgramHandlerClass.inc'),Once

c25_ControlClass                                                     Class(),type, Module('c25_ControlClass.clw'), Link('c25_ControlClass.clw',1),DLL(0)
Construct                                                                   Procedure()
Destruct                                                                    Procedure()
 
stLogFileName                                                               cstring(512)
 
ContainerTabClass                                                          &c25_TabClass


ControlRectChanged                                                          BOOL
TypeEnum                                                                    LONG
ClassPtr                                                                    LONG
MouseIn                                                                     BOOL
MouseDown                                                                   BOOL
 
ContainerType                                                               long
ContainerClassPtr                                                           Long

BitConverterClass                                                           &c25_BitConverterClass
ControlRenderClass                                                          &c25_ControlRendererClass
!MessageOnlyWindowClass                                                      &c25_MessageOnlyWindowClass()
ProgramHandlerClass                                                         &c25_ProgramHandlerClass
ControlRect                                                                 &WindowRect_TYPE
LastControlRect                                                             &WindowRect_TYPE
Name                                                                        &STRING
ThemeName                                                                   &String
stLog                                                                       &StringTheory

Init                                                                        Procedure(long _containerPtr, long _containerType, <string _name>, <long _controlType>, <long _left>, <long _top>, <long _right>, <long _bottom>, <long _width>, <long _height>),long,PROC
Paint                                                                       Procedure(long _canvasType),long,PROC
SetSize                                                                     Procedure(long _left, long _top, long _right, long _bottom),string,proc
WndProc_Process                                                             Procedure(Long _windowHandle, ULong _message, ULong _wParam, Long _lParam, bool Processed, *long ReturnVal, <*bool PostProcess>)
                                                                        End


