                        Member

                        Include('c25_OpenGLClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.clw')
!                            Module('c25_OpenGLClass.clw')
!WindowHandlerThread          Procedure(Long _paramA, Long _paramB),Long
!                            End
                        End

c25OpenGLClass.Construct                                                     Procedure()

Code


    Self.ProgramHandler &= NEW c25ProgramHandlerClass()
    Self.ProgramHandler &= Self.ProgramHandler.Singleton.GetPointer()
    Self.ProgramHandler.Singleton.Start()
    
    X# = glfwInit()
    Message('glfwInit ' & X#)

    
c25OpenGLClass.Destruct                                                      Procedure()

Code

!    Dispose(Self.BitConverter)
!    Dispose(Self.PopupWindow)
    
    
    