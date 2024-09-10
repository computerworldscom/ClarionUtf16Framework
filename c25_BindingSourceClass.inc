    Include('c25_ProgramHandlerClass.inc'),Once

c25_BindingSourceClass                                                      Class(),type, Module('c25_BindingSourceClass.clw'), Link('c25_BindingSourceClass.clw',1),DLL(0)

Construct                                                                       Procedure()
Destruct                                                                        Procedure()

ProgramHandlerClass                                                             &c25_ProgramHandlerClass
BitConverterClass                                                               &c25_BitConverterClass
ControlClass                                                                    &c25_ControlClass

AllowEdit                                                                       BOOL
AllowNew                                                                        BOOL
AllowRemove                                                                     BOOL
Count                                                                           LONG
CurrentDataRow                                                                  &c25_DataRowClass
DataMember                                                                      &String
DataSourceClass                                                                 &c25_DataSourceClass
Filter                                                                          &String
IsBindingSuspended                                                              BOOL
IsFixedSize                                                                     BOOL
IsReadOnly                                                                      BOOL
IsSorted                                                                        BOOL
IsSynchronized                                                                  BOOL
Item                                                                            LONG
List                                                                            &QUEUE
Position                                                                        LONG
RaiseListChangedEvents                                                          BOOL
Sort                                                                            &String
SortDescriptions                                                                &String
SortDirection                                                                   &String
SortProperty                                                                    &String
SupportsAdvancedSorting                                                         BOOL
SupportsChangeNotification                                                      BOOL
SupportsFiltering                                                               BOOL
SupportsSearching                                                               BOOL
SupportsSorting                                                                 BOOL
SyncRoot                                                                        &String
DataSourceProviderType                                                          LONG
TargetViewType                                                                  LONG
RowHeight                                                                       Long

!IndexDecimal                                                                    decimal(20)

IndexI64                                                                         Like(INT64)
!ConvertToIndex64                                                                Procedure(string _value, <*INT64 _int64>),String,proc
Init                                                                            Procedure(*c25_ControlClass _controlClass),Long,Proc
Reset                                                                           Procedure(),Long,Proc
SetCursor                                                                       Procedure(<string _index>),string,Proc
SetDataSource                                                                   Procedure(long _dataSourceProviderType, <string _connnString>, <queue _clarionQ>),string,Proc
AddObject                                                                       Procedure(),string,Proc
AddNew                                                                          Procedure(),string,Proc
ApplySort                                                                       Procedure(),string,Proc
CancelEdit                                                                      Procedure(),string,Proc
ClearObject                                                                     Procedure(),string,Proc
Contains                                                                        Procedure(),string,Proc
CopyTo                                                                          Procedure(),string,Proc
DisposeBindings                                                                 Procedure(),string,Proc
EndEdit                                                                         Procedure(),string,Proc
Find                                                                            Procedure(),string,Proc
GetEnumerator                                                                   Procedure(),string,Proc
GetItemProperties                                                               Procedure(),string,Proc
GetListName                                                                     Procedure(),string,Proc
GetRelatedCurrencyManager                                                       Procedure(),string,Proc
IndexOf                                                                         Procedure(),string,Proc
Insert                                                                          Procedure(),string,Proc
MoveFirst                                                                       Procedure(),string,Proc
MoveLast                                                                        Procedure(),string,Proc
MoveNext                                                                        Procedure(),string,Proc
MovePrevious                                                                    Procedure(),string,Proc
OnAddingNew                                                                     Procedure(),string,Proc
OnBindingComplete                                                               Procedure(),string,Proc
OnCurrentChanged                                                                Procedure(),string,Proc
OnCurrentItemChanged                                                            Procedure(),string,Proc
OnDataError                                                                     Procedure(),string,Proc
OnDataMemberChanged                                                             Procedure(),string,Proc
OnDataSourceChanged                                                             Procedure(),string,Proc
OnListChanged                                                                   Procedure(),string,Proc
OnPositionChanged                                                               Procedure(),string,Proc
RemoveObject                                                                    Procedure(),string,Proc
RemoveAt                                                                        Procedure(),string,Proc
RemoveCurrent                                                                   Procedure(),string,Proc
RemoveFilter                                                                    Procedure(),string,Proc
RemoveSort                                                                      Procedure(),string,Proc
ResetAllowNew                                                                   Procedure(),string,Proc
ResetBindings                                                                   Procedure(),string,Proc
ResetCurrentItem                                                                Procedure(),string,Proc
ResetItem                                                                       Procedure(),string,Proc
ResumeBinding                                                                   Procedure(),string,Proc
SuspendBinding                                                                  Procedure(),string,Proc
!CalculateVisibleRows                                                            Procedure(),string,PROC
                                                                            End

