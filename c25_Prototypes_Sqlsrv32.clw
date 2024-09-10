    Module('sqlsrv32.dll') !msodbcsql17.dll or msodbcsql18
        C25_Bcp_Batch(Long),Short,Raw,Pascal,Name('Bcp_Batch')
        C25_Bcp_Bind(Long Hdbc,Long Pdata,Long Cbindicator,Long Cbdata,Long Pterm,Long Cbterm,Long Edatatype,Long Idxservercol),Short,Raw,Pascal,Name('Bcp_Bind')
        C25_Bcp_Colfmt(Long Hdbc,Long IdxUserDataCol,Long EUserDataType,Long CbIndicator,Long CbUserData,Long PUserDataTerm,Long CbUserDataTerm,Long IdxServerCol),Short,Raw,Pascal,Name('Bcp_Colfmt')
        C25_Bcp_Collen(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_Bcp_Colptr(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_Bcp_Columns(Long,Long),Short,Raw,Pascal,Name('Bcp_Columns')
        C25_Bcp_Control(Long Hdbc, Long EOption, Long IValue),Short,Raw,Pascal,Name('Bcp_Control')
        C25_Bcp_Done(Long),Short,Raw,Pascal,Name('Bcp_Done')
        C25_Bcp_Exec(Long, Long),Long,Raw,Pascal,Name('Bcp_Exec')
        C25_Bcp_Getcolfmt(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_Bcp_Init(Long Hdbc, Long SzTable, Long SzDataFile, Long SzErrorFile, Long EDirection),Long,Pascal,Name('Bcp_Init')
        C25_Bcp_Moretext(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_Bcp_Readfmt(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_Bcp_Sendrow(Long),Short,Raw,Pascal,Name('Bcp_Sendrow')
        C25_Bcp_Setbulkmode(),Short,Raw,Pascal,Name('Bcp_Setbulkmode')
        C25_Bcp_Setcolfmt(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_Bcp_Writefmt(Long,Long),Short,Raw,Pascal,Name('Bcp_Writefmt')
        C25_Bcp_Writefmta(Long,Long),Short,Raw,Pascal,Name('Bcp_Writefmta')
        C25_Bcp_Writefmtw(Long,Long),Short,Raw,Pascal,Name('Bcp_Writefmtw')
        C25_CompareFunction(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_ConfigDriverW(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_ConfigDSNW(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_ConnectDlgProc(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_FinishDlgProc(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLallochandle(Long Handletype, Long Inputhandle, Long Outputhandleptr),Short,Pascal,Raw,Name('SQLallochandle')
        C25_SQLBindCol(Long Statementhandle, Long Columnnumber, Long Targettype,Long  Targetvalueptr, Long Bufferlength, Long Strlen_Or_Ind),Short,Raw,Pascal,Name('SQLBindCol')
        C25_SQLBindParameter(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLBrowseConnectW(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLBulkOperations(Long, Long),Short,Raw,Pascal,Name('SQLbulkoperations')
        C25_SQLCancel(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLCloseCursor(Long),Short,Raw,Pascal,Name('SQLCloseCursor')
        C25_SQLColAttributeW(Long StatementHandle, Long ColumnNumber,Long FieldIdentifier, Long CharacterAttributePtr, Long BufferLength, Long StringLengthPtr, Long NumericAttributePtr),Short,Raw,Pascal,Name('SQLColAttributeW')
        C25_SQLColumnPrivilegesW(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLColumnsW(Long, Long, Long, Long, Long, Long, Long),Short,Raw,Pascal,Name('SQLColumnsW')
        C25_SQLConnectW(Long ConnectionHandle, Long ServerName, Long NameLength1, Long UserName, Long NameLength2, Long Authentication, Long NameLength3),Long,Pascal,Name('SQLConnectW')
        C25_SQLCopyDesc(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLDebug(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLDescribeColW(Long StatementHandle,Long ColumnNumber,Long ColumnName,Long BufferLength,Long NameLengthPtr,Long DataTypePtr,Long ColumnSizePtr, Long DecimalDigitsPtr,Long NullablePtr),Short,Raw,Pascal,Name('SQLDescribeColW')
        C25_SQLDescribeParam(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLDisconnect(Long),Short,Raw,Pascal,Name('SQLDisconnect')
        C25_SQLDriverConnectW(Long Connectionhandle,  Long Windowhandle, Long Inconnectionstring, Long Stringlength1, Long Outconnectionstring, Long Bufferlength, Long Stringlength2Ptr, Long Drivercompletion),Short,Pascal,Name('SQLDriverConnectW')
        C25_SQLEndTran(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLExecDirectW(Long, Long, Long),Short,Raw,Pascal,Name('SQLExecDirectW')
        C25_SQLExecute(Long _StatementHandle),Short,Raw,Pascal,Name('SQLExecute')
        C25_SQLExtendedFetch(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLFetch(Long _StmtHandle),Short,Raw,Pascal,Name('SQLFetch')
        C25_SQLFetchScroll(Long, Long, Long),Short,Raw,Pascal,Name('SQLFetchScroll')
        C25_SQLForeignKeysW(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLFreeHandle(Long,Long),Short,Raw,Pascal,Name('SQLFreeHandle'),Proc
        C25_SQLFreeStmt(Long,Long),Short,Raw,Pascal,Name('SQLFreeStmt')
        C25_SQLGetConnectAttr(Long Connectionhandle, Long Attribute, Long Valueptr,Long Bufferlength, Long Stringlengthptr),Short,Raw,Pascal,Name('SQLGetConnectAttrW')
        C25_SQLGetConnectAttrW(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLGetConnectOption(Long,Long,Long),Short,Raw,Pascal,Name('SQLGetConnectOption')
        C25_SQLGetConnectOptionW(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLGetCursorNameW(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLGetData(Long StatementHandle,Long Col_Or_Param_Num,Long TargetType,Long TargetValuePtr,Long BufferLength,Long StrLen_Or_IndPtr),Short,Raw,Pascal,Name('SQLGetData')
        C25_SQLGetDescFieldW(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLGetDescRecW(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLgetDiagFieldW(Long Handletype,Long Handle,Long Recnumber,Long Diagidentifier,Long Diaginfoptr,Long Bufferlength,Long Stringlengthptr),Short,Raw,Pascal,Name('SQLgetdiagfieldw')
        C25_SQLgetDiagRecW(Long Handletype,  Long Handle,  Long Recnumber,  Long SQLstate,  Long  Nativeerrorptr,  Long  Messagetext,  Long  Bufferlength,  Long Textlengthptr),Short,Raw,Pascal,Name('SQLgetdiagrecw')
        C25_SQLGetEnvAttr(Long EnvironmentHandle, Long Attribute, Long ValuePtr,Long BufferLength, Long StringLengthPtr),Short,Pascal,Name('SQLGetEnvAttr')
        C25_SQLGetFunctions(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLGetInfoW(Long,Long,Long,Long,Long),Short,Raw,Pascal,Name('SQLgetinfow')
        C25_SQLGetStmtAttrW(Long , Long , Long , Long,Long),Short,Raw,Pascal,Name('SQLgetstmtattrw')
        C25_SQLGetTypeInfoW(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLMoreResults(Long),Short,Raw,Pascal,Name('SQLmoreresults')
        C25_SQLNativeSqlW(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLNumParams(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLNumResultCols(Long _StmtHandle, Long _ColumnCountPtr),Short,Raw,Pascal,Name('SQLNumResultCols')
        C25_SQLParamData(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLParamOptions(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLPrepareW(Long _StmtHandle, Long _SQLUTf16, Long _Len),Short,Raw,Pascal,Name('SQLPrepareW')
        C25_SQLPrimaryKeysW(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLProcedureColumnsW(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLProceduresW(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLPutData(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLRowCount(Long _StmtHandle, Long _SQLRowCountPtr),Short,Raw,Pascal,Name('SQLRowCount')
        C25_SQLSetConnectAttr(Long, Long, Long,Long),Short,Raw,Pascal,Name('SQLsetconnectattrw')
        C25_SQLSetConnectOptionW(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLSetCursorNameW(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLSetDescFieldW(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLSetDescRec(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLSetEnvAttr(Long SQLenvhandle, Long SQL_Attr_Odbc_Version, Long SQL_Attr_Odbc_Version_Value, Long),Short,Raw,Pascal,Name('SQLSetEnvAttr')
        C25_SQLSetPos(Long, Long, Long, Long),Short,Raw,Pascal,Name('SQLSetPos')
        C25_SQLSetScrollOptions(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLSetStmtAttrw(Long, Long, Long, Long),Short,Raw,Pascal,Name('SQLSetStmtAttrw')
        C25_SQLSpecialColumnsW(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLStatisticsW(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLTablePrivilegesW(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_SQLTablesW(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_TestDlgProc(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_WizDatabaseDlgProc(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_WizDSNDlgProc(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_WizIntSecurityDlgProc(Long _NOTIMPLEMENTEDYET),Long,Proc
        C25_WizLanguageDlgProc(Long _NOTIMPLEMENTEDYET),Long,Proc
    End

