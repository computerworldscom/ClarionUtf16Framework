                        Member

                        Include('c25_ListItemClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                        End


c25_ListItemClass.Construct                                  Procedure()

ClassTypeName   cstring(128)
ClassStarter   &c25_ClassStarter

Code

    ClassTypeName = 'c25_ListItemClass'

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(ClassTypeName))
    Dispose(ClassStarter)
    Self.BitConverterClass &= NEW c25_BitConverterClass()


c25_ListItemClass.Destruct                                  Procedure()

    Code
        

c25_ListItemClass.Init                                  Procedure()

Code

    
    
    Return 0
    
    
    