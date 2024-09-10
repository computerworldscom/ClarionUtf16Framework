    Member()

    Include('c25_SqliteClass_NavigationTree.inc'),ONCE

            Map
                Include('Sqlite3Prototypes.inc')
                Include('c25_WinApiPrototypes.inc')
                Include('i64.inc')
            End

c25_SqliteClass_NavigationTree.Construct                                 Procedure()

ClassStarter  &c25_ClassStarter

Code
    
    
    Self.NavigationTree &= NEW NavigationTree_TYPE()
    
    Self.ClassTypeName = 'c25_SqliteClass_NavigationTree'

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(Self.ClassTypeName))
    Dispose(ClassStarter)
    
    Self.SqliteClass &= NEW c25_SqliteClass()
    

c25_SqliteClass_NavigationTree.Destruct                                  Procedure()

    Code
        
    !Self.Disconnect()


    
    