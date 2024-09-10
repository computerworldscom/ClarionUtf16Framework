                        Member

                        Include('c25_SqliteConnectionStringBuilderClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                        End


c25_SqliteConnectionStringBuilderClass.Construct                                Procedure()

ClassTypeName cstring(128)
ClassStarter   &c25_ClassStarter

Code

    ClassTypeName = 'c25_SqliteConnectionStringBuilderClass'

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(ClassTypeName))
    Dispose(ClassStarter)
    Self.BitConverterClass &= NEW c25_BitConverterClass()


c25_SqliteConnectionStringBuilderClass.Destruct                                 Procedure()

Code
        

c25_SqliteConnectionStringBuilderClass.Init                                     Procedure()

Code
    
    
    Return 0
    
c25_SqliteConnectionStringBuilderClass.GetDataSource                            Procedure()

Code
    
    If Self.DataSource &= NULL
        Return ''
    End
    Return Self.DataSource 
    
c25_SqliteConnectionStringBuilderClass.SetDataSource                            Procedure(string _dataSource)

Code
        
    If not Self.DataSource &= NULL
        Dispose(Self.DataSource)
    End
    Self.DataSource &= Self.BitConverterClass.BinaryCopy(_dataSource)
    Return 0   
    
c25_SqliteConnectionStringBuilderClass.Reset                                    Procedure()

Code
    
    
    Return 0
    
c25_SqliteConnectionStringBuilderClass.ContainsKey                              Procedure(string _keyword)

Code
    
    
    Return 0
    
    
c25_SqliteConnectionStringBuilderClass.RemoveKey                                Procedure(string _keyword)

Code
    
    
    Return 0
    
    
c25_SqliteConnectionStringBuilderClass.ShouldSerialize                          Procedure(string _keyword)

Code
    
    
    Return 0
    
    
c25_SqliteConnectionStringBuilderClass.TryGetValue                              Procedure(string _keyword,<string _outValue>)

Code
    
    
    Return 0
    
    