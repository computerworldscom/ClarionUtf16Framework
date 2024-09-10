                        Member

    Include('c25_BindingSourceClass.inc'),Once

                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                        End
       
c25_BindingSourceClass.Construct                                    Procedure()

ClassTypeName   cstring(128)
ClassStarter    &c25_ClassStarter

Code

    ClassTypeName = 'c25_BindingSourceClass'

    ClassStarter &= NEW c25_ClassStarter()
    Self.ProgramHandlerClass &= (ClassStarter.Start(ClassTypeName))
    Dispose(ClassStarter)
    
    Self.BitConverterClass &= NEW c25_BitConverterClass()
    Self.DataSourceClass &= NEW c25_DataSourceClass()
    Self.DataSourceClass.Init(self)
    Self.CurrentDataRow &= NEW c25_DataRowClass()
    

c25_BindingSourceClass.Destruct                                     Procedure()

    Code
        
        
c25_BindingSourceClass.Init                                         Procedure(*c25_ControlClass _controlClass)

Code
        
    Self.ControlClass &= _controlClass
    
    Case Self.ControlClass.TypeEnum
    Of ControlType:TreeView
        Self.RowHeight = 21
    End
    !Message('c25_BindingSourceClass.Init')
    
!    If Self.DataSourceClass &= NULL
!        Return 0
!    End
!    Case Self.DataSourceClass.TypeEnum
!    Of DataSourceType:ClarionQueue
!        If Self.DataSourceClass.ClarionSourceQ &= null Or Self.DataSourceClass.ClarionFieldsQ
!            Return 0
!        End
!    End
!    
!    Case Self.DataSourceClass.TypeEnum
!    Of DataSourceType:ClarionQueue
!        If Self.DataSourceClass.ClarionSourceQ &= null Or Self.DataSourceClass.ClarionFieldsQ &= null
!            Get(Self.DataSourceClass.ClarionSourceQ,1)
!            !Self.CurrentRow &= 
!        End
!    End
    
    Return 0
    
    
c25_BindingSourceClass.SetDataSource                                Procedure(long _dataSourceProviderType, <string _connnString>, <queue _clarionQ>)
    

Code
        

    Self.DataSourceProviderType = _dataSourceProviderType
    If omitted(_connnString) = False
        Self.DataSourceClass.SetConnectionString(_connnString)
    End
    If omitted(_clarionQ) = False
        Self.DataSourceClass.SetClarionQueue(_clarionQ)
    End    
    Case Self.DataSourceProviderType
    Of DataSourceProviderType:ClarionQueue    
        Self.SetCursor(1)
    END
    Return 0

    
    
c25_BindingSourceClass.SetCursor                                Procedure(<string _index>)


CODE

    !Self.BitConverterClass ConvertToIndex64(_index)
    !Self.BitConverterClass ConvertToIndex64(_index)
    
    Self.IndexI64 = Self.BitConverterClass.ConvertToI64(_index)
    !Self.IndexDecimal = Self.BitConverterClass.ConvertFromI64(Self.IndexI64)
    
    
    If Self.DataSourceClass &= NULL
        Message('Self.DataSourceClass &= NULL')
        Return 0
    End
    Case Self.DataSourceProviderType
    Of DataSourceProviderType:ClarionQueue
        If Self.DataSourceClass.ClarionSourceQ &= null !Or Self.DataSourceClass.ClarionFieldsQ
            Message('Self.DataSourceClass.ClarionSourceQ &= null')
            Return 0
        End
    End
    
    Case Self.DataSourceProviderType
    Of DataSourceProviderType:ClarionQueue
        If Self.DataSourceClass.ClarionSourceQ &= null Or Self.DataSourceClass.ClarionFieldsQ &= null
            Message('error Self.DataSourceClass.ClarionSourceQ &= null Or Self.DataSourceClass.ClarionFieldsQ &= null')
            Return 0
        End
        Get(Self.DataSourceClass.ClarionSourceQ, Self.IndexI64.Lo)
        If Errorcode() <> 0
            Message('ERROR AT Get(Self.DataSourceClass.ClarionSourceQ, Self.Index64.Lo), TRY GET INDEX: ' & Self.IndexI64.Lo)
            Return 0
        End
        
        
        Self.DataSourceClass.SetPosition( ,,Self.IndexI64)
        
        !Self.DataSourceClass.SetDataRow(Self.CurrentDataRow)
        !Message('done Self.DataSourceClass.SetDataRow(Self.CurrentDataRow)')
        !Message('set cursor : ' & 
        !Self.CurrentRow &= 
    End
    Return 0


!c25_BindingSourceClass.ConvertToIndex64                            Procedure(string _value, <*INT64 _int64>)
!
!Code        
!    
!    Self.IndexDecimal = _value
!    i64FromDecimal(Self.Index64, Self.IndexDecimal)
!    Return Self.Index64   

c25_BindingSourceClass.Reset                                        Procedure()

Code        
    

    Return 0


    
c25_BindingSourceClass.AddObject                                    Procedure()

Code
    
    Return 0

c25_BindingSourceClass.AddNew                                       Procedure()

Code
    
    Return 0

c25_BindingSourceClass.ApplySort                                    Procedure()

Code
    
    Return 0

c25_BindingSourceClass.CancelEdit                                   Procedure()

Code
    
    Return 0

c25_BindingSourceClass.ClearObject                                  Procedure()

Code
    
    Return 0

c25_BindingSourceClass.Contains                                     Procedure()

Code
    
    Return 0
    
c25_BindingSourceClass.CopyTo                                       Procedure()

Code
    
    Return 0

c25_BindingSourceClass.DisposeBindings                              Procedure()

Code
    
    Return 0

c25_BindingSourceClass.EndEdit                                      Procedure()

Code
    
    Return 0

c25_BindingSourceClass.Find                                         Procedure()

Code
    
    Return 0

c25_BindingSourceClass.GetEnumerator                                Procedure()

Code
    
    Return 0

c25_BindingSourceClass.GetItemProperties                            Procedure()

Code
    
    Return 0

c25_BindingSourceClass.GetListName                                  Procedure()

Code
    
    Return 0

c25_BindingSourceClass.GetRelatedCurrencyManager                    Procedure()

Code
    
    Return 0

c25_BindingSourceClass.IndexOf                                      Procedure()

Code
    
    Return 0

c25_BindingSourceClass.Insert                                       Procedure()

Code
    
    Return 0

c25_BindingSourceClass.MoveFirst                                    Procedure()

Code
    
    Return 0

c25_BindingSourceClass.MoveLast                                     Procedure()

Code
    
    Return 0

c25_BindingSourceClass.MoveNext                                     Procedure()

Code
    
    Return 0

c25_BindingSourceClass.MovePrevious                                 Procedure()

Code
    
    Return 0

c25_BindingSourceClass.OnAddingNew                                  Procedure()

Code
    
    Return 0

c25_BindingSourceClass.OnBindingComplete                            Procedure()

Code
    
    Return 0

c25_BindingSourceClass.OnCurrentChanged                             Procedure()

Code
    
    Return 0

c25_BindingSourceClass.OnCurrentItemChanged                         Procedure()

Code
    
    Return 0

c25_BindingSourceClass.OnDataError                                  Procedure()

Code
    
    Return 0

c25_BindingSourceClass.OnDataMemberChanged                          Procedure()

Code
    
    Return 0

c25_BindingSourceClass.OnDataSourceChanged                          Procedure()

Code
    
    Return 0

c25_BindingSourceClass.OnListChanged                                Procedure()

Code
    
    Return 0

c25_BindingSourceClass.OnPositionChanged                            Procedure()

Code
    
    Return 0

c25_BindingSourceClass.RemoveObject                                 Procedure()

Code
    
    Return 0

c25_BindingSourceClass.RemoveAt                                     Procedure()

Code
    
    Return 0

c25_BindingSourceClass.RemoveCurrent                                Procedure()

Code
    
    Return 0

c25_BindingSourceClass.RemoveFilter                                 Procedure()

Code
    
    Return 0

c25_BindingSourceClass.RemoveSort                                   Procedure()

Code
    
    Return 0

c25_BindingSourceClass.ResetAllowNew                                Procedure()

Code
    
    Return 0

c25_BindingSourceClass.ResetBindings                                Procedure()

Code
    
    Return 0

c25_BindingSourceClass.ResetCurrentItem                             Procedure()

Code
    
    Return 0

c25_BindingSourceClass.ResetItem                                    Procedure()

Code
    
    Return 0

c25_BindingSourceClass.ResumeBinding                                Procedure()

Code
    
    Return 0

c25_BindingSourceClass.SuspendBinding                               Procedure()

Code
    
    Return 0

