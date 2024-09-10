        Member

        Include('c25_DataCellClass.inc'),Once

                    MAP
                        Include('CWUTIL.inc'),once
                        Include('i64.inc')
						Include('c25_WinApiPrototypes.inc')
                    End

c25_DataCellClass.Construct Procedure()

Code

    Self.ValueObjectClass &= NEW c25_ValueObjectClass
    
    
c25_DataCellClass.Destruct                                                    Procedure()

Code

!    If not Self.ValueObject &= NULL
!        Dispose(Self.ValueObject)
!    End
!!    If not Self.Result &= NULL
!!        Dispose(Self.Result)
!!    End    
!    Self.DataTable              &= null
!    Self.DataColumn             &= null
!    Self.ValueObjectDefaults    &= null
!    Self.ValueObject            &= null
!    !Self.Result                 &= null

    
c25_DataCellClass.Init                      Procedure(*c25_DataRowClass _dataRowClass)


Code

    Self.DataRow &= _dataRowClass
    Self.ProgramHandlerClass &= Self.DataRow.ProgramHandlerClass
    Self.ValueObjectClass.Init(Self.DataRow.BitConverterClass)
    
    
    return 0
    
    
c25_DataCellClass.GetSpecialColumnType      Procedure()

CODE

    If Self.DataColumn &= NULL
        Return 0
    END
    Return Self.DataColumn.SpecialColumnType


c25_DataCellClass.ConvertClarionQFieldValue Procedure(*c25_DataColumnClass _dataColumnClass, *string _q)

CODE

   
    Case _dataColumnClass.SourceDataTypeEnum
    Of DataTypeEnum:CLA_BYTE
        Case _dataColumnClass.DataTypeEnum
        Of DataTypeEnum:Byte
            Self.ValueObjectClass.SetValueByteFromChar(_q[_dataColumnClass.SourceOffsetStart + 1 : _dataColumnClass.SourceOffsetEnd + 1])
        End
    Of DataTypeEnum:CLA_SHORT
        !DataColumnClass.DataTypeEnum = DataTypeEnum:Int16
        Case _dataColumnClass.DataTypeEnum
        Of DataTypeEnum:Int16
            Self.ValueObjectClass.SetValueInt16FromChars(_q[_dataColumnClass.SourceOffsetStart + 1 : _dataColumnClass.SourceOffsetEnd + 1])
        End        
    Of DataTypeEnum:CLA_USHORT
        !DataColumnClass.DataTypeEnum = DataTypeEnum:UInt16
        Case _dataColumnClass.DataTypeEnum
        Of DataTypeEnum:UInt16
            Self.ValueObjectClass.SetValueUInt16FromChars(_q[_dataColumnClass.SourceOffsetStart + 1 : _dataColumnClass.SourceOffsetEnd + 1])
        End         
    Of DataTypeEnum:CLA_DATE
        !DataColumnClass.DataTypeEnum = DataTypeEnum:FileTimeNanoSecondsUtc
        Case _dataColumnClass.DataTypeEnum
        Of DataTypeEnum:FileTimeNanoSecondsUtc
            Self.ValueObjectClass.SetValueInt32FromChars(_q[_dataColumnClass.SourceOffsetStart + 1 : _dataColumnClass.SourceOffsetEnd + 1])
        End             
    Of DataTypeEnum:CLA_TIME
        !DataColumnClass.DataTypeEnum = DataTypeEnum:FileTimeNanoSecondsUtc
        Case _dataColumnClass.DataTypeEnum
        Of DataTypeEnum:FileTimeNanoSecondsUtc
            Self.ValueObjectClass.SetValueInt32FromChars(_q[_dataColumnClass.SourceOffsetStart + 1 : _dataColumnClass.SourceOffsetEnd + 1])
        End               
    Of DataTypeEnum:CLA_LONG
        !DataColumnClass.DataTypeEnum = DataTypeEnum:Int32
        Case _dataColumnClass.DataTypeEnum
        Of DataTypeEnum:Int32
            Self.ValueObjectClass.SetValueInt32FromChars(_q[_dataColumnClass.SourceOffsetStart + 1 : _dataColumnClass.SourceOffsetEnd + 1])
        End          
    Of DataTypeEnum:CLA_ULONG
        !DataColumnClass.DataTypeEnum = DataTypeEnum:UInt32
        Case _dataColumnClass.DataTypeEnum
        Of DataTypeEnum:UInt32
            Self.ValueObjectClass.SetValueUInt32FromChars(_q[_dataColumnClass.SourceOffsetStart + 1 : _dataColumnClass.SourceOffsetEnd + 1])
        End          
    Of DataTypeEnum:CLA_SREAL
        !DataColumnClass.DataTypeEnum = DataTypeEnum:Numeric
    Of DataTypeEnum:CLA_REAL
        !DataColumnClass.DataTypeEnum = DataTypeEnum:Numeric
    Of DataTypeEnum:CLA_DECIMAL
        !DataColumnClass.DataTypeEnum = DataTypeEnum:Numeric
    Of DataTypeEnum:CLA_PDECIMAL
        !DataColumnClass.DataTypeEnum = DataTypeEnum:Numeric
    Of DataTypeEnum:CLA_UNKNOWN12
    Of DataTypeEnum:CLA_BFLOAT4
        !DataColumnClass.DataTypeEnum = DataTypeEnum:Numeric
    Of DataTypeEnum:CLA_BFLOAT8
        !DataColumnClass.DataTypeEnum = DataTypeEnum:Numeric
    Of DataTypeEnum:CLA_ANY
    Of DataTypeEnum:CLA_UNKNOWN16
    Of DataTypeEnum:CLA_UNKNOWN17
    Of DataTypeEnum:CLA_STRING
        !DataColumnClass.DataTypeEnum = DataTypeEnum:UNICODE_STRING
        Case _dataColumnClass.DataTypeEnum
        Of DataTypeEnum:UNICODE_STRING
            If _dataColumnClass.SourceIsRefPtr
                Self.ValueObjectClass.SetValueUnicodeStringFromStringRef(_q[_dataColumnClass.SourceOffsetStart + 1 : _dataColumnClass.SourceOffsetEnd + 1])
            Else
                Self.ValueObjectClass.SetValueUnicodeStringFromString(_q[_dataColumnClass.SourceOffsetStart + 1 : _dataColumnClass.SourceOffsetEnd + 1])
            End
        End         
    Of DataTypeEnum:CLA_CSTRING
        !DataColumnClass.DataTypeEnum = DataTypeEnum:UNICODE_STRING
        If _dataColumnClass.SourceOffsetStart + 1 > _dataColumnClass.SourceOffsetEnd + 0
            Message('error cstring _dataColumnClass.SourceOffsetStart + 1 > _dataColumnClass.SourceOffsetEnd + 0')
        Else
            Case _dataColumnClass.DataTypeEnum
            Of DataTypeEnum:UNICODE_STRING
                If _dataColumnClass.SourceIsRefPtr
                    Self.ValueObjectClass.SetValueUnicodeStringFromStringRef(_q[_dataColumnClass.SourceOffsetStart + 1 : _dataColumnClass.SourceOffsetEnd + 0])
                Else
                    Self.ValueObjectClass.SetValueUnicodeStringFromString(_q[_dataColumnClass.SourceOffsetStart + 1 : _dataColumnClass.SourceOffsetEnd + 0])
                End
            End 
        End
    Of DataTypeEnum:CLA_PSTRING
        !DataColumnClass.DataTypeEnum = DataTypeEnum:UNICODE_STRING
    Of DataTypeEnum:CLA_MEMO
        !DataColumnClass.DataTypeEnum = DataTypeEnum:UNICODE_STRING
    Of DataTypeEnum:CLA_GROUP
        !DataColumnClass.DataTypeEnum = DataTypeEnum:UNICODE_STRING
    Of DataTypeEnum:CLA_UNKNOWN23
    Of DataTypeEnum:CLA_UNKNOWN24
    Of DataTypeEnum:CLA_UNKNOWN25
    Of DataTypeEnum:CLA_UNKNOWN26
    Of DataTypeEnum:CLA_BLOB
        !DataColumnClass.DataTypeEnum = DataTypeEnum:MemAllocAndSize
    Of DataTypeEnum:CLA_UNKNOWN28
    Of DataTypeEnum:CLA_UNKNOWN29
    Of DataTypeEnum:CLA_UNKNOWN30
    Of DataTypeEnum:CLA_REFERENCE
        !DataColumnClass.DataTypeEnum = DataTypeEnum:MemAllocAndSize
    Of DataTypeEnum:CLA_BSTRING
        !DataColumnClass.DataTypeEnum = DataTypeEnum:MemAllocAndSize
    Of DataTypeEnum:CLA_ASTRING
        !DataColumnClass.DataTypeEnum = DataTypeEnum:MemAllocAndSize
    Of DataTypeEnum:CLA_KEY
    Of DataTypeEnum:CLAEXT_Dec20
        !DataColumnClass.DataTypeEnum = DataTypeEnum:Numeric
    Of DataTypeEnum:CLAEXT_INT64LIKE
        !DataColumnClass.DataTypeEnum = DataTypeEnum:Numeric
    Of DataTypeEnum:CLAEXT_INT64STR8
        !DataColumnClass.DataTypeEnum = DataTypeEnum:Numeric
    Of DataTypeEnum:CLAEXT_JSONInstance
        !!DataColumnClass.DataTypeEnum = DataTypeEnum:MemAllocAndSize
    Of DataTypeEnum:CLAEXT_QUEUEREF
    Of DataTypeEnum:CLAEXT_STInstance
    Of DataTypeEnum:CLAEXT_STRINGANSI
    Of DataTypeEnum:CLAEXT_STRINGBINARY
    Of DataTypeEnum:CLAEXT_STRINGJSON
    Of DataTypeEnum:CLAEXT_STRINGREFANSI
    Of DataTypeEnum:CLAEXT_STRINGREFBINARY
    Of DataTypeEnum:CLAEXT_STRINGREFUTF16
    Of DataTypeEnum:CLAEXT_STRINGREFUTF32
    Of DataTypeEnum:CLAEXT_STRINGREFUTF8
    Of DataTypeEnum:CLAEXT_STRINGUTF16
    Of DataTypeEnum:CLAEXT_STRINGUTF32
    Of DataTypeEnum:CLAEXT_STRINGUTF8
    Of DataTypeEnum:CLAEXT_UINT64LIKE
    Of DataTypeEnum:CLAEXT_UINT64STR8
    Of DataTypeEnum:CLAEXT_CLA_BINARY
    ELSE
    End
    Return 0


!    
!c25_DataCellClass.SetRowIndex                                                         Procedure(string _rowIndex)    
!
!Code
!
!    Self.RowIndex = _rowIndex
!    i64FromDecimal(Self.RowIndex64,Self.RowIndex)
!    Return 0