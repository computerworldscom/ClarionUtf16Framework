        Member

        Include('c25_DataColumnClass.inc'),Once

                    MAP
                        Include('CWUTIL.inc'),once
                        Include('i64.inc')
						Include('c25_WinApiPrototypes.inc')
                    End

c25_DataColumnClass.Construct                       Procedure()

Code
        

c25_DataColumnClass.Destruct                        Procedure()

Code

    
c25_DataColumnClass.Init                            Procedure(*c25_DataColumnsCollectionClass _dataColumnsCollectionClass)

Code
        
    Self.DataColumnsCollectionClass &= _dataColumnsCollectionClass
    Self.DataSourceClass &= Self.DataColumnsCollectionClass.DataSourceClass
    Self.ProgramHandlerClass &= Self.DataSourceClass.ProgramHandlerClass
    
!    Case Self.BindingSourceClass.DataSourceProviderType
!    Of DataSourceProviderType:Sqlite3Table
!        If not Self.Sqlite3Class &= null
!            Dispose(Self.Sqlite3Class)
!        End
!        Self.Sqlite3Class &= NEW c25_SqliteClass()
!    Of DataSourceProviderType:ClarionQueue
!        
!    Of DataSourceProviderType:MsSqlTable
!        
!    End
    
    Return 0
    
    
    