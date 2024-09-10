                        Member

                        Include('c25_ConnectionStringBuilderClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                        End


c25_ConnectionStringBuilderClass.Construct                                  Procedure()

ClassTypeName cstring(128)
ClassStarter   &c25_ClassStarter

Code

    ClassTypeName = 'c25_ConnectionStringBuilderClass'

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(ClassTypeName))
    Dispose(ClassStarter)
    Self.BitConverterClass &= NEW c25_BitConverterClass()


c25_ConnectionStringBuilderClass.Destruct                                  Procedure()

Code

c25_ConnectionStringBuilderClass.Init                                  Procedure()

Code

    
    
    Return 0
    
    
    