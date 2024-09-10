                        Member

                        Include('c25_DataColumnsCollectionClass.inc'),Once
                        Map
                            Include('i64.inc')
                            Include('cwutil.inc')
                            Include('c25_WinApiPrototypes.inc')
                        End

c25_DataColumnsCollectionClass.Construct                                    Procedure()

Code

    Self.BitConverterClass &= NEW c25_BitConverterClass()
    Self.DataColumnsArrayCapacity = Maximum(Self.DataColumnsArray,1)

c25_DataColumnsCollectionClass.Destruct                                     Procedure()

Code
        
 

c25_DataColumnsCollectionClass.Init                                         Procedure(*c25_DataSourceClass _dataSourceClass)

Code

    Self.DataSourceClass &= _dataSourceClass
    Self.ProgramHandlerClass &= Self.DataSourceClass.ProgramHandlerClass
    
    Return 0
    
    
c25_DataColumnsCollectionClass.RemoveAll                                    Procedure()

DataColumn &c25_DataColumnClass

CODE
        
    I# = 0
    LOOP Self.DataColumnsArrayCapacity Times
        I# = I# + 1
        If Self.DataColumnsArray[I#] <> 0
            DataColumn &= (Self.DataColumnsArray[I#])
            Dispose(DataColumn)
            DataColumn &= NULL
        End
    End
    Clear(Self.DataColumnsArray)
    Self.DataColumnsCount = 0
    return 0
    
    
c25_DataColumnsCollectionClass.CreateFromClarionFields                      Procedure(*ClarionFields_TYPE _clarionFields)

DataColumnClass         &c25_DataColumnClass
I                       Long

CODE
        
    Self.RemoveAll()
    
    I = 0
    LOOP
        I = I + 1
        Get(_clarionFields,I)
        If Errorcode() <> 0
            BREAK
        End
        
        DataColumnClass                     &= NEW c25_DataColumnClass()
        DataColumnClass.Init(self)
        Self.DataColumnsCount               = Self.DataColumnsCount + 1
        Self.DataColumnsArray[I]            = Address(DataColumnClass)
        
        DataColumnClass.SourceOffsetStart   = _clarionFields.Offset
        DataColumnClass.SourceOffsetEnd     = _clarionFields.OffsetEnd
        DataColumnClass.SourceOffsetSize    = _clarionFields.SizeBytes
        DataColumnClass.Name                &= Self.BitConverterClass.BinaryCopy(_clarionFields.Name)
        DataColumnClass.NameUpper           &= Self.BitConverterClass.BinaryCopy(Upper(_clarionFields.Name))
        DataColumnClass.Label               &= Self.BitConverterClass.BinaryCopy(_clarionFields.Name)
        DataColumnClass.Caption             &= Self.BitConverterClass.BinaryCopy(_clarionFields.Name)
        DataColumnClass.Label               &= Self.BitConverterClass.BinaryCopy(_clarionFields.Name)
        DataColumnClass.AllowDBNull         = True
        DataColumnClass.SourceDataTypeEnum  = _clarionFields.DataTypeEnum
        DataColumnClass.DataTypeEnum        = DataTypeEnum:Unknown
        DataColumnClass.AllowDBNull         = True
        DataColumnClass.SourceIsRefPtr      = _clarionFields.IsRef
        DataColumnClass.DefaultValue        &= NEW c25_ValueObjectClass()
        DataColumnClass.DefaultValue.SetValueNull()
        
        Case DataColumnClass.SourceDataTypeEnum
        Of DataTypeEnum:CLA_BYTE
            DataColumnClass.DataTypeEnum = DataTypeEnum:Byte
        Of DataTypeEnum:CLA_SHORT
            DataColumnClass.DataTypeEnum = DataTypeEnum:Int16
        Of DataTypeEnum:CLA_USHORT
            DataColumnClass.DataTypeEnum = DataTypeEnum:UInt16
        Of DataTypeEnum:CLA_DATE
            DataColumnClass.DataTypeEnum = DataTypeEnum:FileTimeNanoSecondsUtc
        Of DataTypeEnum:CLA_TIME
            DataColumnClass.DataTypeEnum = DataTypeEnum:FileTimeNanoSecondsUtc
        Of DataTypeEnum:CLA_LONG
            DataColumnClass.DataTypeEnum = DataTypeEnum:Int32
        Of DataTypeEnum:CLA_ULONG
            DataColumnClass.DataTypeEnum = DataTypeEnum:UInt32
        Of DataTypeEnum:CLA_SREAL
            DataColumnClass.DataTypeEnum = DataTypeEnum:Numeric
        Of DataTypeEnum:CLA_REAL
            DataColumnClass.DataTypeEnum = DataTypeEnum:Numeric
        Of DataTypeEnum:CLA_DECIMAL
            DataColumnClass.DataTypeEnum = DataTypeEnum:Numeric
        Of DataTypeEnum:CLA_PDECIMAL
            DataColumnClass.DataTypeEnum = DataTypeEnum:Numeric
        Of DataTypeEnum:CLA_UNKNOWN12
        Of DataTypeEnum:CLA_BFLOAT4
            DataColumnClass.DataTypeEnum = DataTypeEnum:Numeric
        Of DataTypeEnum:CLA_BFLOAT8
            DataColumnClass.DataTypeEnum = DataTypeEnum:Numeric
        Of DataTypeEnum:CLA_ANY
        Of DataTypeEnum:CLA_UNKNOWN16
        Of DataTypeEnum:CLA_UNKNOWN17
        Of DataTypeEnum:CLA_STRING
            DataColumnClass.DataTypeEnum = DataTypeEnum:UNICODE_STRING
        Of DataTypeEnum:CLA_CSTRING
            DataColumnClass.DataTypeEnum = DataTypeEnum:UNICODE_STRING
        Of DataTypeEnum:CLA_PSTRING
            DataColumnClass.DataTypeEnum = DataTypeEnum:UNICODE_STRING
        Of DataTypeEnum:CLA_MEMO
            DataColumnClass.DataTypeEnum = DataTypeEnum:UNICODE_STRING
        Of DataTypeEnum:CLA_GROUP
            DataColumnClass.DataTypeEnum = DataTypeEnum:UNICODE_STRING
        Of DataTypeEnum:CLA_UNKNOWN23
        Of DataTypeEnum:CLA_UNKNOWN24
        Of DataTypeEnum:CLA_UNKNOWN25
        Of DataTypeEnum:CLA_UNKNOWN26
        Of DataTypeEnum:CLA_BLOB
            DataColumnClass.DataTypeEnum = DataTypeEnum:MemAllocAndSize
        Of DataTypeEnum:CLA_UNKNOWN28
        Of DataTypeEnum:CLA_UNKNOWN29
        Of DataTypeEnum:CLA_UNKNOWN30
        Of DataTypeEnum:CLA_REFERENCE
            DataColumnClass.DataTypeEnum = DataTypeEnum:MemAllocAndSize
        Of DataTypeEnum:CLA_BSTRING
            DataColumnClass.DataTypeEnum = DataTypeEnum:MemAllocAndSize
        Of DataTypeEnum:CLA_ASTRING
            DataColumnClass.DataTypeEnum = DataTypeEnum:MemAllocAndSize
        Of DataTypeEnum:CLA_KEY
        Of DataTypeEnum:CLAEXT_Dec20
            DataColumnClass.DataTypeEnum = DataTypeEnum:Numeric
        Of DataTypeEnum:CLAEXT_INT64LIKE
            DataColumnClass.DataTypeEnum = DataTypeEnum:Numeric
        Of DataTypeEnum:CLAEXT_INT64STR8
            DataColumnClass.DataTypeEnum = DataTypeEnum:Numeric
        Of DataTypeEnum:CLAEXT_JSONInstance
            !DataColumnClass.DataTypeEnum = DataTypeEnum:MemAllocAndSize
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
        Case DataColumnClass.NameUpper
        Of 'ID'
            DataColumnClass.SpecialColumnType = SpecialColumnType:TreeNodeId
        Of 'GLOBALID'
            DataColumnClass.SpecialColumnType = SpecialColumnType:TreeNodeGlobalId
        Of 'YOURID'
            DataColumnClass.SpecialColumnType = SpecialColumnType:TreeNodeYourId
        Of 'ORDINAL'
            DataColumnClass.SpecialColumnType = SpecialColumnType:TreeNodeOrdinal
        Of 'NODETYPE'
            DataColumnClass.SpecialColumnType = SpecialColumnType:TreeNodeNodeType
        Of 'NODELEVEL'
            DataColumnClass.SpecialColumnType = SpecialColumnType:TreeNodeNodeLevel
        Of 'NODETAG'
            DataColumnClass.SpecialColumnType = SpecialColumnType:TreeNodeNodeTag
        Of 'EXPANDSTATE'
            DataColumnClass.SpecialColumnType = SpecialColumnType:TreeNodeExpandState
        Of 'ICONCOLLECTIONID'
            DataColumnClass.SpecialColumnType = SpecialColumnType:TreeNodeIconCollectionId
        Of 'STYLECOLLECTIONID'
            DataColumnClass.SpecialColumnType = SpecialColumnType:TreeNodeStyleCollectionId
        Of 'PARENTNODEID'
            DataColumnClass.SpecialColumnType = SpecialColumnType:TreeNodeParentNodeId
        Of 'PARENTNODEROWID'
            DataColumnClass.SpecialColumnType = SpecialColumnType:TreeNodeParentNodeRowId
        Of 'PARENTNODETYPE'
            DataColumnClass.SpecialColumnType = SpecialColumnType:TreeNodeParentNodeType
        Of 'PARENTNODELEVEL'
            DataColumnClass.SpecialColumnType = SpecialColumnType:TreeNodeParentNodeLevel
        Of 'PARENTNODETAG'
            DataColumnClass.SpecialColumnType = SpecialColumnType:TreeNodeParentNodeTag
        Of 'PARENTDISTANCE'
            DataColumnClass.SpecialColumnType = SpecialColumnType:TreeNodeParentDistance
        Of 'CHILDRENNODECOLLECTIONID'
            DataColumnClass.SpecialColumnType = SpecialColumnType:TreeNodeChildrenNodeCollectionId
        Of 'CHILDRENNODESCOUNT'
            DataColumnClass.SpecialColumnType = SpecialColumnType:TreeNodeChildrenNodesCount
        Of 'HIERARCHYID'
            DataColumnClass.SpecialColumnType = SpecialColumnType:TreeNodeHierarchyId
        Of 'NODEPATH'
            DataColumnClass.SpecialColumnType = SpecialColumnType:TreeNodeNodePath
        Of 'NAME'
            DataColumnClass.SpecialColumnType = SpecialColumnType:TreeNodeName
        Of 'LINETEXT'
            DataColumnClass.SpecialColumnType = SpecialColumnType:TreeNodeLineText
        ELSE
            DataColumnClass.SpecialColumnType = SpecialColumnType:None
        End           
    End
    Return Self.DataColumnsCount
    