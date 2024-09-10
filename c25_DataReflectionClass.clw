        Member

        Include('c25_ProgramHandlerClass.inc'),Once


                    MAP
                        Include('CWUTIL.inc'),once
                        Include('i64.inc')
                        Include('c25_WinApiPrototypes.inc')
                    End

c25_DataReflectionClass.Destruct                                    Procedure()

Code

    Dispose(Self.BitConverter)
    Dispose(Self.ClarionFields)
    Dispose(Self.ClarionFields1)
    Dispose(Self.ClarionFields2)
    Dispose(Self.EF_ptrString)
    Dispose(Self.MetaQueueObjectsQ)
    Dispose(Self.DataReflection1)
    Dispose(Self.DataReflection2)

c25_DataReflectionClass.Construct                                   Procedure()

Code

	Self.CRLF               = Chr(13) & Chr(10)
	Self.ClarionFields      &= NEW ClarionFields_TYPE()
	Self.Str8Zeroed         = All(Chr(0),8)
	Self.BitConverter       &= NEW c25_BitConverterClass()
    Self.QBytesDll          &= NEW QBytesDll_TYPE()
    Self.QDLLSections       &= NEW QDLLSections_TYPE()
    Self.ObjectClass        &= NEW c25_ObjectClass()
    Self.StLoadedDll        &= NEW StringTheory()
    Self.StInMemDll         &= NEW StringTheory()
    Self.DataTypeEngines    &= NEW DataTypeEngines_TYPE()
    Self.DataTypes          &= NEW DataTypes_TYPE()
    Self.PopulateDataTypeEngines()
    Self.PopulateDataTypes()

    
    
    
    
c25_DataReflectionClass.SqliteCreateTableSql     Procedure(*SqliteTable_TYPE _sqliteTable)

Sql &STRING

CODE
    
    Self.BitConverter.St1.Start()
    Self.BitConverter.St1.Append('CREATE TABLE "' & _sqliteTable.Name & '" (' & Self.BitConverter.CRLF)
    
    T# = Records(_sqliteTable.SqliteTableColumns)
    I# = 0
    LOOP
        I# = I# + 1
        Get(_sqliteTable.SqliteTableColumns,I#)
        If Errorcode() <> 0
            BREAK
        End
        
        Self.BitConverter.St1.Append('"' & _sqliteTable.SqliteTableColumns.Name & '" ' & _sqliteTable.SqliteTableColumns.DataType & ' ')
        If _sqliteTable.SqliteTableColumns.IsPrimaryKey
            Self.BitConverter.St1.Append('primary key ')
        End
        If _sqliteTable.SqliteTableColumns.NotNull
            Self.BitConverter.St1.Append('not null ')
        End       
        
        If I# < T#
            Self.BitConverter.St1.Append(' ,' & Self.BitConverter.CRLF)
        Else
            Self.BitConverter.St1.Append(' )' & Self.BitConverter.CRLF)
        End
    End
    
    Sql &= NEW STRING(Self.BitConverter.St1.Length())
    Sql = Self.BitConverter.St1.GetValue()
    
    Return Sql
    
    
    
c25_DataReflectionClass.EnumProcessModules                            Procedure()

StartOffset                                 Long
NewByte                                     byte
GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS      equate(4)
GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT                            equate(2)

lphModule string(64000)
lpcbNeeded         Long
BaseName           cstring(2024)

st &StringTheory
Code

    st &= NEW StringTheory()
    st.Start()
    
    !return 0
!GetModuleHandleEx(
!    GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS,
!    (LPCTSTR)GetCurrentModule,
!    &hModule);
!
!  return hModule;    

    !Loop
        !B# = c25_EnumProcessModules(c25_GetCurrentProcess(), Address(lphModule), Size(lphModule), Address(lpcbNeeded))
        !Message('lpcbNeeded ' & lpcbNeeded)
!        If B# = 0
!            BREAK
!        End
    B# = c25_EnumProcessModules(c25_GetCurrentProcess(), Address(lphModule), Size(lphModule), Address(lpcbNeeded))
    !Message('lpcbNeeded ' & lpcbNeeded)
    
    if Self.stLog &= NULL
        Self.stLog &= NEW StringTheory()
    END
    
    Self.stLog.Start()
    
    P# = -4
    Loop lpcbNeeded / 4 TIMES
        P# = P# + 4
        C25_Memcpy(Address(Self.ModuleHandle), Address(lphModule) + P#,4)
        !Message('Self.ModuleHandle ' & Self.ModuleHandle)
        
        C25_GetModuleInformation(c25_GetCurrentProcess(), Self.ModuleHandle, Address(Self.ModuleInfo), Size(Self.ModuleInfo))
        
        !Self.ModuleInfo.
        !address = Self.ModuleInfo.BaseOfDll;
        !_size = Self.ModuleInfo.SizeOfImage;
        !Message('EntryPoint ' & Self.ModuleInfo.EntryPoint)
        
        !Message('_address ' & _address)
        !Message('_size ' & _size)        
        !BREAK
        
        Clear(BaseName)
        c25_GetModuleFileNameExA(c25_GetCurrentProcess(), Self.ModuleHandle, Address(BaseName), Size(BaseName)-1)
        Self.stLog.Append(Clip(BaseName) & '<13,10>')
        
        st.SetValue(Clip(BaseName))
        If st.FindChars('c25DataManager.dll')
            BREAK
        End
    End
    Dispose(st)
    
    Self.stLog.Replace(Chr(0),'')
    !SETCLIPBOARD(Self.stLog.GetValue())    
    Return Self.stLog.GetValue()
    
    
c25_DataReflectionClass.PopulateDataTypes   Procedure()

CODE
    
    Self.DataTypesSeedId = 0
    Free(Self.DataTypes)


    I# = -1
    LOOP 10000 Times
        I# = I# + 1
        Self.DataTypesSeedId      = Self.DataTypesSeedId + 1
        Self.DataTypes.Id         = Self.DataTypesSeedId
        Self.DataTypes.Enum       = Self.DataTypesSeedId
        Self.DataTypes.Name       = Self.GetDataTypeFromEnum(Self.DataTypes.Enum)
        Self.DataTypes.DataTypeEngineEnum = Self.GetDataTypeEngineEnumFromDataTypeEnum(Self.DataTypes.Enum)
        Self.DataTypes.DataTypeEngine = Self.GetDataTypeEngine(Self.DataTypes.DataTypeEngineEnum)
        If Len(Clip(Self.DataTypes.Name)) > 1
            Add(Self.DataTypes)
        End
        If Self.DataTypes.Enum = DataTypeEnum:UNKNOWN
            BREAK
        End  
    End
    !Message(Records(Self.DataTypes))
    Return 0

c25_DataReflectionClass.GetDataTypeEngine   Procedure(long _dataTypeEngineEnum)

CODE 

    
    Case Lower(Clip(_dataTypeEngineEnum))
    Of DataTypeEnginesEnum:Clarion  
        Return 'Clarion'
    Of DataTypeEnginesEnum:ClarionExtended   
        Return 'ClarionExtended'
    Of DataTypeEnginesEnum:CSharp         
        Return 'CSharp'
    Of DataTypeEnginesEnum:MsSql    
        Return 'MsSql'
    Of DataTypeEnginesEnum:SQLC   
        Return 'SQLC'
    Of DataTypeEnginesEnum:Sqlite  
        Return 'Sqlite'
    Of DataTypeEnginesEnum:Oracle  
        Return 'Oracle'
    Of DataTypeEnginesEnum:MySql    
        Return 'MySql'
    Of DataTypeEnginesEnum:Progress  
        Return 'Progress'
    Of DataTypeEnginesEnum:Other  
        Return 'Other'
    Of DataTypeEnginesEnum:Unknown   
        Return 'Unknown'
    End
    Return ''
    
c25_DataReflectionClass.PopulateDataTypeEngines     Procedure()

CODE

    Self.DataTypeEnginesSeedId = 0
    Free(Self.DataTypeEngines)

    Self.DataTypeEnginesSeedId      = Self.DataTypeEnginesSeedId + 1
    Self.DataTypeEngines.Id         = Self.DataTypeEnginesSeedId
    Self.DataTypeEngines.Name       = 'Clarion'
    Self.DataTypeEngines.Enum       = Self.GetDataTypeEngineEnum(Self.DataTypeEngines.Name)
    Add(Self.DataTypeEngines)

    Self.DataTypeEnginesSeedId      = Self.DataTypeEnginesSeedId + 1
    Self.DataTypeEngines.Id         = Self.DataTypeEnginesSeedId
    Self.DataTypeEngines.Name       = 'ClarionExtended'
    Self.DataTypeEngines.Enum       = Self.GetDataTypeEngineEnum(Self.DataTypeEngines.Name)
    Add(Self.DataTypeEngines)

    Self.DataTypeEnginesSeedId      = Self.DataTypeEnginesSeedId + 1
    Self.DataTypeEngines.Id         = Self.DataTypeEnginesSeedId
    Self.DataTypeEngines.Name       = 'CSharp'
    Self.DataTypeEngines.Enum       = Self.GetDataTypeEngineEnum(Self.DataTypeEngines.Name)
    Add(Self.DataTypeEngines)

    Self.DataTypeEnginesSeedId      = Self.DataTypeEnginesSeedId + 1
    Self.DataTypeEngines.Id         = Self.DataTypeEnginesSeedId
    Self.DataTypeEngines.Name       = 'MsSql'
    Self.DataTypeEngines.Enum       = Self.GetDataTypeEngineEnum(Self.DataTypeEngines.Name)
    Add(Self.DataTypeEngines)

    Self.DataTypeEnginesSeedId      = Self.DataTypeEnginesSeedId + 1
    Self.DataTypeEngines.Id         = Self.DataTypeEnginesSeedId
    Self.DataTypeEngines.Name       = 'Sqlite'
    Self.DataTypeEngines.Enum       = Self.GetDataTypeEngineEnum(Self.DataTypeEngines.Name)
    Add(Self.DataTypeEngines)

    Self.DataTypeEnginesSeedId      = Self.DataTypeEnginesSeedId + 1
    Self.DataTypeEngines.Id         = Self.DataTypeEnginesSeedId
    Self.DataTypeEngines.Name       = 'Oracle'
    Self.DataTypeEngines.Enum       = Self.GetDataTypeEngineEnum(Self.DataTypeEngines.Name)
    Add(Self.DataTypeEngines)

    Self.DataTypeEnginesSeedId      = Self.DataTypeEnginesSeedId + 1
    Self.DataTypeEngines.Id         = Self.DataTypeEnginesSeedId
    Self.DataTypeEngines.Name       = 'MySql'
    Self.DataTypeEngines.Enum       = Self.GetDataTypeEngineEnum(Self.DataTypeEngines.Name)
    Add(Self.DataTypeEngines)

    Self.DataTypeEnginesSeedId      = Self.DataTypeEnginesSeedId + 1
    Self.DataTypeEngines.Id         = Self.DataTypeEnginesSeedId
    Self.DataTypeEngines.Name       = 'Progress'
    Self.DataTypeEngines.Enum       = Self.GetDataTypeEngineEnum(Self.DataTypeEngines.Name)
    Add(Self.DataTypeEngines)

    Self.DataTypeEnginesSeedId      = Self.DataTypeEnginesSeedId + 1
    Self.DataTypeEngines.Id         = Self.DataTypeEnginesSeedId
    Self.DataTypeEngines.Name       = 'SQLC'
    Self.DataTypeEngines.Enum       = Self.GetDataTypeEngineEnum(Self.DataTypeEngines.Name)
    Add(Self.DataTypeEngines)

    Self.DataTypeEnginesSeedId      = Self.DataTypeEnginesSeedId + 1
    Self.DataTypeEngines.Id         = Self.DataTypeEnginesSeedId
    Self.DataTypeEngines.Name       = 'Other'
    Self.DataTypeEngines.Enum       = Self.GetDataTypeEngineEnum(Self.DataTypeEngines.Name)
    Add(Self.DataTypeEngines)

    Self.DataTypeEnginesSeedId      = Self.DataTypeEnginesSeedId + 1
    Self.DataTypeEngines.Id         = Self.DataTypeEnginesSeedId
    Self.DataTypeEngines.Name       = 'Unknown'
    Self.DataTypeEngines.Enum       = Self.GetDataTypeEngineEnum(Self.DataTypeEngines.Name)
    Add(Self.DataTypeEngines)

    
    Return 0

c25_DataReflectionClass.GetDataTypeEngineEnum      Procedure(string _dataTypeEngine)

CODE
        
    Case Lower(Clip(_dataTypeEngine))
    Of 'unknown'
        Return DataTypeEnginesEnum:Unknown
    Of 'clarion'
        Return DataTypeEnginesEnum:Clarion
    Of 'clarionextended'
    OrOf 'clarion extended'
        Return DataTypeEnginesEnum:ClarionExtended
    Of 'csharp'
        Return DataTypeEnginesEnum:CSharp
    Of 'mssql'
    OrOf 'mssqlserver'
    OrOf 'mssql server'
        Return DataTypeEnginesEnum:MsSql
    Of 'sqlite'
    OrOf 'sqlite3'
        Return DataTypeEnginesEnum:Sqlite
    Of 'oracle'
        Return DataTypeEnginesEnum:Oracle
    Of 'other'
        Return DataTypeEnginesEnum:Other        
    End
    Return DataTypeEnginesEnum:Unknown

c25_DataReflectionClass.DataTableProperty2DataTablePropertyEnum     Procedure(string _property)

CODE
        
    If Self.BitConverter.StringIsInt(_property)
        Return _property
    End
    Case lower(Clip(_property))
    Of 'name' 
        Return DataTablePropertyEnum:Name
    Of 'creationtime'
        Return  DataTablePropertyEnum:CreationTime                            
    Of 'modificationtime' 
        Return  DataTablePropertyEnum:ModificationTime                        
    Of 'autoaddstylecolumns' 
        Return  DataTablePropertyEnum:AutoAddStyleColumns                     
    Of 'autoaddutf16columns' 
        Return  DataTablePropertyEnum:AutoAddHiddenUtf16Columns                     
    Of 'backwardscompatible' 
        Return  DataTablePropertyEnum:BackwardsCompatible                     
    Of 'awe_extensions' 
        Return  DataTablePropertyEnum:AWE_Extensions                          
    Of 'connection_string' 
        Return  DataTablePropertyEnum:Connection_String                       
    Of 'connection_user' 
        Return  DataTablePropertyEnum:Connection_User                         
    Of 'connection_server' 
        Return  DataTablePropertyEnum:Connection_Server                       
    Of 'connection_database' 
        Return  DataTablePropertyEnum:Connection_Database                     
    Of 'description_systemobject' 
        Return  DataTablePropertyEnum:Description_SystemObject                
    Of 'description_createddate' 
        Return  DataTablePropertyEnum:Description_CreatedDate                 
    Of 'description_name' 
        Return  DataTablePropertyEnum:Description_Name                        
    Of 'description_schema' 
        Return  DataTablePropertyEnum:Description_Schema                      
    Of 'options_quotedidentifier' 
        Return  DataTablePropertyEnum:Options_QuotedIdentifier                
    Of 'options_ansi_nulls' 
        Return  DataTablePropertyEnum:Options_ANSI_NULLs                      
    Of 'options_memoryoptimized' 
        Return  DataTablePropertyEnum:Options_MemoryOptimized                 
    Of 'options_durability' 
        Return  DataTablePropertyEnum:Options_Durability                      
    Of 'tableisreplicated' 
        Return  DataTablePropertyEnum:TableIsReplicated                       
    Of 'options_quotedidentifier' 
        Return  DataTablePropertyEnum:Options_QuotedIdentifier                
    Of 'changetracking' 
        Return  DataTablePropertyEnum:ChangeTracking                          
    Of 'trackcolumnsupdated' 
        Return  DataTablePropertyEnum:TrackColumnsUpdated                     
    Of 'compressiontype' 
        Return  DataTablePropertyEnum:CompressionType                         
    Of 'dataspace' 
        Return  DataTablePropertyEnum:DataSpace                               
    Of 'indexspace' 
        Return  DataTablePropertyEnum:IndexSpace                              
    Of 'rowcount' 
        Return  DataTablePropertyEnum:RowCount                                
    Of 'conn_authentificationmethod' 
        Return  DataTablePropertyEnum:Conn_AuthentificationMethod             
    Of 'conn_username' 
        Return  DataTablePropertyEnum:Conn_UserName                           
    Of 'conn_database' 
        Return  DataTablePropertyEnum:Conn_Database                           
    Of 'conn_spid' 
        Return  DataTablePropertyEnum:Conn_SPID                               
    Of 'conn_networkprotocol' 
        Return  DataTablePropertyEnum:Conn_NetworkProtocol                    
    Of 'conn_networkpacketsize' 
        Return  DataTablePropertyEnum:Conn_NetworkPacketSize                  
    Of 'conn_connectiontimeout' 
        Return  DataTablePropertyEnum:Conn_ConnectionTimeout                  
    Of 'conn_executiontimeout' 
        Return  DataTablePropertyEnum:Conn_ExecutionTimeout                   
    Of 'conn_encrypted' 
        Return  DataTablePropertyEnum:Conn_Encrypted                          
    Of 'conn_productname' 
        Return  DataTablePropertyEnum:Conn_ProductName                        
    Of 'conn_productversion' 
        Return  DataTablePropertyEnum:Conn_ProductVersion                     
    Of 'conn_servername' 
        Return  DataTablePropertyEnum:Conn_ServerName                         
    Of 'conn_instancename' 
        Return  DataTablePropertyEnum:Conn_Instancename                       
    Of 'conn_language' 
        Return  DataTablePropertyEnum:Conn_Language                           
    Of 'conn_collation' 
        Return  DataTablePropertyEnum:Conn_Collation                          
    Of 'default_collation' 
        Return  DataTablePropertyEnum:Default_Collation
    Of 'transactionlocked'
        Return  DataTablePropertyEnum:TransactionLocked
    Of 'transactionlockfromthreadhandle'
        Return  DataTablePropertyEnum:TransactionLockFromThreadHandle
    Of 'transactionlocktimeout'
        Return  DataTablePropertyEnum:TransactionLockTimeout
    Of 'transactionlocktypeenum'
        Return  DataTablePropertyEnum:TransactionLockTypeEnum
    End
    Return 0
    
    
    
!sdfsfsdfsdf.DataTablePropertyStringToEnum                           Procedure(string _    
    
c25_DataReflectionClass.SetDataTypeTarget                           Procedure(ClarionFields_TYPE clarionFields, string fieldName, long targetDatatypeEnum)

CODE

    G# = 0
    Loop
        G# = G# + 1
        Get(clarionFields,G#)
        If Errorcode() <> 0
            BREAK
        End
        If NOT Clip(Lower(clarionFields.Name)) = Clip(Lower(fieldName))
            Cycle
        End
        clarionFields.DataTypeTargetEnum = targetDatatypeEnum
        Put(clarionFields)
        Self.MapDataTypeTarget(clarionFields, G#)
        Break
    End
    Return ''
    
c25_DataReflectionClass.MapDataTypeTarget    Procedure(ClarionFields_TYPE clarionFields, <IndexPtr32 _singleIndexPtr>)

CODE
        
    G# = 0
    If omitted(_singleIndexPtr) = FALSE
        G# = _singleIndexPtr - 1
    End
    Loop
        G# = G# + 1
        Get(clarionFields,G#)
        If Errorcode() <> 0
            BREAK
        End

        Case clarionFields.DataTypeTargetEnum
        Of DatatypeEnum:SQLITE_BLOB
            clarionFields.DataTypeTarget = 'BLOB' !&= Self.BitConverter.BinaryCopy('BLOB',clarionFields.DataTypeTarget)
        Of DatatypeEnum:SQLITE_TINYINT
        OrOf DatatypeEnum:SQLITE_SMALLINT
        OrOf DatatypeEnum:SQLITE_INTEGER
        OrOf DatatypeEnum:SQLITE_INT
        OrOf DatatypeEnum:SQLITE_INT2
        OrOf DatatypeEnum:SQLITE_INT8
        OrOf DatatypeEnum:SQLITE_BIGINT
        OrOf DatatypeEnum:SQLITE_UNSIGNED_BIG_INT
            clarionFields.DataTypeTarget = 'INTEGER' ! &= Self.BitConverter.BinaryCopy('INTEGER',clarionFields.DataTypeTarget)
        Of DatatypeEnum:SQLITE_DECIMAL
        OrOf DatatypeEnum:SQLITE_BOOLEAN
        OrOf DatatypeEnum:SQLITE_NUMERIC
        OrOf DatatypeEnum:SQLITE_DATE
        OrOf DatatypeEnum:SQLITE_DATETIME
            clarionFields.DataTypeTarget = 'NUMERIC' ! &= Self.BitConverter.BinaryCopy('NUMERIC',clarionFields.DataTypeTarget)
        Of DatatypeEnum:SQLITE_REAL
        OrOf DatatypeEnum:SQLITE_FLOAT
        OrOf DatatypeEnum:SQLITE_DOUBLE
        OrOf DatatypeEnum:SQLITE_DOUBLE_PRECISION
            clarionFields.DataTypeTarget = 'REAL' ! &= Self.BitConverter.BinaryCopy('REAL',clarionFields.DataTypeTarget)
        Of DatatypeEnum:SQLITE_NVARCHAR
        OrOf DatatypeEnum:SQLITE_CHARACTER
        OrOf DatatypeEnum:SQLITE_VARCHAR
        OrOf DatatypeEnum:SQLITE_VARYING_CHARACTER
        OrOf DatatypeEnum:SQLITE_NCHAR
        OrOf DatatypeEnum:SQLITE_NATIVE_CHARACTER
        OrOf DatatypeEnum:SQLITE_TEXT
        OrOf DatatypeEnum:SQLITE_CLOB
        OrOf DatatypeEnum:SQLITE_NVARCHAR
            clarionFields.DataTypeTarget = 'TEXT' ! &= Self.BitConverter.BinaryCopy('TEXT',clarionFields.DataTypeTarget)
        Else
            clarionFields.DataTypeTarget = 'BLOB' ! &= Self.BitConverter.BinaryCopy('BLOB',clarionFields.DataTypeTarget)
        END
        Put(clarionFields)
        If omitted(_singleIndexPtr) = FALSE
            BREAK
        End
    End
    Return 0 

    
    
    
c25_DataReflectionClass.UpdateSqliteDataTypeEnum    Procedure(ClarionFields_TYPE clarionFields, <bool _skipMakeFirstFieldPrimary>)

CODE
        
    
    G# = 0
    Loop
        G# = G# + 1
        Get(clarionFields,G#)
        If Errorcode() <> 0
            BREAK
        End
        If G# = 1 And _skipMakeFirstFieldPrimary = False
            If clarionFields.DataTypeEnum=  DataTypeEnum:CLA_DECIMAL And clarionFields.Characters = 21 And clarionFields.Places = 0
                clarionFields.DataTypeTargetEnum = DatatypeEnum:SQLITE_INTEGER
            Else
                Case clarionFields.DataTypeEnum
                Of DataTypeEnum:CLA_BYTE
                    clarionFields.DataTypeTargetEnum = DatatypeEnum:SQLITE_TINYINT
                Of DataTypeEnum:CLA_SHORT
                OrOf DataTypeEnum:CLA_USHORT
                    clarionFields.DataTypeTargetEnum = DatatypeEnum:SQLITE_SMALLINT
                Of DataTypeEnum:CLA_LONG
                OrOf DataTypeEnum:CLA_ULONG
                    clarionFields.DataTypeTargetEnum = DatatypeEnum:SQLITE_INT8
                Else
                    clarionFields.DataTypeTargetEnum = DatatypeEnum:SQLITE_NVARCHAR
                End
            End
        ELSE
            If clarionFields.DataTypeEnum = DataTypeEnum:CLA_DECIMAL And clarionFields.Characters = 21 And clarionFields.Places = 0
                clarionFields.DataTypeTargetEnum = DatatypeEnum:SQLITE_BIGINT
            Else
                Case clarionFields.DataTypeEnum
                Of DataTypeEnum:CLA_BYTE
                    clarionFields.DataTypeTargetEnum = DatatypeEnum:SQLITE_TINYINT
                Of DataTypeEnum:CLA_SHORT
                OrOf DataTypeEnum:CLA_USHORT
                    clarionFields.DataTypeTargetEnum = DatatypeEnum:SQLITE_SMALLINT
                Of DataTypeEnum:CLA_LONG
                OrOf DataTypeEnum:CLA_ULONG
                    clarionFields.DataTypeTargetEnum = DatatypeEnum:SQLITE_INT8
                Of DataTypeEnum:CLA_DECIMAL
                    clarionFields.DataTypeTargetEnum = DatatypeEnum:SQLITE_DECIMAL
                Of DataTypeEnum:CLA_SREAL
                OrOf DataTypeEnum:CLA_REAL
                    clarionFields.DataTypeTargetEnum = DatatypeEnum:SQLITE_REAL
                Of DataTypeEnum:CLA_BFLOAT4
                OrOf DataTypeEnum:CLA_BFLOAT8
                    clarionFields.DataTypeTargetEnum = DatatypeEnum:SQLITE_FLOAT
                Else
                    clarionFields.DataTypeTargetEnum = DatatypeEnum:SQLITE_NVARCHAR
                End
            End
        End
        Put(clarionFields)
    End
    Return 0    
    
c25_DataReflectionClass.AddQBytesDllDataDir             Procedure(long _PEFileOffset1, string _name, *long _offset, *long _virtualAddress, *string _virtualAddress_Hex, *long _VirtualAddress_Size)

IntVal                  Long
CurrentPointer          Long


CODE


    If Self.QBytesDll.Pos <> _PEFileOffset1 + _offset
        Return 0
    End

    CurrentPointer = Pointer(Self.QBytesDll) - 1

    Loop 4 Times
        CurrentPointer = CurrentPointer + 1
        Get(Self.QBytesDll,CurrentPointer)
        If Self.QBytesDll.Pos = _PEFileOffset1 + _offset
            IntVal = Self.QBytesDll.Byte
            Cycle
        End
        If Self.QBytesDll.Pos = _PEFileOffset1 + _offset + 1
            IntVal = (Self.QBytesDll.Byte * 256) + IntVal
            Cycle
        End
        If Self.QBytesDll.Pos = _PEFileOffset1 + _offset + 2
            IntVal = (Self.QBytesDll.Byte * 256 * 256) + IntVal
            Cycle
        End
        If Self.QBytesDll.Pos = _PEFileOffset1 + _offset + 3
            IntVal = (Self.QBytesDll.Byte * 256 * 256 * 256) + IntVal
            PR# = CurrentPointer + 1
            Loop 4 TIMES
                PR# = PR# - 1
                Get(Self.QBytesDll,PR#)
                Self.QBytesDll.Category = _name & ' Address'
                Self.QBytesDll.ValueInt = IntVal
                Self.QBytesDll.ValueIntHex = LongToHex(IntVal,False)
                Put(Self.QBytesDll)
            End
        End
    End

    _virtualAddress = IntVal
    _virtualAddress_Hex = LongToHex((_virtualAddress),0)


    _offset = _offset + 4
    IntVal = 0
    Loop 4 Times
        CurrentPointer = CurrentPointer + 1
        Get(Self.QBytesDll,CurrentPointer)
        If Self.QBytesDll.Pos = _PEFileOffset1 + _offset
            IntVal = Self.QBytesDll.Byte
            Cycle
        End
        If Self.QBytesDll.Pos = _PEFileOffset1 + _offset + 1
            IntVal = (Self.QBytesDll.Byte * 256) + IntVal
            Cycle
        End
        If Self.QBytesDll.Pos = _PEFileOffset1 + _offset + 2
            IntVal = (Self.QBytesDll.Byte * 256 * 256) + IntVal
            Cycle
        End
        If Self.QBytesDll.Pos = _PEFileOffset1 + _offset + 3
            IntVal = (Self.QBytesDll.Byte * 256 * 256 * 256) + IntVal
            PR# = CurrentPointer + 1
            Loop 4 TIMES
                PR# = PR# - 1
                Get(Self.QBytesDll,PR#)
                Self.QBytesDll.Category = _name & ' Size'
                Self.QBytesDll.ValueInt = IntVal
                Self.QBytesDll.ValueIntHex = LongToHex(IntVal,False)
                Put(Self.QBytesDll)
            End
        End
    End
    _VirtualAddress_Size = IntVal
    CurrentPointer = CurrentPointer + 1
    Get(Self.QBytesDll,CurrentPointer)

    _offset = _offset + 4


    Return IntVal


c25_DataReflectionClass.AddQBytesDll           Function(long _PEFileOffset1, string _name, long _offset, long _bytesLen)

IntVal                  Long
CurrentPointer          Long


CODE


    If Self.QBytesDll.Pos <> _PEFileOffset1 + _offset
        Return 0
    End

    CurrentPointer = Pointer(Self.QBytesDll) - 1
    Case _bytesLen
    Of 1
        CurrentPointer = CurrentPointer + 1
        Get(Self.QBytesDll,CurrentPointer)
        Self.QBytesDll.Category = _name
        Self.QBytesDll.ValueInt = Self.QBytesDll.Byte
        Self.QBytesDll.ValueIntHex = LongToHex(Self.QBytesDll.Byte,False)
        Put(Self.QBytesDll)
    Of 2
        Loop _bytesLen Times
            CurrentPointer = CurrentPointer + 1
            Get(Self.QBytesDll,CurrentPointer)
            If Self.QBytesDll.Pos = _PEFileOffset1 + _offset
                IntVal = Self.QBytesDll.Byte
                Cycle
            End
            If Self.QBytesDll.Pos = _PEFileOffset1 + _offset + 1
                IntVal = (Self.QBytesDll.Byte * 256) + IntVal
                PR# = CurrentPointer + 1
                Loop _bytesLen TIMES
                    PR# = PR# - 1
                    Get(Self.QBytesDll,PR#)
                    Self.QBytesDll.Category = _name
                    Self.QBytesDll.ValueInt = IntVal
                    Self.QBytesDll.ValueIntHex = LongToHex(IntVal,False)
                    Put(Self.QBytesDll)
                End
            End
        End
    Of 4
        Loop _bytesLen Times
            CurrentPointer = CurrentPointer + 1
            Get(Self.QBytesDll,CurrentPointer)
            If Self.QBytesDll.Pos = _PEFileOffset1 + _offset
                IntVal = Self.QBytesDll.Byte
                Cycle
            End
            If Self.QBytesDll.Pos = _PEFileOffset1 + _offset + 1
                IntVal = (Self.QBytesDll.Byte * 256) + IntVal
                Cycle
            End
            If Self.QBytesDll.Pos = _PEFileOffset1 + _offset + 2
                IntVal = (Self.QBytesDll.Byte * 256 * 256) + IntVal
                Cycle
            End
            If Self.QBytesDll.Pos = _PEFileOffset1 + _offset + 3
                IntVal = (Self.QBytesDll.Byte * 256 * 256 * 256) + IntVal
                PR# = CurrentPointer + 1
                Loop _bytesLen TIMES
                    PR# = PR# - 1
                    Get(Self.QBytesDll,PR#)
                    Self.QBytesDll.Category = _name
                    Self.QBytesDll.ValueInt = IntVal
                    Self.QBytesDll.ValueIntHex = LongToHex(IntVal,False)
                    Put(Self.QBytesDll)
                End
            End
        End
    End
    CurrentPointer = CurrentPointer + 1
    Get(Self.QBytesDll,CurrentPointer)
    Return IntVal

c25_DataReflectionClass.CalcQBytesValues      Procedure(*long _Pos, long _bytesLen, string _name, *long _value, *string _valueInHex)


IntVal                  Long
Offset                  Long

CODE

    IntVal = 0
    Case _bytesLen
    Of 1
        Get(Self.QBytesDll,_Pos)
        If Errorcode() <> 0
            Return 0
        End
        Self.QBytesDll.Category = _name
        Self.QBytesDll.ValueInt = Self.QBytesDll.Byte
        Self.QBytesDll.ValueIntHex = LongToHex(Self.QBytesDll.Byte,False)
        Put(Self.QBytesDll)
    Of 2
        Get(Self.QBytesDll,_Pos)
        If Errorcode() <> 0
            Return 0
        End
        IntVal = Self.QBytesDll.Byte

        _Pos = _Pos + 1
        Get(Self.QBytesDll,_Pos)
        If Errorcode() <> 0
            Return 0
        End
        IntVal = (Self.QBytesDll.Byte * 256) + IntVal

        Self.QBytesDll.Category = _name
        Self.QBytesDll.ValueInt = IntVal
        Self.QBytesDll.ValueIntHex = LongToHex(IntVal,False)
        Put(Self.QBytesDll)

        Get(Self.QBytesDll,_Pos-1)
        Self.QBytesDll.Category = _name
        Self.QBytesDll.ValueInt = IntVal
        Self.QBytesDll.ValueIntHex = LongToHex(IntVal,False)
        Put(Self.QBytesDll)

        _value = IntVal
        _valueInHex = LongToHex(IntVal,0)
    Of 4
        Get(Self.QBytesDll,_Pos)
        If Errorcode() <> 0
            Return 0
        End
        IntVal = Self.QBytesDll.Byte

        _Pos = _Pos + 1
        Get(Self.QBytesDll,_Pos)
        If Errorcode() <> 0
            Return 0
        End
        IntVal = (Self.QBytesDll.Byte * 256) + IntVal

        _Pos = _Pos + 1
        Get(Self.QBytesDll,_Pos)
        If Errorcode() <> 0
            Return 0
        End
        IntVal = (Self.QBytesDll.Byte * 256 * 256) + IntVal

        _Pos = _Pos + 1
        Get(Self.QBytesDll,_Pos)
        If Errorcode() <> 0
            Return 0
        End
        IntVal = (Self.QBytesDll.Byte * 256 * 256 * 256) + IntVal

        Self.QBytesDll.Category = _name
        Self.QBytesDll.ValueInt = IntVal
        Self.QBytesDll.ValueIntHex = LongToHex(IntVal,False)
        Put(Self.QBytesDll)

        Get(Self.QBytesDll,_Pos-1)
        Self.QBytesDll.Category = _name
        Self.QBytesDll.ValueInt = IntVal
        Self.QBytesDll.ValueIntHex = LongToHex(IntVal,False)
        Put(Self.QBytesDll)

        Get(Self.QBytesDll,_Pos-2)
        Self.QBytesDll.Category = _name
        Self.QBytesDll.ValueInt = IntVal
        Self.QBytesDll.ValueIntHex = LongToHex(IntVal,False)
        Put(Self.QBytesDll)

        Get(Self.QBytesDll,_Pos-3)
        Self.QBytesDll.Category = _name
        Self.QBytesDll.ValueInt = IntVal
        Self.QBytesDll.ValueIntHex = LongToHex(IntVal,False)
        Put(Self.QBytesDll)

        _value = IntVal
        _valueInHex = LongToHex(IntVal,0)
    End
     _Pos = _Pos + 1
    Get(Self.QBytesDll,_Pos)
    Return IntVal

c25_DataReflectionClass.ResetAnalyzeDll     Procedure()

    CODE

        Clear(Self.InOptionalHeader) !                                    BOOL
        Clear(Self.ImageBase) !                                           Long
        Clear(Self.currentOffset) !                                       long
        Clear(Self.EndOptionalHeader) !                                   byte
        Clear(Self.QDLLSections_Fill) !                                   byte
        Clear(Self.Pos) !                                                 long
        Clear(Self.LastPos) !                                             long
        Clear(Self.FromPos) !                                             Long
        Clear(Self.UntilPos) !                                            Long
        Clear(Self.StartAddressDisk) !                                    Long
        Clear(Self.PEFileOffset1) !                                       LONG
        Clear(Self.QDesc) !                                               STRING(16000)
        Clear(Self.QDescLen) !                                            LONG
        Clear(Self.PEFileOffset2) !                                       LONG
        Clear(Self.StartOffsetFieldsDesc) !                               LONG
        Clear(Self.Bytes1LastAutoScroll) !                                BYTE(1)
        Clear(Self.LibraryHandle) !                                       LONG
        Clear(Self.DllFileName) !                                         STRING(2048)
        Clear(Self.IsMemoryLayout) !                                      BYTE
        Clear(Self.ParamBuffer2) !                                        STRING(16000)
        Clear(Self.ParamBuffer3) !                                        STRING(16000)
        Clear(Self.SomeIntValue) !                                        LONG
        Clear(Self.VirtualAddressHex) !                                   STRING('00401000')
        Clear(Self.VirtualAddress) !                                      LONG(4198400)
        Clear(Self.Value32Bytes) !                                        LONG
        Clear(Self.Value32BytesHex) !                                     STRING(8)
        Clear(Self.DD_ExportTable_VirtualAddress) !                       LONG
        Clear(Self.DD_ExportTable_VirtualAddress_Hex) !                   STRING(8)
        Clear(Self.DD_ExportTable_VirtualAddress_Size) !                  LONG
        Clear(Self.DD_ImportTable_VirtualAddress) !                       LONG
        Clear(Self.DD_ImportTable_VirtualAddress_Hex) !                   STRING(8)
        Clear(Self.DD_ImportTable_VirtualAddress_Size) !                  LONG
        Clear(Self.DD_ResourceTable_VirtualAddress) !                     LONG
        Clear(Self.DD_ResourceTable_VirtualAddress_Hex) !                 STRING(8)
        Clear(Self.DD_ResourceTable_VirtualAddress_Size) !                LONG
        Clear(Self.DD_ExceptionTable_VirtualAddress) !                    LONG
        Clear(Self.DD_ExceptionTable_VirtualAddress_Hex) !               STRING(8)
        Clear(Self.DD_ExceptionTable_VirtualAddress_Size) !               LONG
        Clear(Self.DD_CertificateTable_VirtualAddress) !                  LONG
        Clear(Self.DD_CertificateTable_VirtualAddress_Hex) !              STRING(8)
        Clear(Self.DD_CertificateTable_VirtualAddress_Size) !             LONG
        Clear(Self.DD_BaseRelocationTable_VirtualAddress) !               LONG
        Clear(Self.DD_BaseRelocationTable_VirtualAddress_Hex) !           STRING(8)
        Clear(Self.DD_BaseRelocationTable_VirtualAddress_Size) !          LONG
        Clear(Self.DD_DebugDirectory_VirtualAddress) !                    LONG
        Clear(Self.DD_DebugDirectory_VirtualAddress_Hex) !                STRING(8)
        Clear(Self.DD_DebugDirectory_VirtualAddress_Size) !               LONG
        Clear(Self.DD_ArchitectureTable_VirtualAddress) !                 LONG
        Clear(Self.DD_ArchitectureTable_VirtualAddress_Hex) !             STRING(8)
        Clear(Self.DD_ArchitectureTable_VirtualAddress_Size) !            LONG
        Clear(Self.DD_GlobalPtr_VirtualAddress) !                         LONG
        Clear(Self.DD_GlobalPtr_VirtualAddress_Hex) !                     STRING(8)
        Clear(Self.DD_GlobalPtr_VirtualAddress_Size) !                    LONG
        Clear(Self.DD_TLSDirectory_VirtualAddress) !                      LONG
        Clear(Self.DD_TLSDirectory_VirtualAddress_Hex) !                  STRING(8)
        Clear(Self.DD_TLSDirectory_VirtualAddress_Size) !                 LONG
        Clear(Self.DD_LoadConfigTable_VirtualAddress) !                   LONG
        Clear(Self.DD_LoadConfigTable_VirtualAddress_Hex) !               STRING(8)
        Clear(Self.DD_LoadConfigTable_VirtualAddress_Size) !              LONG
        Clear(Self.DD_BoundImportTable_VirtualAddress) !                  LONG
        Clear(Self.DD_BoundImportTable_VirtualAddress_Hex) !              STRING(8)
        Clear(Self.DD_BoundImportTable_VirtualAddress_Size) !             LONG
        Clear(Self.DD_IATTable_VirtualAddress) !                          LONG
        Clear(Self.DD_IATTable_VirtualAddress_Hex) !                      STRING(8)
        Clear(Self.DD_IATTable_VirtualAddress_Size) !                     LONG
        Clear(Self.DD_DelayLoadImportTable_VirtualAddress) !              LONG
        Clear(Self.DD_DelayLoadImportTable_VirtualAddress_Hex) !          STRING(8)
        Clear(Self.DD_DelayLoadImportTable_VirtualAddress_Size) !         LONG
        Clear(Self.DD_CLRRuntimeHeaderTable_VirtualAddress) !             LONG
        Clear(Self.DD_CLRRuntimeHeaderTable_VirtualAddress_Hex) !         STRING(8)
        Clear(Self.DD_CLRRuntimeHeaderTable_VirtualAddress_Size) !        LONG
        Clear(Self.DD_ReservedTable_VirtualAddress) !                     LONG
        Clear(Self.DD_ReservedTable_VirtualAddress_Hex) !                 STRING(8)
        Clear(Self.DD_ReservedTable_VirtualAddress_Size) !                LONG
        Clear(Self.PE01)
        Free(Self.QDLLSections)
        Free(Self.QBytesDll)
        Clear(Self.COFFFileHeader)
        Self.StLoadedDll.Start()
        Self.StInMemDll.Start()



c25_DataReflectionClass.AnalyzeDll                      Procedure(<long _bufferPtr>, <long _bufferSize>, <string _fileNameUtf8>, <bool _isFileStructure>)


IntVal      Long
st1                                                         &StringTheory


CODE

    
    !Return 0
    
    Self.ResetAnalyzeDll()


    If omitted(_fileNameUtf8) = False
        Self.DllFileName = _fileNameUtf8
        Self.StLoadedDll.LoadFile(Self.DllFileName)
    End

    If omitted(_bufferPtr) = False And _bufferSize > 0
        Self.StLoadedDll.SetValueByAddress(_bufferPtr, _bufferSize)
        !Self.StLoadedDll.SaveFile('m:\StDllBytesDRF.dll')
    End

    S# = Self.StLoadedDll.Length()
    If S# = 0
        Message('error missing QueueMeta001.dll')
        Return 0
    End

    Loop S# TIMES
        Self.Pos = Self.Pos + 1
        Clear(Self.QBytesDll)
        Self.QBytesDll.Pos = Self.Pos - 1
        Self.QBytesDll.Char = Self.StLoadedDll.Sub(Self.Pos,1)
        Self.QBytesDll.Byte = Val(Self.QBytesDll.Char)
        Self.QBytesDll.Hex = ByteToHex(Self.QBytesDll.Byte, False)
        Self.QBytesDll.Address = Self.VirtualAddress + Self.QBytesDll.Pos
        Self.QBytesDll.AddressHex = LONGTOHEX(Self.QBytesDll.Address, False)
        If Self.QBytesDll.Pos = 03Ch
            Self.PEFileOffset1 = Self.QBytesDll.Byte
            Self.QBytesDll.Category = 'PE Offset'
        End
        Add(Self.QBytesDll)
    End
    
    Self.Pos = 0
    Loop
        Self.Pos = Self.Pos + 1
        Get(Self.QBytesDll,Self.Pos)
        If Errorcode() <> 0
            BREAK
        End
        If Self.QBytesDll.Pos > Self.PEFileOffset1 - 1 And Self.QBytesDll.Pos < Self.PEFileOffset1 + 4
            Self.QBytesDll.Category = 'SIGNATURE PE'
            Put(Self.QBytesDll)
            Cycle
        End
        If Self.QBytesDll.Pos = Self.PEFileOffset1 + 4
            Self.COFFFileHeader.Machine = Self.AddQBytesDll(Self.PEFileOffset1,'Machine',4,2)
            Self.COFFFileHeader.MachineHex = Self.BitConverter.ShortToHex(Self.COFFFileHeader.Machine)

            Self.COFFFileHeader.NumberOfSections = Self.AddQBytesDll(Self.PEFileOffset1,'NumberOfSections',6,2)

            Self.COFFFileHeader.TimeDateStamp = Self.AddQBytesDll(Self.PEFileOffset1,'TimeDateStamp',8,4)
            Self.COFFFileHeader.TimeDateStampHex = LongToHex(Self.COFFFileHeader.TimeDateStamp, False)

            Self.COFFFileHeader.PointerToSymbolTable = Self.AddQBytesDll(Self.PEFileOffset1,'PointerToSymbolTable',12,4)
            Self.COFFFileHeader.PointerToSymbolTableHex = LongToHex(Self.COFFFileHeader.PointerToSymbolTable, False)

            Self.COFFFileHeader.NumberOfSymbols = Self.AddQBytesDll(Self.PEFileOffset1,'NumberOfSymbols',16,4)
            Self.COFFFileHeader.NumberOfSymbolsHex = LongToHex(Self.COFFFileHeader.NumberOfSymbols, False)

            Self.COFFFileHeader.SizeOfOptionalHeader = Self.AddQBytesDll(Self.PEFileOffset1,'SizeOfOptionalHeader',20,2)
            Self.COFFFileHeader.SizeOfOptionalHeaderHex = Self.BitConverter.ShortToHex(Self.COFFFileHeader.SizeOfOptionalHeader, False)

            Self.COFFFileHeader.Characteristics = Self.AddQBytesDll(Self.PEFileOffset1,'Characteristics',22,2)
            Self.COFFFileHeader.CharacteristicsHex = Self.BitConverter.ShortToHex(Self.COFFFileHeader.Characteristics, False)

            Self.COFFFileHeader.CharacteristicsBits = Self.BitConverter.GetBits16FromShort(Self.COFFFileHeader.Characteristics)

            If BAND(Self.COFFFileHeader.Characteristics,IMAGE_FILE_RELOCS_STRIPPED)
                Self.PE01.RelocsStripped = True
            End
            If BAND(Self.COFFFileHeader.Characteristics,IMAGE_FILE_EXECUTABLE_IMAGE)
                Self.PE01.ExecutableImage = True
            End
            If BAND(Self.COFFFileHeader.Characteristics,IMAGE_FILE_LINE_NUMS_STRIPPED)
                Self.PE01.LineNumsStripped = True
            End
            If BAND(Self.COFFFileHeader.Characteristics,IMAGE_FILE_LOCAL_SYMS_STRIPPED)
                Self.PE01.LocalSymsStripped = True
            End
            If BAND(Self.COFFFileHeader.Characteristics,IMAGE_FILE_AGGRESSIVE_WS_TRIM)
                Self.PE01.AggressiveWsTrim = True
            End
            If BAND(Self.COFFFileHeader.Characteristics,IMAGE_FILE_LARGE_ADDRESS_AWARE)
                Self.PE01.LargeAddressAware = True
            End
            If BAND(Self.COFFFileHeader.Characteristics,IMAGE_FUTURE)
            End
            If BAND(Self.COFFFileHeader.Characteristics,IMAGE_FILE_BYTES_REVERSED_LO)
                Self.PE01.BytesReversedLo = True
            End
            If BAND(Self.COFFFileHeader.Characteristics,IMAGE_FILE_32BIT_MACHINE)
                Self.PE01.Bits32Machine = True
            End
            If BAND(Self.COFFFileHeader.Characteristics,IMAGE_FILE_DEBUG_STRIPPED)
                Self.PE01.DebugStripped = True
            End
            If BAND(Self.COFFFileHeader.Characteristics,IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP)
                Self.PE01.RemovableRunFromSwap = True
            End
            If BAND(Self.COFFFileHeader.Characteristics,IMAGE_FILE_NET_RUN_FROM_SWAP)
                Self.PE01.NetRunFromSwap = True
            End
            If BAND(Self.COFFFileHeader.Characteristics,IMAGE_FILE_SYSTEM)
                Self.PE01.IsSystemFile = True
            End
            If BAND(Self.COFFFileHeader.Characteristics,IMAGE_FILE_DLL)
                Self.PE01.IsDll = True
            End
            If BAND(Self.COFFFileHeader.Characteristics,IMAGE_FILE_UP_SYSTEM_ONLY)
                Self.PE01.SystemOnly = True
            End
            If BAND(Self.COFFFileHeader.Characteristics,IMAGE_FILE_BYTES_REVERSED_HI)
                Self.PE01.BytesReversedHi = True
            End

            Self.Pos = Self.Pos + (22 - 4)
        End

        If Self.QBytesDll.Pos = Self.PEFileOffset1 + 24
            V# = Self.AddQBytesDll(Self.PEFileOffset1,'PE Format: PE32',24,2)
            If V# = 267
                Self.PE01.PEFormat= 'PE32'
                Self.InOptionalHeader = True
                Self.Pos = Self.Pos + 1
                Cycle
            End
        End
        If Self.InOptionalHeader
            If Self.QBytesDll.Pos = Self.PEFileOffset1 + 26
                Self.PE01.MajorLinkerVersion = Self.AddQBytesDll(Self.PEFileOffset1,'MajorLinkerVersion',26,1)

                Self.PE01.MinorLinkerVersion = Self.AddQBytesDll(Self.PEFileOffset1,'MinorLinkerVersion',27,1)

                Self.PE01.SizeOfCode = Self.AddQBytesDll(Self.PEFileOffset1,'SizeOfCode',28,4)
                Self.PE01.SizeOfCodeHex = LongToHex(Self.PE01.SizeOfCode, False)

                Self.PE01.SizeOfInitializedData = Self.AddQBytesDll(Self.PEFileOffset1,'SizeOfInitializedData',32,4)
                Self.PE01.SizeOfInitializedDataHex = LongToHex(Self.PE01.SizeOfInitializedData, False)

                Self.PE01.SizeOfUninitializedData = Self.AddQBytesDll(Self.PEFileOffset1,'SizeOfUninitializedData',36,4)
                Self.PE01.SizeOfUninitializedDataHex = LongToHex(Self.PE01.SizeOfUninitializedData, False)

                Self.PE01.AddressOfEntryPoint = Self.AddQBytesDll(Self.PEFileOffset1,'AddressOfEntryPoint',40,4)
                Self.PE01.AddressOfEntryPointHex = LongToHex(Self.PE01.AddressOfEntryPoint, False)

                Self.PE01.BaseOfCode = Self.AddQBytesDll(Self.PEFileOffset1,'BaseOfCode',44,4)
                Self.PE01.BaseOfCodeHex = LongToHex(Self.PE01.BaseOfCode, False)

                Self.Pos = Self.Pos + (44-26)
            END


            If Self.PE01.PEFormat = 'PE32'
                If Self.QBytesDll.Pos = Self.PEFileOffset1 + 48
                    Self.PE01.BaseOfData = Self.AddQBytesDll(Self.PEFileOffset1,'BaseOfData',48,4)
                    Self.PE01.BaseOfDataHex = LongToHex(Self.PE01.BaseOfData, False)
                    Self.Pos = Self.Pos + 4
                End
            End

            If Self.PE01.IsDll
                If Self.QBytesDll.Pos = Self.PEFileOffset1 + 52
                    Self.PE01.ImageBase = Self.AddQBytesDll(Self.PEFileOffset1,'ImageBase',52,4)
                    Self.PE01.ImageBaseHex = LongToHex(Self.PE01.ImageBase, False)

                    Self.PE01.SectionAlignment = Self.AddQBytesDll(Self.PEFileOffset1,'SectionAlignment',56,4)
                    Self.PE01.SectionAlignmentHex = LongToHex(Self.PE01.SectionAlignment, False)

                    Self.PE01.FileAlignment = Self.AddQBytesDll(Self.PEFileOffset1,'FileAlignment',60,4)
                    Self.PE01.FileAlignmentHex = LongToHex(Self.PE01.FileAlignment, False)

                    Self.PE01.MajorOperatingSystemVersion = Self.AddQBytesDll(Self.PEFileOffset1,'MajorOperatingSystemVersion',64,2)
                    Self.PE01.MajorOperatingSystemVersionHex = Self.BitConverter.ShortToHex(Self.PE01.MajorOperatingSystemVersion, False)

                    Self.PE01.MinorOperatingSystemVersion = Self.AddQBytesDll(Self.PEFileOffset1,'MinorOperatingSystemVersion',66,2)
                    Self.PE01.MinorOperatingSystemVersionHex = Self.BitConverter.ShortToHex(Self.PE01.MinorOperatingSystemVersion, False)

                    Self.PE01.MajorImageVersion = Self.AddQBytesDll(Self.PEFileOffset1,'MajorImageVersion',68,2)
                    Self.PE01.MajorImageVersionHex = Self.BitConverter.ShortToHex(Self.PE01.MajorImageVersion, False)

                    Self.PE01.MinorImageVersion = Self.AddQBytesDll(Self.PEFileOffset1,'MinorImageVersion',70,2)
                    Self.PE01.MinorImageVersionHex = Self.BitConverter.ShortToHex(Self.PE01.MinorImageVersion, False)

                    Self.PE01.MajorSubsystemVersion = Self.AddQBytesDll(Self.PEFileOffset1,'MajorSubsystemVersion',72,2)
                    Self.PE01.MajorSubsystemVersionHex = Self.BitConverter.ShortToHex(Self.PE01.MajorSubsystemVersion, False)

                    Self.PE01.MinorSubsystemVersion = Self.AddQBytesDll(Self.PEFileOffset1,'MinorSubsystemVersion',74,2)
                    Self.PE01.MinorSubsystemVersionHex = Self.BitConverter.ShortToHex(Self.PE01.MinorSubsystemVersion, False)

                    Self.PE01.Win32VersionValue = Self.AddQBytesDll(Self.PEFileOffset1,'Win32VersionValue',76,4)
                    Self.PE01.Win32VersionValueHex = LongToHex(Self.PE01.Win32VersionValue, False)

                    Self.PE01.SizeOfImage = Self.AddQBytesDll(Self.PEFileOffset1,'SizeOfImage',80,4)
                    Self.PE01.SizeOfImageHex = LongToHex(Self.PE01.SizeOfImage, False)

                    Self.PE01.SizeOfHeaders = Self.AddQBytesDll(Self.PEFileOffset1,'SizeOfHeaders',84,4)
                    Self.PE01.SizeOfHeadersHex = LongToHex(Self.PE01.SizeOfHeaders, False)

                    Self.PE01.CheckSum = Self.AddQBytesDll(Self.PEFileOffset1,'CheckSum',88,4)
                    Self.PE01.CheckSumHex = LongToHex(Self.PE01.CheckSum, False)

                    Self.PE01.Subsystem = Self.AddQBytesDll(Self.PEFileOffset1,'Subsystem',92,2)
                    Self.PE01.SubsystemHex = LongToHex(Self.PE01.Subsystem, False)

                    Self.PE01.DllCharacteristics = Self.AddQBytesDll(Self.PEFileOffset1,'DllCharacteristics',94,2)
                    Self.PE01.DllCharacteristicsHex = LongToHex(Self.PE01.DllCharacteristics, False)

                    If BAND(Self.PE01.DllCharacteristics,ENUM_LIBRARY_PROCESS_INIT) <> 0
                        Self.PE01.DllChar_LIBRARY_PROCESS_INIT = True
                    End

                    If BAND(Self.PE01.DllCharacteristics,ENUM_LIBRARY_PROCESS_TERM) <> 0
                        Self.PE01.DllChar_LIBRARY_PROCESS_TERM = True
                    End

                    If BAND(Self.PE01.DllCharacteristics,ENUM_LIBRARY_THREAD_INIT) <> 0
                        Self.PE01.DllChar_LIBRARY_THREAD_INIT = True
                    End

                    If BAND(Self.PE01.DllCharacteristics,ENUM_LIBRARY_THREAD_TERM) <> 0
                        Self.PE01.DllChar_LIBRARY_THREAD_TERM = True
                    End

                    If BAND(Self.PE01.DllCharacteristics,ENUM_HIGH_ENTROPY_VA) <> 0
                        Self.PE01.DllChar_HIGH_ENTROPY_VA = True
                    End
                    If BAND(Self.PE01.DllCharacteristics,ENUM_DYNAMIC_BASE) <> 0
                        Self.PE01.DllChar_DYNAMIC_BASE = True
                    End
                    If BAND(Self.PE01.DllCharacteristics,ENUM_FORCE_INTEGRITY) <> 0
                        Self.PE01.DllChar_FORCE_INTEGRITY = True
                    End
                    If BAND(Self.PE01.DllCharacteristics,ENUM_NX_COMPAT) <> 0
                        Self.PE01.DllChar_NX_COMPAT = True
                    End
                    If BAND(Self.PE01.DllCharacteristics,ENUM_NO_ISOLATION) <> 0
                        Self.PE01.DllChar_NO_ISOLATION = True
                    End
                    If BAND(Self.PE01.DllCharacteristics,ENUM_NO_SEH) <> 0
                        Self.PE01.DllChar_NO_SEH = True
                    End
                    If BAND(Self.PE01.DllCharacteristics,ENUM_NO_BIND) <> 0
                        Self.PE01.DllChar_NO_BIND = True
                    End
                    If BAND(Self.PE01.DllCharacteristics,ENUM_APPCONTAINER) <> 0
                        Self.PE01.DllChar_APPCONTAINER = True
                    End
                    If BAND(Self.PE01.DllCharacteristics,ENUM_WDM_DRIVER) <> 0
                        Self.PE01.DllChar_WDM_DRIVER = True
                    End
                    If BAND(Self.PE01.DllCharacteristics,ENUM_GUARD_CF) <> 0
                        Self.PE01.DllChar_GUARD_CF = True
                    End
                    If BAND(Self.PE01.DllCharacteristics,ENUM_TERMINAL_SERVER_AWARE) <> 0
                        Self.PE01.DllChar_TERMINAL_SERVER_AWARE = True
                    End

                    Self.PE01.SizeOfStackReserve = Self.AddQBytesDll(Self.PEFileOffset1,'SizeOfStackReserve',96,4)
                    Self.PE01.SizeOfStackReserveHex = LongToHex(Self.PE01.SizeOfStackReserve, False)

                    Self.PE01.SizeOfStackCommit = Self.AddQBytesDll(Self.PEFileOffset1,'SizeOfStackCommit',100,4)
                    Self.PE01.SizeOfStackCommitHex = LongToHex(Self.PE01.SizeOfStackCommit, False)

                    Self.PE01.SizeOfHeapReserve = Self.AddQBytesDll(Self.PEFileOffset1,'SizeOfHeapReserve',104,4)
                    Self.PE01.SizeOfHeapReserveHex = LongToHex(Self.PE01.SizeOfHeapReserve, False)

                    Self.PE01.SizeOfHeapCommit = Self.AddQBytesDll(Self.PEFileOffset1,'SizeOfHeapCommit',108,4)
                    Self.PE01.SizeOfHeapCommitHex = LongToHex(Self.PE01.SizeOfHeapCommit, False)

                    Self.PE01.LoaderFlags = Self.AddQBytesDll(Self.PEFileOffset1,'LoaderFlags',112,4)
                    Self.PE01.LoaderFlagsHex = LongToHex(Self.PE01.LoaderFlags, False)

                    Self.PE01.NumberOfRvaAndSizes = Self.AddQBytesDll(Self.PEFileOffset1,'NumberOfRvaAndSizes',116,4)
                    Self.PE01.NumberOfRvaAndSizesHex = LongToHex(Self.PE01.NumberOfRvaAndSizes, False)

                    Self.currentOffset = 120
                    Self.AddQBytesDllDataDir(Self.PEFileOffset1,'Export Table'           ,Self.currentOffset, Self.DD_ExportTable_VirtualAddress           , Self.DD_ExportTable_VirtualAddress_Hex             , Self.DD_ExportTable_VirtualAddress_Size)
                    Self.AddQBytesDllDataDir(Self.PEFileOffset1,'Import Table'           ,Self.currentOffset, Self.DD_ImportTable_VirtualAddress           , Self.DD_ImportTable_VirtualAddress_Hex             , Self.DD_ImportTable_VirtualAddress_Size)
                    Self.AddQBytesDllDataDir(Self.PEFileOffset1,'Resource Table'         ,Self.currentOffset, Self.DD_ResourceTable_VirtualAddress         , Self.DD_ResourceTable_VirtualAddress_Hex           , Self.DD_ResourceTable_VirtualAddress_Size)
                    Self.AddQBytesDllDataDir(Self.PEFileOffset1,'Exception Table'        ,Self.currentOffset, Self.DD_ExceptionTable_VirtualAddress        , Self.DD_ExceptionTable_VirtualAddress_Hex          , Self.DD_ExceptionTable_VirtualAddress_Size)
                    Self.AddQBytesDllDataDir(Self.PEFileOffset1,'Certificate Table'      ,Self.currentOffset, Self.DD_CertificateTable_VirtualAddress      , Self.DD_CertificateTable_VirtualAddress_Hex        , Self.DD_CertificateTable_VirtualAddress_Size)
                    Self.AddQBytesDllDataDir(Self.PEFileOffset1,'BaseRelocation Table'   ,Self.currentOffset, Self.DD_BaseRelocationTable_VirtualAddress   , Self.DD_BaseRelocationTable_VirtualAddress_Hex     , Self.DD_BaseRelocationTable_VirtualAddress_Size)
                    Self.AddQBytesDllDataDir(Self.PEFileOffset1,'DebugDirectory Table'   ,Self.currentOffset, Self.DD_DebugDirectory_VirtualAddress        , Self.DD_DebugDirectory_VirtualAddress_Hex          , Self.DD_DebugDirectory_VirtualAddress_Size)
                    Self.AddQBytesDllDataDir(Self.PEFileOffset1,'Architecture Table'     ,Self.currentOffset, Self.DD_ArchitectureTable_VirtualAddress     , Self.DD_ArchitectureTable_VirtualAddress_Hex       , Self.DD_ArchitectureTable_VirtualAddress_Size)
                    Self.AddQBytesDllDataDir(Self.PEFileOffset1,'GlobalPtr Table'        ,Self.currentOffset, Self.DD_GlobalPtr_VirtualAddress             , Self.DD_GlobalPtr_VirtualAddress_Hex               , Self.DD_GlobalPtr_VirtualAddress_Size)
                    Self.AddQBytesDllDataDir(Self.PEFileOffset1,'TLSDirectory Table'     ,Self.currentOffset, Self.DD_TLSDirectory_VirtualAddress          , Self.DD_TLSDirectory_VirtualAddress_Hex            , Self.DD_TLSDirectory_VirtualAddress_Size)
                    Self.AddQBytesDllDataDir(Self.PEFileOffset1,'LoadConfig Table'       ,Self.currentOffset, Self.DD_LoadConfigTable_VirtualAddress       , Self.DD_LoadConfigTable_VirtualAddress_Hex         , Self.DD_LoadConfigTable_VirtualAddress_Size)
                    Self.AddQBytesDllDataDir(Self.PEFileOffset1,'BoundImport Table'      ,Self.currentOffset, Self.DD_BoundImportTable_VirtualAddress      , Self.DD_BoundImportTable_VirtualAddress_Hex        , Self.DD_BoundImportTable_VirtualAddress_Size)
                    Self.AddQBytesDllDataDir(Self.PEFileOffset1,'IAT Table'              ,Self.currentOffset, Self.DD_IATTable_VirtualAddress              , Self.DD_IATTable_VirtualAddress_Hex                , Self.DD_IATTable_VirtualAddress_Size)
                    Self.AddQBytesDllDataDir(Self.PEFileOffset1,'DelayLoadImport Table'  ,Self.currentOffset, Self.DD_DelayLoadImportTable_VirtualAddress  , Self.DD_DelayLoadImportTable_VirtualAddress_Hex    , Self.DD_DelayLoadImportTable_VirtualAddress_Size)
                    Self.AddQBytesDllDataDir(Self.PEFileOffset1,'CLRRuntimeHeader Table' ,Self.currentOffset, Self.DD_CLRRuntimeHeaderTable_VirtualAddress , Self.DD_CLRRuntimeHeaderTable_VirtualAddress_Hex   , Self.DD_CLRRuntimeHeaderTable_VirtualAddress_Size)
                    Self.AddQBytesDllDataDir(Self.PEFileOffset1,'Reserved Table'         ,Self.currentOffset, Self.DD_ReservedTable_VirtualAddress         , Self.DD_ReservedTable_VirtualAddress_Hex           , Self.DD_ReservedTable_VirtualAddress_Size)

                    Self.Pos = Self.currentOffset + 8 + 120

                    Self.EndOptionalHeader = true
                    Cycle
                End
            End
        End

        If Self.EndOptionalHeader

            If Self.QDLLSections_Fill = 0
                Self.QDLLSections_Fill = True
                Free(Self.QDLLSections)

                S# = -1
                Loop Self.COFFFileHeader.NumberOfSections Times
                    S# = S# + 1
                    Clear(Self.QDLLSections)

                    K# = 0
                    FN# = 0
                    Loop 8 Times
                        Get(Self.QBytesDll,Self.Pos)
                        If Errorcode() <> 0
                            Message('error')
                            Break
                        End
                        K# = K# + 1
                        If Self.QBytesDll.Byte = 0
                            FN# = TRUE
                        Else
                            If FN# = 0
                                Self.QDLLSections.Name[K#] = Self.QBytesDll.Char
                            End
                        End
                        Self.Pos = Self.Pos + 1
                        Self.currentOffset = Self.currentOffset + 1
                    End
                    Self.CalcQBytesValues(Self.Pos, 4, 'VirtualSize'              , Self.QDLLSections.VirtualSize          , Self.QDLLSections.VirtualSizeHex)
                    Self.CalcQBytesValues(Self.Pos, 4, 'VirtualAddress'           , Self.QDLLSections.VirtualAddress       , Self.QDLLSections.VirtualAddressHex)
                    Self.CalcQBytesValues(Self.Pos, 4, 'SizeOfRawData'            , Self.QDLLSections.SizeOfRawData        , Self.QDLLSections.SizeOfRawDataHex)
                    Self.CalcQBytesValues(Self.Pos, 4, 'PointerToRawData'         , Self.QDLLSections.PointerToRawData     , Self.QDLLSections.PointerToRawDataHex)
                    Self.CalcQBytesValues(Self.Pos, 4, 'PointerToRelocations'     , Self.QDLLSections.PointerToRelocations , Self.QDLLSections.PointerToRelocationsHex)
                    Self.CalcQBytesValues(Self.Pos, 4, 'PointerToLinenumbers'     , Self.QDLLSections.PointerToLinenumbers , Self.QDLLSections.PointerToLinenumbersHex)
                    Self.CalcQBytesValues(Self.Pos, 2, 'NumberOfRelocations'      , Self.QDLLSections.NumberOfRelocations  , Self.QDLLSections.NumberOfRelocationsHex)
                    Self.CalcQBytesValues(Self.Pos, 2, 'NumberOfLinenumbers'      , Self.QDLLSections.NumberOfLinenumbers  , Self.QDLLSections.NumberOfLinenumbersHex)
                    Self.CalcQBytesValues(Self.Pos, 4, 'Characteristics'          , Self.QDLLSections.Characteristics      , Self.QDLLSections.CharacteristicsHex)


                    If BAND(IMAGE_SCN_TYPE_NO_PAD,Self.QDLLSections.Characteristics) <> 0               !(000000008h)
                        Self.QDLLSections.TYPE_NO_PAD = True
                    End
                    If BAND(IMAGE_SCN_CNT_CODE,Self.QDLLSections.Characteristics) <> 0                  !(000000020h)
                        Self.QDLLSections.CNT_CODE = True
                    End
                    If BAND(IMAGE_SCN_CNT_INITIALIZED_DATA,Self.QDLLSections.Characteristics) <> 0      !(000000040h)
                        Self.QDLLSections.CNT_INITIALIZED_DATA = True
                    End
                    If BAND(IMAGE_SCN_CNT_UNINITIALIZED_DATA,Self.QDLLSections.Characteristics) <> 0    !(000000080h)
                        Self.QDLLSections.CNT_UNINITIALIZED_DATA = True
                    End
                    If BAND(IMAGE_SCN_LNK_OTHER,Self.QDLLSections.Characteristics) <> 0                 !(000000100h)
                        Self.QDLLSections.LNK_OTHER = True
                    End
                    If BAND(IMAGE_SCN_LNK_INFO,Self.QDLLSections.Characteristics) <> 0                  !(000000200h)
                        Self.QDLLSections.LNK_INFO = True
                    End
                    If BAND(IMAGE_SCN_LNK_REMOVE,Self.QDLLSections.Characteristics) <> 0                !(000000800h)
                        Self.QDLLSections.LNK_REMOVE = True
                    End
                    If BAND(IMAGE_SCN_LNK_COMDAT,Self.QDLLSections.Characteristics) <> 0                !(000001000h)
                        Self.QDLLSections.LNK_COMDAT = True
                    End
                    If BAND(IMAGE_SCN_GPREL,Self.QDLLSections.Characteristics) <> 0                     !(000008000h)
                        Self.QDLLSections.GPREL = True
                    End
                    If BAND(IMAGE_SCN_MEM_PURGEABLE,Self.QDLLSections.Characteristics) <> 0             !(000010000h)
                        Self.QDLLSections.MEM_PURGEABLE = True
                    End
                    If BAND(IMAGE_SCN_MEM_16BIT,Self.QDLLSections.Characteristics) <> 0                 !(000020000h)
                        Self.QDLLSections.MEM_16BIT = True
                    End
                    If BAND(IMAGE_SCN_MEM_LOCKED,Self.QDLLSections.Characteristics) <> 0                !(000040000h)
                        Self.QDLLSections.MEM_LOCKED = True
                    End
                    If BAND(IMAGE_SCN_MEM_PRELOAD,Self.QDLLSections.Characteristics) <> 0               !(000080000h)
                        Self.QDLLSections.MEM_PRELOAD = True
                    End
                    If BAND(IMAGE_SCN_ALIGN_1BYTES,Self.QDLLSections.Characteristics) <> 0              !(000100000h)
                        Self.QDLLSections.ALIGN_1BYTES = True
                    End
                    If BAND(IMAGE_SCN_ALIGN_2BYTES,Self.QDLLSections.Characteristics) <> 0              !(000200000h)
                        Self.QDLLSections.ALIGN_2BYTES = True
                    End
                    If BAND(IMAGE_SCN_ALIGN_4BYTES,Self.QDLLSections.Characteristics) <> 0              !(000300000h)
                        Self.QDLLSections.ALIGN_4BYTES = True
                    End
                    If BAND(IMAGE_SCN_ALIGN_8BYTES,Self.QDLLSections.Characteristics) <> 0              !(000400000h)
                        Self.QDLLSections.ALIGN_8BYTES = True
                    End
                    If BAND(IMAGE_SCN_ALIGN_16BYTES,Self.QDLLSections.Characteristics) <> 0             !(000500000h)
                        Self.QDLLSections.ALIGN_16BYTES = True
                    End
                    If BAND(IMAGE_SCN_ALIGN_32BYTES,Self.QDLLSections.Characteristics) <> 0             !(000600000h)
                        Self.QDLLSections.ALIGN_32BYTES = True
                    End
                    If BAND(IMAGE_SCN_ALIGN_64BYTES,Self.QDLLSections.Characteristics) <> 0             !(000700000h)
                        Self.QDLLSections.ALIGN_64BYTES = True
                    End
                    If BAND(IMAGE_SCN_ALIGN_128BYTES,Self.QDLLSections.Characteristics) <> 0            !(000800000h)
                        Self.QDLLSections.ALIGN_128BYTES = True
                    End
                    If BAND(IMAGE_SCN_ALIGN_256BYTES,Self.QDLLSections.Characteristics) <> 0            !(000900000h)
                        Self.QDLLSections.ALIGN_256BYTES = True
                    End
                    If BAND(IMAGE_SCN_ALIGN_512BYTES,Self.QDLLSections.Characteristics) <> 0            !(000A00000h)
                        Self.QDLLSections.ALIGN_512BYTES = True
                    End
                    If BAND(IMAGE_SCN_ALIGN_1024BYTES,Self.QDLLSections.Characteristics) <> 0           !(000B00000h)
                        Self.QDLLSections.ALIGN_1024BYTES = True
                    End
                    If BAND(IMAGE_SCN_ALIGN_2048BYTES,Self.QDLLSections.Characteristics) <> 0           !(000C00000h)
                        Self.QDLLSections.ALIGN_2048BYTES = True
                    End
                    If BAND(IMAGE_SCN_ALIGN_4096BYTES,Self.QDLLSections.Characteristics) <> 0           !(000D00000h)
                        Self.QDLLSections.ALIGN_4096BYTES = True
                    End
                    If BAND(IMAGE_SCN_ALIGN_8192BYTES,Self.QDLLSections.Characteristics) <> 0           !(000E00000h)
                        Self.QDLLSections.ALIGN_8192BYTES = True
                    End
                    If BAND(IMAGE_SCN_LNK_NRELOC_OVFL,Self.QDLLSections.Characteristics) <> 0           !(001000000h)
                        Self.QDLLSections.LNK_NRELOC_OVFL = True
                    End
                    If BAND(IMAGE_SCN_MEM_DISCARDABLE,Self.QDLLSections.Characteristics) <> 0           !(002000000h)
                        Self.QDLLSections.MEM_DISCARDABLE = True
                    End
                    If BAND(IMAGE_SCN_MEM_NOT_CACHED,Self.QDLLSections.Characteristics) <> 0            !(004000000h)
                        Self.QDLLSections.MEM_NOT_CACHED = True
                    End
                    If BAND(IMAGE_SCN_MEM_NOT_PAGED,Self.QDLLSections.Characteristics) <> 0             !(008000000h)
                        Self.QDLLSections.MEM_NOT_PAGED = True
                    End
                    If BAND(IMAGE_SCN_MEM_SHARED,Self.QDLLSections.Characteristics) <> 0                !(010000000h)
                        Self.QDLLSections.MEM_SHARED = True
                    End
                    If BAND(IMAGE_SCN_MEM_EXECUTE,Self.QDLLSections.Characteristics) <> 0               !(020000000h)
                        Self.QDLLSections.MEM_EXECUTE = True
                    End
                    If BAND(IMAGE_SCN_MEM_READ,Self.QDLLSections.Characteristics) <> 0                  !(040000000h)
                        Self.QDLLSections.MEM_READ = True
                    End
                    If BAND(IMAGE_SCN_MEM_WRITE,Self.QDLLSections.Characteristics) <> 0                 !(080000000h)
                        Self.QDLLSections.MEM_WRITE = True
                    End
                    Self.QDLLSections.Id = Records(Self.QDLLSections) + 1 ! in case only 1 dll , todo
                    Add(Self.QDLLSections)
                End

                Self.LastPos = Self.Pos
            End
        End
    End
    Return ''

c25_DataReflectionClass.GetQBytesDll                    Procedure(<*long _jsonQBytesDll>, <*long _jsonQBytesDllSize>)

Tuple2                                                                      Group
V1                                                                              LONG
V2                                                                              LONG
                                                                            End
    CODE

    Self.BitConverter.St2.Start()
    !Self.BitConverter.St2.Append(Self.BitConverter.QToJson(Self.QBytesDll,'QBytesDll.json', False, True))

    Tuple2 = Self.ObjectClass.StringTheoryToMemAllocPtr(Self.BitConverter.st2, true)
    _jsonQBytesDll      = Tuple2.V1
    _jsonQBytesDllSize  = Tuple2.V2


c25_DataReflectionClass.GetQDLLSections                 Procedure(<*long _jsonQDLLSections>, <*long _jsonQDLLSectionsSize>)

Tuple2                                                                      Group
V1                                                                              LONG
V2                                                                              LONG
                                                                            End
    CODE

    Self.BitConverter.St2.Start()
    !Self.BitConverter.St2.Append(Self.BitConverter.QToJson(Self.QDLLSections,'QDLLSections.json', False, True))

    Tuple2 = Self.ObjectClass.StringTheoryToMemAllocPtr(Self.BitConverter.st2, true)
    _jsonQDLLSections      = Tuple2.V1
    _jsonQDLLSectionsSize  = Tuple2.V2


!c25_DataReflectionClass.Analyze                                 Procedure(<*QUEUE _queue>, <*ClarionFields_TYPE _outputQ>, <Byte _autoStyleColumns>, <*GROUP _group>, <String _tableName>, <bool _debug>, <String _name>, <String _jsonFileOut>)
c25_DataReflectionClass.Analyze                                 Procedure(<*QUEUE _queue>, <*ClarionFields_TYPE _outputQ>, <String _jsonFileOut>)

AdrGroup                        GROUP,PRE(AdrGroup)
PtrAddress                          Long
PtrSize                             Long
                                End
AdrGroupGrp                     GROUP,PRE(AdrGroupGrp)
PtrAddress                          Long
PtrSize                             Long
PtrGrp                              Long
                                End
Address                         Long
AAABlock                        &String
AAABlockMod                     &String
AnyField                        ANY
Block                           &String
CurrentFieldAnyString1          String(1)
DecFieldReturnA                 cString(128)
DecFieldReturnB                 cString(128)
DecFieldStr                     &String
DisplayOrdinal                  Long
FieldIndex                      Long
Fields                          Long
FieldTestIndex                  Long
G                               Long
GroupOriginalSize               Long
GroupStrMod                     &String
GroupStrOrg                     &String
GroupTestBlock                  &String
GroupWidthDisplay               Long
Offset                          Long
OriginalRecord                  &String
TestREAL                        real
TestSREAL                       sreal
TestString                      &String
TestStringLen                   Long
WhoLine                         CSTRING(1024)
ZeroBlock                       &String
QFields                         QUEUE,PRE(QFields)
Ordinal                             Long
Prefix                              Cstring(255)
Name                                Cstring(255)
Characters                          Long
Places                              Long
DataType                            Cstring(255)
DataTypeEnum                        Long
EncodingEnum                        LONG
Dims                                Long
IsGroup                             Byte
IsQueue                             Byte
IsRef                               Byte
PropertyName                        Cstring(2048)
Offset                              Long
OffsetEnd                           Long
PtrAddress                          Long
PtrAddressSize                      Long
PtrSize                             Long
PtrSizeSize                         Long
SizeBytes                           Long
                                End
QBytesB                         QUEUE,PRE(QBytesB)
Pos                                 Long
Changed                             Byte
ByteVal                             Byte
ByteStr                             String(1)
                                End
QBytesOrg                       QUEUE,PRE(QBytesOrg)
Pos                                 Long
Changed                             Byte
ByteVal                             Byte
ByteStr                             String(1)
                                End
QBytesA                         QUEUE,PRE(QBytesA)
Pos                                 Long
Changed                             Byte
ByteVal                             Byte
ByteStr                             String(1)
                                End
AddressFromAny                  String(4),over(Address)
AddressAndSizeFromAny           String(8),over(AdrGroup)
AddressAndSizeFromAnyGrp        String(12),over(AdrGroupGrp)
DecNineBlock                    &String
AnyField2                       ANY
AnyFieldInString31              String(50)
TestBlock                       &String
TestQRef                        Group,Pre(TestQRef)
SomeQRef                            &QUEUE
                                End
DebugThis                       BOOL


    Code

!        If omitted(_tableName) = False
!        End

        OriginalRecord &= NEW String(Size(_queue))
        OriginalRecord = _queue
        If _queue &= NULL
            MESSAGE('Error, reflection queue is null')
            Return ''
        End

        
        If not Self.ClarionFields &= null
            Free(Self.ClarionFields)
        Else
            Self.ClarionFields &= NEW ClarionFields_TYPE()
        End

        Self.FieldsCount = 0

        Free(QBytesOrg)
        Clear(QBytesOrg)

        Fields = 0
        FieldIndex = 0
        Loop 4096 Times
            If Who(_queue, FieldIndex + 1) = ''
                Break
            End
            FieldIndex += 1
            QFields.Ordinal = FieldIndex
            Add(QFields)
        End
        
        
        
        Fields = FieldIndex

        FieldTestIndex = 1

        GroupOriginalSize   = Size(_queue)
        GroupStrOrg         &= NEW String(GroupOriginalSize)
        TestBlock           &= NEW String(GroupOriginalSize)
        GroupStrOrg         = _queue

        !Message('Records(QFields) ' & Records(QFields) & 'Size : ' & Size(TestBlock))
        
        G = 0
        Loop GroupOriginalSize times
            G = G + 1
            Clear(QBytesOrg)
            QBytesOrg.Pos = G
            QBytesOrg.Changed = 0
            QBytesOrg.ByteVal = Val(GroupStrOrg[G])
            QBytesOrg.ByteStr = GroupStrOrg[G]
            Add(QBytesOrg)
        End

        GroupWidthDisplay = GroupOriginalSize

        GroupTestBlock      &= NEW String(GroupOriginalSize)
        P# = 0
        Loop GroupOriginalSize Times
            P# = P# + 1
            GroupTestBlock[P#] = Chr(255)
        End

        ZeroBlock  &= NEW String(GroupOriginalSize)
        P# = 0
        Loop GroupOriginalSize Times
            P# = P# + 1
            ZeroBlock[P#] = Chr(0)
        End

        DecNineBlock  &= NEW String(GroupOriginalSize)
        P# = 0
        Loop GroupOriginalSize Times
            P# = P# + 1
            DecNineBlock[P#] = Chr(153)
        End

        AAABlock  &= NEW String(GroupOriginalSize)
        P# = 0
        Loop GroupOriginalSize Times
            P# = P# + 1
            AAABlock[P#] = 'A'
        End

        AAABlockMod     &= NEW String(GroupOriginalSize)
        Block           &= NEW String(GroupOriginalSize)
        GroupStrMod     &= NEW String(GroupOriginalSize)

        Offset = 1
        Loop
            If FieldTestIndex > Fields
                BREAK
            End

            _queue = GroupTestBlock

            Free(QBytesA)
            G# = 0
            Loop GroupOriginalSize times
                G# = G# + 1
                Clear(QBytesA)
                QBytesA.Pos      = G#
                QBytesA.Changed  = 0
                QBytesA.ByteVal  = Val(GroupTestBlock[G#])
                QBytesA.ByteStr  = GroupTestBlock[G#]
                Add(QBytesA)
            End
            If _queue &= NULL
                Message('error in reflection _queue is null')
            End

!            If omitted(_tableName) = False
!            End
            AnyField        &= NULL
            AnyField        &= What(_queue,FieldTestIndex)

!            If omitted(_tableName) = False
!            End

            If AnyField &= NULL
                Message('error If AnyField &= NULL')
                break
            Else

            End
            AnyField     = ZeroBlock

            GroupStrMod         = _queue

            Free(QBytesB)
            S# = 0
            G# = 0

            Loop GroupOriginalSize Times
                G# = G# + 1
                Clear(QBytesB)

                Get(QBytesA,G#)
                QBytesB.Pos      = G#

                QBytesB.ByteVal  = Val(GroupStrMod[G#])
                QBytesB.ByteStr  = GroupStrMod[G#]

                If QBytesA.ByteVal <> QBytesB.ByteVal
                    QBytesB.Changed = True
                    S# = S# + 1
                End
                Add(QBytesB)
            End

            Get(QFields,FieldTestIndex)
            WhoLine = WHO(_queue,FieldTestIndex)

            SPACE# = Instring(' ',WhoLine,1,1)
            If SPACE# > 0
                Message('who : ' & Clip(WhoLine))
                
                P# = Instring('RENAME(',Clip(Upper(WhoLine)),1,1)
                If P# > 0
                    WhoLine = WhoLine[P# + LEN('REPLACE(')-1 : Size(WhoLine)]
                    P# = Instring(')',Clip(Upper(WhoLine)),1,1)
                    If P# > 1
                        QFields.Name = WhoLine[1 : P#-1]
                    End
                Else
                    !If SPACE# > 0
                        !QFields.Name = WhoLine[1 : SPACE#-1]
                    !ELSE
                        QFields.Name = Clip(WhoLine)
                    !End
                End
            Else
                QFields.Name = Clip(WhoLine)
            End

            B# = Instring(':',QFields.Name,1,1)
            If B# > 1
                QFields:Prefix = QFields.Name[1 : B#-1]
                QFields.Name = Clip(QFields.Name[B#+1 : Size(QFields.Name)])
            End
            QFields.Name = CLIP(QFields.Name)

            QFields.SizeBytes   = S#
!            If S# = 200000
!                DebugThis = TRUE
!                
!                Message('DebugThis on')
!            End
!            
            QFields.Offset      = Offset -1
            QFields.OffsetEnd   = QFields.Offset + QFields.SizeBytes - 1
            Put(QFields)

            Offset = Offset + S#

            FieldTestIndex = FieldTestIndex + 1
            If FieldTestIndex > Fields
                Break
            End
        End

        
        
        
        _queue = ZeroBlock
        Clear(_queue)

        FieldTestIndex = 0
        Loop
            FieldTestIndex = FieldTestIndex + 1
            If FieldTestIndex > Fields
                Break
            End
            Get(QFields,FieldTestIndex)
            If (QFields.SizeBytes <> 4 And QFields.SizeBytes <> 8 And QFields.SizeBytes <> 12)
                Cycle
            End
            AnyField &= What(_queue,FieldTestIndex)

            Case QFields.SizeBytes
            Of 4
                AddressFromAny = AnyField
                If Address = 0
                    QFields:IsRef = True
                    If Len(Clip(WHO(_queue,FieldTestIndex))) > 0
                        QFields.IsQueue = True
                    End
                    Put(QFields)
                End
            Of 8
                AddressAndSizeFromAny = AnyField
                If AdrGroup.PtrAddress = 0 And AdrGroup.PtrSize = 0
                    QFields:IsRef = True
                    Put(QFields)
                End
            Of 12
                AddressAndSizeFromAnyGrp = AnyField
                If AdrGroupGrp.PtrAddress = 0 And AdrGroupGrp.PtrSize = 0
                    QFields:IsRef = True
                    QFields.IsGroup = True
                    Put(QFields)
                End
            End
        End

        _queue = AAABlock

        FieldTestIndex = 0
        Loop
            FieldTestIndex = FieldTestIndex + 1
            If FieldTestIndex > Fields
                Break
            End
            Get(QFields,FieldTestIndex)
            AnyField     &= What(_queue,FieldTestIndex)

            CurrentFieldAnyString1 = AnyField
            If CurrentFieldAnyString1[1] <> 'A'
                cycle
            End

            TestStringLen = QFields.SizeBytes
            If TestStringLen = 0
                Cycle
            End
            If Not TestString &= NULL
                Dispose(TestString)
                TestString &= NULL
            End
            TestString &= NEW String(TestStringLen)

            P# = 0
            Loop TestStringLen Times
                P# = P# + 1
                TestString[P#] = 'A'
            End

            If AnyField = TestString
                QFields.DataType = 'STRING'
            End

            AnyField     &= What(_queue,FieldTestIndex)

            L1# = Len(AnyField)

            TestStringLen = QFields.SizeBytes
            If TestStringLen = 0
                Cycle
            End
            If Not TestString &= NULL
                Dispose(TestString)
                TestString &= NULL
            End
            TestString &= NEW String(TestStringLen)

            P# = 0
            Loop TestStringLen Times
                P# = P# + 1
                TestString[P#] = Chr(0)
            End
            AnyField = Chr(0)

            If L1# <> Len(AnyField)
                QFields.DataType = 'CSTRING'
            End

            Put(QFields)
        End

        _queue = ZeroBlock
        FieldTestIndex = 0
        Loop

            FieldTestIndex = FieldTestIndex + 1
            If FieldTestIndex > Fields
                Break
            End
            Get(QFields,FieldTestIndex)
            If Len(QFields.DataType) > 0
                Cycle
            End
            If QFields.DataType = 'STRING'
                Cycle
            End
            If QFields.DataType = 'CSTRING'
                Cycle
            End

            If (QFields.SizeBytes <> 4 And QFields.SizeBytes <> 2 And QFields.SizeBytes <> 1)
                cycle
            End
            Case QFields.SizeBytes
            Of 1
                AnyField         &= What(_queue,FieldTestIndex)
                AnyField = 255
                If AnyField = 255
                    QFields.DataType = 'BYTE'
                End
            Of 2
                AnyField         &= What(_queue,FieldTestIndex)
                AnyField = 2^16-1
                If AnyField < 0
                    QFields.DataType = 'SHORT'
                Else
                    QFields.DataType = 'USHORT'
                End
            Of 4
                AnyField         &= What(_queue,FieldTestIndex)
                AnyField = 2^32-1
                If AnyField < 0
                    QFields.DataType = 'LONG'
                Else
                    QFields.DataType = 'ULONG'
                End
            End
            Put(QFields)
        End

        
        _queue = ZeroBlock
        FieldTestIndex = 0
        Loop
            _queue = ZeroBlock
            FieldTestIndex = FieldTestIndex + 1
            If FieldTestIndex > Fields
                Break
            End
            Get(QFields,FieldTestIndex)
            Case QFields.DataType
            Of 'STRING'
            OrOf 'CSTRING'
                CYCLE
            End
            
            If QFields.SizeBytes <> 4
                Cycle
            End            
            AnyField &= What(_queue,FieldTestIndex)
            TestSREAL = 0.12345
            AnyField = TestSREAL

            DecFieldReturnA = TestSREAL
            DecFieldReturnB = AnyField

            If DecFieldReturnA = DecFieldReturnB
                QFields.DataType = 'SREAL'
            End
            Put(QFields)
        End

        _queue = ZeroBlock
        FieldTestIndex = 0
        Loop
            _queue = ZeroBlock
            FieldTestIndex = FieldTestIndex + 1
            If FieldTestIndex > Fields
                Break
            End
            Get(QFields,FieldTestIndex)
            Case QFields.DataType
            Of 'STRING'
            OrOf 'CSTRING'
                CYCLE
            End
            If QFields.SizeBytes <> 8
                Cycle
            End
            AnyField &= What(_queue,FieldTestIndex)

            
            
            TestSREAL = 0.12345
            AnyField = TestREAL

            DecFieldReturnA = TestREAL
            DecFieldReturnB = AnyField

            If DecFieldReturnA = DecFieldReturnB
                QFields.DataType = 'REAL'
                QFields.IsRef = False
            End
            Put(QFields)
        End

        FieldTestIndex = 0
        Loop
            FieldTestIndex = FieldTestIndex + 1
            If FieldTestIndex > Fields
                Break
            End
            Get(QFields,FieldTestIndex)

            Case QFields.DataType
            Of 'REAL'
            OrOf 'SREAL'
                CYCLE
            End
            
            
            TestBlock = ZeroBlock
            If QFields.OffsetEnd + 1 < QFields.Offset + 1
                Message('errorcode If QFields.OffsetEnd + 1 < QFields.Offset + 1 --- QFields.OffsetEnd: ' & QFields.OffsetEnd & ', QFields.Offset: ' & QFields.Offset & ', FieldTestIndex: ' & FieldTestIndex & ', GroupOriginalSize: ' & GroupOriginalSize)
            End
            If QFields.SizeBytes-1 < 1
                Cycle
            End
            If QFields.SizeBytes-1 > Size(TestBlock)
                Message('error If QFields.SizeBytes-1 > Size(TestBlock)')
            End
            If Size(TestBlock) < QFields.Offset + 1
                Message('error If Size(TestBlock) < QFields.Offset + 1')
            End
            If Size(TestBlock) < QFields.OffsetEnd + 1
                !Message(_name)
                Message(QFields.Name & ' error If Size(TestBlock) < QFields.OffsetEnd + 1')
                Message('QFields.OffsetEnd + 1 ' & QFields.OffsetEnd + 1)
                Message('Size(TestBlock) ' & Size(TestBlock))
            End
            If QFields.OffsetEnd + 1 < 1
                Message('error If QFields.OffsetEnd + 1 < 1')
            End
            If QFields.Offset + 1 < 1
                Message('error If QFields.Offset + 1 < 1')
            End
            TestBlock[QFields.Offset + 1 : QFields.OffsetEnd + 1] = Chr(0F5h) & All(Chr(055h), QFields.SizeBytes-1)
            _queue = TestBlock

            AnyField &= What(_queue,FieldTestIndex)
            AnyFieldInString31 = AnyField

            AnyFieldInString31 = Left(AnyFieldInString31)
            If AnyFieldInString31[1] <> '-'
                Cycle
            End

            DEC# = True
            P# = 1
            R# = Len(Clip(AnyFieldInString31)) -1
            Loop R# Times
                P# = P# + 1
                If AnyFieldInString31[P#] = '.'
                    Cycle
                End
                If AnyFieldInString31[P#] <> '5'
                    DEC# = False
                    Break
                End
            End
            If DEC# = False
                CYCLE
            End

            P# = Len(Clip(AnyFieldInString31)) + 1
            Places# = 0
            LOOP
                P# = P# - 1
                If P# < 1
                    Places# = 0
                    BREAK
                End
                If AnyFieldInString31[P#] = '.'
                    Break
                End
                Places# = Places# + 1
            End
            QFields.Places = Places#
            If Places# > 0
                QFields.Characters = Len(Clip(AnyFieldInString31)) -2
            Else
                QFields.Characters = Len(Clip(AnyFieldInString31)) -1
            End
            QFields.DataType = 'DECIMAL'
            Put(QFields)
        End

        _queue = ZeroBlock
        FieldTestIndex = 0

        If not Self.ClarionFields &= null
            Free(Self.ClarionFields)
        Else
            Self.ClarionFields &= NEW ClarionFields_TYPE
        End

        G# = 0
        T# = Records(QFields)
        Loop T# times
            G# = G# + 1
            Get(QFields,G#)
            Clear(Self.ClarionFields)

            QFields.Name                                = CLIP(QFields.Name)
            QFields.DataType                            = CLIP(QFields.DataType)

            Self.ClarionFields.Name                   = QFields.Name
            If LEN(CLIP(Self.ClarionFields.Name)) = 0
                MESSAGE('warning reflection, no name defined in your queue on position ' & G# & ', ' & WHO(_queue,G#))
            End
            Self.ClarionFields.Characters               = QFields.Characters
            Self.ClarionFields.DataType                 = Upper(QFields.DataType)
            Self.ClarionFields.Dims                     = QFields.Dims
            Self.ClarionFields.Ordinal                  = QFields.Ordinal
            Self.ClarionFields.IsRef                    = QFields.IsRef
            Self.ClarionFields.Offset                   = QFields.Offset
            Self.ClarionFields.OffsetEnd                = QFields.OffsetEnd


            Self.ClarionFields.Places                   = QFields.Places
            Self.ClarionFields.SizeBytes                = QFields.SizeBytes
            Self.ClarionFields.IsQueue                  = QFields.IsQueue
            Self.ClarionFields.IsGroup                  = QFields.IsGroup


            Case Upper(QFields.DataType)
            Of 'CSTRING'
                If QFields.IsRef
                    Self.ClarionFields.DataTypeEnum = DataTypeEnum:CLA_CSTRING
                ELSE
                    Self.ClarionFields.Characters = Self.ClarionFields.SizeBytes
                    Self.ClarionFields.DataTypeEnum = DataTypeEnum:CLA_CSTRING
                End
                QFields.DataType = 'CLA_CSTRING'
            Of 'STRING'
                If QFields.IsRef
                    Self.ClarionFields.DataTypeEnum = DataTypeEnum:CLA_STRING
                ELSE
                    Self.ClarionFields.Characters = Self.ClarionFields.SizeBytes
                    Self.ClarionFields.DataTypeEnum = DataTypeEnum:CLA_STRING
                End
                QFields.DataType = 'CLA_STRING'
            Of 'ULONG'
                Self.ClarionFields.DataTypeEnum = DataTypeEnum:CLA_ULONG
                QFields.DataType = 'CLA_ULONG'
            Of 'LONG'
                Self.ClarionFields.DataTypeEnum = DataTypeEnum:CLA_LONG
                QFields.DataType = 'CLA_LONG'
            Of 'SHORT'
                Self.ClarionFields.DataTypeEnum = DataTypeEnum:CLA_SHORT
                QFields.DataType = 'CLA_SHORT'
            Of 'USHORT'
                Self.ClarionFields.DataTypeEnum = DataTypeEnum:CLA_USHORT
                QFields.DataType = 'CLA_USHORT'
            Of 'BYTE'
                Self.ClarionFields.DataTypeEnum = DataTypeEnum:CLA_BYTE
                QFields.DataType = 'CLA_BYTE'
            Of 'REAL'
                Self.ClarionFields.DataTypeEnum = DataTypeEnum:CLA_REAL
                QFields.DataType = 'CLA_REAL'
            Of 'SREAL'
                Self.ClarionFields.DataTypeEnum = DataTypeEnum:CLA_SREAL
                QFields.DataType = 'CLA_SREAL'
            Of 'DECIMAL'
                Self.ClarionFields.DataTypeEnum = DataTypeEnum:CLA_DECIMAL
                QFields.DataType = 'CLA_DECIMAL'
            End
            Self.ClarionFields.DataType = QFields.DataType
            Self.ClarionFields.KeyValues &= NEW KeyValue_TYPE()
            Add(Self.ClarionFields)
            Put(QFields)

        End

        Self.FieldsCount = Records(Self.ClarionFields)

        If OMITTED(_outputQ) = False
            Free(_outputQ)
            G# = 0
            T# = Records(Self.ClarionFields)
            Loop
                G# = G# + 1
                Get(Self.ClarionFields,G#)
                If Errorcode() <> 0
                    BREAK
                End
                _outputQ = Self.ClarionFields
                _outputQ.KeyValues &= NEW KeyValue_TYPE()
                Add(_outputQ)
            End
        End

        _queue = OriginalRecord
        Dispose(OriginalRecord)

        Self.FieldsCount = Records(Self.ClarionFields)
        If omitted(_jsonFileOut) = FALSE
            Self.BitConverter.QToJson(Self.ClarionFields, _jsonFileOut, true)
        End

        Return ''

c25_DataReflectionClass.DataTypeEnumToClarionQStorageSize       Procedure(long _dataTypeEnum, <long _characters>, <long _places>)

    CODE

        Case _dataTypeEnum
        Of DataTypeEnum:CLA_BYTE
            Return 1
        Of DataTypeEnum:CLA_SHORT
            Return 2
        Of DataTypeEnum:CLA_USHORT
            Return 2
        Of DataTypeEnum:CLA_DATE
            Return 4
        Of DataTypeEnum:CLA_TIME
            Return 4
        Of DataTypeEnum:CLA_LONG
            Return 4
        Of DataTypeEnum:CLA_ULONG
            Return 4
        Of DataTypeEnum:CLA_SREAL
            Return 4
        Of DataTypeEnum:CLA_REAL
            Return 8
        Of DataTypeEnum:CLA_DECIMAL
            If not (_characters%2) ! isEven
               BytesNeeded# = (_characters+2) / 2
            Else
               BytesNeeded# = (_characters+1) / 2
            End
            Return BytesNeeded#
        Of DataTypeEnum:CLA_PDECIMAL
            D# = (_characters / 2) + 1 ! TODO
            Return D#
        Of DataTypeEnum:CLA_UNKNOWN12
            Return 0
        Of DataTypeEnum:CLA_BFLOAT4
            Return 4
        Of DataTypeEnum:CLA_BFLOAT8
            Return 8
        Of DataTypeEnum:CLA_ANY
            Return 8
        Of DataTypeEnum:CLA_UNKNOWN16
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN17
            Return 0
        Of DataTypeEnum:CLA_STRING
            Return _characters
        Of DataTypeEnum:CLA_CSTRING
            Return _characters + 1
        Of DataTypeEnum:CLA_PSTRING
            Return _characters ! TODO
        Of DataTypeEnum:CLA_MEMO
            Return _characters
        Of DataTypeEnum:CLA_GROUP
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN23
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN24
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN25
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN26
            Return 0
        Of DataTypeEnum:CLA_BLOB
            Return _characters
        Of DataTypeEnum:CLA_UNKNOWN28
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN29
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN30
            Return 0
        Of DataTypeEnum:CLA_REFERENCE
            Return 8
        Of DataTypeEnum:CLA_BSTRING
            Return 8 ! todo
        Of DataTypeEnum:CLA_ASTRING
            Return _characters ! todo
        Of DataTypeEnum:CLA_KEY
            Return 0
        Of DataTypeEnum:CLAEXT_Dec20
            Return 11
        Of DataTypeEnum:CLAEXT_INT64LIKE
            Return 8
        Of DataTypeEnum:CLAEXT_INT64STR8
            Return 8
        Of DataTypeEnum:CLAEXT_JSONInstance
            Return 8
        Of DataTypeEnum:CLAEXT_QUEUEREF
            Return 8
        Of DataTypeEnum:CLAEXT_STInstance
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGANSI
            Return _characters
        Of DataTypeEnum:CLAEXT_STRINGBINARY
            Return _characters
        Of DataTypeEnum:CLAEXT_STRINGJSON
            Return _characters
        Of DataTypeEnum:CLAEXT_STRINGREFANSI
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGREFBINARY
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGREFUTF16
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGREFUTF32
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGREFUTF8
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGUTF16
            Return _characters
        Of DataTypeEnum:CLAEXT_STRINGUTF32
            Return _characters
        Of DataTypeEnum:CLAEXT_STRINGUTF8
            Return _characters
        Of DataTypeEnum:CLAEXT_UINT64LIKE
            Return 8
        Of DataTypeEnum:CLAEXT_UINT64STR8
            Return 8
        Of DataTypeEnum:MSSQL_BIGINT
            Return 8
        Of DataTypeEnum:MSSQL_BINARY
            Return _characters
        Of DataTypeEnum:MSSQL_BIT
            Return 1
        Of DataTypeEnum:MSSQL_CHAR
            Return _characters
        Of DataTypeEnum:MSSQL_DATETIME
            Return 8
        END
        Return _characters

c25_DataReflectionClass.DataTypeEnumToClarionQStorageType       Procedure(long _dataTypeEnum)

    CODE

        Case _dataTypeEnum
        Of DataTypeEnum:CLA_BYTE
            Return DataTypeEnum:CLA_BYTE
        Of DataTypeEnum:CLA_SHORT
            Return DataTypeEnum:CLA_SHORT
        Of DataTypeEnum:CLA_USHORT
            Return DataTypeEnum:CLA_USHORT
        Of DataTypeEnum:CLA_DATE
            Return DataTypeEnum:CLA_DATE
        Of DataTypeEnum:CLA_TIME
            Return DataTypeEnum:CLA_TIME
        Of DataTypeEnum:CLA_LONG
            Return DataTypeEnum:CLA_LONG
        Of DataTypeEnum:CLA_ULONG
            Return DataTypeEnum:CLA_ULONG
        Of DataTypeEnum:CLA_SREAL
            Return DataTypeEnum:CLA_SREAL
        Of DataTypeEnum:CLA_REAL
            Return DataTypeEnum:CLA_REAL
        Of DataTypeEnum:CLA_DECIMAL
            Return DataTypeEnum:CLA_DECIMAL
        Of DataTypeEnum:CLA_PDECIMAL
            Return DataTypeEnum:CLA_PDECIMAL
        Of DataTypeEnum:CLA_UNKNOWN12
            Return DataTypeEnum:CLA_UNKNOWN12
        Of DataTypeEnum:CLA_BFLOAT4
            Return DataTypeEnum:CLA_BFLOAT4
        Of DataTypeEnum:CLA_BFLOAT8
            Return DataTypeEnum:CLA_BFLOAT8
        Of DataTypeEnum:CLA_ANY
            Return DataTypeEnum:CLA_ANY
        Of DataTypeEnum:CLA_UNKNOWN16
            Return DataTypeEnum:CLA_UNKNOWN16
        Of DataTypeEnum:CLA_UNKNOWN17
            Return DataTypeEnum:CLA_UNKNOWN17
        Of DataTypeEnum:CLA_STRING
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:CLA_CSTRING
            Return DataTypeEnum:CLA_CSTRING
        Of DataTypeEnum:CLA_PSTRING
            Return DataTypeEnum:CLA_PSTRING
        Of DataTypeEnum:CLA_MEMO
            Return DataTypeEnum:CLA_MEMO
        Of DataTypeEnum:CLA_GROUP
            Return DataTypeEnum:CLA_GROUP
        Of DataTypeEnum:CLA_UNKNOWN23
            Return DataTypeEnum:CLA_UNKNOWN23
        Of DataTypeEnum:CLA_UNKNOWN24
            Return DataTypeEnum:CLA_UNKNOWN24
        Of DataTypeEnum:CLA_UNKNOWN25
            Return DataTypeEnum:CLA_UNKNOWN25
        Of DataTypeEnum:CLA_UNKNOWN26
            Return DataTypeEnum:CLA_UNKNOWN26
        Of DataTypeEnum:CLA_BLOB
            Return DataTypeEnum:CLA_BLOB
        Of DataTypeEnum:CLA_UNKNOWN28
            Return DataTypeEnum:CLA_UNKNOWN28
        Of DataTypeEnum:CLA_UNKNOWN29
            Return DataTypeEnum:CLA_UNKNOWN29
        Of DataTypeEnum:CLA_UNKNOWN30
            Return DataTypeEnum:CLA_UNKNOWN30
        Of DataTypeEnum:CLA_REFERENCE
            Return DataTypeEnum:CLA_REFERENCE
        Of DataTypeEnum:CLA_BSTRING
            Return DataTypeEnum:CLA_BSTRING
        Of DataTypeEnum:CLA_ASTRING
            Return DataTypeEnum:CLA_ASTRING
        Of DataTypeEnum:CLA_KEY
            Return DataTypeEnum:CLA_KEY
        Of DataTypeEnum:CLAEXT_Dec20
            Return DataTypeEnum:CLA_DECIMAL
        Of DataTypeEnum:CLAEXT_INT64LIKE
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:CLAEXT_INT64STR8
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:CLAEXT_JSONInstance
            Return DataTypeEnum:CLA_REFERENCE
        Of DataTypeEnum:CLAEXT_QUEUEREF
            Return DataTypeEnum:CLA_REFERENCE
        Of DataTypeEnum:CLAEXT_STInstance
            Return DataTypeEnum:CLA_REFERENCE
        Of DataTypeEnum:CLAEXT_STRINGANSI
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:CLAEXT_STRINGBINARY
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:CLAEXT_STRINGJSON
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:CLAEXT_STRINGREFANSI
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:CLAEXT_STRINGREFBINARY
            Return DataTypeEnum:CLA_REFERENCE
        Of DataTypeEnum:CLAEXT_STRINGREFUTF16
            Return DataTypeEnum:CLA_REFERENCE
        Of DataTypeEnum:CLAEXT_STRINGREFUTF32
            Return DataTypeEnum:CLA_REFERENCE
        Of DataTypeEnum:CLAEXT_STRINGREFUTF8
            Return DataTypeEnum:CLA_REFERENCE
        Of DataTypeEnum:CLAEXT_STRINGUTF16
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:CLAEXT_STRINGUTF32
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:CLAEXT_STRINGUTF8
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:CLAEXT_UINT64LIKE
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:CLAEXT_UINT64STR8
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:MSSQL_BIGINT
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:MSSQL_BINARY
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:MSSQL_BIT
            Return DataTypeEnum:CLA_BYTE
        Of DataTypeEnum:MSSQL_CHAR
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:MSSQL_DATETIME
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:MSSQL_DECIMAL
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:MSSQL_DOUBLE
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:MSSQL_FLOAT
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:MSSQL_GUID
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:MSSQL_INTEGER
            Return DataTypeEnum:CLA_LONG
        Of DataTypeEnum:MSSQL_INTERVAL
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:MSSQL_INTERVAL_DAY
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:MSSQL_INTERVAL_DAY_TO_HOUR
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:MSSQL_INTERVAL_DAY_TO_MINUTE
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:MSSQL_INTERVAL_DAY_TO_SECOND
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:MSSQL_INTERVAL_HOUR
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:MSSQL_INTERVAL_HOUR_TO_MINUTE
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:MSSQL_INTERVAL_HOUR_TO_SECOND
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:MSSQL_INTERVAL_MINUTE
            Return DataTypeEnum:CLA_STRING
        Of DataTypeEnum:MSSQL_INTERVAL_MINUTE_TO_SECOND
            Return DataTypeEnum:MSSQL_INTERVAL_MINUTE_TO_SECOND
        Of DataTypeEnum:MSSQL_INTERVAL_MONTH
            Return DataTypeEnum:MSSQL_INTERVAL_MONTH
        Of DataTypeEnum:MSSQL_INTERVAL_YEAR
            Return DataTypeEnum:MSSQL_INTERVAL_YEAR
        Of DataTypeEnum:MSSQL_INTERVAL_YEAR_TO_MONTH
            Return DataTypeEnum:MSSQL_INTERVAL_YEAR_TO_MONTH
        Of DataTypeEnum:MSSQL_LONGVARBINARY
            Return DataTypeEnum:MSSQL_LONGVARBINARY
        Of DataTypeEnum:MSSQL_LONGVARCHAR
            Return DataTypeEnum:MSSQL_LONGVARCHAR
        Of DataTypeEnum:MSSQL_NUMERIC
            Return DataTypeEnum:MSSQL_NUMERIC
        Of DataTypeEnum:MSSQL_REAL
            Return DataTypeEnum:MSSQL_REAL
        Of DataTypeEnum:MSSQL_SMALLINT
            Return DataTypeEnum:MSSQL_SMALLINT
        Of DataTypeEnum:MSSQL_TIMESTAMP
            Return DataTypeEnum:MSSQL_TIMESTAMP
        Of DataTypeEnum:MSSQL_TINYINT
            Return DataTypeEnum:MSSQL_TINYINT
        Of DataTypeEnum:MSSQL_TYPE_DATE
            Return DataTypeEnum:MSSQL_TYPE_DATE
        Of DataTypeEnum:MSSQL_TYPE_TIME
            Return DataTypeEnum:MSSQL_TYPE_TIME
        Of DataTypeEnum:MSSQL_TYPE_TIMESTAMP
            Return DataTypeEnum:MSSQL_TYPE_TIMESTAMP
        Of DataTypeEnum:MSSQL_UNKNOWN
            Return DataTypeEnum:MSSQL_UNKNOWN
        Of DataTypeEnum:MSSQL_VARBINARY
            Return DataTypeEnum:MSSQL_VARBINARY
        Of DataTypeEnum:MSSQL_VARCHAR
            Return DataTypeEnum:MSSQL_VARCHAR
        Of DataTypeEnum:MSSQL_WCHAR
            Return DataTypeEnum:MSSQL_WCHAR
        Of DataTypeEnum:MSSQL_WLONGVARCHAR
            Return DataTypeEnum:MSSQL_WLONGVARCHAR
        Of DataTypeEnum:MSSQL_WVARCHAR
            Return DataTypeEnum:MSSQL_WVARCHAR
        Of DataTypeEnum:SQLC_BIT
            Return DataTypeEnum:SQLC_BIT
        Of DataTypeEnum:SQLC_CHAR
            Return DataTypeEnum:SQLC_CHAR
        Of DataTypeEnum:SQLC_CHAR_ToUtf16
            Return DataTypeEnum:SQLC_CHAR_ToUtf16
        Of DataTypeEnum:SQLC_CHAR_ToUtf8
            Return DataTypeEnum:SQLC_CHAR_ToUtf8
        Of DataTypeEnum:SQLC_LONG
            Return DataTypeEnum:SQLC_LONG
        Of DataTypeEnum:SQLC_SBIGINT_ToDec20
            Return DataTypeEnum:SQLC_SBIGINT_ToDec20
        Of DataTypeEnum:SQLC_SHORT
            Return DataTypeEnum:SQLC_SHORT
        Of DataTypeEnum:SQLC_TINYINT
            Return DataTypeEnum:SQLC_TINYINT
        Of DataTypeEnum:SQLC_UBIGINT_ToDec20
            Return DataTypeEnum:SQLC_UBIGINT_ToDec20
        Of DataTypeEnum:SQLC_ULONG
            Return DataTypeEnum:SQLC_ULONG
        Of DataTypeEnum:SQLC_USHORT
            Return DataTypeEnum:SQLC_USHORT
        Of DataTypeEnum:SQLC_UTINYINT
            Return DataTypeEnum:SQLC_UTINYINT
        END
        Return DataTypeEnum:CLA_STRING

c25_DataReflectionClass.GetDataTypeFromEnum                     Procedure(long _dataTypeEnum)

    CODE

        Case _dataTypeEnum
        Of DataTypeEnum:CLA_BYTE
            Return 'CLA_BYTE'
        Of DataTypeEnum:CLA_SHORT
            Return 'CLA_SHORT'
        Of DataTypeEnum:CLA_USHORT
            Return 'CLA_USHORT'
        Of DataTypeEnum:CLA_DATE
            Return 'CLA_DATE'
        Of DataTypeEnum:CLA_TIME
            Return 'CLA_TIME'
        Of DataTypeEnum:CLA_LONG
            Return 'CLA_LONG'
        Of DataTypeEnum:CLA_ULONG
            Return 'CLA_ULONG'
        Of DataTypeEnum:CLA_SREAL
            Return 'CLA_SREAL'
        Of DataTypeEnum:CLA_REAL
            Return 'CLA_REAL'
        Of DataTypeEnum:CLA_DECIMAL
            Return 'CLA_DECIMAL'
        Of DataTypeEnum:CLA_PDECIMAL
            Return 'CLA_PDECIMAL'
        Of DataTypeEnum:CLA_UNKNOWN12
            Return 'CLA_UNKNOWN12'
        Of DataTypeEnum:CLA_BFLOAT4
            Return 'CLA_BFLOAT4'
        Of DataTypeEnum:CLA_BFLOAT8
            Return 'CLA_BFLOAT8'
        Of DataTypeEnum:CLA_ANY
            Return 'CLA_ANY'
        Of DataTypeEnum:CLA_UNKNOWN16
            Return 'CLA_UNKNOWN16'
        Of DataTypeEnum:CLA_UNKNOWN17
            Return 'CLA_UNKNOWN17'
        Of DataTypeEnum:CLA_STRING
            Return 'CLA_STRING'
        Of DataTypeEnum:CLA_CSTRING
            Return 'CLA_CSTRING'
        Of DataTypeEnum:CLA_PSTRING
            Return 'CLA_PSTRING'
        Of DataTypeEnum:CLA_MEMO
            Return 'CLA_MEMO'
        Of DataTypeEnum:CLA_GROUP
            Return 'CLA_GROUP'
        Of DataTypeEnum:CLA_UNKNOWN23
            Return 'CLA_UNKNOWN23'
        Of DataTypeEnum:CLA_UNKNOWN24
            Return 'CLA_UNKNOWN24'
        Of DataTypeEnum:CLA_UNKNOWN25
            Return 'CLA_UNKNOWN25'
        Of DataTypeEnum:CLA_UNKNOWN26
            Return 'CLA_UNKNOWN26'
        Of DataTypeEnum:CLA_BLOB
            Return 'CLA_BLOB'
        Of DataTypeEnum:CLA_UNKNOWN28
            Return 'CLA_UNKNOWN28'
        Of DataTypeEnum:CLA_UNKNOWN29
            Return 'CLA_UNKNOWN29'
        Of DataTypeEnum:CLA_UNKNOWN30
            Return 'CLA_UNKNOWN30'
        Of DataTypeEnum:CLA_REFERENCE
            Return 'CLA_REFERENCE'
        Of DataTypeEnum:CLA_BSTRING
            Return 'CLA_BSTRING'
        Of DataTypeEnum:CLA_ASTRING
            Return 'CLA_ASTRING'
        Of DataTypeEnum:CLA_KEY
            Return 'CLA_KEY'
        Of DataTypeEnum:CLAEXT_Dec20
            Return 'CLAEXT_Dec20'
        Of DataTypeEnum:CLAEXT_INT64LIKE
            Return 'CLAEXT_INT64LIKE'
        Of DataTypeEnum:CLAEXT_INT64STR8
            Return 'CLAEXT_INT64STR8'
        Of DataTypeEnum:CLAEXT_JSONInstance
            Return 'CLAEXT_JSONInstance'
        Of DataTypeEnum:CLAEXT_QUEUEREF
            Return 'CLAEXT_QUEUEREF'
        Of DataTypeEnum:CLAEXT_STInstance
            Return 'CLAEXT_STInstance'
        Of DataTypeEnum:CLAEXT_STRINGANSI
            Return 'CLAEXT_STRINGANSI'
        Of DataTypeEnum:CLAEXT_STRINGBINARY
            Return 'CLAEXT_STRINGBINARY'
        Of DataTypeEnum:CLAEXT_STRINGJSON
            Return 'CLAEXT_STRINGJSON'
        Of DataTypeEnum:CLAEXT_STRINGREFANSI
            Return 'CLAEXT_STRINGREFANSI'
        Of DataTypeEnum:CLAEXT_STRINGREFBINARY
            Return 'CLAEXT_STRINGREFBINARY'
        Of DataTypeEnum:CLAEXT_STRINGREFUTF16
            Return 'CLAEXT_STRINGREFUTF16'
        Of DataTypeEnum:CLAEXT_STRINGREFUTF32
            Return 'CLAEXT_STRINGREFUTF32'
        Of DataTypeEnum:CLAEXT_STRINGREFUTF8
            Return 'CLAEXT_STRINGREFUTF8'
        Of DataTypeEnum:CLAEXT_STRINGUTF16
            Return 'CLAEXT_STRINGUTF16'
        Of DataTypeEnum:CLAEXT_STRINGUTF32
            Return 'CLAEXT_STRINGUTF32'
        Of DataTypeEnum:CLAEXT_STRINGUTF8
            Return 'CLAEXT_STRINGUTF8'
        Of DataTypeEnum:CLAEXT_UINT64LIKE
            Return 'CLAEXT_UINT64LIKE'
        Of DataTypeEnum:CLAEXT_UINT64STR8
            Return 'CLAEXT_UINT64STR8'
        Of DataTypeEnum:MSSQL_BIGINT
            Return 'MSSQL_BIGINT'
        Of DataTypeEnum:MSSQL_BINARY
            Return 'MSSQL_BINARY'
        Of DataTypeEnum:MSSQL_BIT
            Return 'MSSQL_BIT'
        Of DataTypeEnum:MSSQL_CHAR
            Return 'MSSQL_CHAR'
        Of DataTypeEnum:MSSQL_DATETIME
            Return 'MSSQL_DATETIME'
        Of DataTypeEnum:MSSQL_DECIMAL
            Return 'MSSQL_DECIMAL'
        Of DataTypeEnum:MSSQL_DOUBLE
            Return 'MSSQL_DOUBLE'
        Of DataTypeEnum:MSSQL_FLOAT
            Return 'MSSQL_FLOAT'
        Of DataTypeEnum:MSSQL_GUID
            Return 'MSSQL_GUID'
        Of DataTypeEnum:MSSQL_INTEGER
            Return 'MSSQL_INTEGER'
        Of DataTypeEnum:MSSQL_INTERVAL
            Return 'MSSQL_INTERVAL'
        Of DataTypeEnum:MSSQL_INTERVAL_DAY
            Return 'MSSQL_INTERVAL_DAY'
        Of DataTypeEnum:MSSQL_INTERVAL_DAY_TO_HOUR
            Return 'MSSQL_INTERVAL_DAY_TO_HOUR'
        Of DataTypeEnum:MSSQL_INTERVAL_DAY_TO_MINUTE
            Return 'MSSQL_INTERVAL_DAY_TO_MINUTE'
        Of DataTypeEnum:MSSQL_INTERVAL_DAY_TO_SECOND
            Return 'MSSQL_INTERVAL_DAY_TO_SECOND'
        Of DataTypeEnum:MSSQL_INTERVAL_HOUR
            Return 'MSSQL_INTERVAL_HOUR'
        Of DataTypeEnum:MSSQL_INTERVAL_HOUR_TO_MINUTE
            Return 'MSSQL_INTERVAL_HOUR_TO_MINUTE'
        Of DataTypeEnum:MSSQL_INTERVAL_HOUR_TO_SECOND
            Return 'MSSQL_INTERVAL_HOUR_TO_SECOND'
        Of DataTypeEnum:MSSQL_INTERVAL_MINUTE
            Return 'MSSQL_INTERVAL_MINUTE'
        Of DataTypeEnum:MSSQL_INTERVAL_MINUTE_TO_SECOND
            Return 'MSSQL_INTERVAL_MINUTE_TO_SECOND'
        Of DataTypeEnum:MSSQL_INTERVAL_MONTH
            Return 'MSSQL_INTERVAL_MONTH'
        Of DataTypeEnum:MSSQL_INTERVAL_YEAR
            Return 'MSSQL_INTERVAL_YEAR'
        Of DataTypeEnum:MSSQL_INTERVAL_YEAR_TO_MONTH
            Return 'MSSQL_INTERVAL_YEAR_TO_MONTH'
        Of DataTypeEnum:MSSQL_LONGVARBINARY
            Return 'MSSQL_LONGVARBINARY'
        Of DataTypeEnum:MSSQL_LONGVARCHAR
            Return 'MSSQL_LONGVARCHAR'
        Of DataTypeEnum:MSSQL_NUMERIC
            Return 'MSSQL_NUMERIC'
        Of DataTypeEnum:MSSQL_REAL
            Return 'MSSQL_REAL'
        Of DataTypeEnum:MSSQL_SMALLINT
            Return 'MSSQL_SMALLINT'
        Of DataTypeEnum:MSSQL_TIMESTAMP
            Return 'MSSQL_TIMESTAMP'
        Of DataTypeEnum:MSSQL_TINYINT
            Return 'MSSQL_TINYINT'
        Of DataTypeEnum:MSSQL_TYPE_DATE
            Return 'MSSQL_TYPE_DATE'
        Of DataTypeEnum:MSSQL_TYPE_TIME
            Return 'MSSQL_TYPE_TIME'
        Of DataTypeEnum:MSSQL_TYPE_TIMESTAMP
            Return 'MSSQL_TYPE_TIMESTAMP'
        Of DataTypeEnum:MSSQL_UNKNOWN
            Return 'MSSQL_UNKNOWN'
        Of DataTypeEnum:MSSQL_VARBINARY
            Return 'MSSQL_VARBINARY'
        Of DataTypeEnum:MSSQL_VARCHAR
            Return 'MSSQL_VARCHAR'
        Of DataTypeEnum:MSSQL_WCHAR
            Return 'MSSQL_WCHAR'
        Of DataTypeEnum:MSSQL_WLONGVARCHAR
            Return 'MSSQL_WLONGVARCHAR'
        Of DataTypeEnum:MSSQL_WVARCHAR
            Return 'MSSQL_WVARCHAR'
        Of DataTypeEnum:SQLC_BIT
            Return 'SQLC_BIT'
        Of DataTypeEnum:SQLC_CHAR
            Return 'SQLC_CHAR'
        Of DataTypeEnum:SQLC_CHAR_ToUtf16
            Return 'SQLC_CHAR_ToUtf16'
        Of DataTypeEnum:SQLC_CHAR_ToUtf8
            Return 'SQLC_CHAR_ToUtf8'
        Of DataTypeEnum:SQLC_LONG
            Return 'SQLC_LONG'
        Of DataTypeEnum:SQLC_SBIGINT_ToDec20
            Return 'SQLC_SBIGINT_ToDec20'
        Of DataTypeEnum:SQLC_SHORT
            Return 'SQLC_SHORT'
        Of DataTypeEnum:SQLC_TINYINT
            Return 'SQLC_TINYINT'
        Of DataTypeEnum:SQLC_UBIGINT_ToDec20
            Return 'SQLC_UBIGINT_ToDec20'
        Of DataTypeEnum:SQLC_ULONG
            Return 'SQLC_ULONG'
        Of DataTypeEnum:SQLC_USHORT
            Return 'SQLC_USHORT'
        Of DataTypeEnum:SQLC_UTINYINT
            Return 'SQLC_UTINYINT'
        Of DataTypeEnum:CSHARP_Int1                             
            Return 'CSHARP_Int1'
        Of DataTypeEnum:CSHARP_Int8                             
            Return 'CSHARP_Int8'
        Of DataTypeEnum:CSHARP_UInt8                            
            Return 'CSHARP_UInt8'
        Of DataTypeEnum:CSHARP_Int16                            
            Return 'CSHARP_Int16'
        Of DataTypeEnum:CSHARP_UInt16                           
            Return 'CSHARP_UInt16'
        Of DataTypeEnum:CSHARP_Int32                            
            Return 'CSHARP_Int32'
        Of DataTypeEnum:CSHARP_UInt32                           
            Return 'CSHARP_UInt32'
        Of DataTypeEnum:CSHARP_Int64                            
            Return 'CSHARP_Int64'
        Of DataTypeEnum:CSHARP_UInt64                           
            Return 'CSHARP_UInt64'
        Of DataTypeEnum:CSHARP_Numeric                          
            Return 'CSHARP_Numeric'
        Of DataTypeEnum:SQLITE_INT                              
            Return 'SQLITE_INT'
        Of DataTypeEnum:SQLITE_INTEGER                          
            Return 'SQLITE_INTEGER'
        Of DataTypeEnum:SQLITE_TINYINT                          
            Return 'SQLITE_TINYINT'
        Of DataTypeEnum:SQLITE_SMALLINT                         
            Return 'SQLITE_SMALLINT'
        Of DataTypeEnum:SQLITE_MEDIUMINT                        
            Return 'SQLITE_MEDIUMINT'
        Of DataTypeEnum:SQLITE_BIGINT                           
            Return 'SQLITE_BIGINT'
        Of DataTypeEnum:SQLITE_UNSIGNED_BIG_INT                 
            Return 'SQLITE_UNSIGNED_BIG_INT'
        Of DataTypeEnum:SQLITE_INT2                             
            Return 'SQLITE_INT2'
        Of DataTypeEnum:SQLITE_INT8                             
            Return 'SQLITE_INT8'
        Of DataTypeEnum:SQLITE_CHARACTER                        
            Return 'SQLITE_CHARACTER'
        Of DataTypeEnum:SQLITE_VARCHAR                          
            Return 'SQLITE_VARCHAR'
        Of DataTypeEnum:SQLITE_VARYING_CHARACTER                
            Return 'SQLITE_VARYING_CHARACTER'
        Of DataTypeEnum:SQLITE_NCHAR                            
            Return 'SQLITE_NCHAR'
        Of DataTypeEnum:SQLITE_NATIVE_CHARACTER                 
            Return 'SQLITE_NATIVE_CHARACTER'
        Of DataTypeEnum:SQLITE_NVARCHAR                         
            Return 'SQLITE_NVARCHAR'
        Of DataTypeEnum:SQLITE_TEXT                             
            Return 'SQLITE_TEXT'
        Of DataTypeEnum:SQLITE_CLOB                             
            Return 'SQLITE_CLOB'
        Of DataTypeEnum:SQLITE_BLOB                             
            Return 'SQLITE_BLOB'
        Of DataTypeEnum:SQLITE_REAL                             
            Return 'SQLITE_REAL'
        Of DataTypeEnum:SQLITE_DOUBLE                           
            Return 'SQLITE_DOUBLE'
        Of DataTypeEnum:SQLITE_DOUBLE_PRECISION                 
            Return 'SQLITE_DOUBLE_PRECISION'
        Of DataTypeEnum:SQLITE_FLOAT                            
            Return 'SQLITE_FLOAT'
        Of DataTypeEnum:SQLITE_NUMERIC                          
            Return 'SQLITE_NUMERIC'
        Of DataTypeEnum:SQLITE_DECIMAL                          
            Return 'SQLITE_DECIMAL'
        Of DataTypeEnum:SQLITE_BOOLEAN                          
            Return 'SQLITE_BOOLEAN'
        Of DataTypeEnum:SQLITE_DATE                             
            Return 'SQLITE_DATE'
        Of DataTypeEnum:SQLITE_DATETIME                         
            Return 'SQLITE_DATETIME'            
            
            
        Of DataTypeEnum:UNKNOWN
            Return 'UNKNOWN'
        END
        Return ''

c25_DataReflectionClass.GetDataTypeEnum                         Procedure(string _dataTypeString)

CODE
        
    Case Upper(Clip(_dataTypeString))
    Of 'CLA_BYTE'
        Return DataTypeEnum:CLA_BYTE
    Of 'CLA_SHORT'
        Return DataTypeEnum:CLA_SHORT
    Of 'CLA_USHORT'
        Return DataTypeEnum:CLA_USHORT
    Of 'CLA_DATE'
        Return DataTypeEnum:CLA_DATE
    Of 'CLA_TIME'
        Return DataTypeEnum:CLA_TIME
    Of 'CLA_LONG'
        Return DataTypeEnum:CLA_LONG
    Of 'CLA_ULONG'
        Return DataTypeEnum:CLA_ULONG
    Of 'CLA_SREAL'
        Return DataTypeEnum:CLA_SREAL
    Of 'CLA_REAL'
        Return DataTypeEnum:CLA_REAL
    Of 'CLA_DECIMAL'
        Return DataTypeEnum:CLA_DECIMAL
    Of 'CLA_PDECIMAL'
        Return DataTypeEnum:CLA_PDECIMAL
    Of 'CLA_UNKNOWN12'
        Return DataTypeEnum:CLA_UNKNOWN12
    Of 'CLA_BFLOAT4'
        Return DataTypeEnum:CLA_BFLOAT4
    Of 'CLA_BFLOAT8'
        Return DataTypeEnum:CLA_BFLOAT8
    Of 'CLA_ANY'
        Return DataTypeEnum:CLA_ANY
    Of 'CLA_UNKNOWN16'
        Return DataTypeEnum:CLA_UNKNOWN16
    Of 'CLA_UNKNOWN17'
        Return DataTypeEnum:CLA_UNKNOWN17
    Of 'CLA_STRING'
        Return DataTypeEnum:CLA_STRING
    Of 'CLA_CSTRING'
        Return DataTypeEnum:CLA_CSTRING
    Of 'CLA_PSTRING'
        Return DataTypeEnum:CLA_PSTRING
    Of 'CLA_MEMO'
        Return DataTypeEnum:CLA_MEMO
    Of 'CLA_GROUP'
        Return DataTypeEnum:CLA_GROUP
    Of 'CLA_UNKNOWN23'
        Return DataTypeEnum:CLA_UNKNOWN23
    Of 'CLA_UNKNOWN24'
        Return DataTypeEnum:CLA_UNKNOWN24
    Of 'CLA_UNKNOWN25'
        Return DataTypeEnum:CLA_UNKNOWN25
    Of 'CLA_UNKNOWN26'
        Return DataTypeEnum:CLA_UNKNOWN26
    Of 'CLA_BLOB'
        Return DataTypeEnum:CLA_BLOB
    Of 'CLA_UNKNOWN28'
        Return DataTypeEnum:CLA_UNKNOWN28
    Of 'CLA_UNKNOWN29'
        Return DataTypeEnum:CLA_UNKNOWN29
    Of 'CLA_UNKNOWN30'
        Return DataTypeEnum:CLA_UNKNOWN30
    Of 'CLA_REFERENCE'
        Return DataTypeEnum:CLA_REFERENCE
    Of 'CLA_BSTRING'
        Return DataTypeEnum:CLA_BSTRING
    Of 'CLA_ASTRING'
        Return DataTypeEnum:CLA_ASTRING
    Of 'CLA_KEY'
        Return DataTypeEnum:CLA_KEY
    Of 'CLAEXT_Dec20'
        Return DataTypeEnum:CLAEXT_Dec20
    Of 'CLAEXT_INT64LIKE'
        Return DataTypeEnum:CLAEXT_INT64LIKE
    Of 'CLAEXT_INT64STR8'
        Return DataTypeEnum:CLAEXT_INT64STR8
    Of 'CLAEXT_JSONInstance'
        Return DataTypeEnum:CLAEXT_JSONInstance
    Of 'CLAEXT_QUEUEREF'
        Return DataTypeEnum:CLAEXT_QUEUEREF
    Of 'CLAEXT_STInstance'
        Return DataTypeEnum:CLAEXT_STInstance
    Of 'CLAEXT_STRINGANSI'
        Return DataTypeEnum:CLAEXT_STRINGANSI
    Of 'CLAEXT_STRINGBINARY'
        Return DataTypeEnum:CLAEXT_STRINGBINARY
    Of 'CLAEXT_STRINGJSON'
        Return DataTypeEnum:CLAEXT_STRINGJSON
    Of 'CLAEXT_STRINGREFANSI'
        Return DataTypeEnum:CLAEXT_STRINGREFANSI
    Of 'CLAEXT_STRINGREFBINARY'
        Return DataTypeEnum:CLAEXT_STRINGREFBINARY
    Of 'CLAEXT_STRINGREFUTF16'
        Return DataTypeEnum:CLAEXT_STRINGREFUTF16
    Of 'CLAEXT_STRINGREFUTF32'
        Return DataTypeEnum:CLAEXT_STRINGREFUTF32
    Of 'CLAEXT_STRINGREFUTF8'
        Return DataTypeEnum:CLAEXT_STRINGREFUTF8
    Of 'CLAEXT_STRINGUTF16'
        Return DataTypeEnum:CLAEXT_STRINGUTF16
    Of 'CLAEXT_STRINGUTF32'
        Return DataTypeEnum:CLAEXT_STRINGUTF32
    Of 'CLAEXT_STRINGUTF8'
        Return DataTypeEnum:CLAEXT_STRINGUTF8
    Of 'CLAEXT_UINT64LIKE'
        Return DataTypeEnum:CLAEXT_UINT64LIKE
    Of 'CLAEXT_UINT64STR8'
        Return DataTypeEnum:CLAEXT_UINT64STR8
    Of 'MSSQL_BIGINT'
        Return DataTypeEnum:MSSQL_BIGINT
    Of 'MSSQL_BINARY'
        Return DataTypeEnum:MSSQL_BINARY
    Of 'MSSQL_BIT'
        Return DataTypeEnum:MSSQL_BIT
    Of 'MSSQL_CHAR'
        Return DataTypeEnum:MSSQL_CHAR
    Of 'MSSQL_DATETIME'
        Return DataTypeEnum:MSSQL_DATETIME
    Of 'MSSQL_DECIMAL'
        Return DataTypeEnum:MSSQL_DECIMAL
    Of 'MSSQL_DOUBLE'
        Return DataTypeEnum:MSSQL_DOUBLE
    Of 'MSSQL_FLOAT'
        Return DataTypeEnum:MSSQL_FLOAT
    Of 'MSSQL_GUID'
        Return DataTypeEnum:MSSQL_GUID
    Of 'MSSQL_INTEGER'
        Return DataTypeEnum:MSSQL_INTEGER
    Of 'MSSQL_INTERVAL'
        Return DataTypeEnum:MSSQL_INTERVAL
    Of 'MSSQL_INTERVAL_DAY'
        Return DataTypeEnum:MSSQL_INTERVAL_DAY
    Of 'MSSQL_INTERVAL_DAY_TO_HOUR'
        Return DataTypeEnum:MSSQL_INTERVAL_DAY_TO_HOUR
    Of 'MSSQL_INTERVAL_DAY_TO_MINUTE'
        Return DataTypeEnum:MSSQL_INTERVAL_DAY_TO_MINUTE
    Of 'MSSQL_INTERVAL_DAY_TO_SECOND'
        Return DataTypeEnum:MSSQL_INTERVAL_DAY_TO_SECOND
    Of 'MSSQL_INTERVAL_HOUR'
        Return DataTypeEnum:MSSQL_INTERVAL_HOUR
    Of 'MSSQL_INTERVAL_HOUR_TO_MINUTE'
        Return DataTypeEnum:MSSQL_INTERVAL_HOUR_TO_MINUTE
    Of 'MSSQL_INTERVAL_HOUR_TO_SECOND'
        Return DataTypeEnum:MSSQL_INTERVAL_HOUR_TO_SECOND
    Of 'MSSQL_INTERVAL_MINUTE'
        Return DataTypeEnum:MSSQL_INTERVAL_MINUTE
    Of 'MSSQL_INTERVAL_MINUTE_TO_SECOND'
        Return DataTypeEnum:MSSQL_INTERVAL_MINUTE_TO_SECOND
    Of 'MSSQL_INTERVAL_MONTH'
        Return DataTypeEnum:MSSQL_INTERVAL_MONTH
    Of 'MSSQL_INTERVAL_SECOND'
        Return DataTypeEnum:MSSQL_INTERVAL_SECOND
    Of 'MSSQL_INTERVAL_YEAR'
        Return DataTypeEnum:MSSQL_INTERVAL_YEAR
    Of 'MSSQL_INTERVAL_YEAR_TO_MONTH'
        Return DataTypeEnum:MSSQL_INTERVAL_YEAR_TO_MONTH
    Of 'MSSQL_LONGVARBINARY'
        Return DataTypeEnum:MSSQL_LONGVARBINARY
    Of 'MSSQL_LONGVARCHAR'
        Return DataTypeEnum:MSSQL_LONGVARCHAR
    Of 'MSSQL_NUMERIC'
        Return DataTypeEnum:MSSQL_NUMERIC
    Of 'MSSQL_REAL'
        Return DataTypeEnum:MSSQL_REAL
    Of 'MSSQL_SMALLINT'
        Return DataTypeEnum:MSSQL_SMALLINT
    Of 'MSSQL_TIMESTAMP'
        Return DataTypeEnum:MSSQL_TIMESTAMP
    Of 'MSSQL_TINYINT'
        Return DataTypeEnum:MSSQL_TINYINT
    Of 'MSSQL_TYPE_DATE'
        Return DataTypeEnum:MSSQL_TYPE_DATE
    Of 'MSSQL_TYPE_TIME'
        Return DataTypeEnum:MSSQL_TYPE_TIME
    Of 'MSSQL_TYPE_TIMESTAMP'
        Return DataTypeEnum:MSSQL_TYPE_TIMESTAMP
    Of 'MSSQL_UNKNOWN'
        Return DataTypeEnum:MSSQL_UNKNOWN
    Of 'MSSQL_VARBINARY'
        Return DataTypeEnum:MSSQL_VARBINARY
    Of 'MSSQL_VARCHAR'
        Return DataTypeEnum:MSSQL_VARCHAR
    Of 'MSSQL_WCHAR'
        Return DataTypeEnum:MSSQL_WCHAR
    Of 'MSSQL_WLONGVARCHAR'
        Return DataTypeEnum:MSSQL_WLONGVARCHAR
    Of 'MSSQL_WVARCHAR'
        Return DataTypeEnum:MSSQL_WVARCHAR
    Of 'SQLC_BIT'
        Return DataTypeEnum:SQLC_BIT
    Of 'SQLC_CHAR'
        Return DataTypeEnum:SQLC_CHAR
    Of 'SQLC_CHAR_TOUTF16'
        Return DataTypeEnum:SQLC_CHAR_TOUTF16
    Of 'SQLC_CHAR_TOUTF8'
        Return DataTypeEnum:SQLC_CHAR_TOUTF8
    Of 'SQLC_LONG'
        Return DataTypeEnum:SQLC_LONG
    Of 'SQLC_SBIGINT_TODEC20'
        Return DataTypeEnum:SQLC_SBIGINT_TODEC20
    Of 'SQLC_SHORT'
        Return DataTypeEnum:SQLC_SHORT
    Of 'SQLC_TINYINT'
        Return DataTypeEnum:SQLC_TINYINT
    Of 'SQLC_UBIGINT_TODEC20'
        Return DataTypeEnum:SQLC_UBIGINT_TODEC20
    Of 'SQLC_ULONG'
        Return DataTypeEnum:SQLC_ULONG
    Of 'SQLC_USHORT'
        Return DataTypeEnum:SQLC_USHORT
    Of 'SQLC_UTINYINT'
        Return DataTypeEnum:SQLC_UTINYINT
    Of 'CSHARP_INT1'
        Return DataTypeEnum:CSHARP_INT1
    Of 'CSHARP_INT8'
        Return DataTypeEnum:CSHARP_INT8
    Of 'CSHARP_UINT8'
        Return DataTypeEnum:CSHARP_UINT8
    Of 'CSHARP_INT16'
        Return DataTypeEnum:CSHARP_INT16
    Of 'CSHARP_UINT16'
        Return DataTypeEnum:CSHARP_UINT16
    Of 'CSHARP_INT32'
        Return DataTypeEnum:CSHARP_INT32
    Of 'CSHARP_UINT32'
        Return DataTypeEnum:CSHARP_UINT32
    Of 'CSHARP_INT64'
        Return DataTypeEnum:CSHARP_INT64
    Of 'CSHARP_UINT64'
        Return DataTypeEnum:CSHARP_UINT64
    Of 'CSHARP_NUMERIC'
        Return DataTypeEnum:CSHARP_NUMERIC
    Of 'SQLITE_INT'
        Return DataTypeEnum:SQLITE_INT
    Of 'SQLITE_INTEGER'
        Return DataTypeEnum:SQLITE_INTEGER
    Of 'SQLITE_TINYINT'
        Return DataTypeEnum:SQLITE_TINYINT
    Of 'SQLITE_SMALLINT'
        Return DataTypeEnum:SQLITE_SMALLINT
    Of 'SQLITE_MEDIUMINT'
        Return DataTypeEnum:SQLITE_MEDIUMINT
    Of 'SQLITE_BIGINT'
        Return DataTypeEnum:SQLITE_BIGINT
    Of 'SQLITE_UNSIGNED_BIG_INT'
        Return DataTypeEnum:SQLITE_UNSIGNED_BIG_INT
    Of 'SQLITE_INT2'
        Return DataTypeEnum:SQLITE_INT2
    Of 'SQLITE_INT8'
        Return DataTypeEnum:SQLITE_INT8
    Of 'SQLITE_CHARACTER'
        Return DataTypeEnum:SQLITE_CHARACTER
    Of 'SQLITE_VARCHAR'
        Return DataTypeEnum:SQLITE_VARCHAR
    Of 'SQLITE_VARYING_CHARACTER'
        Return DataTypeEnum:SQLITE_VARYING_CHARACTER
    Of 'SQLITE_NCHAR'
        Return DataTypeEnum:SQLITE_NCHAR
    Of 'SQLITE_NATIVE_CHARACTER'
        Return DataTypeEnum:SQLITE_NATIVE_CHARACTER
    Of 'SQLITE_NVARCHAR'
        Return DataTypeEnum:SQLITE_NVARCHAR
    Of 'SQLITE_TEXT'
        Return DataTypeEnum:SQLITE_TEXT
    Of 'SQLITE_CLOB'
        Return DataTypeEnum:SQLITE_CLOB
    Of 'SQLITE_BLOB'
        Return DataTypeEnum:SQLITE_BLOB
    Of 'SQLITE_REAL'
        Return DataTypeEnum:SQLITE_REAL
    Of 'SQLITE_DOUBLE'
        Return DataTypeEnum:SQLITE_DOUBLE
    Of 'SQLITE_DOUBLE_PRECISION'
        Return DataTypeEnum:SQLITE_DOUBLE_PRECISION
    Of 'SQLITE_FLOAT'
        Return DataTypeEnum:SQLITE_FLOAT
    Of 'SQLITE_NUMERIC'
        Return DataTypeEnum:SQLITE_NUMERIC
    Of 'SQLITE_DECIMAL'
        Return DataTypeEnum:SQLITE_DECIMAL
    Of 'SQLITE_BOOLEAN'
        Return DataTypeEnum:SQLITE_BOOLEAN
    Of 'SQLITE_DATE'
        Return DataTypeEnum:SQLITE_DATE
    Of 'SQLITE_DATETIME'
        Return DataTypeEnum:SQLITE_DATETIME
    Of 'UNKNOWN'
        Return DataTypeEnum:UNKNOWN
    End
    Return DataTypeEnum:UNKNOWN
        
c25_DataReflectionClass.GetDataTypeEngineEnumFromDataTypeEnum                            Procedure(long _dataTypeEnum)

    CODE

        Case _dataTypeEnum
        Of DataTypeEnum:CLA_BYTE
        OrOf DataTypeEnum:CLA_SHORT
        OrOf DataTypeEnum:CLA_USHORT
        OrOf DataTypeEnum:CLA_DATE
        OrOf DataTypeEnum:CLA_TIME
        OrOf DataTypeEnum:CLA_LONG
        OrOf DataTypeEnum:CLA_ULONG
        OrOf DataTypeEnum:CLA_SREAL
        OrOf DataTypeEnum:CLA_REAL
        OrOf DataTypeEnum:CLA_DECIMAL
        OrOf DataTypeEnum:CLA_PDECIMAL
        OrOf DataTypeEnum:CLA_UNKNOWN12
        OrOf DataTypeEnum:CLA_BFLOAT4
        OrOf DataTypeEnum:CLA_BFLOAT8
        OrOf DataTypeEnum:CLA_ANY
        OrOf DataTypeEnum:CLA_UNKNOWN16
        OrOf DataTypeEnum:CLA_UNKNOWN17
        OrOf DataTypeEnum:CLA_STRING
        OrOf DataTypeEnum:CLA_CSTRING
        OrOf DataTypeEnum:CLA_PSTRING
        OrOf DataTypeEnum:CLA_MEMO
        OrOf DataTypeEnum:CLA_GROUP
        OrOf DataTypeEnum:CLA_UNKNOWN23
        OrOf DataTypeEnum:CLA_UNKNOWN24
        OrOf DataTypeEnum:CLA_UNKNOWN25
        OrOf DataTypeEnum:CLA_UNKNOWN26
        OrOf DataTypeEnum:CLA_BLOB
        OrOf DataTypeEnum:CLA_UNKNOWN28
        OrOf DataTypeEnum:CLA_UNKNOWN29
        OrOf DataTypeEnum:CLA_UNKNOWN30
        OrOf DataTypeEnum:CLA_REFERENCE
        OrOf DataTypeEnum:CLA_BSTRING
        OrOf DataTypeEnum:CLA_ASTRING
        OrOf DataTypeEnum:CLA_KEY
            Return DataTypeEnginesEnum:Clarion
        Of DataTypeEnum:CLAEXT_Dec20
        OrOf DataTypeEnum:CLAEXT_INT64LIKE
        OrOf DataTypeEnum:CLAEXT_INT64STR8
        OrOf DataTypeEnum:CLAEXT_JSONInstance
        OrOf DataTypeEnum:CLAEXT_QUEUEREF
        OrOf DataTypeEnum:CLAEXT_STInstance
        OrOf DataTypeEnum:CLAEXT_STRINGANSI
        OrOf DataTypeEnum:CLAEXT_STRINGBINARY
        OrOf DataTypeEnum:CLAEXT_STRINGJSON
        OrOf DataTypeEnum:CLAEXT_STRINGREFANSI
        OrOf DataTypeEnum:CLAEXT_STRINGREFBINARY
        OrOf DataTypeEnum:CLAEXT_STRINGREFUTF16
        OrOf DataTypeEnum:CLAEXT_STRINGREFUTF32
        OrOf DataTypeEnum:CLAEXT_STRINGREFUTF8
        OrOf DataTypeEnum:CLAEXT_STRINGUTF16
        OrOf DataTypeEnum:CLAEXT_STRINGUTF32
        OrOf DataTypeEnum:CLAEXT_STRINGUTF8
        OrOf DataTypeEnum:CLAEXT_UINT64LIKE
        OrOf DataTypeEnum:CLAEXT_UINT64STR8
            Return DataTypeEnginesEnum:ClarionExtended
        Of DataTypeEnum:MSSQL_BIGINT
        OrOf DataTypeEnum:MSSQL_BINARY
        OrOf DataTypeEnum:MSSQL_BIT
        OrOf DataTypeEnum:MSSQL_CHAR
        OrOf DataTypeEnum:MSSQL_DATETIME
        OrOf DataTypeEnum:MSSQL_DECIMAL
        OrOf DataTypeEnum:MSSQL_DOUBLE
        OrOf DataTypeEnum:MSSQL_FLOAT
        OrOf DataTypeEnum:MSSQL_GUID
        OrOf DataTypeEnum:MSSQL_INTEGER
        OrOf DataTypeEnum:MSSQL_INTERVAL
        OrOf DataTypeEnum:MSSQL_INTERVAL_DAY
        OrOf DataTypeEnum:MSSQL_INTERVAL_DAY_TO_HOUR
        OrOf DataTypeEnum:MSSQL_INTERVAL_DAY_TO_MINUTE
        OrOf DataTypeEnum:MSSQL_INTERVAL_DAY_TO_SECOND
        OrOf DataTypeEnum:MSSQL_INTERVAL_HOUR
        OrOf DataTypeEnum:MSSQL_INTERVAL_HOUR_TO_MINUTE
        OrOf DataTypeEnum:MSSQL_INTERVAL_HOUR_TO_SECOND
        OrOf DataTypeEnum:MSSQL_INTERVAL_MINUTE
        OrOf DataTypeEnum:MSSQL_INTERVAL_MINUTE_TO_SECOND
        OrOf DataTypeEnum:MSSQL_INTERVAL_MONTH
        OrOf DataTypeEnum:MSSQL_INTERVAL_SECOND
        OrOf DataTypeEnum:MSSQL_INTERVAL_YEAR
        OrOf DataTypeEnum:MSSQL_INTERVAL_YEAR_TO_MONTH
        OrOf DataTypeEnum:MSSQL_LONGVARBINARY
        OrOf DataTypeEnum:MSSQL_LONGVARCHAR
        OrOf DataTypeEnum:MSSQL_NUMERIC
        OrOf DataTypeEnum:MSSQL_REAL
        OrOf DataTypeEnum:MSSQL_SMALLINT
        OrOf DataTypeEnum:MSSQL_TIMESTAMP
        OrOf DataTypeEnum:MSSQL_TINYINT
        OrOf DataTypeEnum:MSSQL_TYPE_DATE
        OrOf DataTypeEnum:MSSQL_TYPE_TIME
        OrOf DataTypeEnum:MSSQL_TYPE_TIMESTAMP
        OrOf DataTypeEnum:MSSQL_UNKNOWN
        OrOf DataTypeEnum:MSSQL_VARBINARY
        OrOf DataTypeEnum:MSSQL_VARCHAR
        OrOf DataTypeEnum:MSSQL_WCHAR
        OrOf DataTypeEnum:MSSQL_WLONGVARCHAR
        OrOf DataTypeEnum:MSSQL_WVARCHAR
            Return DataTypeEnginesEnum:MSSQL
        Of DataTypeEnum:SQLC_BIT
        OrOf DataTypeEnum:SQLC_CHAR
        OrOf DataTypeEnum:SQLC_CHAR_ToUtf16
        OrOf DataTypeEnum:SQLC_CHAR_ToUtf8
        OrOf DataTypeEnum:SQLC_LONG
        OrOf DataTypeEnum:SQLC_SBIGINT_ToDec20
        OrOf DataTypeEnum:SQLC_SHORT
        OrOf DataTypeEnum:SQLC_TINYINT
        OrOf DataTypeEnum:SQLC_UBIGINT_ToDec20
        OrOf DataTypeEnum:SQLC_ULONG
        OrOf DataTypeEnum:SQLC_USHORT
        OrOf DataTypeEnum:SQLC_UTINYINT
            Return DataTypeEnginesEnum:SQLC
        Of DataTypeEnum:CSHARP_Int1                             
        OrOf DataTypeEnum:CSHARP_Int8                             
        OrOf DataTypeEnum:CSHARP_UInt8                            
        OrOf DataTypeEnum:CSHARP_Int16                            
        OrOf DataTypeEnum:CSHARP_UInt16                           
        OrOf DataTypeEnum:CSHARP_Int32                            
        OrOf DataTypeEnum:CSHARP_UInt32                           
        OrOf DataTypeEnum:CSHARP_Int64                            
        OrOf DataTypeEnum:CSHARP_UInt64                           
        OrOf DataTypeEnum:CSHARP_Numeric   
            Return DataTypeEnginesEnum:CSHARP
        Of DataTypeEnum:SQLITE_INT                              
        OrOf DataTypeEnum:SQLITE_INTEGER                          
        OrOf DataTypeEnum:SQLITE_TINYINT                          
        OrOf DataTypeEnum:SQLITE_SMALLINT                         
        OrOf DataTypeEnum:SQLITE_MEDIUMINT                        
        OrOf DataTypeEnum:SQLITE_BIGINT                           
        OrOf DataTypeEnum:SQLITE_UNSIGNED_BIG_INT                 
        OrOf DataTypeEnum:SQLITE_INT2                             
        OrOf DataTypeEnum:SQLITE_INT8                             
        OrOf DataTypeEnum:SQLITE_CHARACTER                        
        OrOf DataTypeEnum:SQLITE_VARCHAR                          
        OrOf DataTypeEnum:SQLITE_VARYING_CHARACTER                
        OrOf DataTypeEnum:SQLITE_NCHAR                            
        OrOf DataTypeEnum:SQLITE_NATIVE_CHARACTER                 
        OrOf DataTypeEnum:SQLITE_NVARCHAR                         
        OrOf DataTypeEnum:SQLITE_TEXT                             
        OrOf DataTypeEnum:SQLITE_CLOB                             
        OrOf DataTypeEnum:SQLITE_BLOB                             
        OrOf DataTypeEnum:SQLITE_REAL                             
        OrOf DataTypeEnum:SQLITE_DOUBLE                           
        OrOf DataTypeEnum:SQLITE_DOUBLE_PRECISION                 
        OrOf DataTypeEnum:SQLITE_FLOAT                            
        OrOf DataTypeEnum:SQLITE_NUMERIC                          
        OrOf DataTypeEnum:SQLITE_DECIMAL                          
        OrOf DataTypeEnum:SQLITE_BOOLEAN                          
        OrOf DataTypeEnum:SQLITE_DATE                             
        OrOf DataTypeEnum:SQLITE_DATETIME  
            Return DataTypeEnginesEnum:Sqlite
        Of DataTypeEnum:UNKNOWN         
            Return DataTypeEnginesEnum:Unknown
        End

        Return 0
        
c25_DataReflectionClass.GetPresetString     Procedure(long _segments, long _characters, long _dataTypeEnum)

InHex   string(32)
HexLen  LONG

CODE
    
    InHex = Self.BitConverter.Int32ToHex(_characters, True)
    HexLen = Len(Clip(InHex))

    Case HexLen
    Of 1
        Return Chr(_dataTypeEnum) & Chr(_segments) & Chr(Self.BitConverter.FastByteFromHex2('0' & InHex[1]))
    Of 2
        Case InHex[1]
        Of '0'
        OrOf '1'
            Return Chr(_dataTypeEnum) & Chr(_segments) & Chr(Self.BitConverter.FastByteFromHex2(InHex[1:2]))
        Else
            Return Chr(_dataTypeEnum) & Chr(_segments) & Chr(020h) & Chr(Self.BitConverter.FastByteFromHex2(InHex[1:2]))
        End
    Of 3
        Return Chr(_dataTypeEnum) & Chr(_segments) & Chr(Self.BitConverter.FastByteFromHex2('2' & InHex[1])) & |
            Chr(Self.BitConverter.FastByteFromHex2(InHex[2 : 3]))
    Of 4
        Case InHex[1]
        Of '1'
            Return Chr(_dataTypeEnum) & Chr(_segments) & Chr(Self.BitConverter.FastByteFromHex2('3' & InHex[2])) & |
                Chr(Self.BitConverter.FastByteFromHex2(InHex[3 : 4]))
        Else
            Return Chr(_dataTypeEnum) & Chr(_segments) & Chr(Self.BitConverter.FastByteFromHex2('40')) & |
                Chr(Self.BitConverter.FastByteFromHex2(InHex[1:2])) & Chr(Self.BitConverter.FastByteFromHex2(InHex[3 : 4]))
        End
    Of 5
        Return Chr(_dataTypeEnum) & Chr(_segments) & Chr(Self.BitConverter.FastByteFromHex2('4' & InHex[1])) & |
            Chr(Self.BitConverter.FastByteFromHex2(InHex[2 : 3])) & Chr(Self.BitConverter.FastByteFromHex2(InHex[4 : 5]))
    Of 6
        Case InHex[1]
        Of '1'
            Return Chr(_dataTypeEnum) & Chr(_segments) & Chr(Self.BitConverter.FastByteFromHex2('5' & InHex[2])) & |
                Chr(Self.BitConverter.FastByteFromHex2(InHex[3 : 4])) & Chr(Self.BitConverter.FastByteFromHex2(InHex[5 : 6]))
        Else
            Return Chr(_dataTypeEnum) & Chr(_segments) & Chr(Self.BitConverter.FastByteFromHex2('60')) &  |
                Chr(Self.BitConverter.FastByteFromHex2(InHex[1:2])) & Chr(Self.BitConverter.FastByteFromHex2(InHex[3 : 4])) & |
                Chr(Self.BitConverter.FastByteFromHex2(InHex[5 : 6]))
        End
    ELSE
        Message('ERROR: HexLen : ' & HexLen & ', ' & InHex & ', ' & _characters)
    End
    Return ''



c25_DataReflectionClass.DataTypeEnumToDllSetInfo                Procedure(long _segments, long _dataTypeEnum, <long _characters>, <long _places>)

InHex   string(32)
HexLen  LONG

ShortVal                                                            Short
ShortValOver string(2),over(ShortVal)
    CODE

        Case _dataTypeEnum
        Of DataTypeEnum:CLA_BYTE
            Return Chr(DataTypeEnum:CLA_BYTE) & Chr(_segments)
        Of DataTypeEnum:CLA_SHORT
            Return Chr(DataTypeEnum:CLA_SHORT) & Chr(_segments)
        Of DataTypeEnum:CLA_USHORT
            Return Chr(DataTypeEnum:CLA_USHORT) & Chr(_segments)
        Of DataTypeEnum:CLA_DATE
            Return 4
        Of DataTypeEnum:CLA_TIME
            Return 4
        Of DataTypeEnum:CLA_LONG
            Return Chr(DataTypeEnum:CLA_LONG) & Chr(_segments)
        Of DataTypeEnum:CLA_ULONG
            Return Chr(DataTypeEnum:CLA_ULONG) & Chr(_segments)
        Of DataTypeEnum:CLA_SREAL
            Return Chr(DataTypeEnum:CLA_SREAL) & Chr(_segments)
        Of DataTypeEnum:CLA_REAL
            Return Chr(DataTypeEnum:CLA_REAL) & Chr(_segments)
        Of DataTypeEnum:CLA_DECIMAL
		    If not (_characters%2) ! isEven
               ShortVal = (_characters+2) / 2
            Else
                ShortVal = (_characters+1) / 2
            End            
            Return Chr(DataTypeEnum:CLA_DECIMAL) & Chr(_segments) & ShortValOver
        Of DataTypeEnum:CLA_PDECIMAL
            D# = (_characters / 2) + 1 ! TODO
            Return D#
        Of DataTypeEnum:CLA_UNKNOWN12
            Return 0
        Of DataTypeEnum:CLA_BFLOAT4
            Return 4
        Of DataTypeEnum:CLA_BFLOAT8
            Return 8
        Of DataTypeEnum:CLA_ANY
            Return 8
        Of DataTypeEnum:CLA_UNKNOWN16
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN17
            Return 0
        Of DataTypeEnum:CLA_STRING
            Return Self.GetPresetString(_segments, _characters, _dataTypeEnum)
        Of DataTypeEnum:CLA_CSTRING
            Return Self.GetPresetString(_segments, _characters+1, _dataTypeEnum)
        Of DataTypeEnum:CLA_PSTRING
            Return _characters ! TODO
        Of DataTypeEnum:CLA_MEMO
            Return _characters
        Of DataTypeEnum:CLA_GROUP
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN23
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN24
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN25
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN26
            Return 0
        Of DataTypeEnum:CLA_BLOB
            Return _characters
        Of DataTypeEnum:CLA_UNKNOWN28
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN29
            Return 0
        Of DataTypeEnum:CLA_UNKNOWN30
            Return 0
        Of DataTypeEnum:CLA_REFERENCE
            Return 8
        Of DataTypeEnum:CLA_BSTRING
            Return 8 ! todo
        Of DataTypeEnum:CLA_ASTRING
            Return _characters ! todo
        Of DataTypeEnum:CLA_KEY
            Return 0
        Of DataTypeEnum:CLAEXT_Dec20
            Return 11
        Of DataTypeEnum:CLAEXT_INT64LIKE
            Return 8
        Of DataTypeEnum:CLAEXT_INT64STR8
            Return 8
        Of DataTypeEnum:CLAEXT_JSONInstance
            Return 8
        Of DataTypeEnum:CLAEXT_QUEUEREF
            Return 8
        Of DataTypeEnum:CLAEXT_STInstance
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGANSI
            Return _characters
        Of DataTypeEnum:CLAEXT_STRINGBINARY
            Return _characters
        Of DataTypeEnum:CLAEXT_STRINGJSON
            Return _characters
        Of DataTypeEnum:CLAEXT_STRINGREFANSI
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGREFBINARY
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGREFUTF16
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGREFUTF32
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGREFUTF8
            Return 8
        Of DataTypeEnum:CLAEXT_STRINGUTF16
            Return _characters
        Of DataTypeEnum:CLAEXT_STRINGUTF32
            Return _characters
        Of DataTypeEnum:CLAEXT_STRINGUTF8
            Return _characters
        Of DataTypeEnum:CLAEXT_UINT64LIKE
            Return 8
        Of DataTypeEnum:CLAEXT_UINT64STR8
            Return 8
        Of DataTypeEnum:MSSQL_BIGINT
            Return 8
        Of DataTypeEnum:MSSQL_BINARY
            Return _characters
        Of DataTypeEnum:MSSQL_BIT
            Return 1
        Of DataTypeEnum:MSSQL_CHAR
            Return _characters
        Of DataTypeEnum:MSSQL_DATETIME
            Return 8
        END

        Return 0

c25_DataReflectionClass.DataTypeEnumToDllSetInfoTrailing        Procedure(long _segments, long _dataTypeEnum, <long _characters>, <long _places>)

    CODE

        Case _dataTypeEnum
        Of DataTypeEnum:CLA_BYTE
            Return Chr(0) !  1
        Of DataTypeEnum:CLA_SHORT
            Return Chr(0) !  2
        Of DataTypeEnum:CLA_USHORT
            Return Chr(0) !  2
        Of DataTypeEnum:CLA_DATE
            Return Chr(0) !  4
        Of DataTypeEnum:CLA_TIME
            Return Chr(0) !  4
        Of DataTypeEnum:CLA_LONG
            Return Chr(0) !  Chr(DataTypeEnum:CLA_LONG) & Chr(_segments)
        Of DataTypeEnum:CLA_ULONG
            Return Chr(0) !  4
        Of DataTypeEnum:CLA_SREAL
            Return Chr(0) !  4
        Of DataTypeEnum:CLA_REAL
            Return Chr(0) !  8
        Of DataTypeEnum:CLA_DECIMAL
            Return Chr(0) !  Chr(0) !  D#
        Of DataTypeEnum:CLA_PDECIMAL
            Return Chr(0) !  Chr(0) !  D#
        Of DataTypeEnum:CLA_UNKNOWN12
            Return Chr(0) !  Chr(0) !  0
        Of DataTypeEnum:CLA_BFLOAT4
            Return Chr(0) !  Chr(0) !  4
        Of DataTypeEnum:CLA_BFLOAT8
            Return Chr(0) !  Chr(0) !  8
        Of DataTypeEnum:CLA_ANY
            Return Chr(0) !  Chr(0) !  8
        Of DataTypeEnum:CLA_UNKNOWN16
            Return Chr(0) !  Chr(0) !  0
        Of DataTypeEnum:CLA_UNKNOWN17
            Return Chr(0) !  Chr(0) !  0
        Of DataTypeEnum:CLA_STRING
            Return Chr(0) !  _characters
        Of DataTypeEnum:CLA_CSTRING
            Return Chr(0) !  _characters + 1
        Of DataTypeEnum:CLA_PSTRING
            Return Chr(0) !  _characters ! TODO
        Of DataTypeEnum:CLA_MEMO
            Return Chr(0) !  _characters
        Of DataTypeEnum:CLA_GROUP
            Return Chr(0) !  0
        Of DataTypeEnum:CLA_UNKNOWN23
            Return Chr(0) !  0
        Of DataTypeEnum:CLA_UNKNOWN24
            Return Chr(0) !  0
        Of DataTypeEnum:CLA_UNKNOWN25
            Return Chr(0) !  0
        Of DataTypeEnum:CLA_UNKNOWN26
            Return Chr(0) !  0
        Of DataTypeEnum:CLA_BLOB
            Return Chr(0) !  _characters
        Of DataTypeEnum:CLA_UNKNOWN28
            Return Chr(0) !  0
        Of DataTypeEnum:CLA_UNKNOWN29
            Return Chr(0) !  0
        Of DataTypeEnum:CLA_UNKNOWN30
            Return Chr(0) !  0
        Of DataTypeEnum:CLA_REFERENCE
            Return Chr(0) !  8
        Of DataTypeEnum:CLA_BSTRING
            Return Chr(0) !  8 ! todo
        Of DataTypeEnum:CLA_ASTRING
            Return Chr(0) !  _characters ! todo
        Of DataTypeEnum:CLA_KEY
            Return Chr(0) !  0
        END

        Return 0
