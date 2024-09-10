Include('c25_ProgramHandlerClass.inc'),Once


c25_TreeClass                                                           Class(),type, Module('c25_TreeClass.clw'), Link('c25_TreeClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)

Construct                                                                   Procedure()
Destruct                                                                    Procedure()

ClassTypeName                                                               cstring(128)
BackBufferCanvasId                                                          long
WMPaintDC                                                                   Long
WMPaintGraphics                                                             long
WMPaintCanvasId                                                             long
DefaultColIcon                                                              long,dim(1024)
DefaultColStyle                                                             long,dim(1024)
IsBuffered                                                                  BOOL
ListChanged                                                                 BOOL
RecordChanged                                                               bool
RecordsLoaded                                                               bool
RowsCount                                                                   DECIMAL(20,0)
RowSelectedEnd                                                              long
RowSelectedStart                                                            long
UseTreeBuffer                                                               bool
CurrentCellRowIndex                                                         Long
CurrentCellRowIndex_Changed                                                 bool
 
BackBuffer                                                                  &c25_GraphicsClass()
BitConverter                                                                &c25_BitConverterClass()
CurrentNode                                                                 &c25_TreeNodeClass()
GraphicsClass                                                               &c25_GraphicsClass()
MsSql                                                                       &c25_MsSqlClass()
ProgramHandlerClass                                                         &c25_ProgramHandlerClass()

ClaControl                                                                  &ClaControl_TYPE()
ConnString                                                                  &string
DatabaseName                                                                &String
Name                                                                        &string
SchemaName                                                                  &String
TableName                                                                   &String
TableNameFull                                                               &String
TreeBuffer                                                                  &TreeNode_TYPE()
TreeBufferSelected                                                          &TreeNode_TYPE()
TreeBufferTEMP                                                              &TreeNode_TYPE()

EmptyRecord                                                                 Procedure(long _col),STRING
ExecuteQuery                                                                Procedure(string _sql, <string _sqlCount>, <bool _noFreeQ>),string,proc
Free_TreeBuffer                                                             Procedure(<TreeNode_TYPE _TreeNode>),string,proc
GetClaControlEvent                                                          Procedure(long _event)
GetHierarchyId                                                              Procedure(<long _rowIndex>),string,PROC
Init                                                                        Procedure(<long _claListBox>, <string _connString>, <long _dbEngine>, <*queue _q>, <string _name>, <string _tableNameFull>, <string _databaseName>),string,PROC
PaintFirstTime                                                              Procedure(<string _name>),string,PROC
RetrieveRecord                                                              Procedure(long _rowId, <*TreeNode_TYPE _treeNode>),String,proc
SetCurrentNode                                                              Procedure(<long _indexTreeBuffer>)
VLBProc                                                                     Procedure(),string,PROC
VLBProcList                                                                 Procedure(LONG _row, USHORT _col),STRING


WMPaintStruct                                                               Group,Pre(WMPaintStruct)
DC                                                                              Long
Erase                                                                           Long
X                                                                               Long
Y                                                                               Long
W                                                                               Long
H                                                                               Long
Restore                                                                         Long
IncUpdate                                                                       Long
Reserved                                                                        String(255)
                                                                            End
                                                                        End
