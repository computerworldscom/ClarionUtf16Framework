    Member()

        Map
        End

        Include('c25_GlobalMemClass.inc'), once

c25GlobalMemClass.Construct              Procedure()

    Code

        Self.GlobalMemPtr = 0
        Self.Log = 0

c25GlobalMemClass.Destruct       Procedure()

    Code
        
c25GlobalMemClass.RecordsClaQ                   Procedure(String _queueName)

CurrentQueueNameUpper                           cstring(256)

    Code
        
        CurrentQueueNameUpper = Upper(Clip(Left(_queueName)))
        
        Self.I = 0
        Self.R = Records(Self.SuperQueues)
        Loop Self.R Times
            Self.I = Self.I + 1
            Get(Self.SuperQueues,Self.I)
            If Self.SuperQueues.NameUpper <> CurrentQueueNameUpper
                CYCLE
            End
            If Self.SuperQueues.ThisQueue &= NULL
                Return 0
            End
            Return Records(Self.SuperQueues.ThisQueue)
        End
        Return 0

c25GlobalMemClass.PutClaQRecord                 Procedure(String _queueName, Long _index, *queue _q)

CurrentQueueNameUpper                           cstring(256)

    Code
        
        CurrentQueueNameUpper = Upper(Clip(Left(_queueName)))
        
        Self.I = 0
        Self.R = Records(Self.SuperQueues)
        Loop Self.R Times
            Self.I = Self.I + 1
            Get(Self.SuperQueues,Self.I)
            If Self.SuperQueues.NameUpper <> CurrentQueueNameUpper
                CYCLE
            End
            If Self.SuperQueues.ThisQueue &= NULL
                Return -1
            End
            
            Get(Self.SuperQueues.ThisQueue,_index)
            If Errorcode() <> 0
                Return -1
            End

            Self.SuperQueues.ThisQueue.RecordStr = _q
            Put(Self.SuperQueues.ThisQueue)
            Return 0
        End
        Return -1
        
c25GlobalMemClass.GetClaQRecord                 Procedure(String _queueName, Long _index, <*queue _q>, <String _where>)

CurrentQueueNameUpper                           cstring(256)

    Code
        
        CurrentQueueNameUpper = Upper(Clip(Left(_queueName)))
        
        Self.I = 0
        Self.R = Records(Self.SuperQueues)
       
        If omitted(_index) = False
            Loop Self.R Times
                Self.I = Self.I + 1
                Get(Self.SuperQueues,Self.I)

                If Self.SuperQueues.NameUpper <> CurrentQueueNameUpper
                    CYCLE
                End
                If Self.SuperQueues.ThisQueue &= NULL
                    Return -1
                End
                
                Get(Self.SuperQueues.ThisQueue,_index)
                If Errorcode() <> 0
                    Return -1
                End
                If omitted(_q) = False
                    _q = Self.SuperQueues.ThisQueue.RecordStr
                    Return Self.I
                ELSE
                    Return Self.SuperQueues.ThisQueue.RecordStr
                End
            End
            Return -1
        ElsIf omitted(_where) = False
!            Self.St1.Start()
!            Self.St1.SetValue(_where)
!            Self.St1.Split(',')
!            
!            Self.Free_WhereValues()
!            
!            I# = 0
!            LOOP
!                I# = I# + 1
!                Get(WhereValues
!!            
!            Loop Self.R Times
!                Self.I = Self.I + 1
!                Get(Self.SuperQueues,Self.I)
!
!                If Self.SuperQueues.NameUpper <> CurrentQueueNameUpper
!                    CYCLE
!                End
!                If Self.SuperQueues.ThisQueue &= NULL
!                    Return -1
!                End
!                
!                Get(Self.SuperQueues.ThisQueue,_index)
!                If Errorcode() <> 0
!                    Return -1
!                End
!                If omitted(_q) = False
!                    _q = Self.SuperQueues.ThisQueue.RecordStr
!                    Return Self.I
!                ELSE
!                    Return Self.SuperQueues.ThisQueue.RecordStr
!                End
!            End
            Return -1
        End
      
c25GlobalMemClass.Free_WhereValues  Procedure()

    Code
    
        I# = 0
        LOOP
            I# = I# + 1
            Get(Self.WhereValues,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Not Self.WhereValues.Key &= NULL
                Dispose(Self.WhereValues.Key)
            End
            If Not Self.WhereValues.Value &= NULL
                Dispose(Self.WhereValues.Value)
            End
            Put(Self.WhereValues)
        End
        Free(Self.WhereValues)
        
        
        
c25GlobalMemClass.FillClaQ                  Procedure(String _queueName, *queue _q)

CurrentQueueNameUpper                       cstring(256)

    Code
        
        CurrentQueueNameUpper = Upper(Clip(Left(_queueName)))
        
        Self.I = 0
        Self.R = Records(Self.SuperQueues)
        Loop Self.R Times
            Self.I = Self.I + 1
            Get(Self.SuperQueues,Self.I)
            If Self.SuperQueues.NameUpper <> CurrentQueueNameUpper
                CYCLE
            End
            If Self.SuperQueues.ThisQueue &= NULL
                Return -1
            End
            
            Free(_q)
            
            Self.I = 0
            Self.R = Records(Self.SuperQueues.ThisQueue)
            Loop Self.R Times
                Self.I = Self.I + 1
                Get(Self.SuperQueues.ThisQueue,Self.I)
                _q = Self.SuperQueues.ThisQueue.RecordStr
                Add(_q)
            End
            Break
        End
        
        Return 0


c25GlobalMemClass.CreateSuperQueue          Procedure(String _queueName, <*queue _q>, <bool _overwrite>)

TrueReflection                              &TrueReflectionClass
CurrentQueueNameUpper                       cstring(256)
FoundExisting                               BOOL
!BytesHandler                                &BytesHandlerClass

    Code
        

        !BytesHandler &= NEW BytesHandlerClass()
        CurrentQueueNameUpper = Upper(Clip(Left(_queueName)))
        
        Self.I = 0
        Self.R = Records(Self.SuperQueues)
        Loop Self.R Times
            Self.I = Self.I + 1
            Get(Self.SuperQueues,Self.I)
            If Self.SuperQueues.NameUpper <> CurrentQueueNameUpper
                CYCLE
            End
            If omitted(_overwrite) = True Or _overwrite = False
                Return Self.I
            End
            If omitted(_overwrite) = False And _overwrite = True
                If not Self.SuperQueues.ThisQueue &= NULL
                    Dispose(Self.SuperQueues.ThisQueue)
                    Put(Self.SuperQueues)
                End
            End
            FoundExisting = True
            Break
        End
        
        If _overwrite = True And FoundExisting = True
            Return -2
        End
        
        If FoundExisting = False Or _overwrite = False
            Clear(Self.SuperQueues)

            Self.SuperQueues.Name           &= NEW String(Len(_queueName))
            Self.SuperQueues.Name           = _queueName
            
            Self.SuperQueues.NameUpper      &= NEW String(Len(_queueName))
            Self.SuperQueues.NameUpper      = Upper(Clip(Left(_queueName)))

            
            Self.SuperQueues.ThisQueue      &= NEW ThisQueue_TYPE()
            Self.SuperQueuesSeedId           = Self.SuperQueuesSeedId + 1
            Self.SuperQueues.Id              = Self.SuperQueuesSeedId
            Add(Self.SuperQueues)
        Else
            Self.SuperQueues.ThisQueue      &= NEW ThisQueue_TYPE()
            Put(Self.SuperQueues)
        End
        
        If omitted(_q) = False
            
            Self.SuperQueues.ClaQueueAddress = Address(_q)
            Self.SuperQueues.RecordSize = Size(_q)
            
            TrueReflection &= NEW TrueReflectionClass()
            TrueReflection.Analyze(_q, Self.SuperQueues.ClaFields)
            Dispose(TrueReflection)
            
            Self.I = 0
            Self.R = Records(_q)
            Loop Self.R TIMES
                Self.I = Self.I  + 1
                Get(_q,Self.I)
                Self.SuperQueues.ThisQueue.RecordStr &= NEW String(Self.SuperQueues.RecordSize)
                Self.SuperQueues.ThisQueue.RecordStr = _q
                Self.SuperQueues.ThisQueue.Index = Self.I
                Add(Self.SuperQueues.ThisQueue)
            End
            Get(Self.SuperQueues.ThisQueue,1)
        End
        Put(Self.SuperQueues)

        Return Pointer(Self.SuperQueues)
        
  
c25GlobalMemClass.CreateOnce       Procedure()

    Code

        Self.BytesHandler           &= NEW BytesHandlerClass()
        Self.DevicePropDefQ         &= NEW DevicePropDef_TYPE()
        Self.DevicePropertyCodeQ    &= NEW DevicePropertyCode_TYPE()
        Self.Dictionary             &= NEW Dictionary_TYPE()
        Self.NanoSync               &= NEW NanoSyncClass()
        Self.st1                    &= NEW StringTheory()
        Self.st2                    &= NEW StringTheory()
        Self.stLog                  &= NEW StringTheory()
        Self.SuperQueues            &= NEW SuperQueues_TYPE
        Self.SystemClassesQ         &= NEW SystemClasses_TYPE()
        
        Return 0

c25GlobalMemClass.SetGlobalDictionaryValue    Procedure(String _key,String _value)

ReplaceMemRef   &String
ReplaceMemRef2  &String

    Code

        If Self.Dictionary &= NULL
            Self.Dictionary &= NEW Dictionary_TYPE()
        End
        I# = 0
        Loop
            I# = I# + 1
            Get(Self.Dictionary,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Self.Dictionary.Key &= NULL
                CYCLE
            End
            If Upper(clip(Self.Dictionary.Key)) = Upper(clip(_key))

                If not Self.Dictionary.Value &= null
                    If Size(_value) < 1
                        ReplaceMemRef2          &= Self.Dictionary.Value
                        ReplaceMemRef           &= NEW String(1)
                        Self.Dictionary.Value   &= ReplaceMemRef
                        Dispose(ReplaceMemRef2)
                    Else
                        Self.Dictionary.Value &= NEW String(Size(_value))
                        Self.Dictionary.Value = _value
                    End
                Else
                    If Size(_value) < 1
                        Self.Dictionary.Value &= NULL
                    Else
                        Self.Dictionary.Value &= NEW String(Size(_value))
                        Self.Dictionary.Value = _value
                    End
                End
                Put(Self.Dictionary)
                Return Self.Dictionary.Value
            End
        End

        If Size(_value) > 0
            Self.Dictionary.Value &= NEW String(Size(_value))
            Self.Dictionary.Value = _value
        ELSE
            Self.Dictionary.Value &= NULL
        End
        If Size(_key) > 0
            Self.Dictionary.Key &= NEW String(Size(_key))
            Self.Dictionary.Key = Clip(_key)
            Add(Self.Dictionary)
            Return Self.Dictionary.Value
        End
        Return ''

c25GlobalMemClass.GetGlobalDictionaryValue    Procedure(String _key, <String _valueIfNull>)

    Code

        If Self.Dictionary &= NULL
            Message('error GetGlobalDictionaryValue Self.Dictionary &= NULL')
            Return ''
        End

        I# = 0
        Loop
            I# = I# + 1
            Get(Self.Dictionary,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Self.Dictionary.Key &= NULL
                CYCLE
            End
            If Upper(clip(Self.Dictionary.Key)) = Upper(clip(_key))
                If not Self.Dictionary.Value &= null

                    Return Self.Dictionary.Value
                ELSE
                    If omitted(_valueIfNull) = False
                        Return _valueIfNull
                    End
                    Return ''
                End
            End
        End
        If omitted(_valueIfNull) = False
            Return _valueIfNull
        End
        Return ''

c25GlobalMemClass.RemoveGlobalDictionaryValue    Procedure(String _key, <Byte _caseSensitive>)

    Code

        If Self.Dictionary &= NULL
            Message('error GetGlobalDictionaryValue Self.Dictionary &= NULL')
            Return ''
        End
        I# = 0
        Loop
            I# = I# + 1
            Get(Self.Dictionary,I#)
            If Errorcode() <> 0
                BREAK
            End
            If Self.Dictionary.Key &= NULL
                CYCLE
            End
            If _caseSensitive = True
                If clip(Self.Dictionary.Key) = clip(_key)
                    DELETE(Self.Dictionary)
                    Return ''
                End
            ELSE
                If Upper(clip(Self.Dictionary.Key)) = Upper(clip(_key))
                    DELETE(Self.Dictionary)
                    Return ''
                End
            End
        End
        Return ''

