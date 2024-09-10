        Member

        Include('c25_WinMesObjectClass.inc'),Once

                    MAP
                        Include('CWUTIL.inc'),once
                        Include('i64.inc')
						Include('c25_WinApiPrototypes.inc')
                    End

c25_WinMesObjectClass.Destruct                                                    Procedure()

    Code


c25_WinMesObjectClass.Construct                                                   Procedure()

    Code

        Self.C25WinMes                  &= NEW C25WinMes_TYPE()
        Clear(Self.C25WinMes)
        Add(Self.C25WinMes)
        Self.C25WinMesAddress           = Address(Self.C25WinMes)
        Self.C25WinMesSizeAddress       = Address(Self.C25WinMesSize)
        Self.ProcessHeapHandle          = c25_GetProcessHeap()
        Self.BitConverterClass          &= NEW c25_BitConverterClass()
        Self.NanoClockClass             &= NEW c25_NanoSyncClass()

c25_WinMesObjectClass.GetC25WinMes   Procedure(long _address)

    CODE

        Self.GlobalAllocAddress = _address
        Clear(Self.C25WinMes)

        If C25_IsBadReadPtr(Self.GlobalAllocAddress, 4)
            Message('error c25_WinMesObjectClass.SetC25WinMes, C25_IsBadReadPtr')
            Return -1
        End
        C25_Memcpy(Self.C25WinMesSizeAddress, Self.GlobalAllocAddress, 4)
        If Self.C25WinMesSize <> C25WinMesStructureSize
            Message('error Self.C25WinMesSize <> C25WinMesStructureSize')
            Return -1
        End
        If C25_IsBadReadPtr(Self.GlobalAllocAddress, C25WinMesStructureSize)
            Message('error c25_WinMesObjectClass.SetC25WinMes, _address C25WinMesStructureSize')
            Return -1
        End
        C25_Memcpy(Self.C25WinMesAddress, Self.GlobalAllocAddress, C25WinMesStructureSize)
        Put(Self.C25WinMes)


        Return 0


c25_WinMesObjectClass.SetC25WinMes   Procedure()

    CODE

        Put(Self.C25WinMes)
        C25_Memcpy(Self.GlobalAllocAddress, Self.C25WinMesAddress, C25WinMesStructureSize)
        Return 0

