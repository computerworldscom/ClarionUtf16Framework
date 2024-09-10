                        Member

                        Include('c25_SqliteColumnClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                        End


c25_SqliteColumnClass.Construct                                  Procedure()

ClassTypeName cstring(128)
ClassStarter   &c25_ClassStarter

Code

    ClassTypeName = 'c25_SqliteColumnClass'

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(ClassTypeName))
    Dispose(ClassStarter)
    Self.BitConverterClass &= NEW c25_BitConverterClass()


c25_SqliteColumnClass.Destruct                                  Procedure()

Code

c25_SqliteColumnClass.Init                                  Procedure()

Code
    
    
    Return 0
    
    
    