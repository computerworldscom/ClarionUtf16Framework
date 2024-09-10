    Include('c25_ProgramHandlerClass.inc'),Once
    Include('c25_ExtendedDataTypes.inc'),Once

c25_DataColumnClass                                                     Class(),type,Module('c25_DataColumnClass.clw'), Link('c25_DataColumnClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                                                                   Procedure()
Destruct                                                                    Procedure()

AllowDBNull                                                                 BOOL
AutoIncrement                                                               BOOL
AutoIncrementSeed                                                           Like(INT64)
AutoIncrementStep                                                           Like(INT64)
ClaQStor_DataAllocSize                                                      LONG
ClaQStor_DataTypeEnum                                                       LONG
ClaQStor_DllOffset                                                          LONG
ClaQStor_DllSetInfoLength                                                   LONG
ClaQStor_DllSetInfoTrailingLength                                           LONG
ClaQStor_OffsetEnd                                                          LONG
ClaQStor_OffsetStart                                                        LONG
ClaQStor_OffsetSize                                                         LONG
!ColumnMapping                                                               LONG
DataTypeEnum                                                                LONG
SourceDataTypeEnum                                                          LONG
DateTimeMode                                                                long
DefaultValuePtr                                                             LONG
DefaultValueSize                                                            LONG
Disabled                                                                    BOOL
MaxLength                                                                   LONG
Ordinal                                                                     LONG
ReadOnly                                                                    BOOL
TablePtr                                                                    LONG
FormatTypeEnum                                                              LONG ! todo, numeric, currency etc, move to new FormatCla
SourceIsRefPtr                                                              BOOL


SpecialColumnType                                                           LONG


DefaultValue                                                                &c25_ValueObjectClass

ObjectValue                                                                 &c25_ObjectClass ! legacy for DLL use etc

DataColumnsCollectionClass                                                  &c25_DataColumnsCollectionClass
ProgramHandlerClass                                                         &c25_ProgramHandlerClass
DataSourceClass                                                             &c25_DataSourceClass

Label                                                                       &String
Caption                                                                     &String
ClaQStor_DataType                                                           &STRING
ClaQStor_DllSetInfo                                                         &STRING
ClaQStor_DllSetInfoTrailing                                                 &STRING
ClaQStor_FieldName                                                          &STRING
DataLength                                                                  &STRING
DataType                                                                    &STRING
Expression                                                                  &STRING
ExtendedProperties                                                          &PropertyCollection_TYPE
Name                                                                        &STRING
NameUpper                                                                   &STRING
Namespace                                                                   &STRING
Prefix                                                                      &STRING

SourceOffsetStart                                                           LONG
SourceOffsetEnd                                                             LONG
SourceOffsetSize                                                            LONG

Init                                                                        Procedure(*c25_DataColumnsCollectionClass _dataColumnsCollectionClass),long,PROC
                                                                        End


