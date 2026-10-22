# Ponte Objective-C ↔ Python

19 classes, 49 propriedades (12 presentes na GUI), 148 seletores (132 presentes na GUI).

Gerado por `.tools/bridge.py`. Para cada classe Python visível ao Objective-C: as propriedades KVC/KVO (`cxobjc.*_property`) e os seletores (`@cxobjc.namedSelector`, `@cxobjc.method`, ou métodos exportados implicitamente pelo PyObjC, `_` → `:`). **GUI** marca os nomes que existem em `__objc_methname` da slice arm64 da GUI; **Usado em** lista os arquivos de pseudocódigo que enviam a mensagem (`[x nome…]`) ou usam o nome como chave (`@"nome"`).

A coluna "Usado em" é uma busca textual no pseudocódigo: pode faltar uso indireto (bindings de nib, `valueForKeyPath:` composto, `performSelector:`) e pode incluir um homônimo de outra classe.

## `InstalledApplication` (`appdetector`)

| Seletor ObjC | Função Python | Origem | GUI | Usado em |
|---|---|---|---|---|
| `initWithBottleName:profile:andKeyName:` | `initWithBottleName_profile_andKeyName_` | implicit |  |  |
| `canUninstall` | `canUninstall` | implicit | ✓ | BottleViewController |
| `uninstall` | `uninstall` | implicit | ✓ | BottleViewController |

## `BottleCollection` (`bottlecollection`)

| Propriedade ObjC | Atributo Python | Tipo | Só leitura | GUI | Usado em |
|---|---|---|---|---|---|
| `bottleList` | `bottleList` | id |  | ✓ | AskUpdateBottlesOp, CXServer<Produto>, MainWindowController, PackageInstaller, ShutdownController |
| `has32BitBottle` | `has32BitBottle` | BOOL | sim |  |  |

| Seletor ObjC | Função Python | Origem | GUI | Usado em |
|---|---|---|---|---|
| `init` | `init` | implicit | ✓ | BottleMenuHandler, BottleNode, BottleViewController, BuySupportNagController, CDTools, CXApplication … |
| `refresh` | `refresh` | namedSelector | ✓ | BottleMenuHandler, BottleNode, NewBottleController, NoBottleController, PackageInstaller, PublishController |
| `reset` | `reset` | namedSelector | ✓ | PreferencesController |
| `refreshDefaultBottle` | `refreshDefaultBottle` | namedSelector | ✓ | BottleMenuHandler |
| `bottleWithName:` | `bottle_with_name` | namedSelector | ✓ | CXServer<Produto>, InstallConfiguration, LauncherApp, NewBottleController, NoBottleController, PackageInstaller … |
| `addChangeDelegate:` | `addChangeDelegate` | namedSelector | ✓ | CXServer<Produto> |
| `sharedCollection` | `sharedCollection` | cxobjc.method | ✓ | AskUpdateBottlesOp, BottleMenuHandler, BottleNode, CXServer, CXServer<Produto>, InstallConfiguration … |

## `BottleManagement` (`bottlemanagement`)

| Seletor ObjC | Função Python | Origem | GUI | Usado em |
|---|---|---|---|---|
| `createBottle:fromTemplate:` | `create_bottle` | cxobjc.method | ✓ | NewBottleController, NoBottleController |
| `duplicateBottle:fromBottle:` | `copy_bottle` | cxobjc.method | ✓ | MainWindowController, NewBottleController |
| `restoreBottle:fromArchive:` | `restore_bottle` | cxobjc.method | ✓ | NewBottleController |
| `archiveBottle:toPath:` | `archive_bottle` | cxobjc.method | ✓ | BottleMenuHandler |
| `displayNameForTemplate:` | `get_template_name` | cxobjc.method | ✓ | NewBottleController, NoBottleController, SelectBottleSheetController |
| `templates` | `template_list` | cxobjc.method | ✓ | InstallConfiguration, NewBottleController, NoBottleController, SelectBottleSheetController |

## `BottleQuery` (`bottlequery`)

| Seletor ObjC | Função Python | Origem | GUI | Usado em |
|---|---|---|---|---|
| `uniqueBottleName:` | `unique_bottle_name` | cxobjc.method | ✓ | NewBottleController, NoBottleController, PublishController |
| `isValidNewBottleName:` | `is_valid_new_bottle_name` | cxobjc.method | ✓ | NewBottleController, PublishController |

## `BottleWrapper` (`bottlewrapper`)

| Propriedade ObjC | Atributo Python | Tipo | Só leitura | GUI | Usado em |
|---|---|---|---|---|---|
| `name` | `name` | id |  | ✓ | AddDependenciesViewController, BottleMenuHandler, BottleNode, BottleViewController, CXServer, CXServer<Produto> … |
| `appid` | `appid` | id |  | ✓ | BottleMenuHandler, BottleViewController, LauncherTreeNode, PackageInstaller, PackageTreeNode, SubmitRatingController |
| `winePrefix` | `wine_prefix` | id |  | ✓ | CXServer, CXServer<Produto> |
| `systemDrive` | `system_drive` | id |  | ✓ | BottleMenuHandler, RunCommandController |
| `changeableName` | `changeablename` | id |  | ✓ | BottleNode |
| `currentDescription` | `current_description` | id |  | ✓ | BottleViewController |
| `lastQuitFailed` | `last_quit_failed` | BOOL |  |  |  |
| `isDefault` | `is_default` | BOOL |  |  | RunCommandController, SelectBottleController |
| `isManaged` | `is_managed` | BOOL |  |  |  |
| `isUpToDate` | `up_to_date` | BOOL |  |  |  |
| `isD3DMetalAvailable` | `is_d3dmetal_available` | BOOL |  |  |  |
| `isDXMTAvailable` | `is_dxmt_available` | BOOL |  |  |  |
| `isMoltenVKAvailable` | `is_moltenvk_available` | BOOL |  |  |  |
| `isMTLVKAvailable` | `is_mtlvk_available` | BOOL |  |  |  |
| `controlPanelTable` | `control_panel_table` | id |  | ✓ | BottleViewController |
| `isControlPanelReady` | `control_panel_ready` | BOOL |  |  | BottleViewController |
| `isHighResolutionEnabledReady` | `is_high_resolution_enabled_ready` | BOOL |  |  |  |
| `installedPackages` | `installed_packages` | id |  | ✓ | SelectBottleSheetController |
| `isInstalledPackagesReady` | `installed_packages_ready` | BOOL |  |  | PackageInstaller |
| `menuChangedTime` | `menuChangedTime` | id |  |  | CXServer<Produto> |
| `isD3DMetalEnabled` | `isD3DMetalEnabled` | BOOL | sim |  |  |
| `isDXMTEnabled` | `isDXMTEnabled` | BOOL | sim |  |  |
| `isDXVKEnabled` | `isDXVKEnabled` | BOOL | sim |  |  |
| `isWineD3DEnabled` | `isWineD3DEnabled` | BOOL | sim |  |  |
| `isMoltenVKEnabled` | `isMoltenVKEnabled` | BOOL | sim |  |  |
| `isMTLVKEnabled` | `isMTLVKEnabled` | BOOL | sim |  |  |
| `isDLSSEnabled` | `isDLSSEnabled` | BOOL | sim |  |  |
| `isDLSSAvailable` | `isDLSSAvailable` | BOOL | sim |  |  |
| `isHighResolutionEnabled` | `isHighResolutionEnabled` | BOOL | sim |  |  |
| `isMSyncEnabled` | `isMSyncEnabled` | BOOL | sim |  |  |
| `isPreviewEnabled` | `isPreviewEnabled` | BOOL | sim |  |  |
| `shouldNagForRatings` | `shouldNagForRatings` | BOOL | sim |  |  |
| `canRunCommands` | `canRunCommands` | BOOL | sim | ✓ | BottleViewController, IconCollectionViewController |
| `canEdit` | `canEdit` | BOOL | sim |  |  |
| `isUsable` | `isUsable` | BOOL | sim |  |  |
| `canInstall` | `canInstall` | BOOL | sim |  | PackageInstaller |
| `isActive` | `isActive` | BOOL | sim | ✓ | CXServer, PackageViewController, c_functions |
| `canForceQuit` | `canForceQuit` | BOOL | sim |  | BottleViewController |
| `is32Bit` | `is32Bit` | BOOL | sim |  |  |
| `isBusy` | `isBusy` | BOOL | sim |  | MainWindowController |
| `isDisabled` | `isDisabled` | BOOL | sim |  |  |
| `isDeleted` | `isDeleted` | BOOL | sim |  |  |
| `isRenaming` | `isRenaming` | BOOL | sim |  |  |
| `canRename` | `canRename` | BOOL | sim |  |  |
| `needsUpgrade` | `needsUpgrade` | BOOL | sim |  |  |
| `displayName` | `displayName` | id | sim | ✓ | InstallOptionsSheetController, RunCommandController, SelectBottleController, c_functions |
| `windowsVersionDisplayName` | `windowsVersionDisplayName` | id | sim |  |  |

| Seletor ObjC | Função Python | Origem | GUI | Usado em |
|---|---|---|---|---|
| `initWithName:` | `initWithName_` | implicit | ✓ | CXServer<Produto>, LauncherApp, LauncherControlPanel, LauncherDiskFolder, LauncherFolder, LauncherIcon … |
| `addMenuObservers` | `add_menu_observers` | namedSelector |  |  |
| `removeMenuObservers` | `remove_menu_observers` | namedSelector |  |  |
| `unset:config:value` | `unset_config_value` | implicit |  |  |
| `suspend` | `suspend` | implicit | ✓ | ShutdownController |
| `resume` | `resume` | implicit | ✓ | CXServer<Produto>, DownloadProgressController, RegistrationController |
| `removeObservers` | `remove_observers` | namedSelector |  |  |
| `loadBasicInfo` | `load_basic_info` | namedSelector |  |  |
| `reloadInfo` | `reload_info` | namedSelector | ✓ | PackageInstaller |
| `refreshUpToDate` | `refresh_up_to_date` | namedSelector | ✓ |  |
| `setIsDefault:completionHandler:` | `set_is_default` | namedSelector | ✓ | BottleMenuHandler |
| `setGraphicsBackendAuto` | `set_graphics_backend_auto` | namedSelector | ✓ | BottleViewController, MainWindowController |
| `setGraphicsBackendD3DMetal` | `set_graphics_backend_d3dmetal` | namedSelector | ✓ | BottleViewController, MainWindowController |
| `setGraphicsBackendDXMT` | `set_graphics_backend_dxmt` | namedSelector | ✓ | BottleViewController, MainWindowController |
| `setGraphicsBackendDXVK` | `set_graphics_backend_dxvk` | namedSelector | ✓ | BottleViewController, MainWindowController |
| `setGraphicsBackendWine` | `set_graphics_backend_wine` | namedSelector | ✓ | BottleViewController, MainWindowController |
| `setVulkanBackendMoltenVK` | `set_vulkan_backend_moltenvk` | namedSelector | ✓ | BottleViewController, MainWindowController |
| `setVulkanBackendMTLVK` | `set_vulkan_backend_mtlvk` | namedSelector | ✓ | BottleViewController, MainWindowController |
| `enableDLSS` | `enable_dlss` | namedSelector | ✓ | BottleViewController, MainWindowController |
| `disableDLSS` | `disable_dlss` | namedSelector | ✓ | BottleViewController, MainWindowController |
| `loadHighResolutionInfo` | `load_high_resolution_info` | namedSelector | ✓ | MainWindowController |
| `enableHighResolution` | `enableHighResolution` | implicit | ✓ | BottleMenuHandler |
| `disableHighResolution` | `disable_high_resolution` | namedSelector | ✓ | BottleMenuHandler |
| `enableMSync` | `enable_msync` | namedSelector | ✓ | BottleMenuHandler |
| `disableMSync` | `disable_msync` | namedSelector | ✓ | BottleMenuHandler |
| `enablePreview` | `enable_preview` | namedSelector | ✓ | BottleMenuHandler |
| `disablePreview` | `disable_preview` | namedSelector | ✓ | BottleMenuHandler |
| `disableRatingNag` | `disable_rating_nag` | namedSelector | ✓ | SubmitRatingController |
| `loadControlPanelInfo` | `load_control_panel_info` | namedSelector | ✓ | BottleViewController |
| `launchControlPanelApplet:` | `launch_control_panel_applet` | namedSelector | ✓ | LauncherControlPanel |
| `loadApplicationInfo` | `load_application_info` | namedSelector | ✓ | BottleViewController, PackageInstaller |
| `fileIsInBottle:` | `file_is_in_bottle` | namedSelector | ✓ | CXServer<Produto> |
| `writeDescription` | `write_description` | namedSelector | ✓ | BottleViewController |
| `delete:` | `delete` | namedSelector | ✓ | BottleMenuHandler |
| `rename:completionHandler:` | `rename` | namedSelector | ✓ | BottleNode |
| `addChangeDelegate:` | `add_change_delegate` | namedSelector | ✓ | CXServer<Produto> |
| `removeChangeDelegate:` | `remove_change_delegate` | namedSelector |  |  |
| `addStatusOverride:` | `add_status_override` | namedSelector | ✓ | BottleMenuHandler, CXServer<Produto>, PackageInstaller |
| `removeAllStatusOverrides:` | `remove_all_status_overrides` | namedSelector | ✓ | PackageInstaller |
| `removeStatusOverride:` | `remove_status_override` | namedSelector | ✓ | BottleMenuHandler, CXServer<Produto> |
| `quit:` | `quit` | namedSelector | ✓ | BottleMenuHandler |
| `forceQuit:` | `force_quit` | namedSelector | ✓ | BottleMenuHandler |
| `getMissingDependenciesProfile` | `get_missing_dependencies_profile` | namedSelector | ✓ | BottleMenuHandler |
| `bottleName` | `bottleName` | implicit | ✓ | InstallConfiguration, NewBottleController, PackageInstaller, PublishController |

## `C4Profiles` (`c4profilesmanager`)

| Seletor ObjC | Função Python | Origem | GUI | Usado em |
|---|---|---|---|---|
| `profilesSet` | `profilesSet` | cxobjc.method | ✓ | BottleViewController, CDTools, PackageViewController, SubmitRatingController |
| `dropinC4PFile:withSig:` | `dropin_C4PFile` | cxobjc.method | ✓ | PackageViewController |
| `tasteC4PFile:` | `taste_c4p` | cxobjc.method | ✓ | PackageViewController |
| `prepareSingleUseC4PFile:` | `prepare_temp_c4p` | cxobjc.method | ✓ | PackageViewController |
| `getOnlineFilePath` | `getOnlineFilePath` | cxobjc.method | ✓ | CXServer<Produto> |
| `updateOnlineProfilesFromURL:` | `update_online_profiles` | cxobjc.method | ✓ | MainWindowController |
| `getMatchingProfiles:` | `get_matching_profiles` | cxobjc.method | ✓ | CXServer<Produto>, PackageViewController |

## `CDDetector` (`cddetector`)

| Seletor ObjC | Função Python | Origem | GUI | Usado em |
|---|---|---|---|---|
| `findMatchingProfilesForVolume:inProfiles:` | `get_cd_profiles` | cxobjc.method | ✓ | CDTools |

## `AIEScheduler` (`cxaiebase`)

| Seletor ObjC | Função Python | Origem | GUI | Usado em |
|---|---|---|---|---|
| `lock` | `lock` | implicit |  |  |
| `unlock` | `unlock` | implicit |  |  |
| `sortedRunnable` | `sortedRunnable` | implicit | ✓ | PackageInstaller |
| `runnable` | `runnable` | implicit |  |  |
| `schedule:` | `schedule` | namedSelector | ✓ | PackageInstaller |
| `allDone` | `allDone` | implicit | ✓ | PackageInstaller |
| `sortedTasks` | `get_sorted_tasks` | namedSelector | ✓ | PackageInstaller |

## `Engine` (`cxaiengine`)

| Seletor ObjC | Função Python | Origem | GUI | Usado em |
|---|---|---|---|---|
| `initWithInstallTask:logFile:channels:env:` | `initWithInstallTask_logFile_channels_env_` | implicit | ✓ | InstallConfiguration |

## `CXMenu` (`cxmenu`)

| Seletor ObjC | Função Python | Origem | GUI | Usado em |
|---|---|---|---|---|
| `localStartMenuPath` | `local_start_menu_path` | cxobjc.method | ✓ | RunCommandController |
| `localDesktopPath` | `local_desktop_path` | cxobjc.method | ✓ | RunCommandController |
| `createShortcutForBottle:command:name:folder:localDesktopPath:andStartMenuPath:` | `create_custom_shortcut` | cxobjc.method | ✓ | RunCommandController |

## `Proxy` (`cxobjc`)

| Seletor ObjC | Função Python | Origem | GUI | Usado em |
|---|---|---|---|---|
| `valueForUndefinedKey:` | `valueForUndefinedKey_` | implicit |  |  |
| `setValue:forUndefinedKey:` | `setValue_forUndefinedKey_` | implicit |  | DemoRegisterController, PackageInstaller, RegistrationController, SubmitRatingController, c_functions |

## `_UrlGetterDelegate` (`cxurlget_nsurl`)

| Seletor ObjC | Função Python | Origem | GUI | Usado em |
|---|---|---|---|---|
| `initWithOwner:` | `initWithOwner_` | implicit |  |  |
| `URLSession:didBecomeInvalidWithError:` | `URLSession_didBecomeInvalidWithError_` | implicit | ✓ | DownloadProgressController |
| `URLSession:task:didCompleteWithError:` | `URLSession_task_didCompleteWithError_` | implicit | ✓ | DownloadProgressController |
| `URLSession:dataTask:didReceiveResponse:completionHandler:` | `URLSession_dataTask_didReceiveResponse_completionHandler_` | implicit |  | DownloadProgressController |
| `URLSession:dataTask:didReceiveData:` | `URLSession_dataTask_didReceiveData_` | implicit |  | DownloadProgressController |

## `CXUtils` (`cxutils`)

| Seletor ObjC | Função Python | Origem | GUI | Usado em |
|---|---|---|---|---|
| `sanitizedBottleName:` | `sanitize_bottlename` | cxobjc.method | ✓ | InstallConfiguration |
| `cmdLineToArgv:` | `cmdlinetoargv` | cxobjc.method | ✓ | RunCommandController |
| `basename:` | `basename` | cxobjc.method |  |  |
| `dirname:` | `dirname` | cxobjc.method | ✓ | RunCommandController |
| `getLanguageValue:forLanguage:` | `get_language_value` | cxobjc.method | ✓ | PackageTreeNode |
| `installerLoggingPreset` | `installer_logging_preset` | cxobjc.method | ✓ | InstallOptionsSheetController |
| `loggingPresets` | `logging_presets` | cxobjc.method | ✓ | LoggingOption |

## `DemoUtils` (`demoutils`)

| Seletor ObjC | Função Python | Origem | GUI | Usado em |
|---|---|---|---|---|
| `demoStatusForLicenseFile:andSig:` | `demo_status` | cxobjc.method | ✓ | CXApplication, RegistrationController |
| `serialRegistrationURL` | `serial_reg_url` | cxobjc.method | ✓ | RegistrationController |
| `licenseUrlForLogin:andPassword:` | `reg_license_url` | cxobjc.method | ✓ | RegistrationController |
| `createAccountRequestBodyForEmail:name:andPassword:withSerialCode:` | `create_account_request_body_for_email_name_password_with_serial_code` | cxobjc.method | ✓ | RegistrationController |
| `checkSerialCodeRegistrationResponse:` | `checkSerialCodeRegistrationResponse` | cxobjc.method | ✓ | RegistrationController |
| `splitLicenseAndSigFromBuffer:` | `splitLicenseAndSigFromBuffer` | cxobjc.method | ✓ | RegistrationController |
| `lastResort` | `lastResort` | cxobjc.method | ✓ | RegistrationController |
| `checkLicenseDownload:` | `checkLicenseDownload` | cxobjc.method | ✓ | RegistrationController |

## `IconUtils` (`iconutils`)

| Seletor ObjC | Função Python | Origem | GUI | Usado em |
|---|---|---|---|---|
| `init` | `init` | implicit | ✓ | BottleMenuHandler, BottleNode, BottleViewController, BuySupportNagController, CDTools, CXApplication … |
| `getIconPath:` | `get_icon_path` | namedSelector | ✓ | PackageTreeNode |
| `fetchIconList` | `fetch_icon_list` | namedSelector | ✓ | PackageTreeNode |
| `fetchIcon:` | `fetch_icon` | namedSelector | ✓ | PackageTreeNode |

## `InstallTask` (`installtask`)

| Seletor ObjC | Função Python | Origem | GUI | Usado em |
|---|---|---|---|---|
| `initWithDelegate:` | `initWithDelegate_` | implicit | ✓ | InstallConfiguration |
| `init` | `init` | implicit | ✓ | BottleMenuHandler, BottleNode, BottleViewController, BuySupportNagController, CDTools, CXApplication … |
| `setDelegate:` | `set_delegate` | namedSelector | ✓ | BottleViewController, CXApplication, CXServer, CXServer<Produto>, CXWindowController, IconCollectionViewController … |
| `autoFillSettings` | `auto_fill_settings` | namedSelector | ✓ | InstallConfiguration, PackageInstaller |
| `volumeMatchesProfile:` | `volume_matches_profile` | namedSelector | ✓ | InstallConfiguration, PackageInstaller |
| `profileLanguages` | `profileLanguages` | implicit | ✓ | InstallConfiguration, InstallOptionsSheetController |
| `setProfile:` | `setProfile_` | implicit | ✓ | InstallConfiguration |
| `updateProfiles` | `update_profiles` | namedSelector | ✓ | InstallConfiguration, PackageInstaller, PackageViewController |
| `useAutorunFile:` | `use_autorun_file` | namedSelector | ✓ | InstallConfiguration, PackageInstaller |
| `setLocale:` | `SetLocale` | namedSelector | ✓ | CXApplication, CXServer<Produto>, InstallConfiguration, PackageTreeNode |
| `addDependencyOverrides:ofType:` | `AddDependencyOverrides` | namedSelector | ✓ | AddDependenciesViewController, InstallOptionsSheetController |
| `removeDependencyOverrides:` | `RemoveDependencyOverrides` | namedSelector | ✓ | InstallOptionsSheetController |
| `ClearDependencyOverrides` | `ClearDependencyOverrides` | implicit | ✓ | InstallOptionsSheetController |
| `SuggestedDependencyOverrides` | `SuggestedDependencyOverrides` | implicit | ✓ | AddDependenciesViewController |
| `addSourceMedia:withLabel:andDevice:` | `add_source_media` | namedSelector | ✓ | InstallConfiguration, PackageInstaller |
| `removeSourceMedia:` | `remove_source_media` | namedSelector | ✓ | InstallConfiguration, PackageInstaller |
| `setInstallerSource:Requested:` | `setInstallerSource_Requested_` | implicit | ✓ | InstallConfiguration, PackageInstaller, PackageViewController |
| `setInstallerDownload` | `setInstallerDownload` | implicit | ✓ | InstallConfiguration, PackageViewController |
| `setInstallerSteam` | `setInstallerSteam` | implicit | ✓ | InstallConfiguration, PackageViewController |
| `addBottle:` | `add_bottle` | namedSelector | ✓ | InstallConfiguration, PackageInstaller |
| `installedApplicationsReady:` | `installed_applications_ready` | namedSelector | ✓ | InstallConfiguration, PackageInstaller |
| `triggerBottleAnalysis` | `trigger_bottle_analysis` | namedSelector | ✓ | InstallConfiguration, PackageInstaller |
| `removeBottle:` | `remove_bottle` | namedSelector | ✓ | InstallConfiguration, PackageInstaller |
| `isNewBottleNameValid:` | `is_new_bottle_name_valid` | namedSelector | ✓ | InstallConfiguration, SelectBottleSheetController |
| `setNewBottleName:` | `_set_new_bottle_name` | namedSelector | ✓ | InstallConfiguration, PackageInstaller, PackageViewController |
| `createNewBottle:template:` | `createNewBottle_template_` | implicit | ✓ | InstallConfiguration, SelectBottleSheetController |
| `GetCreateNewBottle` | `GetCreateNewBottle` | implicit | ✓ | InstallConfiguration |
| `is64bit` | `is64bit` | implicit | ✓ |  |
| `getDependencyDetails` | `get_dependency_details` | namedSelector | ✓ | InstallConfiguration |
| `getInstallerDetails` | `get_installer_details` | namedSelector | ✓ | InstallConfiguration |
| `getBottleDetails` | `get_bottle_details` | namedSelector | ✓ | InstallConfiguration |
| `getLanguageDetails` | `get_language_details` | namedSelector | ✓ | InstallConfiguration |
| `getMiscDetails` | `get_misc_details` | namedSelector | ✓ | InstallConfiguration |
| `getMissingDependencies:` | `get_missing_dependencies` | cxobjc.method | ✓ | BottleViewController |

## `RatingUtils` (`ratingutils`)

| Seletor ObjC | Função Python | Origem | GUI | Usado em |
|---|---|---|---|---|
| `initWithAppID:` | `initWithAppID_` | implicit | ✓ | SubmitRatingController |
| `fetchRating` | `get_rating` | namedSelector | ✓ | SubmitRatingController |
| `setRating:Notes:` | `set_rating` | namedSelector | ✓ | SubmitRatingController |

## `SystemInfo` (`systeminfo`)

| Seletor ObjC | Função Python | Origem | GUI | Usado em |
|---|---|---|---|---|
| `systemInformationString` | `system_info_string` | cxobjc.method | ✓ | RunCommandController |
| `systemInformationStringForBottle:` | `_system_info_string_for_bottle` | cxobjc.method | ✓ | RunCommandController |

## `WebUtils` (`webutils`)

| Seletor ObjC | Função Python | Origem | GUI | Usado em |
|---|---|---|---|---|
| `createToken:password:` | `create_token` | cxobjc.method | ✓ | RegistrationController, SubmitRatingController |
| `updateCompatDB` | `update_compatdb` | cxobjc.method | ✓ | MainWindowController |

