/*
 * MenuHelper.decompiled.c — pseudocódigo bruto (Ghidra 12.1.4 via REA) do
 * "Menu Helper" do CrossOver 26.3 (Contents/Resources/Menu Helper.cpbz2,
 * Contents/MacOS/Menu Helper, Mach-O x86_64).
 *
 * NÃO é compilável: é a saída do decompilador, preservada como em decompiled/.
 * A especificação legível e o que é reconstruível estão em README.md.
 *
 * O Menu Helper é um lançador por-programa: ao ser aberto, roda o programa
 * Windows da bottle via Wine (cxmenu/cxstart --bottle <nome> --enable-alt-loader
 * macdrv --start <menuPath>) usando CXTask, opcionalmente com um WineLoader
 * embarcado (socket AF_UNIX, protocolo length-prefixed com passagem de fd) que
 * hospeda a app Wine e encaminha eventos Cocoa (CXFBHelperApp sendEvent: ->
 * wineController handleEvent:).
 */


/* ===== -[CXFBHelperDelegate applicationWillFinishLaunching:] @0x200002edd ===== */

/* Function Stack Size: 0x18 bytes */

void CXFBHelperDelegate::applicationWillFinishLaunching_(ID param_1,SEL param_2,ID param_3)

{
  undefined *puVar1;
  char cVar2;
  undefined8 uVar3;
  ID IVar4;
  undefined8 uVar5;
  undefined8 uVar6;
  undefined8 uVar7;
  undefined8 uVar8;
  undefined8 uVar9;
  long lVar10;
  undefined8 uVar11;
  undefined8 uVar12;
  undefined8 uVar13;
  undefined8 uVar14;
  int iVar15;
  long lVar16;
  undefined8 local_40;
  long local_38;
  
  local_38 = *(long *)PTR____stack_chk_guard_20000c0d8;
  uVar3 = (*(code *)PTR__objc_retain_20000c110)(param_3);
  IVar4 = NSAppleEventManager::sharedAppleEventManager
                    ((ID)&_OBJC_CLASS___NSAppleEventManager,"sharedAppleEventManager");
  uVar5 = _objc_retainAutoreleasedReturnValue(IVar4);
  (*(code *)PTR__objc_msgSend_20000c100)
            (uVar5,"setEventHandler:andSelector:forEventClass:andEventID:",param_1,
             "handleGetURLEvent:withReplyEvent:",&DAT_4755524c,&DAT_4755524c);
  IVar4 = NSBundle::mainBundle((ID)&_OBJC_CLASS___NSBundle,"mainBundle");
  uVar6 = _objc_retainAutoreleasedReturnValue(IVar4);
  uVar7 = (*(code *)PTR__objc_msgSend_20000c100)
                    (uVar6,"objectForInfoDictionaryKey:",&cf_CXHelperAppBottleName);
  uVar8 = _objc_retainAutoreleasedReturnValue(uVar7);
  uVar9 = (*(code *)PTR__objc_msgSend_20000c100)(uVar8,"copy");
  uVar7 = *(undefined8 *)(param_1 + bottleName);
  *(undefined8 *)(param_1 + bottleName) = uVar9;
  puVar1 = PTR__objc_release_20000c108;
  (*(code *)PTR__objc_release_20000c108)(uVar7);
  (*(code *)puVar1)(uVar8);
  (*(code *)puVar1)(uVar6);
  IVar4 = NSBundle::mainBundle((ID)&_OBJC_CLASS___NSBundle,"mainBundle");
  uVar7 = _objc_retainAutoreleasedReturnValue(IVar4);
  uVar6 = (*(code *)PTR__objc_msgSend_20000c100)
                    (uVar7,"objectForInfoDictionaryKey:",&cf_CXHelperAppBottleTag);
  uVar6 = _objc_retainAutoreleasedReturnValue(uVar6);
  (*(code *)PTR__objc_release_20000c108)(uVar7);
  puVar1 = PTR__objc_msgSend_20000c100;
  lVar10 = (*(code *)PTR__objc_msgSend_20000c100)(uVar6,"length");
  uVar7 = (*(code *)puVar1)(uVar6,"substringToIndex:",lVar10 + -1);
  uVar7 = _objc_retainAutoreleasedReturnValue(uVar7);
  (*(code *)PTR__objc_release_20000c108)(uVar6);
  IVar4 = NSAppleEventDescriptor::recordDescriptor
                    ((ID)&_OBJC_CLASS___NSAppleEventDescriptor,"recordDescriptor");
  uVar6 = _objc_retainAutoreleasedReturnValue(IVar4);
  IVar4 = NSAppleEventDescriptor::descriptorWithString_
                    ((ID)&_OBJC_CLASS___NSAppleEventDescriptor,"descriptorWithString:",
                     *(undefined8 *)(bottleName + param_1));
  uVar8 = _objc_retainAutoreleasedReturnValue(IVar4);
  (*(code *)PTR__objc_msgSend_20000c100)(uVar6,"setDescriptor:forKeyword:",uVar8,&DAT_42744e6d);
  (*(code *)PTR__objc_release_20000c108)(uVar8);
  IVar4 = NSAppleEventDescriptor::descriptorWithString_
                    ((ID)&_OBJC_CLASS___NSAppleEventDescriptor,"descriptorWithString:",uVar7);
  uVar8 = _objc_retainAutoreleasedReturnValue(IVar4);
  (*(code *)PTR__objc_msgSend_20000c100)(uVar6,"setDescriptor:forKeyword:",uVar8,&DAT_42745467);
  (*(code *)PTR__objc_release_20000c108)(uVar8);
  IVar4 = NSWorkspace::sharedWorkspace((ID)&_OBJC_CLASS___NSWorkspace,"sharedWorkspace");
  uVar8 = _objc_retainAutoreleasedReturnValue(IVar4);
  IVar4 = NSBundle::mainBundle((ID)&_OBJC_CLASS___NSBundle,"mainBundle");
  uVar9 = _objc_retainAutoreleasedReturnValue(IVar4);
  uVar11 = (*(code *)PTR__objc_msgSend_20000c100)(uVar9,"bundleURL");
  uVar11 = _objc_retainAutoreleasedReturnValue(uVar11);
  local_40 = uVar11;
  IVar4 = NSArray::arrayWithObjects_count_
                    ((ID)&_OBJC_CLASS___NSArray,"arrayWithObjects:count:",&local_40,1);
  uVar12 = _objc_retainAutoreleasedReturnValue(IVar4);
  (*(code *)PTR__objc_msgSend_20000c100)
            (uVar8,
             "CX_openURLs:withAppBundleIdentifier:orIdentifyingURLScheme:options:additionalEventParamDescriptor:"
             ,uVar12,&cf_com_codeweavers_CrossOver,&cf_com_codeweavers_private_CrossOver_app_scheme,
             0x300,uVar6);
  (*(code *)PTR__objc_release_20000c108)(uVar12);
  (*(code *)PTR__objc_release_20000c108)(uVar11);
  (*(code *)PTR__objc_release_20000c108)(uVar9);
  (*(code *)PTR__objc_release_20000c108)(uVar8);
  lVar10 = helperServerProxy;
  iVar15 = 10;
  do {
    lVar16 = *(long *)(param_1 + lVar10);
    if (lVar16 != 0) goto LAB_200003272;
    IVar4 = NSConnection::rootProxyForConnectionWithRegisteredName_host_
                      ((ID)&_OBJC_CLASS___NSConnection,
                       "rootProxyForConnectionWithRegisteredName:host:",
                       &cf_com_codeweavers_CrossOver_HelperServer,0);
    uVar9 = _objc_retainAutoreleasedReturnValue(IVar4);
    uVar8 = *(undefined8 *)(param_1 + lVar10);
    *(undefined8 *)(param_1 + lVar10) = uVar9;
    (*(code *)PTR__objc_release_20000c108)(uVar8);
    if (*(long *)(param_1 + lVar10) == 0) {
      _sleep(1);
    }
    iVar15 = iVar15 + -1;
  } while (iVar15 != 0);
  lVar16 = *(long *)(param_1 + lVar10);
  if (lVar16 == 0) {
    _NSLog(&cf_UnabletolocateaCrossOverhelperserver_Weshouldreallytellsomeoneaboutthis_);
    (*(code *)PTR__objc_msgSend_20000c100)(*(undefined8 *)PTR__NSApp_20000c008,"terminate:",param_1)
    ;
    lVar16 = *(long *)(param_1 + lVar10);
  }
LAB_200003272:
  (*(code *)PTR__objc_msgSend_20000c100)
            (lVar16,"setProtocolForProxy:",&objc::protocol_t::HelperServer);
  IVar4 = NSBundle::mainBundle((ID)&_OBJC_CLASS___NSBundle,"mainBundle");
  uVar9 = _objc_retainAutoreleasedReturnValue(IVar4);
  uVar8 = (*(code *)PTR__objc_msgSend_20000c100)
                    (uVar9,"objectForInfoDictionaryKey:",&cf_CXHelperAppBottleName);
  uVar11 = _objc_retainAutoreleasedReturnValue(uVar8);
  uVar12 = (*(code *)PTR__objc_msgSend_20000c100)(uVar11,"copy");
  uVar8 = *(undefined8 *)(param_1 + bottleName);
  *(undefined8 *)(param_1 + bottleName) = uVar12;
  (*(code *)PTR__objc_release_20000c108)(uVar8);
  (*(code *)PTR__objc_release_20000c108)(uVar11);
  (*(code *)PTR__objc_release_20000c108)(uVar9);
  puVar1 = PTR__objc_msgSend_20000c100;
  while( true ) {
    cVar2 = (*(code *)puVar1)(*(undefined8 *)(param_1 + lVar10),"isServerReadyForBottle:",
                              *(undefined8 *)(param_1 + bottleName));
    if (cVar2 != '\0') break;
    _sleep(1);
  }
  IVar4 = NSBundle::mainBundle((ID)&_OBJC_CLASS___NSBundle,"mainBundle");
  uVar9 = _objc_retainAutoreleasedReturnValue(IVar4);
  uVar8 = (*(code *)PTR__objc_msgSend_20000c100)
                    (uVar9,"objectForInfoDictionaryKey:",&cf_CrossOverHelperMenuPath);
  uVar11 = _objc_retainAutoreleasedReturnValue(uVar8);
  uVar12 = (*(code *)PTR__objc_msgSend_20000c100)(uVar11,"copy");
  uVar8 = *(undefined8 *)(param_1 + menuPath);
  *(undefined8 *)(param_1 + menuPath) = uVar12;
  (*(code *)PTR__objc_release_20000c108)(uVar8);
  (*(code *)PTR__objc_release_20000c108)(uVar11);
  (*(code *)PTR__objc_release_20000c108)(uVar9);
  IVar4 = NSWorkspace::sharedWorkspace((ID)&_OBJC_CLASS___NSWorkspace,"sharedWorkspace");
  uVar8 = _objc_retainAutoreleasedReturnValue(IVar4);
  uVar9 = (*(code *)PTR__objc_msgSend_20000c100)
                    (uVar8,"CX_absolutePathForAppBundleWithIdentifier:orIdentifyingURLScheme:",
                     &cf_com_codeweavers_CrossOver,&cf_com_codeweavers_private_CrossOver_app_scheme)
  ;
  uVar9 = _objc_retainAutoreleasedReturnValue(uVar9);
  (*(code *)PTR__objc_release_20000c108)(uVar8);
  IVar4 = NSBundle::bundleWithPath_((ID)&_OBJC_CLASS___NSBundle,"bundleWithPath:",uVar9);
  uVar11 = _objc_retainAutoreleasedReturnValue(IVar4);
  uVar8 = (*(code *)PTR__objc_msgSend_20000c100)(uVar11,"sharedSupportPath");
  uVar12 = _objc_retainAutoreleasedReturnValue(uVar8);
  uVar8 = (*(code *)PTR__objc_msgSend_20000c100)
                    (uVar12,"stringByAppendingPathComponent:",&cf_CrossOver);
  uVar13 = _objc_retainAutoreleasedReturnValue(uVar8);
  uVar14 = (*(code *)PTR__objc_msgSend_20000c100)(uVar13,"copy");
  lVar10 = crossOverRoot;
  uVar8 = *(undefined8 *)(param_1 + crossOverRoot);
  *(undefined8 *)(param_1 + crossOverRoot) = uVar14;
  (*(code *)PTR__objc_release_20000c108)(uVar8);
  (*(code *)PTR__objc_release_20000c108)(uVar13);
  (*(code *)PTR__objc_release_20000c108)(uVar12);
  (*(code *)PTR__objc_release_20000c108)(uVar11);
  uVar8 = (*(code *)PTR__objc_msgSend_20000c100)
                    (*(undefined8 *)(lVar10 + param_1),"stringByAppendingPathComponent:",&cf_bin);
  uVar11 = _objc_retainAutoreleasedReturnValue(uVar8);
  uVar8 = (*(code *)PTR__objc_msgSend_20000c100)
                    (uVar11,"stringByAppendingPathComponent:",&cf_cxmenu);
  uVar12 = _objc_retainAutoreleasedReturnValue(uVar8);
  uVar13 = (*(code *)PTR__objc_msgSend_20000c100)(uVar12,"copy");
  uVar8 = *(undefined8 *)(param_1 + cxmenuPath);
  *(undefined8 *)(param_1 + cxmenuPath) = uVar13;
  (*(code *)PTR__objc_release_20000c108)(uVar8);
  (*(code *)PTR__objc_release_20000c108)(uVar12);
  uVar8 = (*(code *)PTR__objc_msgSend_20000c100)
                    (uVar11,"stringByAppendingPathComponent:",&cf_cxstart);
  uVar12 = _objc_retainAutoreleasedReturnValue(uVar8);
  uVar13 = (*(code *)PTR__objc_msgSend_20000c100)(uVar12,"copy");
  uVar8 = *(undefined8 *)(param_1 + cxstartPath);
  *(undefined8 *)(param_1 + cxstartPath) = uVar13;
  (*(code *)PTR__objc_release_20000c108)(uVar8);
  (*(code *)PTR__objc_release_20000c108)(uVar12);
  uVar8 = (*(code *)PTR__objc_msgSend_20000c100)(uVar11,"stringByAppendingPathComponent:",&cf_wine);
  uVar12 = _objc_retainAutoreleasedReturnValue(uVar8);
  uVar13 = (*(code *)PTR__objc_msgSend_20000c100)(uVar12,"copy");
  uVar8 = *(undefined8 *)(param_1 + winePath);
  *(undefined8 *)(param_1 + winePath) = uVar13;
  (*(code *)PTR__objc_release_20000c108)(uVar8);
  (*(code *)PTR__objc_release_20000c108)(uVar12);
  uVar8 = (*(code *)PTR__objc_msgSend_20000c100)(*(undefined8 *)PTR__NSApp_20000c008,"mainMenu");
  IVar4 = _objc_retainAutoreleasedReturnValue(uVar8);
  formatMenuItemsWithBundleName_(param_1,"formatMenuItemsWithBundleName:",IVar4);
  (*(code *)PTR__objc_release_20000c108)(IVar4);
  (*(code *)PTR__objc_release_20000c108)(uVar11);
  (*(code *)PTR__objc_release_20000c108)(uVar9);
  (*(code *)PTR__objc_release_20000c108)(uVar6);
  (*(code *)PTR__objc_release_20000c108)(uVar7);
  (*(code *)PTR__objc_release_20000c108)(uVar5);
  (*(code *)PTR__objc_release_20000c108)(uVar3);
  if (*(long *)PTR____stack_chk_guard_20000c0d8 == local_38) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  ___stack_chk_fail();
}

/* ===== -[CXFBHelperDelegate applicationOpenUntitledFile:] @0x200002200 ===== */

/* Function Stack Size: 0x18 bytes */

char CXFBHelperDelegate::applicationOpenUntitledFile_(ID param_1,SEL param_2,ID param_3)

{
  undefined *puVar1;
  ID IVar2;
  ID IVar3;
  long lVar4;
  
  puVar1 = PTR__objc_msgSend_20000c100;
  IVar3 = *(ID *)(param_1 + cxmenuPath);
  IVar2 = NSArray::arrayWithObjects_
                    ((ID)&_OBJC_CLASS___NSArray,"arrayWithObjects:",&cf___bottle,
                     *(undefined8 *)(param_1 + bottleName),&cf___wait_children,
                     &cf___enable_alt_loader,&cf_macdrv,&cf___start,
                     *(undefined8 *)(param_1 + menuPath),0);
  IVar2 = _objc_retainAutoreleasedReturnValue(IVar2);
  IVar3 = createWineTaskWithLaunchPath_andArguments_
                    (param_1,"createWineTaskWithLaunchPath:andArguments:",IVar3,IVar2);
  lVar4 = _objc_retainAutoreleasedReturnValue(IVar3);
  (*(code *)PTR__objc_release_20000c108)(IVar2);
  if (lVar4 != 0) {
    (*(code *)puVar1)(lVar4,"launch");
    (*(code *)puVar1)(*(undefined8 *)(param_1 + taskArray),"addObject:",lVar4);
  }
  (*(code *)PTR__objc_release_20000c108)(lVar4);
  return '\x01';
}

/* ===== -[CXFBHelperDelegate handleGetURLEvent:withReplyEvent:] @0x2000037ab ===== */

/* Function Stack Size: 0x20 bytes */

void CXFBHelperDelegate::handleGetURLEvent_withReplyEvent_
               (ID param_1,SEL param_2,ID param_3,ID param_4)

{
  undefined *puVar1;
  undefined8 uVar2;
  undefined8 uVar3;
  long lVar4;
  ID IVar5;
  ID IVar6;
  long lVar7;
  
  puVar1 = PTR__objc_msgSend_20000c100;
  uVar2 = (*(code *)PTR__objc_msgSend_20000c100)(param_3,"paramDescriptorForKeyword:",&DAT_2d2d2d2d)
  ;
  uVar2 = _objc_retainAutoreleasedReturnValue(uVar2);
  uVar3 = (*(code *)puVar1)(uVar2,"stringValue");
  lVar4 = _objc_retainAutoreleasedReturnValue(uVar3);
  if (lVar4 != 0) {
    IVar6 = *(ID *)(param_1 + cxstartPath);
    IVar5 = NSArray::arrayWithObjects_
                      ((ID)&_OBJC_CLASS___NSArray,"arrayWithObjects:",&cf___bottle,
                       *(undefined8 *)(param_1 + bottleName),&cf___enable_alt_loader,&cf_macdrv__,
                       lVar4,0);
    IVar5 = _objc_retainAutoreleasedReturnValue(IVar5);
    IVar6 = createWineTaskWithLaunchPath_andArguments_
                      (param_1,"createWineTaskWithLaunchPath:andArguments:",IVar6,IVar5);
    lVar7 = _objc_retainAutoreleasedReturnValue(IVar6);
    (*(code *)PTR__objc_release_20000c108)(IVar5);
    puVar1 = PTR__objc_msgSend_20000c100;
    if (lVar7 != 0) {
      (*(code *)PTR__objc_msgSend_20000c100)(lVar7,"launch");
      (*(code *)puVar1)(*(undefined8 *)(param_1 + taskArray),"addObject:",lVar7);
    }
    (*(code *)PTR__objc_release_20000c108)(lVar7);
  }
  puVar1 = PTR__objc_release_20000c108;
  (*(code *)PTR__objc_release_20000c108)(lVar4);
  (*(code *)puVar1)(uVar2);
  return;
}

/* ===== -[CXFBHelperDelegate application:openFiles:] @0x2000022e9 ===== */

/* Function Stack Size: 0x20 bytes */

void CXFBHelperDelegate::application_openFiles_(ID param_1,SEL param_2,ID param_3,ID param_4)

{
  undefined *puVar1;
  undefined *puVar2;
  char *pcVar3;
  char cVar4;
  ID IVar5;
  undefined8 uVar6;
  undefined8 uVar7;
  undefined8 uVar8;
  long lVar9;
  undefined8 local_1a8;
  long lStack_1a0;
  long *local_198;
  undefined8 uStack_190;
  undefined8 local_188;
  undefined8 uStack_180;
  undefined8 local_178;
  undefined8 uStack_170;
  undefined8 local_168;
  undefined8 local_160;
  char *local_158;
  char *local_150;
  char *local_148;
  char *local_140;
  char *local_138;
  ID local_130;
  long local_128;
  char *local_120;
  long local_118;
  undefined8 local_110;
  undefined8 local_108;
  long local_100;
  undefined8 local_f8;
  undefined8 local_f0;
  undefined8 local_e8;
  undefined8 local_e0;
  undefined8 local_d8;
  long local_d0;
  undefined8 local_c8;
  undefined4 local_bc;
  undefined1 local_b8 [128];
  long local_38;
  
  puVar1 = PTR__objc_retain_20000c110;
  local_38 = *(long *)PTR____stack_chk_guard_20000c0d8;
  local_110 = (*(code *)PTR__objc_retain_20000c110)(param_3);
  local_d0 = (*(code *)puVar1)(param_4);
  puVar1 = PTR__objc_msgSend_20000c100;
  IVar5 = NSBundle::mainBundle((ID)&_OBJC_CLASS___NSBundle,"mainBundle");
  uVar6 = _objc_retainAutoreleasedReturnValue(IVar5);
  uVar7 = (*(code *)puVar1)(uVar6,"objectForInfoDictionaryKey:",&cf_CFBundleDocumentTypes);
  uVar7 = _objc_retainAutoreleasedReturnValue(uVar7);
  puVar2 = PTR__objc_release_20000c108;
  (*(code *)PTR__objc_release_20000c108)(uVar6);
  local_108 = uVar7;
  uVar6 = (*(code *)puVar1)(uVar7,"valueForKeyPath:",
                            &cf__distinctUnionOfArrays_CFBundleTypeExtensions);
  uVar6 = _objc_retainAutoreleasedReturnValue(uVar6);
  IVar5 = NSSet::setWithArray_((ID)&_OBJC_CLASS___NSSet,"setWithArray:",uVar6);
  local_f8 = _objc_retainAutoreleasedReturnValue(IVar5);
  (*(code *)puVar2)(uVar6);
  puVar2 = PTR__objc_retain_20000c110;
  local_f0 = (*(code *)PTR__objc_retain_20000c110)(*(undefined8 *)(param_1 + cxstartPath));
  IVar5 = NSMutableArray::arrayWithObjects_
                    ((ID)&_OBJC_CLASS___NSMutableArray,"arrayWithObjects:",&cf___bottle,
                     *(undefined8 *)(param_1 + bottleName),&cf___wait_children,
                     &cf___enable_alt_loader,&cf_macdrv,&cf___,0);
  local_e8 = _objc_retainAutoreleasedReturnValue(IVar5);
  local_e0 = (*(code *)puVar2)(*(undefined8 *)(param_1 + cxmenuPath));
  IVar5 = NSMutableArray::arrayWithObjects_
                    ((ID)&_OBJC_CLASS___NSMutableArray,"arrayWithObjects:",&cf___bottle,
                     *(undefined8 *)(param_1 + bottleName),&cf___wait_children,
                     &cf___enable_alt_loader,&cf_macdrv,&cf___start,
                     *(undefined8 *)(param_1 + menuPath),0);
  local_d8 = _objc_retainAutoreleasedReturnValue(IVar5);
  local_1a8 = 0;
  lStack_1a0 = 0;
  local_198 = (long *)0x0;
  uStack_190 = 0;
  local_188 = 0;
  uStack_180 = 0;
  local_178 = 0;
  uStack_170 = 0;
  uVar6 = (*(code *)PTR__objc_retain_20000c110)(local_d0);
  local_100 = (*(code *)puVar1)(uVar6,"countByEnumeratingWithState:objects:count:",&local_1a8,
                                local_b8,0x10);
  if (local_100 == 0) {
    (*(code *)PTR__objc_release_20000c108)(uVar6);
    cVar4 = '\0';
  }
  else {
    local_128 = *local_198;
    local_bc = (undefined4)CONCAT71((int7)((ulong)local_128 >> 8),1);
    local_130 = param_1;
    local_c8 = uVar6;
    do {
      local_158 = "pathExtension";
      local_150 = "containsObject:";
      local_148 = "createWineTaskWithLaunchPath:andArguments:";
      local_120 = "launch";
      local_118 = taskArray;
      local_140 = "removeLastObject";
      lVar9 = 0;
      local_138 = "addObject:";
      do {
        if (*local_198 != local_128) {
          _objc_enumerationMutation(local_c8);
        }
        uVar6 = *(undefined8 *)(lStack_1a0 + lVar9 * 8);
        local_d0 = lVar9;
        uVar7 = (*(code *)puVar1)(uVar6,local_158);
        local_168 = _objc_retainAutoreleasedReturnValue(uVar7);
        cVar4 = (*(code *)puVar1)(local_f8,local_150,local_168);
        puVar2 = PTR__objc_retain_20000c110;
        uVar8 = local_e8;
        uVar7 = local_f0;
        if (cVar4 == '\0') {
          uVar8 = local_d8;
          uVar7 = local_e0;
        }
        uVar7 = (*(code *)PTR__objc_retain_20000c110)(uVar7);
        uVar8 = (*(code *)puVar2)(uVar8);
        pcVar3 = local_138;
        (*(code *)puVar1)(uVar8,local_138,uVar6);
        IVar5 = local_130;
        local_160 = uVar7;
        uVar6 = (*(code *)puVar1)(local_130,local_148,uVar7,uVar8);
        lVar9 = _objc_retainAutoreleasedReturnValue(uVar6);
        if (lVar9 == 0) {
          local_bc = 0;
        }
        else {
          (*(code *)puVar1)(lVar9,local_120);
          (*(code *)puVar1)(*(undefined8 *)(IVar5 + local_118),pcVar3,lVar9);
        }
        (*(code *)puVar1)(uVar8,local_140);
        puVar2 = PTR__objc_release_20000c108;
        (*(code *)PTR__objc_release_20000c108)(lVar9);
        (*(code *)puVar2)(uVar8);
        (*(code *)puVar2)(local_160);
        (*(code *)puVar2)(local_168);
        lVar9 = local_d0 + 1;
      } while (local_100 != lVar9);
      local_100 = (*(code *)puVar1)(local_c8,"countByEnumeratingWithState:objects:count:",&local_1a8
                                    ,local_b8,0x10);
      uVar6 = local_c8;
    } while (local_100 != 0);
    (*(code *)PTR__objc_release_20000c108)(local_c8);
    cVar4 = ((char)local_bc == '\0') * '\x02';
  }
  uVar7 = local_110;
  (*(code *)PTR__objc_msgSend_20000c100)(local_110,"replyToOpenOrPrint:",cVar4);
  puVar1 = PTR__objc_release_20000c108;
  (*(code *)PTR__objc_release_20000c108)(local_d8);
  (*(code *)puVar1)(local_e0);
  (*(code *)puVar1)(local_e8);
  (*(code *)puVar1)(local_f0);
  (*(code *)puVar1)(local_f8);
  (*(code *)puVar1)(local_108);
  (*(code *)puVar1)(uVar6);
  (*(code *)puVar1)(uVar7);
  if (*(long *)PTR____stack_chk_guard_20000c0d8 != local_38) {
                    /* WARNING: Subroutine does not return */
    ___stack_chk_fail();
  }
  return;
}

/* ===== -[CXFBHelperDelegate createWineTaskWithLaunchPath:andArguments:] @0x2000027ed ===== */

/* Function Stack Size: 0x20 bytes */

ID CXFBHelperDelegate::createWineTaskWithLaunchPath_andArguments_
             (ID param_1,SEL param_2,ID param_3,ID param_4)

{
  undefined *puVar1;
  undefined *puVar2;
  char cVar3;
  ID IVar4;
  undefined8 uVar5;
  undefined8 uVar6;
  undefined8 uVar7;
  ID IVar8;
  undefined8 uVar9;
  undefined8 uVar10;
  undefined8 uVar11;
  long lVar12;
  ID IVar13;
  long lVar14;
  
  puVar1 = PTR__objc_retain_20000c110;
  IVar4 = (*(code *)PTR__objc_retain_20000c110)(param_4);
  uVar5 = (*(code *)puVar1)(param_3);
  uVar6 = _NSHomeDirectory();
  uVar6 = _objc_retainAutoreleasedReturnValue(uVar6);
  puVar1 = PTR__objc_msgSend_20000c100;
  uVar7 = (*(code *)PTR__objc_msgSend_20000c100)
                    (*(undefined8 *)(param_1 + helperServerProxy),"getEnvironmentForXConnection");
  uVar7 = _objc_retainAutoreleasedReturnValue(uVar7);
  IVar8 = NSBundle::mainBundle((ID)&_OBJC_CLASS___NSBundle,"mainBundle");
  uVar9 = _objc_retainAutoreleasedReturnValue(IVar8);
  uVar10 = (*(code *)puVar1)(uVar9,"objectForInfoDictionaryKey:",
                             *(undefined8 *)PTR__kCFBundleNameKey_20000c0f0);
  uVar10 = _objc_retainAutoreleasedReturnValue(uVar10);
  (*(code *)puVar1)(uVar7,"setObject:forKey:",uVar10,&cf_CX_LAUNCHER_BUNDLE_NAME);
  puVar2 = PTR__objc_release_20000c108;
  (*(code *)PTR__objc_release_20000c108)(uVar10);
  (*(code *)puVar2)(uVar9);
  IVar8 = NSUserDefaults::standardUserDefaults
                    ((ID)&_OBJC_CLASS___NSUserDefaults,"standardUserDefaults");
  uVar9 = _objc_retainAutoreleasedReturnValue(IVar8);
  uVar10 = (*(code *)puVar1)(uVar9,"persistentDomainForName:",&cf_com_codeweavers_CrossOver);
  uVar10 = _objc_retainAutoreleasedReturnValue(uVar10);
  uVar11 = (*(code *)puVar1)(uVar10,"objectForKey:",&cf_DisableWineIntegration);
  uVar11 = _objc_retainAutoreleasedReturnValue(uVar11);
  cVar3 = (*(code *)puVar1)(uVar11,"boolValue");
  (*(code *)puVar2)(uVar11);
  (*(code *)puVar2)(uVar10);
  (*(code *)puVar2)(uVar9);
  lVar12 = wineLoader;
  if (cVar3 == '\0') {
    lVar14 = *(long *)(param_1 + wineLoader);
    if (lVar14 == 0) {
      IVar8 = _objc_alloc(&objc::class_t::WineLoader);
      IVar8 = WineLoader::initWithCrossOverRoot_
                        (IVar8,"initWithCrossOverRoot:",*(ID *)(param_1 + crossOverRoot));
      uVar9 = *(undefined8 *)(param_1 + lVar12);
      *(ID *)(param_1 + lVar12) = IVar8;
      (*(code *)PTR__objc_release_20000c108)(uVar9);
      lVar14 = *(long *)(param_1 + lVar12);
    }
    puVar1 = PTR__objc_msgSend_20000c100;
    uVar9 = (*(code *)PTR__objc_msgSend_20000c100)(lVar14,"socketPath");
    uVar9 = _objc_retainAutoreleasedReturnValue(uVar9);
    lVar12 = (*(code *)puVar1)(uVar9,"length");
    if (lVar12 != 0) {
      (*(code *)PTR__objc_msgSend_20000c100)
                (uVar7,"setObject:forKey:",uVar9,&cf_CX_WINEWRAPPER_ALT_LOADER_SOCKET);
    }
    (*(code *)PTR__objc_release_20000c108)(uVar9);
  }
  IVar8 = _objc_alloc_init(&objc::class_t::CXTask);
  (*(code *)PTR__objc_msgSend_20000c100)(IVar8,"setLaunchPath:",uVar5);
  (*(code *)PTR__objc_release_20000c108)(uVar5);
  if (IVar4 != 0) {
    CXTask::setArguments_(IVar8,"setArguments:",IVar4);
  }
  puVar1 = PTR__objc_msgSend_20000c100;
  (*(code *)PTR__objc_msgSend_20000c100)(IVar8,"setCurrentDirectoryPath:",uVar6);
  IVar13 = NSFileHandle::fileHandleWithNullDevice
                     ((ID)&_OBJC_CLASS___NSFileHandle,"fileHandleWithNullDevice");
  uVar5 = _objc_retainAutoreleasedReturnValue(IVar13);
  (*(code *)puVar1)(IVar8,"setStandardInput:",uVar5);
  puVar2 = PTR__objc_release_20000c108;
  (*(code *)PTR__objc_release_20000c108)(uVar5);
  IVar13 = NSFileHandle::fileHandleWithNullDevice
                     ((ID)&_OBJC_CLASS___NSFileHandle,"fileHandleWithNullDevice");
  uVar5 = _objc_retainAutoreleasedReturnValue(IVar13);
  (*(code *)puVar1)(IVar8,"setStandardOutput:",uVar5);
  (*(code *)puVar2)(uVar5);
  (*(code *)puVar1)(IVar8,"setEnvironment:",uVar7);
  IVar13 = NSNotificationCenter::defaultCenter
                     ((ID)&_OBJC_CLASS___NSNotificationCenter,"defaultCenter");
  uVar5 = _objc_retainAutoreleasedReturnValue(IVar13);
  (*(code *)puVar1)(uVar5,"addObserver:selector:name:object:",param_1,"wineAppExited:",
                    *(undefined8 *)PTR__NSTaskDidTerminateNotification_20000c088,IVar8);
  (*(code *)puVar2)(uVar5);
  (*(code *)puVar2)(uVar7);
  (*(code *)puVar2)(uVar6);
  (*(code *)puVar2)(IVar4);
  IVar4 = _objc_autoreleaseReturnValue(IVar8);
  return IVar4;
}

/* ===== -[CXFBHelperDelegate formatMenuItemsWithBundleName:] @0x200002b40 ===== */

/* Function Stack Size: 0x18 bytes */

void CXFBHelperDelegate::formatMenuItemsWithBundleName_(ID param_1,SEL param_2,ID param_3)

{
  undefined *puVar1;
  char cVar2;
  undefined4 uVar3;
  undefined8 uVar4;
  ID IVar5;
  undefined8 uVar6;
  undefined8 uVar7;
  long lVar8;
  undefined8 uVar9;
  long lVar10;
  undefined8 uVar11;
  undefined8 uVar12;
  code *pcVar13;
  undefined8 in_R9;
  code *pcVar14;
  long lVar15;
  
  uVar4 = (*(code *)PTR__objc_retain_20000c110)(param_3);
  pcVar13 = (code *)PTR__objc_msgSend_20000c100;
  IVar5 = NSBundle::mainBundle((ID)&_OBJC_CLASS___NSBundle,"mainBundle");
  uVar6 = _objc_retainAutoreleasedReturnValue(IVar5);
  uVar7 = (*pcVar13)(uVar6,"objectForInfoDictionaryKey:",
                     *(undefined8 *)PTR__kCFBundleNameKey_20000c0f0);
  uVar7 = _objc_retainAutoreleasedReturnValue(uVar7);
  (*(code *)PTR__objc_release_20000c108)(uVar6);
  lVar8 = (*pcVar13)(uVar4,"numberOfItems");
  if (0 < lVar8) {
    lVar15 = 0;
    do {
      uVar6 = (*pcVar13)(uVar4,"itemAtIndex:",lVar15);
      uVar6 = _objc_retainAutoreleasedReturnValue(uVar6);
      cVar2 = (*pcVar13)(uVar6,"isSeparatorItem");
      if (cVar2 == '\0') {
        uVar9 = (*pcVar13)(uVar6,"attributedTitle");
        uVar9 = _objc_retainAutoreleasedReturnValue(uVar9);
        lVar10 = (*pcVar13)(uVar9,"length");
        if (lVar10 == 0) {
          uVar11 = (*pcVar13)(uVar6,"title");
          uVar11 = _objc_retainAutoreleasedReturnValue(uVar11);
          lVar10 = (*pcVar13)(uVar11,"length");
          pcVar14 = (code *)PTR__objc_release_20000c108;
          if ((lVar10 != 0) &&
             (lVar10 = (*pcVar13)(uVar11,"rangeOfString:",&cf___),
             pcVar14 = (code *)PTR__objc_release_20000c108, lVar10 != 0x7fffffffffffffff)) {
            uVar12 = (*pcVar13)(uVar11,"stringByReplacingOccurrencesOfString:withString:",&cf___,
                                uVar7);
            uVar12 = _objc_retainAutoreleasedReturnValue(uVar12);
            (*pcVar13)(uVar6,"setTitle:",uVar12);
            pcVar14 = (code *)PTR__objc_release_20000c108;
            (*(code *)PTR__objc_release_20000c108)(uVar12);
          }
LAB_200002e40:
          (*pcVar14)(uVar11);
        }
        else {
          uVar11 = (*pcVar13)(uVar9,"string");
          uVar11 = _objc_retainAutoreleasedReturnValue(uVar11);
          lVar10 = (*pcVar13)(uVar11,"rangeOfString:",&cf___);
          pcVar14 = (code *)PTR__objc_release_20000c108;
          (*(code *)PTR__objc_release_20000c108)(uVar11);
          if (lVar10 != 0x7fffffffffffffff) {
            uVar11 = (*pcVar13)(uVar9,"mutableCopy");
            uVar12 = (*pcVar13)(uVar11,"mutableString");
            uVar12 = _objc_retainAutoreleasedReturnValue(uVar12);
            uVar3 = (*(code *)PTR__objc_msgSend_20000c100)(uVar11,"length");
            (*(code *)PTR__objc_msgSend_20000c100)
                      (uVar12,"replaceOccurrencesOfString:withString:options:range:",&cf___,uVar7,0,
                       in_R9,0,uVar3);
            pcVar13 = (code *)PTR__objc_msgSend_20000c100;
            (*pcVar14)(uVar12);
            (*pcVar13)(uVar6,"setAttributedTitle:",uVar11);
            goto LAB_200002e40;
          }
        }
        cVar2 = (*pcVar13)(uVar6,"hasSubmenu");
        if (cVar2 != '\0') {
          uVar11 = (*pcVar13)(uVar6,"submenu");
          IVar5 = _objc_retainAutoreleasedReturnValue(uVar11);
          formatMenuItemsWithBundleName_(param_1,"formatMenuItemsWithBundleName:",IVar5);
          pcVar14 = (code *)PTR__objc_release_20000c108;
          (*(code *)PTR__objc_release_20000c108)(IVar5);
        }
        (*pcVar14)(uVar9);
      }
      (*(code *)PTR__objc_release_20000c108)(uVar6);
      lVar15 = lVar15 + 1;
    } while (lVar8 != lVar15);
  }
  puVar1 = PTR__objc_release_20000c108;
  (*(code *)PTR__objc_release_20000c108)(uVar7);
  (*(code *)puVar1)(uVar4);
  return;
}

/* ===== -[CXFBHelperDelegate wineAppExited:] @0x2000036b8 ===== */

/* Function Stack Size: 0x18 bytes */

void CXFBHelperDelegate::wineAppExited_(ID param_1,SEL param_2,ID param_3)

{
  undefined *puVar1;
  undefined8 uVar2;
  ID IVar3;
  undefined8 uVar4;
  long lVar5;
  
  puVar1 = PTR__objc_msgSend_20000c100;
  uVar2 = (*(code *)PTR__objc_msgSend_20000c100)(param_3,"object");
  uVar2 = _objc_retainAutoreleasedReturnValue(uVar2);
  IVar3 = NSNotificationCenter::defaultCenter
                    ((ID)&_OBJC_CLASS___NSNotificationCenter,"defaultCenter");
  uVar4 = _objc_retainAutoreleasedReturnValue(IVar3);
  (*(code *)puVar1)(uVar4,"removeObserver:name:object:",param_1,0,uVar2);
  (*(code *)PTR__objc_release_20000c108)(uVar4);
  lVar5 = taskArray;
  (*(code *)puVar1)(*(undefined8 *)(param_1 + taskArray),"removeObject:",uVar2);
  lVar5 = (*(code *)puVar1)(*(undefined8 *)(param_1 + lVar5),"count");
  if (lVar5 == 0) {
    if (*(long *)(param_1 + wineLoader) != 0) {
      uVar4 = (*(code *)PTR__objc_msgSend_20000c100)(*(long *)(param_1 + wineLoader),"socketPath");
      lVar5 = _objc_retainAutoreleasedReturnValue(uVar4);
      (*(code *)PTR__objc_release_20000c108)(lVar5);
      if (lVar5 == 0) goto LAB_20000379a;
    }
    (*(code *)PTR__objc_msgSend_20000c100)(*(undefined8 *)PTR__NSApp_20000c008,"terminate:",param_1)
    ;
  }
LAB_20000379a:
  (*(code *)PTR__objc_release_20000c108)(uVar2);
  return;
}

/* ===== -[CXFBHelperApp sendEvent:] @0x200001f96 ===== */

/* Function Stack Size: 0x18 bytes */

void CXFBHelperApp::sendEvent_(ID param_1,SEL param_2,ID param_3)

{
  undefined *puVar1;
  char cVar2;
  undefined8 uVar3;
  ID IVar4;
  undefined8 uVar5;
  ID local_40;
  class_t *local_38;
  
  uVar3 = (*(code *)PTR__objc_retain_20000c110)(param_3);
  puVar1 = PTR__objc_msgSend_20000c100;
  IVar4 = wineController(param_1,"wineController");
  uVar5 = _objc_retainAutoreleasedReturnValue(IVar4);
  cVar2 = (*(code *)puVar1)(uVar5,"handleEvent:",uVar3);
  (*(code *)PTR__objc_release_20000c108)(uVar5);
  if (cVar2 == '\0') {
    local_38 = &objc::class_t::CXFBHelperApp;
    local_40 = param_1;
    NSApplication::sendEvent_((ID)&local_40,"sendEvent:",uVar3);
    IVar4 = wineController(param_1,"wineController");
    uVar5 = _objc_retainAutoreleasedReturnValue(IVar4);
    (*(code *)puVar1)(uVar5,"didSendEvent:",uVar3);
    (*(code *)PTR__objc_release_20000c108)(uVar5);
  }
  (*(code *)PTR__objc_release_20000c108)(uVar3);
  return;
}

/* ===== -[WineLoader initWithCrossOverRoot:] @0x200008a10 ===== */

/* Function Stack Size: 0x18 bytes */

ID WineLoader::initWithCrossOverRoot_(ID param_1,SEL param_2,ID param_3)

{
  int iVar1;
  ID IVar2;
  undefined8 uVar3;
  char *pcVar4;
  ID IVar5;
  size_t sVar6;
  long lVar7;
  ulong uVar8;
  dispatch_queue_t queue;
  dispatch_object_t object;
  ID local_b8;
  class_t *local_b0;
  sockaddr local_a2 [6];
  long local_38;
  
  local_38 = *(long *)PTR____stack_chk_guard_20000c0d8;
  local_b0 = &objc::class_t::WineLoader;
  local_b8 = param_1;
  IVar2 = NSObject::init((ID)&local_b8,"init");
  if (IVar2 != 0) {
    uVar3 = (*(code *)PTR__objc_msgSend_20000c100)(param_3,"copy");
    *(undefined8 *)(IVar2 + 8) = uVar3;
    iVar1 = _socket(1,1,0);
    *(int *)(IVar2 + 0x10) = iVar1;
    if (iVar1 != -1) {
      iVar1 = _fcntl(iVar1,4,4);
      if (iVar1 == 0) {
        pcVar4 = _tmpnam((char *)0x0);
        if (pcVar4 == (char *)0x0) {
          lVar7 = *(long *)(IVar2 + 0x18);
        }
        else {
          IVar5 = NSFileManager::defaultManager((ID)&_OBJC_CLASS___NSFileManager,"defaultManager");
          sVar6 = _strlen(pcVar4);
          IVar5 = NSFileManager::stringWithFileSystemRepresentation_length_
                            (IVar5,"stringWithFileSystemRepresentation:length:",pcVar4,sVar6);
          lVar7 = (*(code *)PTR__objc_retain_20000c110)(IVar5);
          *(long *)(IVar2 + 0x18) = lVar7;
        }
        if (lVar7 != 0) {
          local_a2[0].sa_family = '\x01';
          uVar8 = ___strlcpy_chk(local_a2[0].sa_data,pcVar4,0x68,0x68);
          if (uVar8 < 0x68) {
            sVar6 = _strlen(local_a2[0].sa_data);
            local_a2[0].sa_len = (char)sVar6 + '\x03';
            iVar1 = _bind(*(int *)(IVar2 + 0x10),local_a2,0x6a);
            if (iVar1 == 0) {
              *(undefined1 *)(IVar2 + 0x20) = 1;
              IVar5 = NSNotificationCenter::defaultCenter
                                ((ID)&_OBJC_CLASS___NSNotificationCenter,"defaultCenter");
              IVar5 = NSNotificationCenter::addObserverForName_object_queue_usingBlock_
                                (IVar5,"addObserverForName:object:queue:usingBlock:",
                                 *(undefined8 *)
                                  PTR__NSApplicationWillTerminateNotification_20000c068,
                                 *(undefined8 *)PTR__NSApp_20000c008,0);
              *(ID *)(IVar2 + 0x28) = IVar5;
              iVar1 = _listen(*(int *)(IVar2 + 0x10),5);
              if (iVar1 == 0) {
                queue = _dispatch_get_global_queue(0,0);
                object._os_obj =
                     (_os_object_s *)
                     _dispatch_source_create
                               ((dispatch_source_type_t)PTR___dispatch_source_type_read_20000c0e8,
                                (long)*(int *)(IVar2 + 0x10),0,queue);
                *(dispatch_object_t *)(IVar2 + 0x30) = object;
                if (object._os_obj != (_os_object_s *)0x0) {
                  *(undefined1 *)(IVar2 + 0x38) = 1;
                  _dispatch_retain(object);
                  _dispatch_source_set_event_handler(object._os_obj);
                  _dispatch_source_set_cancel_handler(object._os_obj);
                  _dispatch_resume(object);
                  goto LAB_200008ab0;
                }
              }
            }
          }
        }
      }
    }
    (*(code *)PTR__objc_release_20000c108)(IVar2);
  }
  IVar2 = 0;
LAB_200008ab0:
  if (*(long *)PTR____stack_chk_guard_20000c0d8 == local_38) {
    return IVar2;
  }
                    /* WARNING: Subroutine does not return */
  ___stack_chk_fail();
}

/* ===== -[WineLoader shouldConnectionProceedWithRequest:] @0x200008f5c ===== */

/* Function Stack Size: 0x18 bytes */

char WineLoader::shouldConnectionProceedWithRequest_(ID param_1,SEL param_2,ID param_3)

{
  ID IVar1;
  char *pcVar2;
  long lVar3;
  char cVar4;
  
  if (*(dispatch_source_t *)(param_1 + 0x30) == (dispatch_source_t)0x0) {
    cVar4 = '\0';
  }
  else {
    _dispatch_source_cancel(*(dispatch_source_t *)(param_1 + 0x30));
    _dispatch_release(*(dispatch_object_t *)(param_1 + 0x30));
    *(undefined8 *)(param_1 + 0x30) = 0;
    if (*(long *)(param_1 + 0x28) != 0) {
      IVar1 = NSNotificationCenter::defaultCenter
                        ((ID)&_OBJC_CLASS___NSNotificationCenter,"defaultCenter");
      NSNotificationCenter::removeObserver_(IVar1,"removeObserver:",*(undefined8 *)(param_1 + 0x28))
      ;
      *(undefined8 *)(param_1 + 0x28) = 0;
    }
    if (*(char *)(param_1 + 0x20) != '\0') {
      pcVar2 = (char *)(*(code *)PTR__objc_msgSend_20000c100)
                                 (*(undefined8 *)(param_1 + 0x18),"fileSystemRepresentation");
      _unlink(pcVar2);
      *(undefined1 *)(param_1 + 0x20) = 0;
    }
    (*(code *)PTR__objc_release_20000c108)(*(undefined8 *)(param_1 + 0x18));
    *(undefined8 *)(param_1 + 0x18) = 0;
    lVar3 = (*(code *)PTR__objc_msgSend_20000c100)
                      (*(undefined8 *)PTR__NSApp_20000c008,"activationPolicy");
    cVar4 = '\x01';
    if (lVar3 == 0) {
      IVar1 = NSProcessInfo::processInfo((ID)&_OBJC_CLASS___NSProcessInfo,"processInfo");
      IVar1 = NSProcessInfo::beginActivityWithOptions_reason_
                        (IVar1,"beginActivityWithOptions:reason:",&DAT_00efffff,
                         &cf_RunningWindowsprogram);
      (*(code *)PTR__objc_retain_20000c110)(IVar1);
    }
  }
  return cVar4;
}

/* ===== -[WineLoaderClientConnection handleConnection] @0x200007e75 ===== */

/* Function Stack Size: 0x10 bytes */

void WineLoaderClientConnection::handleConnection(ID param_1,SEL param_2)

{
  char cVar1;
  uint uVar2;
  int iVar3;
  char *pcVar4;
  size_t sVar5;
  char *pcVar6;
  ssize_t sVar7;
  int *piVar8;
  undefined8 uVar9;
  long lVar10;
  ulong uVar11;
  undefined8 *puVar12;
  undefined8 *puVar13;
  ID IVar14;
  unsigned_long_long uVar15;
  undefined4 *puVar16;
  undefined *puVar17;
  cfstringStruct *pcVar18;
  undefined **ppuVar19;
  char *pcVar20;
  long lVar21;
  ulong uVar22;
  iovec local_118;
  msghdr local_108;
  undefined8 local_d8;
  undefined8 *local_d0;
  undefined8 local_c8;
  unsigned_long_long local_b8;
  unsigned_long_long local_b0;
  ulong local_a8;
  code *local_a0;
  uint local_98 [4];
  undefined8 local_88;
  undefined8 uStack_80;
  int local_74;
  unsigned_long_long local_70;
  undefined8 local_68;
  undefined4 local_5c;
  size_t local_58;
  uint local_4c;
  char *local_48;
  undefined8 *local_40;
  undefined1 local_31;
  
  local_68 = _objc_alloc_init(&_OBJC_CLASS___NSAutoreleasePool);
  local_88 = 0xffffffffffffffff;
  uStack_80 = 0xffffffffffffffff;
  local_98[0] = 0;
  local_98[1] = 0;
  local_98[2] = 0;
  local_98[3] = 0xffffffff;
  local_d0 = &local_d8;
  local_d8 = 0;
  local_c8 = 0x2020000000;
  uVar2 = _fcntl(*(int *)(param_1 + 0x10),3);
  if (uVar2 == 0xffffffff) {
    piVar8 = ___error();
    pcVar18 = &cf__s_fcntl_F_GETFL_failed_errno_d;
LAB_200007fd4:
    local_74 = *piVar8;
LAB_200007fd6:
    _NSLog(pcVar18,"-[WineLoaderClientConnection handleConnection]",local_74);
  }
  else {
    iVar3 = _fcntl(*(int *)(param_1 + 0x10),4,(ulong)(uVar2 & 0xfffffffb));
    if (iVar3 == -1) {
      piVar8 = ___error();
      pcVar18 = &cf__s_fcntl_F_SETFL_failed_errno_d;
      goto LAB_200007fd4;
    }
    cVar1 = readData_length_(param_1,"readData:length:",&local_74,4);
    if (cVar1 == '\0') {
      piVar8 = ___error();
      pcVar18 = &cf__s_readingrequesttypefailed_errno_d;
      goto LAB_200007fd4;
    }
    if (local_74 != 0x52c17355) {
      pcVar18 = &cf__s_unknownrequesttype0x_08x;
      goto LAB_200007fd6;
    }
    pcVar4 = readLengthPrefixedBuffer_(param_1,"readLengthPrefixedBuffer:",&local_b8);
    if (pcVar4 != (char *)0x0) {
      if (local_b8 == 0) {
        _free(pcVar4);
        pcVar4 = (char *)0x0;
LAB_2000080c0:
        pcVar6 = readLengthPrefixedBuffer_(param_1,"readLengthPrefixedBuffer:",&local_70);
        if (pcVar6 != (char *)0x0) {
          if ((local_70 == 0) || (pcVar6[local_70 - 1] == '\0')) {
            local_48 = readLengthPrefixedBuffer_(param_1,"readLengthPrefixedBuffer:",&local_b0);
            if (local_48 != (char *)0x0) {
              if (local_b0 == 0) {
                pcVar18 = &cf__s_argslistisempty;
LAB_20000818e:
                _NSLog(pcVar18,"-[WineLoaderClientConnection handleConnection]");
              }
              else {
                if (local_48[local_b0 - 1] != '\0') {
                  pcVar18 = &cf__s_argsisnotnull_terminated;
                  goto LAB_20000818e;
                }
                local_4c = 1;
                uVar15 = 0;
                do {
                  local_4c = local_4c + (local_48[uVar15] == '\0');
                  uVar15 = uVar15 + 1;
                } while (local_b0 != uVar15);
                uVar11 = (ulong)local_4c;
                local_40 = _malloc(uVar11 * 8 + 8);
                if (local_40 != (undefined8 *)0x0) {
                  local_118.iov_base = &local_31;
                  local_108.msg_iov = &local_118;
                  local_118.iov_len = 1;
                  local_108.msg_name = (void *)0x0;
                  local_108.msg_namelen = 0;
                  local_108.msg_iovlen = 1;
                  local_108.msg_control = local_98;
                  local_108.msg_controllen = 0x20;
                  local_108.msg_flags = 0;
                  local_a8 = uVar11;
                  do {
                    sVar7 = _recvmsg(*(int *)(param_1 + 0x10),&local_108,0x40);
                    if (sVar7 != -1) {
                      if (sVar7 == 1) {
                        pcVar18 = &cf__s_failedtoreceivefiledescriptors;
                        if (((((local_108._40_8_ & 0x2000000000) != 0) ||
                             (local_108.msg_controllen < 0x1c)) || (local_98[1] != 0xffff)) ||
                           ((local_98[2] != 1 || (local_98[0] < 0x1c)))) goto LAB_200008725;
                        if (local_98[0] < 0x20) {
                          uStack_80 = CONCAT44(0xffffffff,(int)uStack_80);
                        }
                        goto LAB_2000082bf;
                      }
                      break;
                    }
                    piVar8 = ___error();
                  } while (*piVar8 == 4);
                  piVar8 = ___error();
                  pcVar18 = &cf__s_failedtoreceivefiledescriptors_errno_d;
                  goto LAB_2000082f9;
                }
                _NSLog(&cf__s_failedtoallocateargvwith_delements,
                       "-[WineLoaderClientConnection handleConnection]",local_4c);
              }
              lVar10 = 0;
              local_40 = (undefined8 *)0x0;
              goto LAB_200007ff9;
            }
            pcVar18 = &cf__s_readingargsfailed;
            local_48 = (char *)0x0;
          }
          else {
            pcVar18 = &cf__s_environmentisnotnull_terminated;
          }
          lVar10 = 0;
          _NSLog(pcVar18,"-[WineLoaderClientConnection handleConnection]");
          local_40 = (undefined8 *)0x0;
          local_48 = (char *)0x0;
          goto LAB_200007ff9;
        }
        _NSLog(&cf__s_readingenvironmentfailed,"-[WineLoaderClientConnection handleConnection]");
      }
      else {
        if ((pcVar4[local_b8 - 1] == '\0') && (sVar5 = _strlen(pcVar4), sVar5 + 1 == local_b8))
        goto LAB_2000080c0;
        _NSLog(&cf__s_workingdirectoryisnotasinglenull_terminatedstring,
               "-[WineLoaderClientConnection handleConnection]");
      }
      lVar10 = 0;
      local_40 = (undefined8 *)0x0;
      local_48 = (char *)0x0;
      pcVar6 = (char *)0x0;
      goto LAB_200007ff9;
    }
    _NSLog(&cf__s_readingworkingdirectoryfailed,"-[WineLoaderClientConnection handleConnection]");
  }
  lVar10 = 0;
  local_40 = (undefined8 *)0x0;
  local_48 = (char *)0x0;
  goto LAB_200007ff6;
  while (piVar8 = ___error(), *piVar8 == 4) {
LAB_2000082bf:
    sVar7 = _read(*(int *)(param_1 + 0x10),&local_31,1);
    if (sVar7 != -1) {
      if (sVar7 != 0) {
        pcVar18 = &cf__s_gotextraneousdatainsteadofEOF;
LAB_200008725:
        lVar10 = 0;
        _NSLog(pcVar18,"-[WineLoaderClientConnection handleConnection]");
        goto LAB_200007ff9;
      }
      uVar9 = (*(code *)PTR__objc_msgSend_20000c100)(*(undefined8 *)(param_1 + 8),"crossOverRoot");
      uVar9 = (*(code *)PTR__objc_msgSend_20000c100)
                        (uVar9,"stringByAppendingPathComponent:",&cf_lib);
      uVar9 = (*(code *)PTR__objc_msgSend_20000c100)
                        (uVar9,"stringByAppendingPathComponent:",&cf_wine_);
      uVar9 = (*(code *)PTR__objc_msgSend_20000c100)
                        (uVar9,"stringByAppendingPathComponent:",&cf_x86_64_unix);
      local_58 = (*(code *)PTR__objc_msgSend_20000c100)
                           (uVar9,"stringByAppendingPathComponent:",&cf_ntdll_so);
      uVar9 = (*(code *)PTR__objc_msgSend_20000c100)(local_58,"fileSystemRepresentation");
      lVar10 = _dlopen(uVar9,0);
      if (lVar10 == 0) {
        uVar9 = _dlerror();
        lVar10 = 0;
        _NSLog(&cf_Failedtoload____s,local_58,uVar9);
        goto LAB_200007ff9;
      }
      local_a0 = (code *)_dlsym(lVar10,"__wine_main");
      if (local_a0 == (code *)0x0) {
        uVar9 = _dlerror();
        _NSLog(&cf_Failedtofindsymbol___wine_main_in____s,local_58,uVar9);
        goto LAB_200007ff9;
      }
      _dispatch_sync(PTR___dispatch_main_q_20000c0e0);
      if (*(char *)(local_d0 + 3) == '\0') goto LAB_200007ff9;
      puVar16 = &local_5c;
      local_5c = 0x52c17356;
      uVar11 = 0;
      goto LAB_200008457;
    }
  }
  piVar8 = ___error();
  pcVar18 = &cf__s_failedtoreadEOF_errno_d;
LAB_2000082f9:
  lVar10 = 0;
  _NSLog(pcVar18,"-[WineLoaderClientConnection handleConnection]",*piVar8);
  goto LAB_200007ff9;
LAB_200008457:
  do {
    sVar7 = _write(*(int *)(param_1 + 0x10),puVar16,4 - uVar11);
    if (sVar7 < 1) {
      piVar8 = ___error();
      if (*piVar8 != 4) {
        piVar8 = ___error();
        _NSLog(&cf__s_failedtosendresponse_errno_d_p_p__response_p_sizeof_response__lu,
               "-[WineLoaderClientConnection handleConnection]",*piVar8,puVar16,&local_5c,4);
        goto LAB_200007ff9;
      }
    }
    else {
      puVar16 = (undefined4 *)((long)puVar16 + sVar7);
    }
    uVar11 = (long)puVar16 - (long)&local_5c;
  } while (uVar11 < 4);
  _close(*(int *)(param_1 + 0x10));
  *(undefined4 *)(param_1 + 0x10) = 0xffffffff;
  if (PTR_DAT_20000f0c8 != (undefined *)0x0) {
    ppuVar19 = &_reservations;
    puVar17 = PTR_DAT_20000f0c8;
    do {
      _mmap(*ppuVar19,puVar17,0,&DAT_00001052,0xffffffff,0);
      puVar17 = ppuVar19[3];
      ppuVar19 = ppuVar19 + 2;
    } while (puVar17 != (undefined *)0x0);
  }
  if ((pcVar4 != (char *)0x0) && (*pcVar4 != '\0')) {
    _chdir(pcVar4);
  }
  _free(pcVar4);
  puVar12 = _malloc(8);
  *puVar12 = 0;
  puVar13 = (undefined8 *)__NSGetEnviron();
  *puVar13 = puVar12;
  pcVar20 = pcVar6;
  for (; local_70 != 0; local_70 = local_70 - (local_58 + 1)) {
    local_58 = _strlen(pcVar20);
    pcVar4 = _strchr(pcVar20,0x3d);
    if (pcVar4 == (char *)0x0) {
      pcVar4 = (char *)0x0;
      _NSLog(&cf__s_environmentbufferhasmalformedstring__s,
             "-[WineLoaderClientConnection handleConnection]",pcVar20);
      goto LAB_200007ff9;
    }
    *pcVar4 = '\0';
    iVar3 = _strcmp(pcVar20,"WINE_WAIT_CHILD_PIPE");
    if ((iVar3 != 0) && (iVar3 = _strcmp(pcVar20,"CX_ALT_LOADER_SOCKET"), iVar3 != 0)) {
      _setenv(pcVar20,pcVar4 + 1,1);
    }
    pcVar20 = pcVar20 + local_58 + 1;
  }
  _free(pcVar6);
  pcVar4 = _getenv("WINELOADER");
  *local_40 = pcVar4;
  if (pcVar4 != (char *)0x0) {
LAB_2000085ba:
    uVar11 = local_a8;
    if (1 < local_4c) {
      uVar22 = 1;
      pcVar4 = local_48;
      do {
        local_40[uVar22] = pcVar4;
        sVar5 = _strlen(pcVar4);
        pcVar4 = pcVar4 + sVar5 + 1;
        uVar22 = uVar22 + 1;
      } while (uVar11 != uVar22);
    }
    local_40[uVar11] = 0;
    lVar21 = 0;
    do {
      _dup2(local_98[lVar21 + 3],(int)lVar21);
      _close(local_98[lVar21 + 3]);
      local_98[lVar21 + 3] = 0xffffffff;
      lVar21 = lVar21 + 1;
    } while (lVar21 != 3);
    iVar3 = _fcntl((int)uStack_80,2,1);
    if (iVar3 == -1) {
      piVar8 = ___error();
      _NSLog(&cf__s_failedtosetreceivedWineserversockettoclose_on_exec_errno_d,
             "-[WineLoaderClientConnection handleConnection]",*piVar8);
    }
    IVar14 = NSString::stringWithFormat_
                       ((ID)&_OBJC_CLASS___NSString,"stringWithFormat:",&cf__d,
                        uStack_80 & 0xffffffff);
    pcVar4 = (char *)NSString::UTF8String(IVar14,"UTF8String");
    _setenv("WINESERVERSOCKET",pcVar4,1);
    if (-1 < (long)uStack_80) {
      IVar14 = NSString::stringWithFormat_((ID)&_OBJC_CLASS___NSString,"stringWithFormat:",&cf__d);
      pcVar4 = (char *)NSString::UTF8String(IVar14,"UTF8String");
      _setenv("WINE_WAIT_CHILD_PIPE",pcVar4,1);
    }
    (*(code *)PTR__objc_msgSend_20000c100)(local_68,"drain");
    (*local_a0)(local_4c,local_40);
    pcVar6 = (char *)0x0;
    pcVar4 = (char *)0x0;
    local_68 = 0;
    goto LAB_200007ff9;
  }
  uVar9 = (*(code *)PTR__objc_msgSend_20000c100)(*(undefined8 *)(param_1 + 8),"crossOverRoot");
  uVar9 = (*(code *)PTR__objc_msgSend_20000c100)(uVar9,"stringByAppendingPathComponent:",&cf_bin);
  uVar9 = (*(code *)PTR__objc_msgSend_20000c100)
                    (uVar9,"stringByAppendingPathComponent:",&cf_wineloader);
  pcVar4 = (char *)(*(code *)PTR__objc_msgSend_20000c100)(uVar9,"UTF8String");
  if (pcVar4 != (char *)0x0) {
    pcVar4 = _strdup(pcVar4);
    *local_40 = pcVar4;
    if (pcVar4 != (char *)0x0) goto LAB_2000085ba;
  }
  _NSLog(&cf_failedtoconstructwineloaderpathstring);
LAB_200007ff6:
  pcVar6 = (char *)0x0;
  pcVar4 = (char *)0x0;
LAB_200007ff9:
  (*(code *)PTR__objc_msgSend_20000c100)(local_68,"drain");
  _free(pcVar4);
  _free(pcVar6);
  _free(local_48);
  _free(local_40);
  lVar21 = 3;
  do {
    if (local_98[lVar21] != 0xffffffff) {
      _close(local_98[lVar21]);
    }
    lVar21 = lVar21 + 1;
  } while (lVar21 != 8);
  if (lVar10 != 0) {
    _dlclose(lVar10);
  }
  _close(*(int *)(param_1 + 0x10));
  *(undefined4 *)(param_1 + 0x10) = 0xffffffff;
  __Block_object_dispose(&local_d8,8);
  return;
}

/* ===== -[WineLoaderClientConnection readLengthPrefixedBuffer:] @0x200007db4 ===== */

/* Function Stack Size: 0x18 bytes */

void * WineLoaderClientConnection::readLengthPrefixedBuffer_
                 (ID param_1,SEL param_2,unsigned_long_long *param_3)

{
  size_t sVar1;
  char cVar2;
  void *pvVar3;
  int *piVar4;
  
  cVar2 = readData_length_(param_1,"readData:length:",param_3,8);
  if (cVar2 == '\0') {
    piVar4 = ___error();
    pvVar3 = (void *)0x0;
    _NSLog(&cf__s_readinglengthfailed_errno_d,
           "-[WineLoaderClientConnection readLengthPrefixedBuffer:]",*piVar4);
  }
  else {
    sVar1 = *param_3;
    pvVar3 = _malloc(sVar1);
    if (pvVar3 == (void *)0x0) {
      pvVar3 = (void *)0x0;
      _NSLog(&cf__s_failedtoallocatebufferoflength_llu,
             "-[WineLoaderClientConnection readLengthPrefixedBuffer:]",sVar1);
    }
    else {
      cVar2 = readData_length_(param_1,"readData:length:",pvVar3,sVar1);
      if (cVar2 == '\0') {
        piVar4 = ___error();
        _NSLog(&cf__s_readingbufferfailed_errno_d,
               "-[WineLoaderClientConnection readLengthPrefixedBuffer:]",*piVar4);
        _free(pvVar3);
        pvVar3 = (void *)0x0;
      }
    }
  }
  return pvVar3;
}
