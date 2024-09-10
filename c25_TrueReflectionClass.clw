        Member

        Include('c25_ProgramHandlerClass.inc'),Once

        Include('c25_TrueReflectionClass.inc'),Once

                    MAP
                        Include('CWUTIL.inc'),once
                        Include('i64.inc')
                        Include('c25_WinApiPrototypes.clw')
                    End

TrueReflectionClass.Destruct                        Procedure()

Code
        
    Dispose(Self.c25QueueObject)
    Dispose(Self.BitConverter)
    Dispose(Self.ClarionFields)
    Dispose(Self.ClarionFields1)
    Dispose(Self.ClarionFields2)
    Dispose(Self.EF_ptrString)
    !Dispose(Self.BitConverter.Js1)
    !Dispose(Self.Logger)
    Dispose(Self.MetaQueueObjectsQ)
    !Dispose(Self.QueueObjectsQ)
    !Dispose(Self.Reflection)
    !Dispose(Self.SomeQ)
    !Dispose(Self.SomeQueueRef)
    !Dispose(Self.ThisNewQueue)
    Dispose(Self.TrueReflection1)
    Dispose(Self.TrueReflection2)

TrueReflectionClass.Construct                       Procedure()

    Code

        Self.CRLF = Chr(13) & Chr(10)
        Self.ClarionFields &= NEW ClarionFields_TYPE()
        Self.Str8Zeroed = All(Chr(0),8)
!        Self.BitConverter.Js1 &= NEW JsonClass()
!        Self.QueueObjectsQ &= NEW QueueObjectsQ_TYPE()
!        Self.MetaQueueObjectsQ &= NEW QueueObjectsQ_TYPE()
        Self.BitConverter &= NEW c25BitConverterClass()
        

TrueReflectionClass.LoadQueueTypes                  Procedure()

!c25QueueObject          &c25QueueObjectClass
SomeQ                   &QUEUE
ClarionFields           &ClarionFields_TYPE
!ThisTrueReflection      &TrueReflectionClass

Code

!    ThisTrueReflection &= null
    !ThisTrueReflection &= NEW TrueReflectionClass()
    Self.TrueReflection1 &= NEW TrueReflectionClass()
    
    ClarionFields &= NEW ClarionFields_TYPE
    
    Self.QueueObjectsQ &= NEW QueueObjectsQ_TYPE()
    Self.MetaQueueObjectsQ &= NEW QueueObjectsQ_TYPE()    

    Self.BitConverter.St1.Start()
    Self.BitConverter.St2.Start()
    Self.BitConverter.St2.SetValue('')
    Self.BitConverter.St2.SaveFile('m:\log\Processed_QueueTypes.txt')
    
    
    !DPK_DC_NoUseClass_TYPE
    
    Self.BitConverter.Js1.Start()
    Self.BitConverter.Js1.SetTagCase(jf:CaseAny)
    Self.BitConverter.Js1.SetRemovePrefix(True)
    Self.BitConverter.St1.LoadFile('M:\Clarion11\accessory\libsrc\win\META\QueueTypes.json') 
    Free(Self.MetaQueueObjectsQ)
    Self.BitConverter.Js1.Load(Self.MetaQueueObjectsQ,Self.BitConverter.St1)
    !Sort(QFields,QFields.Name)
    Self.BitConverter.St1.Start()
    I# = 0
    LOOP
        I# = I# + 1
        Get(Self.MetaQueueObjectsQ,I#)
        If Errorcode() <> 0
            BREAK
        End
        If Self.MetaQueueObjectsQ.SkipMetaQueue
            Cycle
        End
        Self.c25QueueObject &= NEW c25QueueObjectClass()
        Self.MetaQueueObjectsQ.IsPrototype = TRUE
        Self.MetaQueueObjectsQ.QueueObjectPtr = Address(Self.c25QueueObject)
        
        !SomeQ &= NULL
        
        !SomeQ &= c25QueueObject.CreateClarionQueue(Self.MetaQueueObjectsQ.TypeName, Self.MetaQueueObjectsQ.TypeName, )
        SomeQ &= Self.c25QueueObject.CreateClarionQueue(Self.MetaQueueObjectsQ.TypeName, Self.MetaQueueObjectsQ.TypeName, )
        
        If not SomeQ &= null !Self.c25QueueObject.Q &= null
            !ClarionFields &= NEW ClarionFields_TYPE
            !Self.MetaQueueObjectsQ.ClarionFieldsPtr = Address(ClarionFields)
!            If not c25QueueObject.TrueReflection &= NULL
!                Dispose(c25QueueObject.TrueReflection)
!            End
            !Self.c25QueueObject.TrueReflection &= NEW TrueReflectionClass()
            !c25_sleepex(50,0)
            
            Free(ClarionFields)
            
            Self.BitConverter.St2.Start()
            Self.BitConverter.St2.Append('TRY ' & Self.MetaQueueObjectsQ.TypeName & Self.CRLF)
            Self.BitConverter.St2.SaveFile('m:\log\Processed_QueueTypes.txt', True) 
            
            !ThisTrueReflection.Analyze(SomeQ ,Self.c25QueueObject.ClarionFields)
            Self.TrueReflection1.Analyze(SomeQ, , , , , True, Self.MetaQueueObjectsQ.TypeName) ! ,ClarionFields)
            
            Self.BitConverter.St2.Start()
            Self.BitConverter.St2.Append(Self.MetaQueueObjectsQ.TypeName & Self.CRLF)
            Self.BitConverter.St2.SaveFile('m:\log\Processed_QueueTypes.txt', True)            
            
            !Dispose(ThisTrueReflection)
            
            !c25_sleepex(50,0)
!!            I# = 0
!!            R# = Records(ClarionFields)
!!            LOOP
!!                I# = I# + 1
!!                Get(ClarionFields,I#)
!!            End
!             Self.BitConverter.QueueToJsonString(ClarionFields, False, , , 'm:\log\ClaFields_' & Self.MetaQueueObjectsQ.TypeName & '.json')
!            !Message('Self.MetaQueueObjectsQ.ClarionFieldsPtr')
        Else
            !Message('not ok Self.MetaQueueObjectsQ.TypeName ' & Self.MetaQueueObjectsQ.TypeName)
            Self.BitConverter.St1.Append(Self.MetaQueueObjectsQ.TypeName & Self.CRLF)
        End
        !Self.MetaQueueObjectsQ.MetaJsonString
        !Message(Self.MetaQueueObjectsQ.TypeName)
        
        !Dispose(Self.c25QueueObject)
!        Dispose(SomeQ)
        
        Put(Self.MetaQueueObjectsQ)
    End
    Self.BitConverter.St1.SaveFile('m:\log\Missing_QueueTypes.txt')
    
    Dispose(Self.TrueReflection1)
    
    Message('done LoadQueueTypes')
    
    Return ''

TrueReflectionClass.CreateSqliteScriptFromQueue     Procedure(*QUEUE _queue, String _tableName)

ClarionFields &ClarionFields_TYPE

    Code

        ClarionFields &= NEW ClarionFields_TYPE()

        Self.Analyze(_queue, ClarionFields)

        Self.BitConverter.St1.Start()
        Self.BitConverter.St1.SetValue('')
        Self.BitConverter.St1.Append('CREATE TABLE If NOT EXISTS ' & Clip(_tableName) & ' ('  & Self.CRLF)

        Self.BitConverter.St1.Append('ROWID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'  & Self.CRLF)

        I# = 0
        Loop Records(ClarionFields) TIMES
            I# = I# + 1
            Get(ClarionFields, I#)

            If Upper(ClarionFields.Name) <> 'ROWID'
                Case Upper(ClarionFields.DataType)
                Of 'Byte'
                OrOf 'UShort'
                OrOf 'Short'
                OrOf 'Long'
                OrOf 'ULong'
                    Self.BitConverter.St1.Append('[' & ClarionFields.Name & '] '  & 'INTEGER' & ',' & Self.CRLF)
                Of 'DECIMAL'
                    If ClarionFields.Characters < 21
                        Self.BitConverter.St1.Append('[' & ClarionFields.Name & '] '  & 'BIGINT' & ',' & Self.CRLF)
                    Else
                        Self.BitConverter.St1.Append('[' & ClarionFields.Name & '] TEXT COLLATE NOCASE,' & Self.CRLF)
                    End
                Else
                    Self.BitConverter.St1.Append('[' & ClarionFields.Name & '] TEXT COLLATE NOCASE,' & Self.CRLF)
                End
            End
        End
        Dispose(ClarionFields)

        Self.BitConverter.St1.Crop(1, Self.BitConverter.St1.Length() - 3)
        Self.BitConverter.St1.Append(');'  & Self.CRLF)
        Self.BitConverter.St1.Append(Self.CRLF )

        Return Self.BitConverter.St1.GetValue()

TrueReflectionClass.Analyze                         Procedure(<*QUEUE _queue>, <*ClarionFields_TYPE _outputQ>, <Byte _autoStyleColumns>, <*GROUP _group>, <String _tableName>, <bool _debug>, <String _name>, <String _jsonFileOut>)

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
Index                               Long
Offset                              Long
OffsetEnd                           Long
Name                                CSTRING(128)
StructurePrefix                     CSTRING(128)
StructureName                       CSTRING(128)
DataType                            CSTRING(128)
SizeBytes                           Long
IsRef                               Byte
Characters                          Long
Places                              Long
String1K                            String(1024)
Dimensions                          Long
TestValueLen                        Long
PtrAddress                          Long
PtrSize                             Long
PtrAddressSize                      Long
PtrSizeSize                         Long
IsQueue                             Byte
IsGroup                             Byte
IsAnsi                              Byte
IsUtf7                              Byte
IsUtf8                              Byte
IsUtf16                             Byte
IsUtf32                             Byte
IsBase64                            Byte
IsBinary                            Byte
OtherEncoding                       Byte
Encoding                            CString(128)
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

DecNineBlock                        &String
AnyField2                           ANY
AnyFieldInString31                  String(50)
TestBlock                           &String

TestQRef                            Group,Pre(TestQRef)
SomeQRef                                &QUEUE
                                    End

    Code

        If omitted(_tableName) = False
        End

        OriginalRecord &= NEW String(Size(_queue))
        OriginalRecord = _queue
        If _queue &= NULL
            MESSAGE('Error, reflection queue is null')
            Return ''
        End

        If not Self.ClarionFields &= null
            Free(Self.ClarionFields)
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
            QFields.Index = FieldIndex
            Add(QFields)
        End
        Fields = FieldIndex
        If omitted(_tableName) = False
        End
        FieldTestIndex = 1

        GroupOriginalSize   = Size(_queue)
        GroupStrOrg         &= NEW String(GroupOriginalSize)
        TestBlock           &= NEW String(GroupOriginalSize)
        GroupStrOrg         = _queue

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

            If omitted(_tableName) = False
            End
            AnyField &= NULL
            AnyField     &= What(_queue,FieldTestIndex)

            If omitted(_tableName) = False
            End

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

                P# = Instring('RENAME(',Clip(Upper(WhoLine)),1,1)
                If P# > 0
                    WhoLine = WhoLine[P# + LEN('REPLACE(')-1 : Size(WhoLine)]
                    P# = Instring(')',Clip(Upper(WhoLine)),1,1)
                    If P# > 1
                        QFields.Name = WhoLine[1 : P#-1]
                    End
                Else
                    If SPACE# > 0
                        QFields.Name = WhoLine[1 : SPACE#-1]
                    ELSE
                        QFields.Name = Clip(WhoLine)
                    End
                End
            Else
                QFields.Name = Clip(WhoLine)
            End

            B# = Instring(':',QFields.Name,1,1)
            If B# > 1
                QFields:StructurePrefix = QFields.Name[1 : B#-1]
                QFields.Name = Clip(QFields.Name[B#+1 : Size(QFields.Name)])
            End
            QFields.Name = CLIP(QFields.Name)

            QFields.SizeBytes   = S#
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
                QFields:String1K = Address
                If Address = 0
                    QFields:IsRef = True
                    If Len(Clip(WHO(_queue,FieldTestIndex))) > 0
                        QFields.IsQueue = True
                    End
                    Put(QFields)
                End
            Of 8
                AddressAndSizeFromAny = AnyField
                QFields:String1K = AdrGroup.PtrAddress & ' : ' & AdrGroup.PtrSize
                If AdrGroup.PtrAddress = 0 And AdrGroup.PtrSize = 0
                    QFields:IsRef = True
                    Put(QFields)
                End
            Of 12
                AddressAndSizeFromAnyGrp = AnyField
                QFields:String1K = AdrGroupGrp.PtrAddress & ' : ' & AdrGroupGrp.PtrSize & ' : ' & AdrGroupGrp.PtrGrp
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
                QFields.DataType = 'String'
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
            If QFields.DataType = 'String'
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
                    QFields.DataType = 'Byte'
                End
            Of 2
                AnyField         &= What(_queue,FieldTestIndex)
                AnyField = 2^16-1
                If AnyField < 0
                    QFields.DataType = 'Short'
                Else
                    QFields.DataType = 'UShort'
                End
            Of 4
                AnyField         &= What(_queue,FieldTestIndex)
                AnyField = 2^32-1
                If AnyField < 0
                    QFields.DataType = 'Long'
                Else
                    QFields.DataType = 'ULong'
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
            If QFields.DataType <> 'ULong'
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
            If Len(QFields.DataType) <> 0
                Cycle
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
            If Len(QFields.DataType) > 0
                Cycle
            End

            TestBlock = ZeroBlock
            If QFields.OffsetEnd + 1 < QFields.Offset + 1
                Message('errorcode If QFields.OffsetEnd + 1 < QFields.Offset + 1')
            End
            If QFields.SizeBytes-1 < 1
                Message('error QFields.SizeBytes-1')
            End
            If QFields.SizeBytes-1 > Size(TestBlock)
                Message('error If QFields.SizeBytes-1 > Size(TestBlock)')
            End
            If Size(TestBlock) < QFields.Offset + 1
                Message('error If Size(TestBlock) < QFields.Offset + 1')
            End
            If Size(TestBlock) < QFields.OffsetEnd + 1
                Message(_name)
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
        Loop
            BREAK
            _queue = ZeroBlock
            FieldTestIndex = FieldTestIndex + 1
            If FieldTestIndex > Fields
                Break
            End
            Get(QFields,FieldTestIndex)
            If Len(QFields.DataType) > 0
                Cycle
            End
            Odd# = QFields.SizeBytes%2
            DecLen# = 0
            If Odd#
                DecLen# = (QFields.SizeBytes) * 2
            Else
                Cycle
            End
            DecLen# = DecLen# - 1

            FP# = 1
            Loop DecLen# Times
                FP# = FP# + 1
                If FP# = DecLen#
                    break
                End
                If not DecFieldStr &= null
                    Dispose(DecFieldStr)
                End
                DecFieldStr &= NEW String(DecLen#)
                P# = 0
                Loop DecLen# times
                    P# = P# + 1
                    If P# = FP#
                        DecFieldStr[P#] = '.'
                    Else
                        DecFieldStr[P#] = '9'
                    End
                End
                QFields:TestValueLen = DecLen#

                AnyField &= What(_queue,FieldTestIndex)
                AnyField = DecFieldStr
                DecFieldReturnA = AnyField
                If DecFieldReturnA = DecFieldStr
                    QFields.DataType = 'DECIMAL'
                    QFields.Characters = DecLen#
                    QFields.Places = QFields.Characters - FP#
                Else
                    cycle
                End
                Put(QFields)
                break
            End
        End

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
            QFields.StructureName                       = CLIP(QFields.StructureName)
            QFields.StructurePrefix                     = CLIP(QFields.StructurePrefix)

            If Upper(QFields.DataType) = 'DECIMAL'
                Odd# = QFields.Characters%2
                If Odd# = True
                    QFields.Characters = (QFields.Characters-1)
                End
                Put(QFields)
            End

            Self.ClarionFields.Name                   = QFields.Name
            If LEN(CLIP(Self.ClarionFields.Name)) = 0
                MESSAGE('warning reflection, no name defined in your queue on position ' & G# & ', ' & WHO(_queue,G#))
            End
            Self.ClarionFields.Characters             = QFields.Characters
            Self.ClarionFields.DataType               = Upper(QFields.DataType)
            Self.ClarionFields.Dimensions             = QFields.Dimensions
            Self.ClarionFields.Index                  = QFields.Index
            Self.ClarionFields.IsRef                  = QFields.IsRef
            Self.ClarionFields.Offset                 = QFields.Offset
            Self.ClarionFields.OffsetEnd              = QFields.OffsetEnd

            Self.ClarionFields.ClaOffset              = QFields.Offset + 1
            Self.ClarionFields.ClaOffsetEnd           = QFields.OffsetEnd + 1

            Self.ClarionFields.Places                 = QFields.Places
            Self.ClarionFields.PtrAddress             = QFields.PtrAddress
            Self.ClarionFields.PtrAddressSize         = QFields.PtrAddressSize
            Self.ClarionFields.PtrSize                = QFields.PtrSize
            Self.ClarionFields.PtrSizeSize            = QFields.PtrSizeSize
            Self.ClarionFields.SizeBytes              = QFields.SizeBytes
            Self.ClarionFields.StructureName          = QFields.StructureName
            Self.ClarionFields.StructurePrefix        = QFields.StructurePrefix
            Self.ClarionFields.TestValueLen           = QFields.TestValueLen
            Self.ClarionFields.IsQueue                = QFields.IsQueue
            Self.ClarionFields.IsGroup                = QFields.IsGroup

            QFields.IsAnsi = True
            Self.BitConverter.St1.Start()
            Self.BitConverter.St1.SetValue(Upper(Self.ClarionFields.Name))
            Self.ClarionFields.IsAnsi                 = QFields.IsAnsi

            If Self.BitConverter.St1.EndsWith('UTF8')
                QFields.IsUtf8 = True
                Self.ClarionFields.IsUtf8 = QFields.IsUtf8
                Self.ClarionFields.IsAnsi = 0
            End

            If Self.BitConverter.St1.EndsWith('UTF16')
                QFields.IsUtf16 = True
                Self.ClarionFields.IsUtf16 = QFields.IsUtf16
                Self.ClarionFields.IsAnsi = 0
            End

            If Self.BitConverter.St1.FindChars('NVARCHAR') > 0 Or Self.BitConverter.St1.FindChars('NCHAR') > 0
                QFields.IsUtf16 = True
                Self.ClarionFields.IsUtf16 = QFields.IsUtf16
                Self.ClarionFields.IsAnsi = 0
            End

            If Self.BitConverter.St1.EndsWith('UTF32')
                QFields.IsUtf32 = True
                Self.ClarionFields.IsUtf32 = QFields.IsUtf32
                Self.ClarionFields.IsAnsi = 0
            End

            If Self.BitConverter.St1.EndsWith('BINARY') Or Self.BitConverter.St1.EndsWith('BLOB')
                QFields.IsBinary = True
                Self.ClarionFields.IsBinary = True
                Self.ClarionFields.IsAnsi = 0
            End

             If Self.BitConverter.St1.Instring('_ENC_')
                QFields.OtherEncoding = True
                Self.ClarionFields.OtherEncoding = QFields.OtherEncoding
                In# = Self.BitConverter.St1.Instring('_ENC_')
                Self.ClarionFields.Encoding = Self.BitConverter.St1.Sub(In#+5,Self.BitConverter.St1.Length() - In#+5)
                Self.ClarionFields.IsAnsi = 0
            End

            If Self.BitConverter.St1.EndsWith('_STYLE')
                Self.ClarionFields.DisplayOrdinal = DisplayOrdinal
                Self.ClarionFields.IsStyle = True
            ELSE
                DisplayOrdinal = DisplayOrdinal + 1
                Self.ClarionFields.DisplayOrdinal = DisplayOrdinal
            End

            Case Upper(QFields.DataType)
            Of 'STRING'
                If QFields.IsRef
                    Self.ClarionFields.DataTypeEnum = ClaDataTypeEnum:STRINGREF
                ELSE
                    Self.ClarionFields.DataTypeEnum = ClaDataTypeEnum:String
                End
            Of 'ULONG'
                Self.ClarionFields.DataTypeEnum = ClaDataTypeEnum:ULong
            Of 'LONG'
                Self.ClarionFields.DataTypeEnum = ClaDataTypeEnum:Long
            Of 'SHORT'
                Self.ClarionFields.DataTypeEnum = ClaDataTypeEnum:Short
            Of 'USHORT'
                Self.ClarionFields.DataTypeEnum = ClaDataTypeEnum:UShort
            Of 'BYTE'
                Self.ClarionFields.DataTypeEnum = ClaDataTypeEnum:Byte
            Of 'REAL'
                Self.ClarionFields.DataTypeEnum = ClaDataTypeEnum:REAL
            Of 'SREAL'
                Self.ClarionFields.DataTypeEnum = ClaDataTypeEnum:SREAL
            Of 'DECIMAL'
                If Self.ClarionFields.Characters = 20
                    Self.ClarionFields.DataTypeEnum = ClaDataTypeEnum:DEC20
                Else
                    Self.ClarionFields.DataTypeEnum = ClaDataTypeEnum:DECIMAL
                End
            End

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
                Add(_outputQ)
            End
        End

        _queue = OriginalRecord
        Dispose(OriginalRecord)

        Self.FieldsCount = Records(Self.ClarionFields)

        If omitted(_jsonFileOut) = False
            Self.BitConverter.QueueToJsonString(Self.ClarionFields, , , ,_jsonFileOut)
        End
        
        !Self.LoadQueueTypes()
        
        Return ''

TrueReflectionClass.DisposeStringRef                Procedure(String _stringRef)

ptrString  &String

    Code

        Self.EF_AddressAndSizeFromAny = _stringRef
        If Self.EF_AdrGroup.EF_PtrAddress <> 0 And Self.EF_AdrGroup.EF_PtrSize > 0
            ptrString &= Self.EF_AdrGroup.EF_PtrAddress & ':' & Self.EF_AdrGroup.EF_PtrSize
            If not ptrString &= NULL
                Dispose(ptrString)
                ptrString &= null
            End
        End
        Return All(Chr(0),Len(_stringRef))

TrueReflectionClass.DisposeQFields                  Procedure(*QUEUE _q)

QueueStr                                &String
Queue2Str                               &String
QueuePtr                                Long
QueuePtrOver                            String(4),over(QueuePtr)
RecsClarionFields2                      Long
Queue2Size                              Long
Queue2Recs                              Long
SomeAny                                 ANY

    Code

        If _q &= NULL
            Return 0
        End

        If Not Self.ClarionFields &= NULL
            Free(Self.ClarionFields)
        ELSE
            Self.ClarionFields &= NEW ClarionFields_TYPE()
        End
        Self.Analyze(_q, Self.ClarionFields)

        QueueStr &= NEW String(Size(_q))

        Clear(Self.IsRefArray)
        Self.R2 = Records(Self.ClarionFields)

        Self.I2 = 0
        Loop Self.R2 TIMES
            Self.I2 = Self.I2 + 1
            Get(Self.ClarionFields,Self.I2)
            If Self.ClarionFields.IsRef And Upper(Self.ClarionFields.DataType) = 'String'
                Self.IsRefArray[Self.I2] = TRUE
                Message('ja ref String on ' & Self.I2)
            End
        End

        Self.I = 0
        Self.R = Records(_q)
        Loop Self.R TIMES
            Self.I = Self.I + 1
            Get(_q,Self.I)
            If Self.IsRefArray[Self.I]
                Get(Self.ClarionFields,Self.I)
                QueueStr = _q
                Self.DisposeStringRef(QueueStr[Self.ClarionFields.ClaOffset : Self.ClarionFields.ClaOffsetEnd])
            End
        End
        Free(_q)
        Return 0

TrueReflectionClass.AddRowBytesToQueue              Procedure(*queue _q, *StringTheory _st, Long _startPos , Long _endPos)

Code

    If _startPos < _endPos And _startPos > 0
        _q = _st.Slice(_startPos, _endPos)
        Add(_q)
    End

TrueReflectionClass.GetPutStringFromRef             Procedure(String _stringRef, *StringTheory _st, <*Long _totalLen>)

Code

    Self.EF_AddressAndSizeFromAny = _stringRef
    If Self.EF_AdrGroup.EF_PtrAddress <> 0 And Self.EF_AdrGroup.EF_PtrSize > 0
        Self.ThisLength = Self.EF_AdrGroup.EF_PtrSize
        _st.Append(Self.LengthStr)
        
        Self.PtrString &= Self.EF_AdrGroup.EF_PtrAddress & ':' & Self.EF_AdrGroup.EF_PtrSize
        _st.Append(Self.PtrString)
        _totalLen = _totalLen + 4 + Self.ThisLength
        
        !!!!Self.Logger.AddLogLine('_st.Append(Self.PtrString)', '(' & Self.ThisLength & ') ' & Self.PtrString)
    Else
        Self.ThisLength = 0
        _st.Append(Self.LengthStr)
        _totalLen = _totalLen + 4
    End
    Return ''
    
TrueReflectionClass.SerializeQueue                  Procedure(*queue _q, <*StringTheory _st>, <String _filenameUtf>)

QueueStr                                &String
Queue2Str                               &String
QueuePtr                                Long
QueuePtrOver                            String(4),over(QueuePtr)
RecsClarionFields2                      Long
Queue2Size                              Long
Queue2Recs                              Long

Code

    
    Return 0
    
    
    Message('start TrueReflectionClass.SerializeQueue')
!    If Self.Logger &= null
!        Self.Logger  &= NEW LoggerClass()
!    End
!    !Message(1)
!    Self.Logger.Module          = 'TrueReflectionClass'
!    Self.Logger.MethodName      = 'SerializeQueue'
!    Self.Logger.AddLogLine('START')
    !Message(2)
    Self.BitConverter.St1.Start()
    Self.BitConverter.St2.Start()
    !Message(3)
    Self.TrueReflection1  &= NEW TrueReflectionClass()
    Self.ClarionFields1   &= NEW ClarionFields_TYPE()
    Self.ClarionFields2   &= NEW ClarionFields_TYPE()
    !Message(4)
    If _q &= NULL
        Message('error serialize queue is null')
        Return 0
    End
    Message(5)
    Self.TrueReflection1.Analyze(_q, Self.ClarionFields1)
    Message(6)
    !Self.BitConverter.QueueToJsonString(Self.ClarionFields1, False, False, False, 'm:\log\serialize_ClarionFields1.json')
    !Self.BitConverter.QueueToJsonString(Self.ClarionFields1, False, False, False, 'm:\log\serialize_ClarionFields1.json')
    
    
    QBlocks# = 0
    
    QueueStr &= NEW String(Size(_q))
    Get(_q,1)
    If Errorcode() <> 0
        Message('error get(_q,1)')
        Return 0
    End
    QueueStr = _q
    I# = 0
    LOOP
        !BREAK
        
        I# = I# + 1
        Get(Self.ClarionFields1,I#)
        If Errorcode() <> 0
            Break
        End
        If Self.ClarionFields1.IsQueue = False
            CYCLE
        End
        Message(7)
        Self.BitConverter.St1.Start()
        
        Self.QBlockLengthIndicatorPos = Self.BitConverter.St2.Length() + 1 
        Self.QBlockLength = 0
        Self.BitConverter.St2.Append(Self.QBlockLengthStr)
        Message(8)
        Self.QHdrLengthIndicatorPos = Self.BitConverter.St2.Length() + 1
        Self.QHdrLength = 0
        Self.BitConverter.St2.Append(Self.QHdrLengthStr) 
        Message(9)
        

        !!!!Self.Logger.AddLogLine('SET Self.QHdrLengthPos',Self.QHdrLengthPos) 
        
        Self.QHdrStartPos = Self.BitConverter.St2.Length() + 1
        Message(10)
        !!!!Self.Logger.AddLogLine('SET Self.QHdrStartPos',Self.QHdrStartPos) 
        
        QueuePtrOver = QueueStr[Self.ClarionFields1.ClaOffset : Self.ClarionFields1.ClaOffsetEnd]
        Message(12)
        
        Self.BitConverter.St2.Append('QueueName:' & Self.ClarionFields1.Name)
        Message(12)
        !Self.Logger.AddLogLine('QueuePtr:' , QueuePtr)
        !Self.Logger.AddLogLine('QueueName:' , Self.ClarionFields1.Name)
        !!Self.Logger.AddLogLine('SET Self.QHdrStartPos',Self.QHdrStartPos) 
        
        
        
        Free(Self.ClarionFields2)
        Message(13)
        If QueuePtr <> 0
            Message(14)
            Self.TrueReflection2  &= NEW TrueReflectionClass()
            Message(15)
            Self.SomeQ &= (QueuePtr)
            Message(16)
            Self.TrueReflection2.Analyze(Self.SomeQ, Self.ClarionFields2)
            Message(17)
            RecsClarionFields2 = Records(Self.ClarionFields2)
            Message(18)
            Queue2Size = Size(Self.SomeQ)
            Message(19)
            Queue2Recs = Records(Self.SomeQ)                    
            Message(20)
            If not Queue2Str &= NULL
                Dispose(Queue2Str)
            End
            Queue2Str &= NEW String(Queue2Size)
            
            Clear(Self.ClarionFieldsIsRefStr_Array)
            Clear(Self.ClarionFieldsClaStart_Array)
            Clear(Self.ClarionFieldsClaEnd_Array)

            Self.F = 0
            Loop RecsClarionFields2 Times
                Self.F = Self.F + 1
                Get(Self.ClarionFields2,Self.F)
                If Self.ClarionFields2.IsRef
                    Case Upper(Self.ClarionFields2.DataType)
                    Of 'String'
                        Self.ClarionFieldsIsRefStr_Array[Self.F]    = True
                        Self.ClarionFieldsClaStart_Array[Self.F]    = Self.ClarionFields2.ClaOffset
                        Self.ClarionFieldsClaEnd_Array[Self.F]      = Self.ClarionFields2.ClaOffsetEnd
                    End
                End
            End
            
            
            Self.BitConverter.St2.Append(',QueueFields:'         & RecsClarionFields2)
            Self.BitConverter.St2.Append(',QueueRecords:'        & Queue2Recs)
            Self.BitConverter.St2.Append(',QueueRecordSize:'     & Queue2Size)
            
            Self.QHdrLength = Self.BitConverter.St2.Length() - Self.QHdrStartPos + 1
            
            !!!!Self.Logger.AddLogLine('Self.BitConverter.St2.Length()',Self.BitConverter.St2.Length()) 
            !!!!Self.Logger.AddLogLine('Self.QHdrStartPos',Self.QHdrStartPos) 
            !!!!Self.Logger.AddLogLine('SET Self.QHdrLength',Self.QHdrLength) 

            Self.BitConverter.St2.SetSlice(Self.QHdrLengthIndicatorPos, Self.QHdrLengthIndicatorPos + 3, Self.QHdrLengthStr)
            
            X# = 0
            LOOP Queue2Recs Times
                X# = X# + 1
                Get(Self.SomeQ,X#)
                Queue2Str = Self.SomeQ
                
                Self.F = 0
                Loop RecsClarionFields2 Times
                    Self.F = Self.F + 1
                    If Self.ClarionFieldsIsRefStr_Array[Self.F] = 0
                        CYCLE
                    End
                    Queue2Str[Self.ClarionFieldsClaStart_Array[Self.F] : Self.ClarionFieldsClaEnd_Array[Self.F]] = Self.Str8Zeroed
                End
                
                Self.BitConverter.St2.Append(Queue2Str)

                Queue2Str = Self.SomeQ                        
                
                Self.QVarsLength = 0
                Self.QVarsLengthIndicatorPos = Self.BitConverter.St2.Length() + 1
                
                Self.BitConverter.St2.Append(Self.QVarsLengthStr)
                
                Self.F = 0
                Loop RecsClarionFields2 Times
                    Self.F = Self.F + 1
                    If Self.ClarionFieldsIsRefStr_Array[Self.F] = 0
                        CYCLE
                    End
                    Self.GetPutStringFromRef(Queue2Str[Self.ClarionFieldsClaStart_Array[Self.F] : Self.ClarionFieldsClaEnd_Array[Self.F]], Self.BitConverter.St2, Self.QVarsLength)
                End
                !Self.QVarsLength = 77
                !!!!Self.Logger.AddLogLine('Self.QVarsLengthIndicatorPos', Self.QVarsLengthIndicatorPos)
                Self.BitConverter.St2.SetSlice(Self.QVarsLengthIndicatorPos, Self.QVarsLengthIndicatorPos + 3, Self.QVarsLengthStr)
            End
            Self.QBlockLength = Self.BitConverter.St2.Length() - Self.QBlockLengthIndicatorPos + 1
            Self.BitConverter.St2.SetSlice(Self.QBlockLengthIndicatorPos, Self.QBlockLengthIndicatorPos + 3, Self.QBlockLengthStr)
            
            Dispose(Self.TrueReflection2)
        Else
            Message('q ptr is 0')
        End
    End
    
    Self.BitConverter.St2.SaveFile('m:\log\SerializeQueue.txt')

    If omitted(_st) = False
        _st.Append(Self.BitConverter.St2.GetValue())
        Return ''
    Else
        Return Self.BitConverter.St2.GetValue()
    End

TrueReflectionClass.DeSerializeQueues               Procedure(*StringTheory _st)

QueueStr                    &String
Queue2Str                   &String
QueuePtr                    Long
RecsClarionFields2          Long
Queue2Size                  Long
Queue2Recs                  Long
StartPos                    Long
HeaderLine                  String(16000)
QueuePtrOver                String(4),over(QueuePtr)
I                           Long
!P                           Long
L                           Long
QHdr                        Group,Pre(QHdr)
QueueFields                     Long
QueueRecords                    Long
QueueRecordSize                 Long
QueueName                       cstring(128)
TypeName                        cstring(128)
QueuePtr                        Long
                            End
QToGo                       Long
ColonPos                    Long
SomeQueueRef                &QUEUE
ClarionFields               &ClarionFields_TYPE

FoundWithRecs               BOOL
SomeLong                    Long
SomeStrOverLong             String(4),over(someLong)
ParentQ                     &queue

Code


    !Self.Logger                &= NEW LoggerClass()
    !Self.Logger.Module          = 'TrueReflectionClass'
    !Self.Logger.MethodName      = 'DeSerializeQueue'
    !!Self.Logger.AddLogLine('START')
    
    !ParentQ &= _parentQ
    
!    ClarionFields &= NEW ClarionFields_TYPE()
!    Self.Analyze(Self.MachineQ, ClarionFields)
!    QueueStr &= NEW String(SIZE(Self.MachineQ))
!    Get(Self.MachineQ,1)
!    QueueStr = Self.MachineQ
    
!    Self.BitConverter.St1.Start()
!    Self.BitConverter.St1.SetValue(QueueStr)
!    Self.BitConverter.St1.SaveFile('m:\log\QueueStr.txt')
!    Return ''
    
    Self.BitConverter.St1.Start()
    Self.BitConverter.St2.Start()
    Self.BitConverter.St3.Start()

    Self.P = 1
    
l1  Loop !2 Times
        StartPos = Self.P
        If StartPos > _st.Length()
            BREAK
        End
        Self.QBlockLengthStr = _st.Slice(Self.P, Self.P + 3)
        !!!Self.Logger.AddLogLine('Self.QBlockLengthStr',Self.QBlockLength)
        Self.P = Self.P + 4
        
        Self.QHdrLengthStr = _st.Slice(Self.P, Self.P + 3)
        !!!Self.Logger.AddLogLine('Self.QHdrLength',Self.QHdrLength)
        Self.P = Self.P + 4
        
        Clear(QHdr)
        
        Self.BitConverter.St1.Start()
        Self.BitConverter.St1.Append(_st.Slice(Self.P , Self.P + Self.QHdrLength-1))
        
        Self.P = Self.P + Self.QHdrLength !+ 1
        
        !!!Self.Logger.AddLogLine('Hdr',Self.BitConverter.St1.GetValue())
        
        Self.BitConverter.St1.Split(',')
        
        I = 0
        Loop Records(Self.BitConverter.St1.lines) Times
            I = I + 1
            Get(Self.BitConverter.St1.lines,I)
            If Errorcode() <> 0
                BREAK
            End
            L = Len(Clip(Self.BitConverter.St1.lines.line))
            ColonPos = Instring(':',Clip(Self.BitConverter.St1.lines.line),1,1)
            If ColonPos < 1
                Message('header corrupt')
                CYCLE
            End
            If L < ColonPos + 1
                Message('header colpos corrupt')
                CYCLE
            End
            Case Self.BitConverter.St1.lines.line[1 : ColonPos]
            Of 'QueueName:'
                QHdr.QueueName          = Self.BitConverter.St1.lines.line[ColonPos + 1 : L]
                !!!Self.Logger.AddLogLine('QHdr.QueueName',QHdr.QueueName)
            Of 'TypeName:'
                QHdr.TypeName           = Self.BitConverter.St1.lines.line[ColonPos + 1 : L]
                !!!Self.Logger.AddLogLine('QHdr.QueueName',QHdr.QueueName)                
            Of 'QueuePtr:'
                QHdr.QueuePtr           = Self.BitConverter.St1.lines.line[ColonPos + 1 : L]
                !!!Self.Logger.AddLogLine('QHdr.QueuePtr',QHdr.QueuePtr)
            Of 'QueueFields:'
                QHdr.QueueFields        = Self.BitConverter.St1.lines.line[ColonPos + 1 : L]
                !!!Self.Logger.AddLogLine('QHdr.QueueFields',QHdr.QueueFields)
            Of 'QueueRecords:'
                QHdr.QueueRecords       = Self.BitConverter.St1.lines.line[ColonPos + 1 : L]
                !!!Self.Logger.AddLogLine('QHdr.QueueRecords',QHdr.QueueRecords)
            Of 'QueueRecordSize:'
                QHdr.QueueRecordSize    = Self.BitConverter.St1.lines.line[ColonPos + 1 : L]
                !!!Self.Logger.AddLogLine('QHdr.QueueRecordSize',QHdr.QueueRecordSize)
            End
        End
        
        Cycle
        
        
        SomeQueueRef &= Self.CreateQueueObject(QHdr.QueueName, QHdr.TypeName, True)
        
        If SomeQueueRef &= NULL
            CYCLE
        End      
        
        I = 0
        Loop Records(ClarionFields) Times
            I = I + 1
            Get(ClarionFields,I)
            If ClarionFields.Name <> QHdr.QueueName
                CYCLE
            End
            Self.QRefStr4 = QueueStr[ClarionFields.ClaOffset : ClarionFields.ClaOffsetEnd]
            !!Self.Logger.AddLogLine('Self.QRefLongOverStr4 ' , Self.QRefLongOverStr4)
!            If Self.MachineQ.BiosBoardCpu &= NULL
!                Message('error Self.MachineQ.BiosBoardCpu is null')
!            ELSE
!                Message('Self.MachineQ.BiosBoardCpu is not null, ok')
!            End
            
            !SomeQueueRef &= Self.MachineQ.BiosBoardCpu !(Self.QRefLongOverStr4)  !Self.GetQueueRefFromStr4(QueueStr[ClarionFields.ClaOffset : ClarionFields.ClaOffsetEnd])
            !Message('dat wel')
            Break
        End
        If 1 > 0 !not SomeQueueRef &= null
            Self.I2 = 0
            !!Self.Logger.AddLogLine('enum records' , ClarionFields.Name)
            
            Message('try')
            !Self.MachineQ &= NEW MachineQ_TYPE
            !Message('try2')
            !Add(Self.MachineQ)
            !Message('try3')
            !Self.MachineQ.BiosBoardCpu &= NEW BiosBoardCpu_TYPE
            !Message('try4')
            !Add(Self.MachineQ.BiosBoardCpu)
            !Get(Self.MachineQ.BiosBoardCpu,1)
            Message('try done')
            Loop QHdr.QueueRecords Times
                BREAK
                
                Self.I2 = Self.I2 + 1
               
                !Self.AddRowBytesToQueue(SomeQueueRef, _st, Self.P , Self.P + QHdr.QueueRecordSize - 1)
                
                !If Self.P =< (Self.P + QHdr.QueueRecordSize - 1)
                !    SomeQueueRef = _st.Slice(Self.P, Self.P + QHdr.QueueRecordSize - 1)
                    Add(SomeQueueRef)
                !End
!!!!                Self.BitConverter.St1.Start()
!!!!                Self.BitConverter.St1.SetValue(_st.Slice(Self.P , Self.P + QHdr.QueueRecordSize - 1))
!!!!                Self.BitConverter.St1.SaveFile('m:\log\' & ClarionFields.Name & '_record_' & Format(Self.I2,@N08) & '.txt') 
                
                Self.P = Self.P + QHdr.QueueRecordSize
                
!                Self.BitConverter.St1.Start()
!                Self.BitConverter.St1.SetValue(_st.Slice(Self.P , Self.P + 100))
!                Self.BitConverter.St1.SaveFile('m:\log\' & ClarionFields.Name & '_record_' & Format(Self.I2,@N08) & '_varlen.txt') 

                Self.QVarsLengthStr = _st.Slice(Self.P , Self.P + 3)
                Self.P = Self.P + 4
!                !!Self.Logger.AddLogLine('Self.QVarsLength: ' , Self.QVarsLength)
                ! enum String refs
                
                !-----------------
                Self.P = Self.P + Self.QVarsLength
                !!!Self.Logger.AddLogLine('Self.QVarsLength: ' , Self.QVarsLength)
                FoundWithRecs = true
            End
        ELSE
            !Message('error queue deser is null')
            !!!Self.Logger.AddLogLine(ClarionFields.Name & ' ERROR NOT OK QRef')
        End
        
        
        !SomeQueueRef &= null
        
        Self.P = StartPos + Self.QBlockLength !+ 1
        
        If FoundWithRecs
            !Break l1
        End
        !!!!!Self.Logger.AddLogLine('P, QBlockLength' , (P & ', ' & Self.QBlockLength & ', ' & P + Self.QBlockLength)
    End
    !!Self.Logger.AddLogLine('DONE')
    Return ''        
     
TrueReflectionClass.CreateQueueObject               Procedure(String _queueName, String _queueTypeName, <bool _free>)

QueueObject &c25QueueObjectClass
Found       BOOL

Code
    

!    If not !Self.Logger &= NULL
!        !Self.Logger &= NEW LoggerClass()
!    End
    
    !!Self.Logger.AddLogLine('START CreateQueueObject', _queueName & ', ' & _queueTypeName)

    Self.I = 0
    Loop
        Self.I = Self.I + 1
        Get(Self.QueueObjectsQ,Self.I)
        If Errorcode() <> 0
            BREAK
        End
        If Upper(_queueName) = Upper(Self.QueueObjectsQ.Name)
            If Self.QueueObjectsQ.QueueObjectPtr = 0
                Message('error Self.QueueObjectsQ.QueueObjectPtr = 0')
                Delete(Self.QueueObjectsQ)
            End
            QueueObject &= (Self.QueueObjectsQ.QueueObjectPtr)
            If omitted(_free) = False And _free = True
                If Records(QueueObject.Q) > 0
                    Free(QueueObject.Q)
                End
            End
            Found = True
            Break
        End
    End
    If Found = False
        Clear(Self.QueueObjectsQ)
        Self.QueueObjectsQ.Id = Self.GetNewId_QueueObjectsQ()
        Self.QueueObjectsQ.Name = Clip(Left(Self.QueueObjectsQ.Name))
        Self.QueueObjectsQ.TypeName = Clip(Left(_queueTypeName))
        QueueObject &= NEW c25QueueObjectClass()
        Self.QueueObjectsQ.QueueObjectPtr = Address(QueueObject)
        Add(Self.QueueObjectsQ)
        
        QueueObject.Q &= QueueObject.CreateClarionQueue()
        !Message('QueueObject.Q tot hier')
!        If not QueueObject.Q &= NULL
!            Message(QueueObject.Name)
!        ELSE
!            Message('QueueObject.Q is null error')
!        End
    End

    QueueObject &= null
    
    !!Self.Logger.AddLogLine('DONE CreateQueueObject', _queueName & ', ' & _queueTypeName)
    Return NULL

TrueReflectionClass.GetNewId_QueueObjectsQ          Procedure(<bool _isGlobal>)

I       Long
MaxId   Long

Code
        
    I = 0
    Loop
        I = I + 1
        Get(Self.QueueObjectsQ,I)
        If Errorcode() <> 0
            BREAK
        End
        If Self.QueueObjectsQ.Id > MaxId
            MaxId = Self.QueueObjectsQ.Id
        End
    End
    Return MaxId + 1
        