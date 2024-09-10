Include('c25_ProgramHandlerClass.inc'),Once

c25OpenGLClass                              Class(),Type, Module('c25_OpenGLClass.clw'), Link('c25_OpenGLClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                                      Procedure()
Destruct                                       Procedure()

ProgramHandler                                  &c25ProgramHandlerClass()
BitConverter                                    &c25BitConverterClass()

                                            End



