    Include('StringTheory.inc'),once
    Include('jFiles.inc'),once
    Include('cwsynchc.inc'),once
    Include('errors.clw'),once
    Include('c25_DataTypes.clw'),ONCE

QManagerClass Class(),type,Module('c25_QManagerClass.clw'), Link('c25_QManagerClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)

Construct                   Procedure(),private
Destruct                    Procedure(),private
Start                       Procedure()
SQL                         &String
SQLLength                   Long
Sqlite34StmtHandle           Long
CursorPos                   Long
st1                         &StringTheory()
Sqlite34                     &Sqlite34Class()
Sqlite34Q                    &Sqlite34Class()
ReflectionQ                 &TrueReflectionClass()
Properties                  Group(QManagerClasses_TYPE),Pre(Properties).

Init                        Procedure(*queue _queue, <String _tableName>, <QManagerClasses_TYPE _qManagerClassQueue>),String,proc
Reset                       Procedure()
Q                           &queue
StrRec                      &String
StrRecLen                   Long
QJSonParams                 &String
QTableFieldsQ               &PragmaTableInfo_TYPE()
QTableFieldsQ_Count         Long
JsonParamsQ                 &QManagerJsonParams_TYPE()
QTableExists                Byte
ClarionFields             &ClarionFields_TYPE()
ClarionFields_Count       Long
ParseJsonParameters         Procedure(String _jsonParams, QKeyValue_TYPE _field2DataTypeQ),String,proc
ParseJsonConfig             Procedure(String _json),String,proc
Config                      Group,Pre(Config)
ContentEncoding                 CSTRING(128),NAME('Content-Encoding')
                            End
TableExists                 Procedure(String _tableName),Byte
GetQRecord                  Procedure(),String,proc
CRLF                        String(2)
CreateTableFromQueue        Procedure(),String,proc
CursorRowId                 Long
QStateQ                     &QState_TYPE()
Save                        Procedure(<Long _pointer>,<Byte _actionType>),String,proc
MapQueueToTableFields       Procedure(),String,proc
PrepareStatement            Procedure(String _type),String,proc
BindTableRecord             Procedure(),String,proc
ExecutePreparedStatement    Procedure(),String,proc
SQLITE_API_RETURN           Long
SESSIONINPUTID              Decimal(20,0)
SESSIONINPUTIDTxt           String(20)
TableHasSESSIONINPUTID      Byte
TableHasUPDATEDATETIME      Byte
TableHasCRC32RECORD      Byte
BindSESSIONINPUTID          Byte
BindSESSIONINPUTIDParamIndex   Long
QueueHasROWID               Byte
QueueROWIDIndex             Long
QueueHasSESSIONINPUTID      Byte
QueueHasUPDATEDATETIME      Byte
QueueHasCRC32RECORD      Byte
LoadQueueRecords            Procedure(),String,proc
AddRecord                   Procedure(*queue _queue),String,proc
LastPreparedStatementType   CString(128)
LoadIntoQueue               Procedure(*queue _queue, String _tableName),String,proc
Log                         Byte
St1Log                      &StringTheory()
Sqlite34ConnString           CString(1024)
IsDiskDb                    Byte

                        End

