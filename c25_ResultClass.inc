    Include('c25_ProgramHandlerClass.inc'),Once
    Include('c25_ExtendedDataTypes.inc'),Once

c25_ResultClass           	                                            Class(),type,Module('c25_ResultClass.clw'), Link('c25_ResultClass.clw',_ABCLinkMode_),DLL(_ABCDllMode_)
Construct                                                                   Procedure()
Destruct                                                                    Procedure()

ValueObject                                                                 &c25_ObjectClass
Reset                                                                       Procedure()
                                                                        End


