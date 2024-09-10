        Member()
        include('c25_QManagerClass.inc'), once
        Include('c25_Sqlite34Class.inc'), once
        Include('c25_TrueReflectionClass.inc'), once

         Map
                Include('c25_Prototypes_WinApi32.clw')
                Include('c25_Prototypes_Sqlite3.clw')
                Include('i64.inc')
        End

QManagerClass.Construct              Procedure()

    Code

QManagerClass.Start              Procedure()

    Code

        Self.CRLF =  Chr(13) & Chr(10)
        Self.ClarionFields &= NULL
        Self.QStateQ &= null
        Self.st1 &= NEW StringTheory()
        Self.LastPreparedStatementType = 'PreparedStatementType:None'

        Self.Sqlite34 &= NEW Sqlite34Class()

        Self.Sqlite34Q &= NEW Sqlite34Class()

QManagerClass.Destruct             Procedure()

        Code

QManagerClass.Reset Procedure()

    Code

        Dispose(Self.SQL)
        Self.SQLLength                   = 0
        Self.Sqlite34StmtHandle           = 0
        Self.CursorPos                   = 0
        Dispose(Self.st1)
        Dispose(Self.Sqlite34)
        Dispose(Self.ReflectionQ)
        Dispose(Self.Q)
        Dispose(Self.StrRec)
        Self.StrRecLen                   = 0
        Self.Properties.TableName                   = ''
        Dispose(Self.QJSonParams)
        Dispose(Self.QTableFieldsQ)
        Self.QTableFieldsQ_Count         = 0
        Dispose(Self.JsonParamsQ)
        Self.QTableExists                = 0
        Dispose(Self.ClarionFields)
        Self.CRLF                        = ''
        Self.CursorRowId                 = 0
        Dispose(Self.QStateQ)
        Self.SQLITE_API_RETURN           = 0
        Self.SESSIONINPUTID              = 0
        Self.SESSIONINPUTIDTxt           = ''
        Self.TableHasSESSIONINPUTID      = 0
        Self.TableHasUPDATEDATETIME      = 0
        Self.TableHasCRC32RECORD      = 0
        Self.BindSESSIONINPUTID          = 0
        Self.BindSESSIONINPUTIDParamIndex = 0
        Self.QueueHasROWID               = 0
        Self.QueueROWIDIndex             = 0
        Self.QueueHasSESSIONINPUTID      = 0
        Self.QueueHasUPDATEDATETIME      = 0
        Self.QueueHasCRC32RECORD      = 0
        Dispose(Self.Properties.QManager)
        Dispose(Self.Properties.JsonParams)
        Dispose(Self.Properties.QueueName)
        Dispose(Self.Properties.TableName)
        Clear(Self.Properties)

QManagerClass.Init             Procedure(*queue _queue,  <String _tableName>, <QManagerClasses_TYPE _qManagerClassQueue>)

RowId_Offset                        Long
Id_Offset                           Long
Str4                                String(4)
ULongOverStr4                       ULong,over(str4)
I                                   Long
T                                   Long
QClarionFields                      Group(ClarionFields_TYPE),Pre(QClarionFields).
ProtoGroupQueue                     group,pre(ProtoGroupQueue)
SomeQueue                               &QUEUE
                                    End

    Code

        Self.JsonParamsQ            &= NEW QManagerJsonParams_TYPE()
        Self.ReflectionQ            &= NEW TrueReflectionClass()
        Self.QTableFieldsQ          &= NEW PragmaTableInfo_TYPE()
        Self.ClarionFields        &= NEW ClarionFields_TYPE()

        Self.StrRecLen              = Size(_queue)
        Self.StrRec                 &= NEW String(Self.StrRecLen)
        Self.Q                      &= _queue

        If OMITTED(_qManagerClassQueue) = False
            Self.Properties = _qManagerClassQueue
        End
        If OMITTED(_tableName) = False
            Self.Properties.TableName &= NEW String(Len(Clip(_tableName)))
            Self.Properties.TableName = _tableName

        End
        Self.Sqlite34                &= NEW Sqlite34Class()

        Self.Sqlite34Q               &= NEW Sqlite34Class()

        Self.ReflectionQ.Analyze(Self.Q,Self.ClarionFields, Self.Properties.AutoStyleColumns)

        Self.ClarionFields_Count  = Records(Self.ClarionFields)

        Self.QTableExists           = Self.TableExists(Clip(Self.Properties.TableName))

        If Self.QTableExists = True
            If Self.Properties.DropTable = True
                Self.Sqlite34.ExecuteNonQuery('DROP TABLE ' & Clip(Self.Properties.TableName))
            End
        Else
            Self.CreateTableFromQueue()
        End

        Self.ReflectionQ.GetTableMetaData(Clip(Self.Properties.TableName) ,Self.QTableFieldsQ)
        Self.QTableFieldsQ_Count = Records(Self.QTableFieldsQ)

        I = 0
        Loop Self.QTableFieldsQ_Count TIMES
            I = I + 1
            Get(Self.QTableFieldsQ,I)
            If Upper(Clip(Self.QTableFieldsQ.name)) = 'SESSIONINPUTID'
                Self.TableHasSESSIONINPUTID = TRUE
            End
            If Upper(Clip(Self.QTableFieldsQ.name)) = 'UPDATEDATETIME'
                Self.TableHasUPDATEDATETIME = TRUE
            End
            If Upper(Clip(Self.QTableFieldsQ.name)) = 'CRC32RECORD'
                Self.TableHasCRC32RECORD = TRUE
            End
        End

        Self.MapQueueToTableFields()

        RowId_Offset = -1
        Id_Offset = -1

        If Self.ReflectionQ.HasField('RowId')
            RowId_Offset = Self.ReflectionQ.GetFieldOffset('RowId')
        End
        If Self.ReflectionQ.HasField('Id')
            Id_Offset = Self.ReflectionQ.GetFieldOffset('Id')
        End

        If not Self.QStateQ &= null
            Dispose(Self.QStateQ)
        End

        Self.QStateQ &= NEW QState_TYPE()

        T = Records(Self.Q)
        I = 0
        Loop T TIMES
            I = I + 1
            Get(Self.Q,I)
            If Errorcode() <> 0
                BREAK
            End
            Clear(Self.QStateQ)

            Self.QStateQ.Index = I
            If RowId_Offset > -1
                Self.StrRec = Self.Q
                Str4 = Self.StrRec[RowId_Offset + 1 : RowId_Offset + 1 + 3]
                Self.QStateQ.ROWID = ULongOverStr4
            End
            If Id_Offset > -1
                Self.StrRec = Self.Q
                Str4 = Self.StrRec[Id_Offset + 1: Id_Offset + 1 + 3]
                Self.QStateQ.ID = ULongOverStr4
            End
            If Self.QStateQ.ROWID = 0
                Self.QStateQ.State = QState:NewQueueRecord
            ELSE
                Self.QStateQ.State = QState:LoadQueueRecord
            End
            Add(Self.QStateQ)
        End

        Self.Save()

        Self.LoadQueueRecords()

        Return ''

QManagerClass.LoadQueueRecords        Procedure()

    Code

        Return ''

QManagerClass.GetQRecord        Procedure()

    Code

        Return ''

QManagerClass.TableExists   Procedure(String _tableName)

CountResult                     Long

    Code

        Self.Sqlite34.ExecuteScalarTurboReturnType = 1
        CountResult = Self.Sqlite34.ExecuteScalarTurbo('SELECT count(*) FROM sqlite_master WHERE type=''table'' AND name=''' & _tableName & ''';')
        If CountResult > 0
            Return True
        End
        Return False

QManagerClass.CreateTableFromQueue  Procedure()

st1                                 &StringTheory()
G                                   Long
ReturnString                        String(65000)

    Code

        st1 &= NEW StringTheory()
        st1.Start()

        st1.Start()
        st1.SetValue('')
        st1.Append('CREATE TABLE If NOT EXISTS ' & Clip(Self.Properties.TableName) & ' ('  & Self.CRLF)

        st1.Append('ROWID INTEGER PRIMARY KEY AUTOINCREMENT,'  & Self.CRLF)

        st1.Append('SESSIONINPUTID TEXT COLLATE NOCASE,'  & Self.CRLF)
        st1.Append('UPDATEDATETIME TEXT COLLATE NOCASE,'  & Self.CRLF)
        st1.Append('CRC32RECORD INTEGER,'  & Self.CRLF)

        G = 0
        Loop
            G = G + 1
            Get(Self.ClarionFields,G)
            If Errorcode() <> 0
                BREAK
            End
            Case Upper(Self.ClarionFields.Name)
            Of 'ROWID'
            OROF 'SESSIONINPUTID'
            OROF 'UPDATEDATETIME'
            OrOf 'CRC32RECORD'
                Cycle
            End

            Case Upper(Self.ClarionFields.DataType)
            Of 'Byte'
            OrOf 'UShort'
            OrOf 'Short'
            OrOf 'Long'
            OrOf 'ULong'
                st1.Append('[' & Self.ClarionFields.Name & '] '  & 'INTEGER' & ',' & Self.CRLF)
            Else
                st1.Append('[' & Self.ClarionFields.Name & '] TEXT COLLATE NOCASE,' & Self.CRLF)
            End
        End

        st1.Crop(1, st1.Length() - 3)
        st1.Append(');'  & Self.CRLF)
        st1.Append(Self.CRLF)

        ReturnString = st1.GetValue()

        Self.Sqlite34.ExecuteNonQuery(st1.GetValue())

        Dispose(st1)

        Return ReturnString

QManagerClass.ParseJsonParameters   Procedure(String _jsonParams, QKeyValue_TYPE _field2DataTypeQ)

JsonParams                              &JSONClass
JsonParamsRecord                        &JSONClass
st1                                     &StringTheory
i1                                      Long
i2                                      Long

    Code

        Self.JsonParamsQ.FieldEncodingQ &= NEW FieldEncoding_TYPE()

        JsonParams &= NEW JSONClass()
        st1 &= NEW StringTheory()

        JsonParams.LoadString(_jsonParams)
        st1.Start()

        Dispose(JsonParams)
        Dispose(JsonParamsRecord)
        Dispose(st1)

        Return ''

QManagerClass.MapQueueToTableFields      Procedure()

I                                       Long
I2                                      Long
    Code

        Self.QueueHasROWID = 0
        Self.QueueROWIDIndex = 0

        I = 0
        Loop
            I = I + 1
            Get(Self.ClarionFields,I)
            If Errorcode() <> 0
                Break
            End

            Case Upper(clip(Self.ClarionFields.Name))
            Of 'ROWID'
            OrOf 'SESSIONINPUTID'
            OrOf 'UPDATEDATETIME'
            OrOf 'CRC32RECORD'
                Self.ClarionFields.ExcludeInPrepare = True
                Put(Self.ClarionFields)
            End
            Case Upper(clip(Self.ClarionFields.Name))
            Of 'ROWID'
                Self.QueueHasROWID = True
                Self.QueueROWIDIndex = I
            Of 'SESSIONINPUTID'
            Of 'UPDATEDATETIME'
            Of 'CRC32RECORD'
            End

            I2 = 0
            Loop Self.QTableFieldsQ_Count Times
                I2 = I2 + 1
                Get(Self.QTableFieldsQ,I2)
                If Errorcode() <> 0
                    Break
                End

                If Upper(clip(Self.QTableFieldsQ.name)) = Upper(clip(Self.ClarionFields.Name))
                    Self.ClarionFields.QTableFieldsQ_Index = I2
                    Put(Self.ClarionFields)

                    Self.QTableFieldsQ.ClarionFields_Index = I
                    Put(Self.QTableFieldsQ)

                    BREAK
                End
            End
        End

        Return ''

QManagerClass.ParseJsonConfig       Procedure(String _json)

Config                      Group,Pre(Config)
ContentEncoding                 CSTRING(128),NAME('Content-Encoding')
                            End
js1                                     &JSONClass
st1                                     &StringTheory()

        Code

            st1  &= NEW StringTheory()
            st1.Start()
            st1.Append(_json)

            js1 &= NEW JSONClass()
            js1.Start()
            js1.SetTagCase(jf:CaseAny)
            js1.Load(Config, st1)

            js1.Start()
            Dispose(js1)

            st1.Start()
            dispose(st1)

            Return ''

QManagerClass.BindTableRecord        Procedure()

T                               Long
I                               Long
RecIdx                          Long
CurrentFieldAny                 ANY
Address                         Long
AdrGroup                        Group,pre(AdrGroup)
PtrAddress                          Long
PtrSize                             Long
                                End
AddressFromAny                  String(4),over(Address)
AddressAndSizeFromAny           String(8),over(AdrGroup)
ptrQueue                        &queue
ptrStringTheory                 &stringtheory
ptrString                       &String
ptrCString                      &cstring
ptrPString                      &pstring
SQLLine16K                      String(16000)
SQL                             &String
SQLLen                          Long
SQLITE_API_RETURN               Long
SqliteStmtHandle                Long
IntVal                          Long
SpecialRecordsCount             Long
NewField                        &String
NewFieldLen                     Long
INTSTR8                         String(8)
Int32                           Long
Str4OverInt32                   String(4),OVER(Int32)
Int64Grp                                    LIKE(INT64)
Str8OverInt64                   String(8),OVER(Int64Grp)
UInt32                          ULong
Str4OverUInt32                  String(4),OVER(UInt32)
UInt64Grp                       LIKE(UINT64)
Str8OverUInt64                  String(8),OVER(UInt64Grp)
SomeReal                        REAL
Sqlite34_uint64                  real,over(UInt64Grp)
SelfQI                                      Long

LogFileName                                 cstring(255)

    Code

        If Self.st1 &= NULL
            Self.st1 &= NEW StringTheory()
        End

        If Self.BindSESSIONINPUTID = TRUE
            Sqlite34_bind_text(Self.Sqlite34Q.PreparedStmtHandle, Self.BindSESSIONINPUTIDParamIndex, Address(Self.SESSIONINPUTIDTxt),Len(Clip(Self.SESSIONINPUTIDTxt)),0)
        End

        SelfQI = 0
        I = 0
        Loop Self.ClarionFields_Count TIMES
            I = I + 1
            Get(Self.ClarionFields,I)
            If Errorcode() <> 0
                BREAK
            End
            If Self.ClarionFields.NotExistInQueue
                CYCLE
            End

            SelfQI = SelfQI + 1
            If Self.ClarionFields.ExcludeInPrepare = TRUE
                CYCLE
            End
            If Self.ClarionFields.QTableFieldsQ_Index = 0
                CYCLE
            End

            If Self.Log
                Self.St1Log.Append('-------------------------------------------' & Self.CRLF)
                Self.St1Log.Append(Self.ClarionFields.DataType & ', ' & Self.ClarionFields.Name & Self.CRLF)
            End

            Sqlite34_bind_null( Self.Sqlite34Q.PreparedStmtHandle, Sqlite34_bind_parameter_index( Self.Sqlite34Q.PreparedStmtHandle, '@p' & Self.ClarionFields.ParamId & Chr(0)))

            If Self.ClarionFields.IsRef = True
                CurrentFieldAny &= WHAT(Self.Q,SelfQI)
                If CurrentFieldAny &= null
                    Cycle
                End
                If not CurrentFieldAny &= null
                    AddressAndSizeFromAny = CurrentFieldAny
                    ptrString &= AdrGroup.PtrAddress  & ':' & AdrGroup.PtrSize
                    If ptrString &= NULL
                        CYCLE
                    End
                    If not CurrentFieldAny &= null

                        AddressAndSizeFromAny = CurrentFieldAny
                        ptrString &= AdrGroup.PtrAddress  & ':' & AdrGroup.PtrSize
                        If not ptrString &= null
                            Self.st1.Start()
                            If Self.ClarionFields.IsAnsi
                                Self.st1.encoding = st:EncodeAnsi
                                Self.st1.codepage = st:CP_THREAD_ACP
                                Self.st1.SetValue(Clip(ptrString))
                                Self.st1.ToUnicode(st:EncodeUtf16)
                            End
                            If Self.ClarionFields.IsUtf8
                                Self.st1.encoding = st:EncodeUtf8
                                Self.st1.codepage = st:CP_UTF8
                                Self.st1.SetValue(Clip(ptrString))
                                Self.st1.ToUnicode(st:EncodeUtf16)
                            End
                            If Self.ClarionFields.IsUtf16
                                Self.st1.encoding = st:EncodeUtf16
                                Self.st1.SetValue(Clip(ptrString))
                            End
                            If Self.ClarionFields.IsUtf32
                                Self.st1.encoding = st:EncodeUtf32
                                Self.st1.SetValue(Clip(ptrString))
                                Self.st1.ToUnicode(st:EncodeUtf16)
                            End
                            If Self.ClarionFields.IsBinary = True! TODO TESTING
                                Self.st1.Start()
                                Self.St1.SetValue(CurrentFieldAny)
                                If not NewField &= NULL
                                    Dispose(NewField)
                                End
                                NewFieldLen = Self.St1.Length()
                                If NewFieldLen > 0
                                    NewField &= NEW String(NewFieldLen)
                                    NewField = Self.St1.GetValue()
                                    Clear(UInt64Grp)
                                    UInt64Grp.Lo = Self.St1.Length() !+ 2
                                    Sqlite34_bind_blob( Self.Sqlite34Q.SqliteStmtHandle, Sqlite34_bind_parameter_index( Self.Sqlite34Q.SqliteStmtHandle, '@p' & Self.ClarionFields.ParamId & Chr(0)), Address(NewField),UInt64Grp.Lo,SQLITE_TRANSIENT)
                                End
                            ELSE
                                If not NewField &= NULL
                                    Dispose(NewField)
                                End
                                NewFieldLen = Self.St1.Length()
                                If NewFieldLen > 0
                                    NewField &= NEW String(Self.St1.Length())
                                    NewField = Self.St1.GetValue()
                                    Sqlite34_bind_text16( Self.Sqlite34Q.PreparedStmtHandle, Sqlite34_bind_parameter_index( Self.Sqlite34Q.PreparedStmtHandle, '@p' & Self.ClarionFields.ParamId & Chr(0)), Address(NewField),Self.St1.Length(),SQLITE_STATIC)
                                End
                            End
                        End
                    End
                End
            Else
                CurrentFieldAny &= WHAT(Self.Q,SelfQI)

                If not CurrentFieldAny &= null

                    Case Upper(Self.ClarionFields.DataType)
                    Of 'ULong'
                    OrOf 'Long'
                    OrOf 'UShort'
                    OrOf 'Short'
                    OrOf 'Byte'
                        IntVal = CurrentFieldAny
                        Sqlite34_bind_int( Self.Sqlite34Q.PreparedStmtHandle, Sqlite34_bind_parameter_index( Self.Sqlite34Q.PreparedStmtHandle, '@p' & Self.ClarionFields.ParamId & Chr(0)), IntVal)
                        CYCLE
                    Else

                       Self.st1.Start()
                        If Self.ClarionFields.IsAnsi
                            Self.st1.encoding = st:EncodeAnsi
                            Self.st1.codepage = st:CP_THREAD_ACP
                            Self.st1.SetValue(Clip(CurrentFieldAny))
                            Self.st1.ToUnicode(st:EncodeUtf16)

                        End
                        If Self.ClarionFields.IsUtf8
                            Self.st1.encoding = st:EncodeUtf8
                            Self.st1.codepage = st:CP_UTF8
                            Self.st1.SetValue(Clip(CurrentFieldAny))
                            Self.st1.ToUnicode(st:EncodeUtf16)
                        End
                        If Self.ClarionFields.IsUtf16
                            Self.st1.encoding = st:EncodeUtf16
                            Self.st1.SetValue(Clip(CurrentFieldAny))
                        End
                        If Self.ClarionFields.IsUtf32
                            Self.st1.encoding = st:EncodeUtf32
                            Self.st1.SetValue(Clip(CurrentFieldAny))
                            Self.st1.ToUnicode(st:EncodeUtf16)
                        End
                        If Self.ClarionFields.IsBinary = True! TODO TESTING
                            If not NewField &= NULL
                                Dispose(NewField)
                            End
                            NewFieldLen = Size(CurrentFieldAny)
                            If NewFieldLen > 0
                                NewField &= New String(NewFieldLen)
                                NewField = CurrentFieldAny
                                If NewFieldLen > 0
                                   Sqlite34_bind_text( Self.Sqlite34Q.PreparedStmtHandle, Sqlite34_bind_parameter_index( Self.Sqlite34Q.PreparedStmtHandle, '@p' & Self.ClarionFields.ParamId & Chr(0)), Address(NewField),NewFieldLen,SQLITE_STATIC)
                                End
                            End
                        ELSE
                            If not NewField &= NULL
                                Dispose(NewField)
                            End

                            NewFieldLen = Self.St1.Length()
                            If NewFieldLen > 0
                                Self.St1.Append( Chr(0) & Chr(0) & Chr(0) )
                                NewField &= NEW String(Self.St1.Length() + 2)
                                NewField = Chr(0FFh) & Chr(0FEh) & Self.St1.GetValue()
                                P# = Size(NewField) + 1
                                Loop
                                    P# = P# - 1
                                    If P# < 1
                                        BREAK
                                    End
                                    If NewField[P#] = Chr(0)
                                        CYCLE
                                    End
                                    BREAK
                                End
                                If (P#%2) ! odd
                                    P# = P# + 1
                                End
                                Clear(UInt64Grp)
                                UInt64Grp.Lo = P#
                                Sqlite34_bind_text64( Self.Sqlite34Q.PreparedStmtHandle, Sqlite34_bind_parameter_index( Self.Sqlite34Q.PreparedStmtHandle, '@p' & Self.ClarionFields.ParamId & Chr(0)), Address(NewField),Sqlite34_uint64,SQLITE_STATIC, SQLITE_UTF16LE)
                            End
                        End
                    End

                End

            End
        End

        If Self.Log
            Self.St1Log.SaveFile(logfilename, true)
        End

        Return ''

QManagerClass.PrepareStatement      Procedure(String _type)

SQLITE_API_RETURN           Long
SQLLine16K                  String(65000)
SpecialRecordsCount         Long
F                           Long
ParamFieldIndex             Long

    Code

        Self.BindSESSIONINPUTIDParamIndex = 0
        Case Upper(CLIP(_type))
        Of 'INSERT'
            SQLLine16K = 'INSERT INTO ' & Clip(Self.Properties.TableName) & ' ('
            ParamFieldIndex = 0
            Self.BindSESSIONINPUTID = TRUE

            If Self.TableHasSESSIONINPUTID = True And Self.BindSESSIONINPUTID = TRUE
                SQLLine16K = Clip(SQLLine16K) & 'SESSIONINPUTID, '
                ParamFieldIndex = ParamFieldIndex + 1
                Self.BindSESSIONINPUTIDParamIndex = ParamFieldIndex
            Else
                Self.BindSESSIONINPUTID = False
            End
        End
        F = 0
        Loop Self.ClarionFields_Count Times
            F = F + 1
            Get(Self.ClarionFields,F)
            If Self.ClarionFields.ExcludeInPrepare = TRUE
                CYCLE
            End
            If F < Self.ClarionFields_Count
                SQLLine16K = Clip(SQLLine16K) & ' [' & Clip(Self.ClarionFields.Name) & '], '
            ELSE
                SQLLine16K = Clip(SQLLine16K) & ' [' & Clip(Self.ClarionFields.Name)& ']'
                SQLLine16K = Clip(SQLLine16K)& ') VALUES('
                BREAK
            End
        End

        ParamFieldIndex = 0
        If Self.BindSESSIONINPUTIDParamIndex > 0
            ParamFieldIndex = ParamFieldIndex + 1
            SQLLine16K = Clip(SQLLine16K) & '@p' & Self.BindSESSIONINPUTIDParamIndex
        Else
            Self.BindSESSIONINPUTID = False
        End

        F = 0
        Loop Self.ClarionFields_Count Times
            F = F + 1
            Get(Self.ClarionFields,F)
            If Self.ClarionFields.ExcludeInPrepare = TRUE
                CYCLE
            End
            ParamFieldIndex = ParamFieldIndex + 1
            Self.ClarionFields.ParamId = ParamFieldIndex
            Put(Self.ClarionFields)

            If ParamFieldIndex = 1
                SQLLine16K = Clip(SQLLine16K) & '@p' & ParamFieldIndex
                CYCLE
            End

            If F < Self.ClarionFields_Count
                SQLLine16K = Clip(SQLLine16K) & ', @p' & ParamFieldIndex
            Else
                SQLLine16K = Clip(SQLLine16K) & ', @p' & ParamFieldIndex
                SQLLine16K = Clip(SQLLine16K) & ');'
            End
        End
        Self.Sqlite34Q.Sqlite34_prepare_v2(SQLLine16K)

        Self.LastPreparedStatementType = _type
        Return ''

QManagerClass.Save          Procedure(<Long _pointer>, <Byte _actionType>)

ScalarReturnInt             Long
ScalarReturnString          String(20)
ScalarReturnDec             Decimal(20,0)
T                           Long
LastRowIdReal               real
LastRowIdBefore             Long
LastRowId                   Long
LastRowIdsReal              sreal
LONGValue                   Long
STR4OVERLONG                String(4),OVER(LONGValue)
AnyField                    ANY
FIRSTSESSIONINPUTID         String(20)
LASTSESSIONINPUTID          String(20)
ActionType                  Cstring(128)

    Code

        Self.SESSIONINPUTID = Random(2^28,2^31) & Random(2^30,2^31) & Random(2^30,2^31)
        Self.SESSIONINPUTID = Self.SESSIONINPUTID / 100
        FIRSTSESSIONINPUTID = Self.SESSIONINPUTID
        T = Records(Self.Q)
        Self.PrepareStatement('INSERT')
        Self.CursorPos = 0
        If _pointer <> 0
            T = 1
            Self.CursorPos = _pointer - 1
        End
        Loop T TIMES
            Self.CursorPos = Self.CursorPos + 1
            Get(Self.Q,Self.CursorPos)
            If Errorcode() <> 0
                BREAK
            End
            Get(Self.QStateQ,Self.CursorPos)
            If Errorcode() <> 0
                Self.QStateQ.State = QState:NewQueueRecord ! todo is hook
            End
            Case Self.QStateQ.State
            Of QState:NewQueueRecord                                                              !EQUATE(3)

                Self.SESSIONINPUTID = Self.SESSIONINPUTID + 1
                Self.SESSIONINPUTIDTxt = Self.SESSIONINPUTID
                If LEN(Clip(FIRSTSESSIONINPUTID)) = 0
                    FIRSTSESSIONINPUTID = Self.SESSIONINPUTID
                End
                Self.BindTableRecord()

                LastRowIdBefore = Sqlite34_last_insert_rowid( Self.Sqlite34Q.ConnHandle)
                Self.ExecutePreparedStatement()
                LastRowId = Sqlite34_last_insert_rowid( Self.Sqlite34Q.ConnHandle)
                If LastRowId - 1 <> LastRowIdBefore
                    ScalarReturnString = Self.Sqlite34Q.ExecuteScalarTurbo('select SESSIONINPUTID from ' & Clip(Self.Properties.TableName) & ' WHERE ROWID = ' & LastRowId)
                    If Clip(ScalarReturnString) <> Clip(Self.SESSIONINPUTIDTxt)
                       LastRowId = Self.Sqlite34Q.ExecuteScalarTurbo('select ROWID from ' & Clip(Self.Properties.TableName) & ' WHERE SESSIONINPUTID = "' & Clip(Self.SESSIONINPUTIDTxt) & '"')
                    End
                End

                If Self.QueueHasROWID = True
                    AnyField &= null
                    AnyField &= WHAT(Self.Q,Self.QueueROWIDIndex)
                    If not AnyField &= NULL
                        AnyField = LastRowId
                        Put(Self.Q)
                    End
                End

                Self.QStateQ.State = QState:Synced
                Put(Self.QStateQ)
            End

        End
        LASTSESSIONINPUTID = Self.SESSIONINPUTID
        Self.SQLITE_API_RETURN = Sqlite34_finalize( Self.Sqlite34Q.PreparedStmtHandle)
        If Self.SQLITE_API_RETURN <> SQLITE_OK
            Return 0
        End
        LASTSESSIONINPUTID = Self.SESSIONINPUTID
        Self.Sqlite34Q.ExecuteNonQuery('UPDATE ' & Clip(Self.Properties.TableName) & ' SET SESSIONINPUTID = NULL WHERE SESSIONINPUTID >= ' & FIRSTSESSIONINPUTID & ' AND SESSIONINPUTID <= ' & LASTSESSIONINPUTID)

        Return ''

QManagerClass.ExecutePreparedStatement      Procedure()

    Code

        Self.SQLITE_API_RETURN = 0
        Self.SQLITE_API_RETURN   = Sqlite34_step( Self.Sqlite34Q.PreparedStmtHandle)
        If (Self.SQLITE_API_RETURN <> SQLITE_ROW and Self.SQLITE_API_RETURN <> SQLITE_DONE)
        End

        Self.SQLITE_API_RETURN   = Sqlite34_reset( Self.Sqlite34Q.PreparedStmtHandle)
        If Self.SQLITE_API_RETURN <> SQLITE_OK
        End

        Self.SQLITE_API_RETURN   = Sqlite34_clear_bindings( Self.Sqlite34Q.PreparedStmtHandle)
        If Self.SQLITE_API_RETURN <> SQLITE_OK
        End
        Return ''

QManagerClass.AddRecord     Procedure(*queue _queue)

    Code

        Self.Save()

        Return ''

QManagerClass.LoadIntoQueue Procedure(*queue _queue, String _tableName)

    Code

        Return ''

