        Member

            Include('c25_MachineClass.inc'),once
            Include('c25_Sqlite34Class.inc'),once
            Include('c25_NanoSyncClass.inc'),once
            Include('c25_TrueReflectionClass.inc'),once
            Include('c25_WinApi32Class.inc'),once
            Include('c25_WinNT_Errorcode_Equates.clw'),ONCE

            Include('windows.inc'),once
            Map
                Include('c25_Prototypes_WinApi32.clw')
                Include('c25_Prototypes_Sqlite3.clw')
                Include('i64.inc')
            End

MachineClass.Construct                    Procedure()

    Code

        Self.Logger &= NEW LoggerClass()
        Self.Logger.Module = 'MachineClass'
        Self.Logger.AddLogLine('MachineClass.Construct')
        Self.Buffer &= NULL
        Self.Buffer2MBAddress = Address(Self.Buffer2MB)
        Self.CRLF = Chr(13) & Chr(10)
        Self.Devices &= NEW Device_TYPE
        Self.DevicePropDef &= NEW DevicePropDef_TYPE()
        Self.DeviceProperties &= NEW DeviceProperties_TYPE
        Self.DevicePropertyGuids &= NEW DevicePropertyGuids_TYPE()
        Self.DPK_BASE_STRING_LIST &= NEW DPK_BASE_STRING_LIST_TYPE()
        Self.js1 &= NEW JSONClass()
        Self.NanoClock &= NEW NanoSyncClass()
        Self.st1 &= NEW StringTheory()
        Self.st2 &= NEW StringTheory()
        Self.st3 &= NEW StringTheory()
        Self.st4 &= NEW StringTheory()
        Self.st5 &= NEW StringTheory()
        Self.WinApi &= NEW WinApi32Class()
        Self.WinObject &= NEW WinObject_TYPE()
        Self.Zero = Chr(0)
        Self.Zero2 = Chr(0) & Chr(0)
        Self.CreateHardwareObjects()
        Self.Logger.AddLogLine('DONE MachineClass.Construct')

MachineClass.Destruct                     Procedure()

    Code

MachineClass.GetBiosPage001Count    Procedure()
    Code

    If Self.BiosPage001 &= NULL
        Return 0
    ELSE
        Return Records(Self.BiosPage001)
    End

MachineClass.CreateHardwareObjects  Procedure()

    Code

        Self.MachineAsQueue &= NEW Machine_TYPE
        Clear(Self.Machine)

        Self.BiosBoardCpu &= NEW BiosBoardCpu_TYPE
        Self.BiosPage000 &= NEW BiosPage000_TYPE
        Self.BiosPage001 &= NEW BiosPage001_TYPE
        Self.BiosPage002 &= NEW BiosPage002_TYPE
        Self.BiosPage003 &= NEW BiosPage003_TYPE
        Self.BiosPage004 &= NEW BiosPage004_TYPE
        Self.BiosPage005 &= NEW BiosPage005_TYPE
        Self.BiosPage006 &= NEW BiosPage006_TYPE
        Self.BiosPage007 &= NEW BiosPage007_TYPE
        Self.BiosPage008 &= NEW BiosPage008_TYPE
        Self.BiosPage009 &= NEW BiosPage009_TYPE
        Self.BiosPage010 &= NEW BiosPage010_TYPE
        Self.BiosPage011 &= NEW BiosPage011_TYPE
        Self.BiosPage012 &= NEW BiosPage012_TYPE
        Self.BiosPage013 &= NEW BiosPage013_TYPE
        Self.BiosPage014 &= NEW BiosPage014_TYPE
        Self.BiosPage015 &= NEW BiosPage015_TYPE
        Self.BiosPage016 &= NEW BiosPage016_TYPE
        Self.BiosPage017 &= NEW BiosPage017_TYPE
        Self.BiosPage018 &= NEW BiosPage018_TYPE
        Self.BiosPage019 &= NEW BiosPage019_TYPE
        Self.BiosPage020 &= NEW BiosPage020_TYPE
        Self.BiosPage021 &= NEW BiosPage021_TYPE
        Self.BiosPage022 &= NEW BiosPage022_TYPE
        Self.BiosPage023 &= NEW BiosPage023_TYPE
        Self.BiosPage024 &= NEW BiosPage024_TYPE
        Self.BiosPage025 &= NEW BiosPage025_TYPE
        Self.BiosPage026 &= NEW BiosPage026_TYPE
        Self.BiosPage027 &= NEW BiosPage027_TYPE
        Self.BiosPage028 &= NEW BiosPage028_TYPE
        Self.BiosPage029 &= NEW BiosPage029_TYPE
        Self.BiosPage030 &= NEW BiosPage030_TYPE
        Self.BiosPage031 &= NEW BiosPage031_TYPE
        Self.BiosPage032 &= NEW BiosPage032_TYPE
        Self.BiosPage033 &= NEW BiosPage033_TYPE
        Self.BiosPage034 &= NEW BiosPage034_TYPE
        Self.BiosPage035 &= NEW BiosPage035_TYPE
        Self.BiosPage036 &= NEW BiosPage036_TYPE
        Self.BiosPage037 &= NEW BiosPage037_TYPE
        Self.BiosPage038 &= NEW BiosPage038_TYPE
        Self.BiosPage039 &= NEW BiosPage039_TYPE
        Self.BiosPage040 &= NEW BiosPage040_TYPE
        Self.BiosPage041 &= NEW BiosPage041_TYPE
        Self.BiosPage042 &= NEW BiosPage042_TYPE
        Self.BiosPage043 &= NEW BiosPage043_TYPE
        Self.BiosPage044 &= NEW BiosPage044_TYPE
        Self.BiosPage045 &= NEW BiosPage045_TYPE
        Self.BiosPage046 &= NEW BiosPage046_TYPE
        Self.BiosPage126 &= NEW BiosPage126_TYPE
        Self.BiosPage127 &= NEW BiosPage127_TYPE
        Self.BiosPages &= NEW BiosPages_TYPE
        Self.BiosRaw &= NEW BiosRaw_TYPE
        Self.BiosTypes &= NEW BiosTypes_TYPE()
        Self.Devices &= NEW Device_TYPE()

        include('Hardware_DVNEW.clw'),once

        Self.FullMachineQ  &= NEW MachineQ_TYPE

        Return 0

MachineClass.DisposeHardwareObjects         Procedure()

    Code

    Return 0

MachineClass.Init                         Procedure(<Long _machineId>,<Long _connHandle>,<Long _dbEngineType>)

    Code

        Self.Logger.AddLogLine('START MachineClass.Init')
        Self.DbEngineType = DbEngineType:Sqlite3
        If omitted(_dbEngineType) = False
            Self.DbEngineType = _dbEngineType
        End
        Case Self.DbEngineType
        Of DbEngineType:Sqlite3
            If Self.Sqlite34 &= NULL
                Self.Sqlite34 &= NEW Sqlite34Class()
            End
        End
        If omitted(_connHandle) = False
            Case Self.DbEngineType
            Of DbEngineType:Sqlite3
                Self.Sqlite34.ConnHandle = _connHandle
            End
        End
        If omitted(_machineId) = False
            Self.Id = _machineId
            Self.GetMachine()
            Self.GetBiosFromMachine()
            Self.GetDevicesFromMachine()
            Self.GetWinObjectsFromMachine()
        End
        Self.ReferenceFullMachineQ()
        Self.Logger.AddLogLine('DONE MachineClass.Init')
        Return 0

MachineClass.ReferenceFullMachineQ            Procedure()

    Code

        Self.Logger.AddLogLine('START MachineClass.ReferenceFullMachineQ')
        Clear(Self.FullMachineQ)
        Self.FullMachineQ.Id                                            = Self.Id
        Self.FullMachineQ.BiosBoardCpu                                    &= Self.BiosBoardCpu
        Self.FullMachineQ.BiosPage000                                     &= Self.BiosPage000
        Self.FullMachineQ.BiosPage001                                     &= Self.BiosPage001
        Self.FullMachineQ.BiosPage002                                     &= Self.BiosPage002
        Self.FullMachineQ.BiosPage003                                     &= Self.BiosPage003
        Self.FullMachineQ.BiosPage004                                     &= Self.BiosPage004
        Self.FullMachineQ.BiosPage005                                     &= Self.BiosPage005
        Self.FullMachineQ.BiosPage006                                     &= Self.BiosPage006
        Self.FullMachineQ.BiosPage007                                     &= Self.BiosPage007
        Self.FullMachineQ.BiosPage008                                     &= Self.BiosPage008
        Self.FullMachineQ.BiosPage009                                     &= Self.BiosPage009
        Self.FullMachineQ.BiosPage010                                     &= Self.BiosPage010
        Self.FullMachineQ.BiosPage011                                     &= Self.BiosPage011
        Self.FullMachineQ.BiosPage012                                     &= Self.BiosPage012
        Self.FullMachineQ.BiosPage013                                     &= Self.BiosPage013
        Self.FullMachineQ.BiosPage014                                     &= Self.BiosPage014
        Self.FullMachineQ.BiosPage015                                     &= Self.BiosPage015
        Self.FullMachineQ.BiosPage016                                     &= Self.BiosPage016
        Self.FullMachineQ.BiosPage017                                     &= Self.BiosPage017
        Self.FullMachineQ.BiosPage018                                     &= Self.BiosPage018
        Self.FullMachineQ.BiosPage019                                     &= Self.BiosPage019
        Self.FullMachineQ.BiosPage020                                     &= Self.BiosPage020
        Self.FullMachineQ.BiosPage021                                     &= Self.BiosPage021
        Self.FullMachineQ.BiosPage022                                     &= Self.BiosPage022
        Self.FullMachineQ.BiosPage023                                     &= Self.BiosPage023
        Self.FullMachineQ.BiosPage024                                     &= Self.BiosPage024
        Self.FullMachineQ.BiosPage025                                     &= Self.BiosPage025
        Self.FullMachineQ.BiosPage026                                     &= Self.BiosPage026
        Self.FullMachineQ.BiosPage027                                     &= Self.BiosPage027
        Self.FullMachineQ.BiosPage028                                     &= Self.BiosPage028
        Self.FullMachineQ.BiosPage029                                     &= Self.BiosPage029
        Self.FullMachineQ.BiosPage030                                     &= Self.BiosPage030
        Self.FullMachineQ.BiosPage031                                     &= Self.BiosPage031
        Self.FullMachineQ.BiosPage032                                     &= Self.BiosPage032
        Self.FullMachineQ.BiosPage033                                     &= Self.BiosPage033
        Self.FullMachineQ.BiosPage034                                     &= Self.BiosPage034
        Self.FullMachineQ.BiosPage035                                     &= Self.BiosPage035
        Self.FullMachineQ.BiosPage036                                     &= Self.BiosPage036
        Self.FullMachineQ.BiosPage037                                     &= Self.BiosPage037
        Self.FullMachineQ.BiosPage038                                     &= Self.BiosPage038
        Self.FullMachineQ.BiosPage039                                     &= Self.BiosPage039
        Self.FullMachineQ.BiosPage040                                     &= Self.BiosPage040
        Self.FullMachineQ.BiosPage041                                     &= Self.BiosPage041
        Self.FullMachineQ.BiosPage042                                     &= Self.BiosPage042
        Self.FullMachineQ.BiosPage043                                     &= Self.BiosPage043
        Self.FullMachineQ.BiosPage044                                     &= Self.BiosPage044
        Self.FullMachineQ.BiosPage045                                     &= Self.BiosPage045
        Self.FullMachineQ.BiosPage046                                     &= Self.BiosPage046
        Self.FullMachineQ.BiosPage126                                     &= Self.BiosPage126
        Self.FullMachineQ.BiosPage127                                     &= Self.BiosPage127
        Self.FullMachineQ.BiosPages                                       &= Self.BiosPages
        Self.FullMachineQ.BiosRaw                                         &= Self.BiosRaw
        Self.FullMachineQ.BiosTypes                                       &= Self.BiosTypes
        Self.FullMachineQ.Devices                                          &= Self.Devices
        Self.FullMachineQ.DeviceProperties                                &= Self.DeviceProperties
        Self.FullMachineQ.DPK_AdditionalSoftwareRequested                              &= Self.DPK_AdditionalSoftwareRequested
        Self.FullMachineQ.DPK_Address                                                  &= Self.DPK_Address
        Self.FullMachineQ.DPK_AssignedToGuest                                          &= Self.DPK_AssignedToGuest
        Self.FullMachineQ.DPK_BaseContainerId                                          &= Self.DPK_BaseContainerId
        Self.FullMachineQ.DPK_BiosDeviceName                                           &= Self.DPK_BiosDeviceName
        Self.FullMachineQ.DPK_BusNumber                                                &= Self.DPK_BusNumber
        Self.FullMachineQ.DPK_BusRelations                                             &= Self.DPK_BusRelations
        Self.FullMachineQ.DPK_BusReportedDeviceDesc                                    &= Self.DPK_BusReportedDeviceDesc
        Self.FullMachineQ.DPK_BusTypeGuid                                              &= Self.DPK_BusTypeGuid
        Self.FullMachineQ.DPK_Capabilities                                             &= Self.DPK_Capabilities
        Self.FullMachineQ.DPK_Characteristics                                          &= Self.DPK_Characteristics
        Self.FullMachineQ.DPK_Children                                                 &= Self.DPK_Children
        Self.FullMachineQ.DPK_Class                                                    &= Self.DPK_Class
        Self.FullMachineQ.DPK_ClassGuid                                                &= Self.DPK_ClassGuid
        Self.FullMachineQ.DPK_CompatibleIds                                            &= Self.DPK_CompatibleIds
        Self.FullMachineQ.DPK_ConfigFlags                                              &= Self.DPK_ConfigFlags
        Self.FullMachineQ.DPK_ConfigurationId                                          &= Self.DPK_ConfigurationId
        Self.FullMachineQ.DPK_Container_Address                                        &= Self.DPK_Container_Address
        Self.FullMachineQ.DPK_Container_AlwaysShowDeviceAsConnected                    &= Self.DPK_Container_AlwaysShowDeviceAsConnected
        Self.FullMachineQ.DPK_Container_AssociationArray                               &= Self.DPK_Container_AssociationArray
        Self.FullMachineQ.DPK_Container_BaselineExperienceId                           &= Self.DPK_Container_BaselineExperienceId
        Self.FullMachineQ.DPK_Container_Category                                       &= Self.DPK_Container_Category
        Self.FullMachineQ.DPK_Container_Category_Desc_Plural                           &= Self.DPK_Container_Category_Desc_Plural
        Self.FullMachineQ.DPK_Container_Category_Desc_Singular                         &= Self.DPK_Container_Category_Desc_Singular
        Self.FullMachineQ.DPK_Container_Category_Icon                                  &= Self.DPK_Container_Category_Icon
        Self.FullMachineQ.DPK_Container_CategoryGroup_Desc                             &= Self.DPK_Container_CategoryGroup_Desc
        Self.FullMachineQ.DPK_Container_CategoryGroup_Icon                             &= Self.DPK_Container_CategoryGroup_Icon
        Self.FullMachineQ.DPK_Container_ConfigFlags                                    &= Self.DPK_Container_ConfigFlags
        Self.FullMachineQ.DPK_Container_CusPrivPackFamNames                            &= Self.DPK_Container_CusPrivPackFamNames
        Self.FullMachineQ.DPK_Container_DeviceDescription1                             &= Self.DPK_Container_DeviceDescription1
        Self.FullMachineQ.DPK_Container_DeviceDescription2                             &= Self.DPK_Container_DeviceDescription2
        Self.FullMachineQ.DPK_Container_DeviceFunctionSubRank                          &= Self.DPK_Container_DeviceFunctionSubRank
        Self.FullMachineQ.DPK_Container_DiscoveryMethod                                &= Self.DPK_Container_DiscoveryMethod
        Self.FullMachineQ.DPK_Container_ExperienceId                                   &= Self.DPK_Container_ExperienceId
        Self.FullMachineQ.DPK_Container_FriendlyName                                   &= Self.DPK_Container_FriendlyName
        Self.FullMachineQ.DPK_Container_HasProblem                                     &= Self.DPK_Container_HasProblem
        Self.FullMachineQ.DPK_Container_Icon                                           &= Self.DPK_Container_Icon
        Self.FullMachineQ.DPK_Container_InstallInProgress                              &= Self.DPK_Container_InstallInProgress
        Self.FullMachineQ.DPK_Container_IsAuthenticated                                &= Self.DPK_Container_IsAuthenticated
        Self.FullMachineQ.DPK_Container_IsConnected                                    &= Self.DPK_Container_IsConnected
        Self.FullMachineQ.DPK_Container_IsDefaultDevice                                &= Self.DPK_Container_IsDefaultDevice
        Self.FullMachineQ.DPK_Container_IsDeviceUniquelyIdentifiable                   &= Self.DPK_Container_IsDeviceUniquelyIdentifiable
        Self.FullMachineQ.DPK_Container_IsEncrypted                                    &= Self.DPK_Container_IsEncrypted
        Self.FullMachineQ.DPK_Container_IsLocalMachine                                 &= Self.DPK_Container_IsLocalMachine
        Self.FullMachineQ.DPK_Container_IsMetadataSearchInProgress                     &= Self.DPK_Container_IsMetadataSearchInProgress
        Self.FullMachineQ.DPK_Container_IsNetworkDevice                                &= Self.DPK_Container_IsNetworkDevice
        Self.FullMachineQ.DPK_Container_IsNotInterestingForDisplay                     &= Self.DPK_Container_IsNotInterestingForDisplay
        Self.FullMachineQ.DPK_Container_IsPaired                                       &= Self.DPK_Container_IsPaired
        Self.FullMachineQ.DPK_Container_IsRebootRequired                               &= Self.DPK_Container_IsRebootRequired
        Self.FullMachineQ.DPK_Container_IsSharedDevice                                 &= Self.DPK_Container_IsSharedDevice
        Self.FullMachineQ.DPK_Container_IsShowInDisconnectedState                      &= Self.DPK_Container_IsShowInDisconnectedState
        Self.FullMachineQ.DPK_Container_Last_Connected                                 &= Self.DPK_Container_Last_Connected
        Self.FullMachineQ.DPK_Container_Last_Seen                                      &= Self.DPK_Container_Last_Seen
        Self.FullMachineQ.DPK_Container_LaunchDeviceStageFromExplorer                  &= Self.DPK_Container_LaunchDeviceStageFromExplorer
        Self.FullMachineQ.DPK_Container_LaunchDeviceStageOnDeviceConnect               &= Self.DPK_Container_LaunchDeviceStageOnDeviceConnect
        Self.FullMachineQ.DPK_Container_Manufacturer                                   &= Self.DPK_Container_Manufacturer
        Self.FullMachineQ.DPK_Container_MetadataCabinet                                &= Self.DPK_Container_MetadataCabinet
        Self.FullMachineQ.DPK_Container_MetadataChecksum                               &= Self.DPK_Container_MetadataChecksum
        Self.FullMachineQ.DPK_Container_MetadataPath                                   &= Self.DPK_Container_MetadataPath
        Self.FullMachineQ.DPK_Container_ModelName                                      &= Self.DPK_Container_ModelName
        Self.FullMachineQ.DPK_Container_ModelNumber                                    &= Self.DPK_Container_ModelNumber
        Self.FullMachineQ.DPK_Container_PrimaryCategory                                &= Self.DPK_Container_PrimaryCategory
        Self.FullMachineQ.DPK_Container_PrivilegedPackageFamilyNames                   &= Self.DPK_Container_PrivilegedPackageFamilyNames
        Self.FullMachineQ.DPK_Container_RequiresPairingElevation                       &= Self.DPK_Container_RequiresPairingElevation
        Self.FullMachineQ.DPK_Container_RequiresUninstallElevation                     &= Self.DPK_Container_RequiresUninstallElevation
        Self.FullMachineQ.DPK_Container_UnpairUninstall                                &= Self.DPK_Container_UnpairUninstall
        Self.FullMachineQ.DPK_Container_Version                                        &= Self.DPK_Container_Version
        Self.FullMachineQ.DPK_ContainerId                                              &= Self.DPK_ContainerId
        Self.FullMachineQ.DPK_CreatorProcessId                                         &= Self.DPK_CreatorProcessId
        Self.FullMachineQ.DPK_DC_Characteristics                                       &= Self.DPK_DC_Characteristics
        Self.FullMachineQ.DPK_DC_ClassCoInstallers                                     &= Self.DPK_DC_ClassCoInstallers
        Self.FullMachineQ.DPK_DC_ClassInstaller                                        &= Self.DPK_DC_ClassInstaller
        Self.FullMachineQ.DPK_DC_ClassName                                             &= Self.DPK_DC_ClassName
        Self.FullMachineQ.DPK_DC_DefaultService                                        &= Self.DPK_DC_DefaultService
        Self.FullMachineQ.DPK_DC_DevType                                               &= Self.DPK_DC_DevType
        Self.FullMachineQ.DPK_DC_DHPRebalanceOptOut                                    &= Self.DPK_DC_DHPRebalanceOptOut
        Self.FullMachineQ.DPK_DC_Exclusive                                             &= Self.DPK_DC_Exclusive
        Self.FullMachineQ.DPK_DC_Icon                                                  &= Self.DPK_DC_Icon
        Self.FullMachineQ.DPK_DC_IconPath                                              &= Self.DPK_DC_IconPath
        Self.FullMachineQ.DPK_DC_LowerFilters                                          &= Self.DPK_DC_LowerFilters
        Self.FullMachineQ.DPK_DC_Name                                                  &= Self.DPK_DC_Name
        Self.FullMachineQ.DPK_DC_NoDisplayClass                                        &= Self.DPK_DC_NoDisplayClass
        Self.FullMachineQ.DPK_DC_NoInstallClass                                        &= Self.DPK_DC_NoInstallClass
        Self.FullMachineQ.DPK_DC_NoUseClass                                            &= Self.DPK_DC_NoUseClass
        Self.FullMachineQ.DPK_DC_PropPageProvider                                      &= Self.DPK_DC_PropPageProvider
        Self.FullMachineQ.DPK_DC_Security                                              &= Self.DPK_DC_Security
        Self.FullMachineQ.DPK_DC_SecuritySDS                                           &= Self.DPK_DC_SecuritySDS
        Self.FullMachineQ.DPK_DC_SilentInstall                                         &= Self.DPK_DC_SilentInstall
        Self.FullMachineQ.DPK_DC_UpperFilters                                          &= Self.DPK_DC_UpperFilters
        Self.FullMachineQ.DPK_DebuggerSafe                                             &= Self.DPK_DebuggerSafe
        Self.FullMachineQ.DPK_DependencyDependents                                     &= Self.DPK_DependencyDependents
        Self.FullMachineQ.DPK_DependencyProviders                                      &= Self.DPK_DependencyProviders
        Self.FullMachineQ.DPK_DeviceDesc                                               &= Self.DPK_DeviceDesc
        Self.FullMachineQ.DPK_DevNodeStatus                                            &= Self.DPK_DevNodeStatus
        Self.FullMachineQ.DPK_DevType                                                  &= Self.DPK_DevType
        Self.FullMachineQ.DPK_DHP_Rebalance_Policy                                     &= Self.DPK_DHP_Rebalance_Policy
        Self.FullMachineQ.DPK_Driver                                                   &= Self.DPK_Driver
        Self.FullMachineQ.DPK_DriverCoInstallers                                       &= Self.DPK_DriverCoInstallers
        Self.FullMachineQ.DPK_DriverDate                                               &= Self.DPK_DriverDate
        Self.FullMachineQ.DPK_DriverDesc                                               &= Self.DPK_DriverDesc
        Self.FullMachineQ.DPK_DriverInfPath                                            &= Self.DPK_DriverInfPath
        Self.FullMachineQ.DPK_DriverInfSection                                         &= Self.DPK_DriverInfSection
        Self.FullMachineQ.DPK_DriverInfSectionExt                                      &= Self.DPK_DriverInfSectionExt
        Self.FullMachineQ.DPK_DriverLogoLevel                                          &= Self.DPK_DriverLogoLevel
        Self.FullMachineQ.DPK_DriverProblemDesc                                        &= Self.DPK_DriverProblemDesc
        Self.FullMachineQ.DPK_DriverPropPageProvider                                   &= Self.DPK_DriverPropPageProvider
        Self.FullMachineQ.DPK_DriverProvider                                           &= Self.DPK_DriverProvider
        Self.FullMachineQ.DPK_DriverRank                                               &= Self.DPK_DriverRank
        Self.FullMachineQ.DPK_DriverVersion                                            &= Self.DPK_DriverVersion
        Self.FullMachineQ.DPK_EjectionRelations                                        &= Self.DPK_EjectionRelations
        Self.FullMachineQ.DPK_EnumeratorName                                           &= Self.DPK_EnumeratorName
        Self.FullMachineQ.DPK_Exclusive                                                &= Self.DPK_Exclusive
        Self.FullMachineQ.DPK_ExtendedAddress                                          &= Self.DPK_ExtendedAddress
        Self.FullMachineQ.DPK_ExtendedConfigurationIds                                 &= Self.DPK_ExtendedConfigurationIds
        Self.FullMachineQ.DPK_FirmwareDate                                             &= Self.DPK_FirmwareDate
        Self.FullMachineQ.DPK_FirmwareRevision                                         &= Self.DPK_FirmwareRevision
        Self.FullMachineQ.DPK_FirmwareVendor                                           &= Self.DPK_FirmwareVendor
        Self.FullMachineQ.DPK_FirmwareVersion                                          &= Self.DPK_FirmwareVersion
        Self.FullMachineQ.DPK_FirstInstallDate                                         &= Self.DPK_FirstInstallDate
        Self.FullMachineQ.DPK_FriendlyName                                             &= Self.DPK_FriendlyName
        Self.FullMachineQ.DPK_FriendlyNameAttributes                                   &= Self.DPK_FriendlyNameAttributes
        Self.FullMachineQ.DPK_GenericDriverInstalled                                   &= Self.DPK_GenericDriverInstalled
        Self.FullMachineQ.DPK_HardwareIds                                              &= Self.DPK_HardwareIds
        Self.FullMachineQ.DPK_HasProblem                                               &= Self.DPK_HasProblem
        Self.FullMachineQ.DPK_InLocalMachineContainer                                  &= Self.DPK_InLocalMachineContainer
        Self.FullMachineQ.DPK_InstallDate                                              &= Self.DPK_InstallDate
        Self.FullMachineQ.DPK_InstallState                                             &= Self.DPK_InstallState
        Self.FullMachineQ.DPK_InstanceId                                               &= Self.DPK_InstanceId
        Self.FullMachineQ.DPK_Interface_ClassGuid                                      &= Self.DPK_Interface_ClassGuid
        Self.FullMachineQ.DPK_Interface_Enabled                                        &= Self.DPK_Interface_Enabled
        Self.FullMachineQ.DPK_Interface_FriendlyName                                   &= Self.DPK_Interface_FriendlyName
        Self.FullMachineQ.DPK_Interface_ReferenceString                                &= Self.DPK_Interface_ReferenceString
        Self.FullMachineQ.DPK_Interface_Restricted                                     &= Self.DPK_Interface_Restricted
        Self.FullMachineQ.DPK_Interface_SchematicName                                  &= Self.DPK_Interface_SchematicName
        Self.FullMachineQ.DPK_Interface_UnrestrictedAppCapabilities                    &= Self.DPK_Interface_UnrestrictedAppCapabilities
        Self.FullMachineQ.DPK_InterfaceClass_DefaultInterface                          &= Self.DPK_InterfaceClass_DefaultInterface
        Self.FullMachineQ.DPK_InterfaceClass_Name                                      &= Self.DPK_InterfaceClass_Name
        Self.FullMachineQ.DPK_IsAssociateableByUserAction                              &= Self.DPK_IsAssociateableByUserAction
        Self.FullMachineQ.DPK_IsPresent                                                &= Self.DPK_IsPresent
        Self.FullMachineQ.DPK_IsRebootRequired                                         &= Self.DPK_IsRebootRequired
        Self.FullMachineQ.DPK_LastArrivalDate                                          &= Self.DPK_LastArrivalDate
        Self.FullMachineQ.DPK_LastRemovalDate                                          &= Self.DPK_LastRemovalDate
        Self.FullMachineQ.DPK_Legacy                                                   &= Self.DPK_Legacy
        Self.FullMachineQ.DPK_LegacyBusType                                            &= Self.DPK_LegacyBusType
        Self.FullMachineQ.DPK_LocationInfo                                             &= Self.DPK_LocationInfo
        Self.FullMachineQ.DPK_LocationPaths                                            &= Self.DPK_LocationPaths
        Self.FullMachineQ.DPK_LowerFilters                                             &= Self.DPK_LowerFilters
        Self.FullMachineQ.DPK_Manufacturer                                             &= Self.DPK_Manufacturer
        Self.FullMachineQ.DPK_ManufacturerAttributes                                   &= Self.DPK_ManufacturerAttributes
        Self.FullMachineQ.DPK_MatchingDeviceId                                         &= Self.DPK_MatchingDeviceId
        Self.FullMachineQ.DPK_Model                                                    &= Self.DPK_Model
        Self.FullMachineQ.DPK_ModelId                                                  &= Self.DPK_ModelId
        Self.FullMachineQ.DPK_Name                                                     &= Self.DPK_Name
        Self.FullMachineQ.DPK_NoConnectSound                                           &= Self.DPK_NoConnectSound
        Self.FullMachineQ.DPK_Numa_Node                                                &= Self.DPK_Numa_Node
        Self.FullMachineQ.DPK_Numa_Proximity_Domain                                    &= Self.DPK_Numa_Proximity_Domain
        Self.FullMachineQ.DPK_Parent                                                   &= Self.DPK_Parent
        Self.FullMachineQ.DPK_PDOName                                                  &= Self.DPK_PDOName
        Self.FullMachineQ.DPK_PhysicalDeviceLocation                                   &= Self.DPK_PhysicalDeviceLocation
        Self.FullMachineQ.DPK_Pkg_BrandingIcon                                         &= Self.DPK_Pkg_BrandingIcon
        Self.FullMachineQ.DPK_Pkg_DetailedDescription                                  &= Self.DPK_Pkg_DetailedDescription
        Self.FullMachineQ.DPK_Pkg_DocumentationLink                                    &= Self.DPK_Pkg_DocumentationLink
        Self.FullMachineQ.DPK_Pkg_Icon                                                 &= Self.DPK_Pkg_Icon
        Self.FullMachineQ.DPK_Pkg_Model                                                &= Self.DPK_Pkg_Model
        Self.FullMachineQ.DPK_Pkg_VendorWebSite                                        &= Self.DPK_Pkg_VendorWebSite
        Self.FullMachineQ.DPK_PostInstallInProgress                                    &= Self.DPK_PostInstallInProgress
        Self.FullMachineQ.DPK_PowerData                                                &= Self.DPK_PowerData
        Self.FullMachineQ.DPK_PowerRelations                                           &= Self.DPK_PowerRelations
        Self.FullMachineQ.DPK_PresenceNotForDevice                                     &= Self.DPK_PresenceNotForDevice
        Self.FullMachineQ.DPK_ProblemCode                                              &= Self.DPK_ProblemCode
        Self.FullMachineQ.DPK_ProblemStatus                                            &= Self.DPK_ProblemStatus
        Self.FullMachineQ.DPK_Query_ObjectType                                         &= Self.DPK_Query_ObjectType
        Self.FullMachineQ.DPK_RemovalPolicy                                            &= Self.DPK_RemovalPolicy
        Self.FullMachineQ.DPK_RemovalPolicyDefault                                     &= Self.DPK_RemovalPolicyDefault
        Self.FullMachineQ.DPK_RemovalPolicyOverride                                    &= Self.DPK_RemovalPolicyOverride
        Self.FullMachineQ.DPK_RemovalRelations                                         &= Self.DPK_RemovalRelations
        Self.FullMachineQ.DPK_Reported                                                 &= Self.DPK_Reported
        Self.FullMachineQ.DPK_ReportedDeviceIdsHash                                    &= Self.DPK_ReportedDeviceIdsHash
        Self.FullMachineQ.DPK_ResourcePickerExceptions                                 &= Self.DPK_ResourcePickerExceptions
        Self.FullMachineQ.DPK_ResourcePickerTags                                       &= Self.DPK_ResourcePickerTags
        Self.FullMachineQ.DPK_SafeRemovalRequired                                      &= Self.DPK_SafeRemovalRequired
        Self.FullMachineQ.DPK_SafeRemovalRequiredOverride                              &= Self.DPK_SafeRemovalRequiredOverride
        Self.FullMachineQ.DPK_Security                                                 &= Self.DPK_Security
        Self.FullMachineQ.DPK_SecuritySDS                                              &= Self.DPK_SecuritySDS
        Self.FullMachineQ.DPK_Service                                                  &= Self.DPK_Service
        Self.FullMachineQ.DPK_SessionId                                                &= Self.DPK_SessionId
        Self.FullMachineQ.DPK_ShowInUninstallUI                                        &= Self.DPK_ShowInUninstallUI
        Self.FullMachineQ.DPK_Siblings                                                 &= Self.DPK_Siblings
        Self.FullMachineQ.DPK_SignalStrength                                           &= Self.DPK_SignalStrength
        Self.FullMachineQ.DPK_SoftRestartSupported                                     &= Self.DPK_SoftRestartSupported
        Self.FullMachineQ.DPK_Stack                                                    &= Self.DPK_Stack
        Self.FullMachineQ.DPK_TransportRelations                                       &= Self.DPK_TransportRelations
        Self.FullMachineQ.DPK_UINumber                                                 &= Self.DPK_UINumber
        Self.FullMachineQ.DPK_UINumberDescFormat                                       &= Self.DPK_UINumberDescFormat
        Self.FullMachineQ.DPK_UpperFilters                                             &= Self.DPK_UpperFilters
        Add(Self.FullMachineQ)

        Self.Logger.AddLogLine('DONE MachineClass.ReferenceFullMachineQ')
        Return 0

MachineClass.GetMachine     Procedure(<Long _machineId>)

    Code

        Self.Logger.AddLogLine('START MachineClass.GetMachine')
        If omitted(_machineId) = False
            Self.MachineId = _machineId
        Else
            Self.MachineId = Self.Id
        End
        Clear(Self.Machine)
        Free(Self.MachineAsQueue)

        Case Self.DbEngineType
        Of DbEngineType:Sqlite3
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from Machine where Id = ' & Self.MachineId, Self.MachineAsQueue)
            Get(Self.MachineAsQueue,1)
            If Errorcode() = 0
                Self.Machine = Self.MachineAsQueue
            End
        End
        Self.Logger.AddLogLine('DONE MachineClass.GetMachine')
        Return Self.Machine

MachineClass.GetWinObjectsFromMachine     Procedure(<Long _machineId>)

    Code

        Self.Logger.AddLogLine('START MachineClass.GetWinObjectsFromMachine')
        If omitted(_machineId) = False
            Self.MachineId = _machineId
        Else
            Self.MachineId = Self.Id
        End

        Case Self.DbEngineType
        Of DbEngineType:Sqlite3

            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from WinObject where MachineId = ' & Self.MachineId & ' order by parentid, type, nameansi', Self.WinObject)
        End
        Self.Logger.AddLogLine('DONE MachineClass.GetWinObjectsFromMachine')
        Return ''

MachineClass.GetDevicesFromMachine     Procedure(<Long _machineId>)

    Code

        Self.Logger.AddLogLine('START MachineClass.GetDevicesFromMachine')
        If omitted(_machineId) = False
            Self.MachineId = _machineId
        Else
            Self.MachineId = Self.Id
        End

        Case Self.DbEngineType
        Of DbEngineType:Sqlite3

            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from Devices where MachineId = ' & Self.MachineId & ' order by ParentInstance, Instance', Self.Devices)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_AdditionalSoftwareRequested where MachineId = ' & Self.MachineId, Self.DPK_AdditionalSoftwareRequested)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Address where MachineId = ' & Self.MachineId, Self.DPK_Address)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_AssignedToGuest where MachineId = ' & Self.MachineId, Self.DPK_AssignedToGuest)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_BaseContainerId where MachineId = ' & Self.MachineId, Self.DPK_BaseContainerId)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_BiosDeviceName where MachineId = ' & Self.MachineId, Self.DPK_BiosDeviceName)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_BusNumber where MachineId = ' & Self.MachineId, Self.DPK_BusNumber)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_BusRelations where MachineId = ' & Self.MachineId, Self.DPK_BusRelations)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_BusReportedDeviceDesc where MachineId = ' & Self.MachineId, Self.DPK_BusReportedDeviceDesc)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_BusTypeGuid where MachineId = ' & Self.MachineId, Self.DPK_BusTypeGuid)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Capabilities where MachineId = ' & Self.MachineId, Self.DPK_Capabilities)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Characteristics where MachineId = ' & Self.MachineId, Self.DPK_Characteristics)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Children where MachineId = ' & Self.MachineId, Self.DPK_Children)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_ClassGuid where MachineId = ' & Self.MachineId, Self.DPK_ClassGuid)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Class where MachineId = ' & Self.MachineId, Self.DPK_Class)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_CompatibleIds where MachineId = ' & Self.MachineId, Self.DPK_CompatibleIds)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_ConfigFlags where MachineId = ' & Self.MachineId, Self.DPK_ConfigFlags)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_ConfigurationId where MachineId = ' & Self.MachineId, Self.DPK_ConfigurationId)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_ContainerId where MachineId = ' & Self.MachineId, Self.DPK_ContainerId)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_Address where MachineId = ' & Self.MachineId, Self.DPK_Container_Address)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_AlwaysShowDeviceAsConnected where MachineId = ' & Self.MachineId, Self.DPK_Container_AlwaysShowDeviceAsConnected)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_AssociationArray where MachineId = ' & Self.MachineId, Self.DPK_Container_AssociationArray)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_BaselineExperienceId where MachineId = ' & Self.MachineId, Self.DPK_Container_BaselineExperienceId)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_CategoryGroup_Desc where MachineId = ' & Self.MachineId, Self.DPK_Container_CategoryGroup_Desc)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_CategoryGroup_Icon where MachineId = ' & Self.MachineId, Self.DPK_Container_CategoryGroup_Icon)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_Category_Desc_Plural where MachineId = ' & Self.MachineId, Self.DPK_Container_Category_Desc_Plural)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_Category_Desc_Singular where MachineId = ' & Self.MachineId, Self.DPK_Container_Category_Desc_Singular)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_Category_Icon where MachineId = ' & Self.MachineId, Self.DPK_Container_Category_Icon)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_Category where MachineId = ' & Self.MachineId, Self.DPK_Container_Category)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_ConfigFlags where MachineId = ' & Self.MachineId, Self.DPK_Container_ConfigFlags)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_CusPrivPackFamNames where MachineId = ' & Self.MachineId, Self.DPK_Container_CusPrivPackFamNames)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_DeviceDescription1 where MachineId = ' & Self.MachineId, Self.DPK_Container_DeviceDescription1)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_DeviceDescription2 where MachineId = ' & Self.MachineId, Self.DPK_Container_DeviceDescription2)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_DeviceFunctionSubRank where MachineId = ' & Self.MachineId, Self.DPK_Container_DeviceFunctionSubRank)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_DiscoveryMethod where MachineId = ' & Self.MachineId, Self.DPK_Container_DiscoveryMethod)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_ExperienceId where MachineId = ' & Self.MachineId, Self.DPK_Container_ExperienceId)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_FriendlyName where MachineId = ' & Self.MachineId, Self.DPK_Container_FriendlyName)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_HasProblem where MachineId = ' & Self.MachineId, Self.DPK_Container_HasProblem)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_Icon where MachineId = ' & Self.MachineId, Self.DPK_Container_Icon)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_InstallInProgress where MachineId = ' & Self.MachineId, Self.DPK_Container_InstallInProgress)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_IsAuthenticated where MachineId = ' & Self.MachineId, Self.DPK_Container_IsAuthenticated)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_IsConnected where MachineId = ' & Self.MachineId, Self.DPK_Container_IsConnected)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_IsDefaultDevice where MachineId = ' & Self.MachineId, Self.DPK_Container_IsDefaultDevice)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_IsDeviceUniquelyIdentifiable where MachineId = ' & Self.MachineId, Self.DPK_Container_IsDeviceUniquelyIdentifiable)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_IsEncrypted where MachineId = ' & Self.MachineId, Self.DPK_Container_IsEncrypted)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_IsLocalMachine where MachineId = ' & Self.MachineId, Self.DPK_Container_IsLocalMachine)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_IsMetadataSearchInProgress where MachineId = ' & Self.MachineId, Self.DPK_Container_IsMetadataSearchInProgress)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_IsNetworkDevice where MachineId = ' & Self.MachineId, Self.DPK_Container_IsNetworkDevice)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_IsNotInterestingForDisplay where MachineId = ' & Self.MachineId, Self.DPK_Container_IsNotInterestingForDisplay)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_IsPaired where MachineId = ' & Self.MachineId, Self.DPK_Container_IsPaired)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_IsRebootRequired where MachineId = ' & Self.MachineId, Self.DPK_Container_IsRebootRequired)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_IsSharedDevice where MachineId = ' & Self.MachineId, Self.DPK_Container_IsSharedDevice)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_IsShowInDisconnectedState where MachineId = ' & Self.MachineId, Self.DPK_Container_IsShowInDisconnectedState)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_Last_Connected where MachineId = ' & Self.MachineId, Self.DPK_Container_Last_Connected)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_Last_Seen where MachineId = ' & Self.MachineId, Self.DPK_Container_Last_Seen)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_LaunchDeviceStageFromExplorer where MachineId = ' & Self.MachineId, Self.DPK_Container_LaunchDeviceStageFromExplorer)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_LaunchDeviceStageOnDeviceConnect where MachineId = ' & Self.MachineId, Self.DPK_Container_LaunchDeviceStageOnDeviceConnect)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_Manufacturer where MachineId = ' & Self.MachineId, Self.DPK_Container_Manufacturer)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_MetadataCabinet where MachineId = ' & Self.MachineId, Self.DPK_Container_MetadataCabinet)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_MetadataChecksum where MachineId = ' & Self.MachineId, Self.DPK_Container_MetadataChecksum)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_MetadataPath where MachineId = ' & Self.MachineId, Self.DPK_Container_MetadataPath)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_ModelName where MachineId = ' & Self.MachineId, Self.DPK_Container_ModelName)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_ModelNumber where MachineId = ' & Self.MachineId, Self.DPK_Container_ModelNumber)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_PrimaryCategory where MachineId = ' & Self.MachineId, Self.DPK_Container_PrimaryCategory)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_PrivilegedPackageFamilyNames where MachineId = ' & Self.MachineId, Self.DPK_Container_PrivilegedPackageFamilyNames)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_RequiresPairingElevation where MachineId = ' & Self.MachineId, Self.DPK_Container_RequiresPairingElevation)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_RequiresUninstallElevation where MachineId = ' & Self.MachineId, Self.DPK_Container_RequiresUninstallElevation)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_UnpairUninstall where MachineId = ' & Self.MachineId, Self.DPK_Container_UnpairUninstall)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Container_Version where MachineId = ' & Self.MachineId, Self.DPK_Container_Version)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_CreatorProcessId where MachineId = ' & Self.MachineId, Self.DPK_CreatorProcessId)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DC_Characteristics where MachineId = ' & Self.MachineId, Self.DPK_DC_Characteristics)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DC_ClassCoInstallers where MachineId = ' & Self.MachineId, Self.DPK_DC_ClassCoInstallers)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DC_ClassInstaller where MachineId = ' & Self.MachineId, Self.DPK_DC_ClassInstaller)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DC_ClassName where MachineId = ' & Self.MachineId, Self.DPK_DC_ClassName)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DC_DHPRebalanceOptOut where MachineId = ' & Self.MachineId, Self.DPK_DC_DHPRebalanceOptOut)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DC_DefaultService where MachineId = ' & Self.MachineId, Self.DPK_DC_DefaultService)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DC_DevType where MachineId = ' & Self.MachineId, Self.DPK_DC_DevType)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DC_Exclusive where MachineId = ' & Self.MachineId, Self.DPK_DC_Exclusive)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DC_IconPath where MachineId = ' & Self.MachineId, Self.DPK_DC_IconPath)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DC_Icon where MachineId = ' & Self.MachineId, Self.DPK_DC_Icon)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DC_LowerFilters where MachineId = ' & Self.MachineId, Self.DPK_DC_LowerFilters)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DC_Name where MachineId = ' & Self.MachineId, Self.DPK_DC_Name)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DC_NoDisplayClass where MachineId = ' & Self.MachineId, Self.DPK_DC_NoDisplayClass)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DC_NoInstallClass where MachineId = ' & Self.MachineId, Self.DPK_DC_NoInstallClass)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DC_NoUseClass where MachineId = ' & Self.MachineId, Self.DPK_DC_NoUseClass)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DC_PropPageProvider where MachineId = ' & Self.MachineId, Self.DPK_DC_PropPageProvider)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DC_SecuritySDS where MachineId = ' & Self.MachineId, Self.DPK_DC_SecuritySDS)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DC_Security where MachineId = ' & Self.MachineId, Self.DPK_DC_Security)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DC_SilentInstall where MachineId = ' & Self.MachineId, Self.DPK_DC_SilentInstall)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DC_UpperFilters where MachineId = ' & Self.MachineId, Self.DPK_DC_UpperFilters)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DHP_Rebalance_Policy where MachineId = ' & Self.MachineId, Self.DPK_DHP_Rebalance_Policy)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DebuggerSafe where MachineId = ' & Self.MachineId, Self.DPK_DebuggerSafe)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DependencyDependents where MachineId = ' & Self.MachineId, Self.DPK_DependencyDependents)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DependencyProviders where MachineId = ' & Self.MachineId, Self.DPK_DependencyProviders)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DevNodeStatus where MachineId = ' & Self.MachineId, Self.DPK_DevNodeStatus)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DevType where MachineId = ' & Self.MachineId, Self.DPK_DevType)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DeviceDesc where MachineId = ' & Self.MachineId, Self.DPK_DeviceDesc)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DriverCoInstallers where MachineId = ' & Self.MachineId, Self.DPK_DriverCoInstallers)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DriverDate where MachineId = ' & Self.MachineId, Self.DPK_DriverDate)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DriverDesc where MachineId = ' & Self.MachineId, Self.DPK_DriverDesc)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DriverInfPath where MachineId = ' & Self.MachineId, Self.DPK_DriverInfPath)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DriverInfSectionExt where MachineId = ' & Self.MachineId, Self.DPK_DriverInfSectionExt)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DriverInfSection where MachineId = ' & Self.MachineId, Self.DPK_DriverInfSection)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DriverLogoLevel where MachineId = ' & Self.MachineId, Self.DPK_DriverLogoLevel)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DriverProblemDesc where MachineId = ' & Self.MachineId, Self.DPK_DriverProblemDesc)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DriverPropPageProvider where MachineId = ' & Self.MachineId, Self.DPK_DriverPropPageProvider)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DriverProvider where MachineId = ' & Self.MachineId, Self.DPK_DriverProvider)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DriverRank where MachineId = ' & Self.MachineId, Self.DPK_DriverRank)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_DriverVersion where MachineId = ' & Self.MachineId, Self.DPK_DriverVersion)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Driver where MachineId = ' & Self.MachineId, Self.DPK_Driver)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_EjectionRelations where MachineId = ' & Self.MachineId, Self.DPK_EjectionRelations)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_EnumeratorName where MachineId = ' & Self.MachineId, Self.DPK_EnumeratorName)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Exclusive where MachineId = ' & Self.MachineId, Self.DPK_Exclusive)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_ExtendedAddress where MachineId = ' & Self.MachineId, Self.DPK_ExtendedAddress)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_ExtendedConfigurationIds where MachineId = ' & Self.MachineId, Self.DPK_ExtendedConfigurationIds)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_FirmwareDate where MachineId = ' & Self.MachineId, Self.DPK_FirmwareDate)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_FirmwareRevision where MachineId = ' & Self.MachineId, Self.DPK_FirmwareRevision)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_FirmwareVendor where MachineId = ' & Self.MachineId, Self.DPK_FirmwareVendor)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_FirmwareVersion where MachineId = ' & Self.MachineId, Self.DPK_FirmwareVersion)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_FirstInstallDate where MachineId = ' & Self.MachineId, Self.DPK_FirstInstallDate)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_FriendlyNameAttributes where MachineId = ' & Self.MachineId, Self.DPK_FriendlyNameAttributes)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_FriendlyName where MachineId = ' & Self.MachineId, Self.DPK_FriendlyName)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_GenericDriverInstalled where MachineId = ' & Self.MachineId, Self.DPK_GenericDriverInstalled)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_HardwareIds where MachineId = ' & Self.MachineId, Self.DPK_HardwareIds)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_HasProblem where MachineId = ' & Self.MachineId, Self.DPK_HasProblem)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_InLocalMachineContainer where MachineId = ' & Self.MachineId, Self.DPK_InLocalMachineContainer)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_InstallDate where MachineId = ' & Self.MachineId, Self.DPK_InstallDate)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_InstallState where MachineId = ' & Self.MachineId, Self.DPK_InstallState)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_InstanceId where MachineId = ' & Self.MachineId, Self.DPK_InstanceId)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_InterfaceClass_DefaultInterface where MachineId = ' & Self.MachineId, Self.DPK_InterfaceClass_DefaultInterface)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_InterfaceClass_Name where MachineId = ' & Self.MachineId, Self.DPK_InterfaceClass_Name)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Interface_ClassGuid where MachineId = ' & Self.MachineId, Self.DPK_Interface_ClassGuid)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Interface_Enabled where MachineId = ' & Self.MachineId, Self.DPK_Interface_Enabled)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Interface_FriendlyName where MachineId = ' & Self.MachineId, Self.DPK_Interface_FriendlyName)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Interface_ReferenceString where MachineId = ' & Self.MachineId, Self.DPK_Interface_ReferenceString)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Interface_Restricted where MachineId = ' & Self.MachineId, Self.DPK_Interface_Restricted)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Interface_SchematicName where MachineId = ' & Self.MachineId, Self.DPK_Interface_SchematicName)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Interface_UnrestrictedAppCapabilities where MachineId = ' & Self.MachineId, Self.DPK_Interface_UnrestrictedAppCapabilities)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_IsAssociateableByUserAction where MachineId = ' & Self.MachineId, Self.DPK_IsAssociateableByUserAction)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_IsPresent where MachineId = ' & Self.MachineId, Self.DPK_IsPresent)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_IsRebootRequired where MachineId = ' & Self.MachineId, Self.DPK_IsRebootRequired)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_LastArrivalDate where MachineId = ' & Self.MachineId, Self.DPK_LastArrivalDate)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_LastRemovalDate where MachineId = ' & Self.MachineId, Self.DPK_LastRemovalDate)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_LegacyBusType where MachineId = ' & Self.MachineId, Self.DPK_LegacyBusType)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Legacy where MachineId = ' & Self.MachineId, Self.DPK_Legacy)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_LocationInfo where MachineId = ' & Self.MachineId, Self.DPK_LocationInfo)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_LocationPaths where MachineId = ' & Self.MachineId, Self.DPK_LocationPaths)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_LowerFilters where MachineId = ' & Self.MachineId, Self.DPK_LowerFilters)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_ManufacturerAttributes where MachineId = ' & Self.MachineId, Self.DPK_ManufacturerAttributes)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Manufacturer where MachineId = ' & Self.MachineId, Self.DPK_Manufacturer)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_MatchingDeviceId where MachineId = ' & Self.MachineId, Self.DPK_MatchingDeviceId)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_ModelId where MachineId = ' & Self.MachineId, Self.DPK_ModelId)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Model where MachineId = ' & Self.MachineId, Self.DPK_Model)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Name where MachineId = ' & Self.MachineId, Self.DPK_Name)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_NoConnectSound where MachineId = ' & Self.MachineId, Self.DPK_NoConnectSound)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Numa_Node where MachineId = ' & Self.MachineId, Self.DPK_Numa_Node)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Numa_Proximity_Domain where MachineId = ' & Self.MachineId, Self.DPK_Numa_Proximity_Domain)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_PDOName where MachineId = ' & Self.MachineId, Self.DPK_PDOName)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Parent where MachineId = ' & Self.MachineId, Self.DPK_Parent)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_PhysicalDeviceLocation where MachineId = ' & Self.MachineId, Self.DPK_PhysicalDeviceLocation)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Pkg_BrandingIcon where MachineId = ' & Self.MachineId, Self.DPK_Pkg_BrandingIcon)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Pkg_DetailedDescription where MachineId = ' & Self.MachineId, Self.DPK_Pkg_DetailedDescription)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Pkg_DocumentationLink where MachineId = ' & Self.MachineId, Self.DPK_Pkg_DocumentationLink)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Pkg_Icon where MachineId = ' & Self.MachineId, Self.DPK_Pkg_Icon)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Pkg_Model where MachineId = ' & Self.MachineId, Self.DPK_Pkg_Model)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Pkg_VendorWebSite where MachineId = ' & Self.MachineId, Self.DPK_Pkg_VendorWebSite)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_PostInstallInProgress where MachineId = ' & Self.MachineId, Self.DPK_PostInstallInProgress)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_PowerData where MachineId = ' & Self.MachineId, Self.DPK_PowerData)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_PowerRelations where MachineId = ' & Self.MachineId, Self.DPK_PowerRelations)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_PresenceNotForDevice where MachineId = ' & Self.MachineId, Self.DPK_PresenceNotForDevice)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_ProblemCode where MachineId = ' & Self.MachineId, Self.DPK_ProblemCode)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_ProblemStatus where MachineId = ' & Self.MachineId, Self.DPK_ProblemStatus)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Query_ObjectType where MachineId = ' & Self.MachineId, Self.DPK_Query_ObjectType)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_RemovalPolicyDefault where MachineId = ' & Self.MachineId, Self.DPK_RemovalPolicyDefault)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_RemovalPolicyOverride where MachineId = ' & Self.MachineId, Self.DPK_RemovalPolicyOverride)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_RemovalPolicy where MachineId = ' & Self.MachineId, Self.DPK_RemovalPolicy)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_RemovalRelations where MachineId = ' & Self.MachineId, Self.DPK_RemovalRelations)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_ReportedDeviceIdsHash where MachineId = ' & Self.MachineId, Self.DPK_ReportedDeviceIdsHash)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Reported where MachineId = ' & Self.MachineId, Self.DPK_Reported)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_ResourcePickerExceptions where MachineId = ' & Self.MachineId, Self.DPK_ResourcePickerExceptions)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_ResourcePickerTags where MachineId = ' & Self.MachineId, Self.DPK_ResourcePickerTags)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_SafeRemovalRequiredOverride where MachineId = ' & Self.MachineId, Self.DPK_SafeRemovalRequiredOverride)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_SafeRemovalRequired where MachineId = ' & Self.MachineId, Self.DPK_SafeRemovalRequired)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_SecuritySDS where MachineId = ' & Self.MachineId, Self.DPK_SecuritySDS)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Security where MachineId = ' & Self.MachineId, Self.DPK_Security)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Service where MachineId = ' & Self.MachineId, Self.DPK_Service)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_SessionId where MachineId = ' & Self.MachineId, Self.DPK_SessionId)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_ShowInUninstallUI where MachineId = ' & Self.MachineId, Self.DPK_ShowInUninstallUI)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Siblings where MachineId = ' & Self.MachineId, Self.DPK_Siblings)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_SignalStrength where MachineId = ' & Self.MachineId, Self.DPK_SignalStrength)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_SoftRestartSupported where MachineId = ' & Self.MachineId, Self.DPK_SoftRestartSupported)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_Stack where MachineId = ' & Self.MachineId, Self.DPK_Stack)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK where MachineId = ' & Self.MachineId, Self.DPK)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_TransportRelations where MachineId = ' & Self.MachineId, Self.DPK_TransportRelations)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_UINumberDescFormat where MachineId = ' & Self.MachineId, Self.DPK_UINumberDescFormat)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_UINumber where MachineId = ' & Self.MachineId, Self.DPK_UINumber)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from DPK_UpperFilters where MachineId = ' & Self.MachineId, Self.DPK_UpperFilters)

        End
        Self.Logger.AddLogLine('DONE MachineClass.GetDevicesFromMachine')
        Return ''
        
MachineClass.GetBiosFromMachine     Procedure(<Long _machineId>)

ClarionFields                           &ClarionFields_TYPE()

    Code

        Self.Logger.AddLogLine('START MachineClass.GetBiosFromMachine')
        If omitted(_machineId) = False
            Self.MachineId = _machineId
        Else
            Self.MachineId = Self.Id
        End

        Case Self.DbEngineType
        Of DbEngineType:Sqlite3

            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosBoardCpu where MachineId = ' & Self.MachineId, Self.BiosBoardCpu)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage000 where MachineId = ' & Self.MachineId, Self.BiosPage000)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage001 where MachineId = ' & Self.MachineId, Self.BiosPage001)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage002 where MachineId = ' & Self.MachineId, Self.BiosPage002)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage003 where MachineId = ' & Self.MachineId, Self.BiosPage003)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage004 where MachineId = ' & Self.MachineId, Self.BiosPage004)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage005 where MachineId = ' & Self.MachineId, Self.BiosPage005)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage006 where MachineId = ' & Self.MachineId, Self.BiosPage006)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage007 where MachineId = ' & Self.MachineId, Self.BiosPage007)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage008 where MachineId = ' & Self.MachineId, Self.BiosPage008)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage009 where MachineId = ' & Self.MachineId, Self.BiosPage009)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage010 where MachineId = ' & Self.MachineId, Self.BiosPage010)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage011 where MachineId = ' & Self.MachineId, Self.BiosPage011)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage012 where MachineId = ' & Self.MachineId, Self.BiosPage012)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage013 where MachineId = ' & Self.MachineId, Self.BiosPage013)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage014 where MachineId = ' & Self.MachineId, Self.BiosPage014)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage015 where MachineId = ' & Self.MachineId, Self.BiosPage015)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage016 where MachineId = ' & Self.MachineId, Self.BiosPage016)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage017 where MachineId = ' & Self.MachineId, Self.BiosPage017)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage018 where MachineId = ' & Self.MachineId, Self.BiosPage018)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage019 where MachineId = ' & Self.MachineId, Self.BiosPage019)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage020 where MachineId = ' & Self.MachineId, Self.BiosPage020)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage021 where MachineId = ' & Self.MachineId, Self.BiosPage021)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage022 where MachineId = ' & Self.MachineId, Self.BiosPage022)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage023 where MachineId = ' & Self.MachineId, Self.BiosPage023)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage024 where MachineId = ' & Self.MachineId, Self.BiosPage024)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage025 where MachineId = ' & Self.MachineId, Self.BiosPage025)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage026 where MachineId = ' & Self.MachineId, Self.BiosPage026)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage027 where MachineId = ' & Self.MachineId, Self.BiosPage027)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage028 where MachineId = ' & Self.MachineId, Self.BiosPage028)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage029 where MachineId = ' & Self.MachineId, Self.BiosPage029)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage030 where MachineId = ' & Self.MachineId, Self.BiosPage030)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage031 where MachineId = ' & Self.MachineId, Self.BiosPage031)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage032 where MachineId = ' & Self.MachineId, Self.BiosPage032)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage033 where MachineId = ' & Self.MachineId, Self.BiosPage033)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage034 where MachineId = ' & Self.MachineId, Self.BiosPage034)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage035 where MachineId = ' & Self.MachineId, Self.BiosPage035)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage036 where MachineId = ' & Self.MachineId, Self.BiosPage036)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage037 where MachineId = ' & Self.MachineId, Self.BiosPage037)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage038 where MachineId = ' & Self.MachineId, Self.BiosPage038)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage039 where MachineId = ' & Self.MachineId, Self.BiosPage039)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage040 where MachineId = ' & Self.MachineId, Self.BiosPage040)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage041 where MachineId = ' & Self.MachineId, Self.BiosPage041)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage042 where MachineId = ' & Self.MachineId, Self.BiosPage042)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage043 where MachineId = ' & Self.MachineId, Self.BiosPage043)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage044 where MachineId = ' & Self.MachineId, Self.BiosPage044)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage045 where MachineId = ' & Self.MachineId, Self.BiosPage045)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage046 where MachineId = ' & Self.MachineId, Self.BiosPage046)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage126 where MachineId = ' & Self.MachineId, Self.BiosPage126)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPage127 where MachineId = ' & Self.MachineId, Self.BiosPage127)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosPages where MachineId = ' & Self.MachineId, Self.BiosPages)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosRaw where MachineId = ' & Self.MachineId, Self.BiosRaw)
            Self.Sqlite34.ExecuteQueryToQueueEntity('select * from BiosTypes where MachineId = ' & Self.MachineId, Self.BiosTypes)
        End
        
        Self.Logger.AddLogLine('DONE MachineClass.GetBiosFromMachine')
        Return ''

MachineClass.FreeBios     Procedure()

    Code

        Free(Self.BiosBoardCpu)
        Free(Self.BiosPage000)
        Free(Self.BiosPage001)
        Free(Self.BiosPage002)
        Free(Self.BiosPage003)
        Free(Self.BiosPage004)
        Free(Self.BiosPage005)
        Free(Self.BiosPage006)
        Free(Self.BiosPage007)
        Free(Self.BiosPage008)
        Free(Self.BiosPage009)
        Free(Self.BiosPage010)
        Free(Self.BiosPage011)
        Free(Self.BiosPage012)
        Free(Self.BiosPage013)
        Free(Self.BiosPage014)
        Free(Self.BiosPage015)
        Free(Self.BiosPage016)
        Free(Self.BiosPage017)
        Free(Self.BiosPage018)
        Free(Self.BiosPage019)
        Free(Self.BiosPage020)
        Free(Self.BiosPage021)
        Free(Self.BiosPage022)
        Free(Self.BiosPage023)
        Free(Self.BiosPage024)
        Free(Self.BiosPage025)
        Free(Self.BiosPage026)
        Free(Self.BiosPage027)
        Free(Self.BiosPage028)
        Free(Self.BiosPage029)
        Free(Self.BiosPage030)
        Free(Self.BiosPage031)
        Free(Self.BiosPage032)
        Free(Self.BiosPage033)
        Free(Self.BiosPage034)
        Free(Self.BiosPage035)
        Free(Self.BiosPage036)
        Free(Self.BiosPage037)
        Free(Self.BiosPage038)
        Free(Self.BiosPage039)
        Free(Self.BiosPage040)
        Free(Self.BiosPage041)
        Free(Self.BiosPage042)
        Free(Self.BiosPage043)
        Free(Self.BiosPage044)
        Free(Self.BiosPage045)
        Free(Self.BiosPage046)
        Free(Self.BiosPage126)
        Free(Self.BiosPage127)
        Free(Self.BiosPages)
        Free(Self.BiosRaw)
        Free(Self.BiosTypes)

        Return 0

