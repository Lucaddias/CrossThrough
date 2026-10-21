// BottleMenuHandler.m — CrossThrough
#import "BottleMenuHandler.h"
#import "CrossThrough.h"
#import "HopperCompat.h"
#import "MainWindowController.h"
#import "NewBottleController.h"
#import "PublishController.h"
#import "RunCommandController.h"
#import "SubmitRatingController.h"
#import "PackageTreeNode.h"
#import "CXSetupLib.h"
#import "CXApplication.h"
#import "NSString+CrossOverAdditions.h"

#import <SecurityFoundation/SFAuthorization.h>
#import <Security/Authorization.h>
#import <unistd.h>
#import <stdio.h>

@implementation BottleMenuHandler

+ (void)deleteBottle:(id)arg1 withWindow:(id)arg2 {
    id bottle = arg1;
    NSWindow *window = arg2;
    NSString *bottleName = [bottle name];
    NSAlert *alert = [[NSAlert alloc] init];

    NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"Are you sure you want to delete the '%@' bottle?" value:@"" table:nil];
    [alert setMessageText:[NSString stringWithFormat:fmt, bottleName]];

    NSString *infoFmt = [[NSBundle mainBundle] localizedStringForKey:@"Deleting this bottle will permanently erase all Windows applications contained in it, as well as any documents stored in its C: drive." value:@"" table:nil];
    [alert setInformativeText:[NSString stringWithFormat:infoFmt, bottleName]];

    [alert addButtonWithTitle:[[NSBundle mainBundle] localizedStringForKey:@"Cancel" value:@"" table:nil]];
    [alert addButtonWithTitle:[[NSBundle mainBundle] localizedStringForKey:@"Delete" value:@"" table:nil]];

    if (@available(macOS 11.0, *)) {
        if ([[alert buttons] count] > 1) {
            [[[alert buttons] objectAtIndex:1] setHasDestructiveAction:YES];
        }
    }

    [alert beginSheetModalForWindow:window completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == 1001) { // NSAlertSecondButtonReturn
            BOOL isManaged = [bottle isIsManaged];
            if (isManaged) {
                SFAuthorization *auth = [SFAuthorization authorization];
                if (![auth obtainWithRight:"system.privilege.admin" flags:0x13 error:NULL]) {
                    return;
                }
                [BottleMenuHandler rateBottle:bottle withWindow:window isDeleting:YES];
                [bottle delete:^(id arg) {
                    if ([bottle isIsDeleted]) {
                        [[[CXSetupLib bottleCollectionClass] sharedCollection] refresh];
                    }
                    if (auth) {
                        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            [BottleMenuHandler deleteManagedBottle:bottle withWindow:window authorization:auth];
                        });
                    }
                }];
            } else {
                [BottleMenuHandler rateBottle:bottle withWindow:window isDeleting:YES];
                [bottle delete:^(id arg) {
                    if ([bottle isIsDeleted]) {
                        [[[CXSetupLib bottleCollectionClass] sharedCollection] refresh];
                    } else {
                        NSAlert *failAlert = [[NSAlert alloc] init];
                        NSString *failFmt = [[NSBundle mainBundle] localizedStringForKey:@"Failed to delete the bottle '%@'." value:@"" table:nil];
                        [failAlert setMessageText:[NSString stringWithFormat:failFmt, bottleName]];
                        [failAlert beginSheetModalForWindow:window completionHandler:nil];
                        [failAlert release];
                    }
                }];
            }
        }
    }];
    [alert release];
}

+ (void)deleteManagedBottle:(id)arg1 withWindow:(id)arg2 authorization:(id)arg3 {
    if (![arg1 isIsManaged]) {
        return;
    }
    NSString *bottleName = [arg1 name];
    const char *cxbottle = [bottleName UTF8String];
    FILE *pipe = NULL;
    NSString *crossOverRoot = [(CXApplication *)[NSApplication sharedApplication] crossOverRoot];
    NSString *bouncePath = [NSString stringWithFormat:@"%@/bin/cxbounce", crossOverRoot];
    AuthorizationRef authRef = [(SFAuthorization *)arg3 authorizationRef];
    char *args[] = { "cxbottle", "--delete", "--bottle", (char *)cxbottle, "--force", "--scope", "managed", NULL };

    OSStatus status = AuthorizationExecuteWithPrivileges(authRef, [bouncePath fileSystemRepresentation], 0, args, &pipe);
    if (status != errAuthorizationSuccess) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *info = [[NSBundle mainBundle] localizedStringForKey:@"Could not obtain the authorization to delete files owned by the administrator." value:@"" table:nil];
            NSAlert *failAlert = [[NSAlert alloc] init];
            NSString *msgFmt = [[NSBundle mainBundle] localizedStringForKey:@"Failed to delete the published bottle '%@'." value:@"" table:nil];
            [failAlert setMessageText:[NSString stringWithFormat:msgFmt, bottleName]];
            [failAlert setInformativeText:info];
            [failAlert beginSheetModalForWindow:arg2 completionHandler:nil];
            [failAlert release];
        });
    } else {
        char buf[1024];
        int fd = fileno(pipe);
        while (read(fd, buf, sizeof(buf)) > 0) {}
        fclose(pipe);
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[CXSetupLib bottleCollectionClass] sharedCollection] refresh];
        });
    }
}

+ (void)duplicateBottle:(id)arg1 withWindow:(id)arg2 {
    NSString *bottleName = [arg1 name];
    NewBottleController *ctrl = [[NewBottleController alloc] init];
    [ctrl setCopyMode:YES withBottleToCopy:bottleName];
    NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"copy of %@" value:@"" table:nil];
    [ctrl setSuggestedBottleName:[NSString stringWithFormat:fmt, bottleName]];
    [ctrl setupGUI];
    [arg2 beginSheet:[ctrl window] completionHandler:nil];
    [ctrl release];
}

+ (void)exportBottle:(id)arg1 withWindow:(id)arg2 {
    id bottle = arg1;
    NSWindow *window = arg2;
    NSString *bottleName = [bottle name];
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    [savePanel setAllowedFileTypes:@[@"cxarchive"]];
    [savePanel setCanSelectHiddenExtension:YES];
    [savePanel setNameFieldStringValue:[NSString stringWithFormat:@"%@.cxarchive", bottleName]];

    [savePanel beginSheetModalForWindow:window completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == NSModalResponseOK) {
            NSString *path = [[savePanel URL] path];
            NSString *fsPath = [path stringInFileSystemRepresentationForm];
            dispatch_async(dispatch_get_main_queue(), ^{
                [bottle addStatusOverride:[[CXSetupLib cxSetupClass] bottleStatus:@"ARCHIVING"]];
            });
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSArray *res = [[CXSetupLib bottleManagementClass] archiveBottle:bottle toPath:fsPath];
                BOOL ok = NO;
                if ([res count] > 0) {
                    ok = [[res objectAtIndex:0] boolValue];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (!ok) {
                        id errMsg = [res count] > 1 ? [res objectAtIndex:1] : nil;
                        if (errMsg) {
                            NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"Failed to export bottle '%@' to an archive." value:@"" table:nil];
                            NSAlert *alert = [[NSAlert alloc] init];
                            [alert setMessageText:[NSString stringWithFormat:fmt, bottleName]];
                            [alert setInformativeText:errMsg];
                            [alert beginSheetModalForWindow:window completionHandler:nil];
                            [alert release];
                        }
                    }
                    [bottle removeStatusOverride:[[CXSetupLib cxSetupClass] bottleStatus:@"ARCHIVING"]];
                });
            });
        }
    }];
}

+ (void)installSoftwareIntoBottle:(id)arg1 withWindow:(id)arg2 {
    id ctrl = [arg2 windowController];
    if ([ctrl isKindOfClass:[MainWindowController class]]) {
        [(MainWindowController *)ctrl showInstallViewWithSelectedBottle:arg1];
    } else {
        NSLog(@"Expected controller of window in +installSoftwareIntoBottle:withWindow: to be a MainWindowController, but got %@", [ctrl class]);
    }
}

+ (void)installMissingDependencies:(id)arg1 withWindow:(id)arg2 {
    id ctrl = [arg2 windowController];
    if ([ctrl isKindOfClass:[MainWindowController class]]) {
        id profile = [arg1 getMissingDependenciesProfile];
        if (profile) {
            PackageTreeNode *node = [[PackageTreeNode alloc] initWithProfile:profile];
            [node loadIcon];
            [(MainWindowController *)ctrl showInstallViewWithSelectedBottle:arg1 package:node];
            [node release];
        }
    } else {
        NSLog(@"Expected controller of window in +installMissingDependencies:withWindow: to be a MainWindowController, but got %@", [ctrl class]);
    }
}

+ (void)openCDriveForBottle:(id)arg1 {
    [[NSWorkspace sharedWorkspace] openFile:[arg1 systemDrive]];
}

+ (void)openShellForBottle:(id)arg1 {
    NSString *bottleName = [arg1 name];
    NSString *systemDrive = [arg1 systemDrive];
    NSString *crossOverRoot = [(CXApplication *)[NSApplication sharedApplication] crossOverRoot];
    NSString *binDir = [crossOverRoot stringByAppendingPathComponent:@"bin"];

    NSSet *excludedKeys = [NSSet setWithObjects:
        @"HOME", @"USER", @"NSUnbufferedIO", @"__CF_USER_TEXT_ENCODING",
        @"DYLD_NEW_LOCAL_SHARED_REGIONS", @"TERM_PROGRAM", @"TERM_PROGRAM_VERSION",
        @"SHLVL", @"LOGNAME", @"OLDPWD", @"_", @"PS1", @"PS2", @"PS3", @"PS4",
        @"TERM", @"DYLD_NO_FIX_PREBINDING", @"SHELL", @"NSZombieEnabled",
        @"DYLD_FRAMEWORK_PATH", @"SECURITYSESSIONID", @"PWD", @"PATH", nil];

    NSDictionary *env = [[NSProcessInfo processInfo] environment];
    NSMutableString *envCommands = [NSMutableString string];
    [env enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (![excludedKeys containsObject:key]) {
            NSString *quotedKey = [key stringQuotedForBash];
            NSString *quotedObj = [obj stringQuotedForBash];
            NSString *exportLine = [NSString stringWithFormat:@"export %@=%@", quotedKey, quotedObj];
            NSString *scriptLine = [NSString stringWithFormat:@"do script %@ in theWindow\ndelay 0.1\n", [exportLine stringQuotedForAppleScript]];
            [envCommands appendString:scriptLine];
        }
    }];

    NSString *titleFmt = [[NSBundle mainBundle] localizedStringForKey:@"%1$@ Bottle \"%2$@\"" value:@"" table:nil];
    NSString *title = [NSString stringWithFormat:titleFmt, @"CrossOver", bottleName];

    NSString *quotedBottle = [bottleName stringQuotedForBash];
    NSString *quotedBin = [binDir stringQuotedForBash];
    NSString *quotedDrive = [systemDrive stringQuotedForBash];
    NSString *cdCmd = [NSString stringWithFormat:@"export CX_BOTTLE=%@\nexport PATH=%@\":$PATH\"\ncd %@", quotedBottle, quotedBin, quotedDrive];

    NSString *scriptSource = [NSString stringWithFormat:
        @"tell app \"Terminal\"\n"
        @"activate\n"
        @"delay 0.1\n"
        @"do script \"exec /bin/bash -l\"\n"
        @"set theWindow to the front window\n"
        @"set the custom title of theWindow to %@\n"
        @"delay 1.0\n"
        @"%@"
        @"do script %@ in theWindow\n"
        @"end tell",
        [title stringQuotedForAppleScript],
        envCommands,
        [cdCmd stringQuotedForAppleScript]];

    NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:scriptSource];
    NSDictionary *errorInfo = nil;
    [appleScript executeAndReturnError:&errorInfo];
    if (errorInfo) {
        NSLog(@"Error running script: error %@\nsource: %@\n", errorInfo, scriptSource);
    }
    [appleScript release];
}

+ (void)publishBottle:(id)arg1 withWindow:(id)arg2 {
    NSString *bottleName = [arg1 name];
    PublishController *ctrl = [[PublishController alloc] init];
    [ctrl setupGUI];
    [ctrl setSourceBottle:bottleName];
    [arg2 beginSheet:[ctrl window] completionHandler:nil];
    [ctrl release];
}

+ (void)rateBottle:(id)arg1 withWindow:(id)arg2 isDeleting:(BOOL)arg3 {
    if (arg1 != nil) {
        NSString *appid = [arg1 appid];
        if ([appid length] != 0 && ![arg1 isIsManaged]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                SubmitRatingController *ctrl = [[SubmitRatingController alloc] initWithBottle:arg1 isNag:YES isDeleting:arg3];
                if (ctrl != nil) {
                    if (arg2 != nil) {
                        [arg2 beginSheet:[ctrl window] completionHandler:nil];
                    } else {
                        [[ctrl window] center];
                        [[ctrl window] makeKeyAndOrderFront:arg2];
                    }
                    [ctrl release];
                }
            });
        }
    }
}

+ (void)runCommandInBottle:(id)arg1 {
    [self runCommandInBottle:arg1 withLauncher:nil];
}

+ (void)runCommandInBottle:(id)arg1 withLauncher:(id)arg2 {
    if (arg1 != nil && ![arg1 isCanRunCommands]) {
        return;
    }
    RunCommandController *ctrl = [[RunCommandController alloc] init];
    if (arg2 != nil) {
        [ctrl setLauncher:arg2];
    }
    [ctrl window];
    if (arg1 != nil) {
        [ctrl setSelectedBottle:arg1];
    }
    [ctrl showWindow:self];
    [ctrl release];
}

+ (void)toggleDefaultBottle:(id)arg1 {
    NSNumber *newVal = [NSNumber numberWithBool:![arg1 isIsDefault]];
    [arg1 setIsDefault:newVal completionHandler:^(id err) {
        [[[CXSetupLib bottleCollectionClass] sharedCollection] refreshDefaultBottle];
    }];
}

+ (void)toggleMSyncForBottle:(id)arg1 withWindow:(id)arg2 {
    [self toggleMSyncForBottle:arg1 withWindow:arg2 modalCompletionHandler:nil];
}

+ (void)toggleMSyncForBottle:(id)arg1 withWindow:(id)arg2 modalCompletionHandler:(id)arg3 {
    void (^handler)(BOOL) = [arg3 copy];
    BOOL isEnabled = [arg1 isIsMSyncEnabled];
    NSAlert *alert = [[NSAlert alloc] init];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *rebootBtnTitle = nil;
    NSString *infoPrefix = @"";
    if (isEnabled) {
        [alert setMessageText:[bundle localizedStringForKey:@"Disable MSync" value:@"" table:nil]];
        rebootBtnTitle = [bundle localizedStringForKey:@"Reboot Bottle and Disable MSync" value:@"" table:nil];
    } else {
        [alert setMessageText:[bundle localizedStringForKey:@"Enable MSync" value:@"" table:nil]];
        NSString *warn = [bundle localizedStringForKey:@"WARNING: Some Windows applications will not work correctly with MSync enabled." value:@"" table:nil];
        infoPrefix = [warn stringByAppendingString:@"\n\n"];
        rebootBtnTitle = [bundle localizedStringForKey:@"Reboot Bottle and Enable MSync" value:@"" table:nil];
    }
    [alert addButtonWithTitle:rebootBtnTitle];

    NSString *rebootMsg = [bundle localizedStringForKey:@"Changing this setting will reboot the bottle and cause any running applications in the bottle to quit. Are you sure you want to do this?" value:@"" table:nil];
    [alert setInformativeText:[infoPrefix stringByAppendingString:rebootMsg]];
    [alert addButtonWithTitle:[bundle localizedStringForKey:@"Cancel" value:@"" table:nil]];

    [alert beginSheetModalForWindow:arg2 completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == NSAlertFirstButtonReturn) {
            if (!isEnabled) {
                [arg1 enableMSync];
            } else {
                [arg1 disableMSync];
            }
        }
        if (handler) {
            handler(returnCode != NSAlertFirstButtonReturn);
            [handler release];
        }
    }];
    [alert release];
}

+ (void)toggleHighResolutionForBottle:(id)arg1 withWindow:(id)arg2 {
    [self toggleHighResolutionForBottle:arg1 withWindow:arg2 modalCompletionHandler:nil];
}

+ (void)toggleHighResolutionForBottle:(id)arg1 withWindow:(id)arg2 modalCompletionHandler:(id)arg3 {
    void (^handler)(BOOL) = [arg3 copy];
    BOOL isEnabled = [arg1 isIsHighResolutionEnabled];
    NSAlert *alert = [[NSAlert alloc] init];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *infoPrefix = @"";
    if (isEnabled) {
        [alert setMessageText:[bundle localizedStringForKey:@"Disable High Resolution" value:@"" table:nil]];
        [alert addButtonWithTitle:[bundle localizedStringForKey:@"Reboot Bottle and Disable High Resolution Mode" value:@"" table:nil]];
    } else {
        BOOL anyRetina = NO;
        BOOL allRetina = YES;
        for (NSScreen *screen in [NSScreen screens]) {
            NSNumber *screenNum = [[screen deviceDescription] objectForKey:@"NSScreenNumber"];
            CGDirectDisplayID displayID = [screenNum unsignedIntValue];
            CGDisplayModeRef mode = CGDisplayCopyDisplayMode(displayID);
            if (mode) {
                BOOL isRetina = (CGDisplayModeGetWidth(mode) != CGDisplayModeGetPixelWidth(mode));
                allRetina = allRetina && isRetina;
                anyRetina = anyRetina || isRetina;
                CGDisplayModeRelease(mode);
            }
        }
        [alert setMessageText:[bundle localizedStringForKey:@"Enable High Resolution" value:@"" table:nil]];
        NSString *warn = [bundle localizedStringForKey:@"WARNING: Many Windows applications render incorrectly in high resolution mode." value:@"" table:nil];
        if (anyRetina) {
            if (!allRetina) {
                NSString *note = [bundle localizedStringForKey:@"NOTE: Your Mac has a mix of Retina and non-Retina displays. High resolution mode will make things look better on your Retina displays but worse on your non-Retina displays." value:@"" table:nil];
                warn = [[warn stringByAppendingString:@"\n\n"] stringByAppendingString:note];
            }
        } else {
            NSString *note = [bundle localizedStringForKey:@"NOTE: Your Mac does not have any Retina displays that would benefit from high resolution mode. Enabling it will just make things look blurry." value:@"" table:nil];
            warn = [[warn stringByAppendingString:@"\n\n"] stringByAppendingString:note];
        }
        infoPrefix = [warn stringByAppendingString:@"\n\n"];
        [alert addButtonWithTitle:[bundle localizedStringForKey:@"Reboot Bottle and Enable High Resolution Mode" value:@"" table:nil]];
    }

    NSString *rebootMsg = [bundle localizedStringForKey:@"Changing this setting will reboot the bottle and cause any running applications in the bottle to quit. Are you sure you want to do this?" value:@"" table:nil];
    [alert setInformativeText:[infoPrefix stringByAppendingString:rebootMsg]];
    [alert addButtonWithTitle:[bundle localizedStringForKey:@"Cancel" value:@"" table:nil]];

    [alert beginSheetModalForWindow:arg2 completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == NSAlertFirstButtonReturn) {
            if (!isEnabled) {
                [arg1 enableHighResolution];
            } else {
                [arg1 disableHighResolution];
            }
        }
        if (handler) {
            handler(returnCode != NSAlertFirstButtonReturn);
            [handler release];
        }
    }];
    [alert release];
}

+ (void)togglePreviewForBottle:(id)arg1 withWindow:(id)arg2 {
    [self togglePreviewForBottle:arg1 withWindow:arg2 modalCompletionHandler:nil];
}

+ (void)togglePreviewForBottle:(id)arg1 withWindow:(id)arg2 modalCompletionHandler:(id)arg3 {
    void (^handler)(BOOL) = [arg3 copy];
    BOOL isEnabled = [arg1 isIsPreviewEnabled];
    NSAlert *alert = [[NSAlert alloc] init];
    NSBundle *bundle = [NSBundle mainBundle];
    if (isEnabled) {
        [alert setMessageText:[bundle localizedStringForKey:@"Disable for CrossOver Preview" value:@"" table:nil]];
        [alert setInformativeText:[bundle localizedStringForKey:@"Disabling this bottle for CrossOver Preview will cause any running applications in the bottle to quit. Are you sure you want to do this?" value:@"" table:nil]];
        [alert addButtonWithTitle:[bundle localizedStringForKey:@"Disable for CrossOver Preview" value:@"" table:nil]];
        [alert addButtonWithTitle:[bundle localizedStringForKey:@"Cancel" value:@"" table:nil]];
        [alert beginSheetModalForWindow:arg2 completionHandler:^(NSModalResponse returnCode) {
            if (returnCode == NSAlertFirstButtonReturn) {
                [arg1 quit:^(id err) {
                    [arg1 disablePreview];
                }];
            }
            if (handler) {
                handler(returnCode != NSAlertFirstButtonReturn);
                [handler release];
            }
        }];
    } else {
        [alert setMessageText:[bundle localizedStringForKey:@"Enable for CrossOver Preview" value:@"" table:nil]];
        NSString *warn = [bundle localizedStringForKey:@"WARNING: CrossOver Preview contains untested changes that may permanently break bottles." value:@"" table:nil];
        NSString *prefix = [warn stringByAppendingString:@"\n\n"];
        NSString *confirmFmt = [bundle localizedStringForKey:@"Are you sure you want to enable the '%@' bottle for CrossOver Preview?" value:@"" table:nil];
        NSString *confirmMsg = [NSString stringWithFormat:confirmFmt, [arg1 name]];
        [alert setInformativeText:[prefix stringByAppendingString:confirmMsg]];
        [alert addButtonWithTitle:[bundle localizedStringForKey:@"Enable for CrossOver Preview" value:@"" table:nil]];
        [alert addButtonWithTitle:[bundle localizedStringForKey:@"Cancel" value:@"" table:nil]];
        [alert beginSheetModalForWindow:arg2 completionHandler:^(NSModalResponse returnCode) {
            if (returnCode == NSAlertFirstButtonReturn) {
                [arg1 enablePreview];
            }
            if (handler) {
                handler(returnCode != NSAlertFirstButtonReturn);
                [handler release];
            }
        }];
    }
    [alert release];
}

+ (void)quitBottle:(id)arg1 {
    [arg1 quit:nil];
}

+ (void)forceQuitBottle:(id)arg1 {
    [arg1 forceQuit:nil];
}

@end
