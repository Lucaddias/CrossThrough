// LoggingOptionsViewController.m — CrossThrough
#import "LoggingOptionsViewController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation LoggingOptionsViewController

+ (id)keyPathsForValuesAffectingEnableControls {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x40;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   var_18 = **___stack_chk_guard;
     *   var_28 = @"createLogFile";
     *   r0 = [NSArray arrayWithObjects:&var_28 count:0x2];
     *   r20 = [r0 retain];
     *   r19 = [[NSSet setWithArray:r20] retain];
     *   r0 = [r20 release];
     *   if (**___stack_chk_guard != var_18) {
     *   __stack_chk_fail();
     *   }
     *   r0 = [r19 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)initWithLogFileName:(id)arg1 {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)viewDidLoad {
    return;
}

- (void)updateLogFileURL {
    return;
}

- (void)setLogFileName:(id)arg1 {
    return;
}

- (void)selectLogFile:(id)arg1 {
    return;
}

- (void)clearLoggingChannels:(id)arg1 {
    return;
}

- (id)combineChannels:(id)arg1 with:(id)arg2 andDelimiter:(id)arg3 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r31 = r31 - 0x140;
     *   var_50 = r28;
     *   decomp_var_48 = r27;
     *   var_40 = r26;
     *   decomp_var_38 = r25;
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   var_60 = **___stack_chk_guard;
     *   r21 = [arg2 retain];
     *   r19 = [arg3 retain];
     *   r20 = [arg4 retain];
     *   r22 = [[r21 componentsSeparatedByString:r20] retain];
     *   if (r21 == 0x0) {
     *   r21 = @"";
     *   }
     *   r23 = [[NSMutableString string] retain];
     *   if ([r22 count] != 0x0) {
     *   r24 = [[NSSet setWithArray:r22] retain];
     *   var_120 = q0;
     *   ... (60 more lines)
     */
    return nil;
}

- (void)addLoggingChannels:(id)arg1 {
    return;
}

- (void)addExtraEnvVariables:(id)arg1 {
    return;
}

- (BOOL)enableControls {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   r31 = r31 + 0xffffffffffffffe0;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r19 = self;
     *   r0 = [self createLogFile];
     *   if (r0 != 0x0) {
     *   r0 = [r19 enabled];
     *   }
     *   return r0;
     */
    return NO;
}

- (void)sanitizeLogChannels {
    return;
}

- (void)saveSettingsToRecent {
    return;
}

- (void)updateRecentMenuItems {
    return;
}

- (void)restoreRecent:(id)arg1 {
    return;
}

- (BOOL)createLogFile {
    return self->_createLogFile;
}

- (void)setCreateLogFile:(BOOL)arg1 {
    self->_createLogFile = arg1;
}

- (BOOL)enabled {
    return self->_enabled;
}

- (void)setEnabled:(BOOL)arg1 {
    self->_enabled = arg1;
}

- (id)channelCombos {
    return [[self->_channelCombos retain] autorelease];
}

- (void)setChannelCombos:(id)arg1 {
    if (self->_channelCombos != arg1) {
        [self->_channelCombos release];
        self->_channelCombos = [arg1 retain];
    }
}

- (id)logChannels {
    return [[self->_logChannels retain] autorelease];
}

- (void)setLogChannels:(id)arg1 {
    if (self->_logChannels != arg1) {
        [self->_logChannels release];
        self->_logChannels = [arg1 copy];
    }
}

- (id)logEnvironment {
    return [[self->_logEnvironment retain] autorelease];
}

- (void)setLogEnvironment:(id)arg1 {
    if (self->_logEnvironment != arg1) {
        [self->_logEnvironment release];
        self->_logEnvironment = [arg1 copy];
    }
}

- (id)logFileName {
    return self->_logFileName;
}

- (id)logFileURL {
    return self->_logFileURL;
}

- (void)setLogFileURL:(id)arg1 {
    if (self->_logFileURL != arg1) {
        [self->_logFileURL release];
        self->_logFileURL = [arg1 copy];
    }
}

- (id)logDirectoryURL {
    return [[self->_logDirectoryURL retain] autorelease];
}

- (void)setLogDirectoryURL:(id)arg1 {
    if (self->_logDirectoryURL != arg1) {
        [self->_logDirectoryURL release];
        self->_logDirectoryURL = [arg1 copy];
    }
}

- (BOOL)logFileNameFromUser {
    return self->_logFileNameFromUser;
}

- (void)setLogFileNameFromUser:(BOOL)arg1 {
    self->_logFileNameFromUser = arg1;
}

- (id)channelPresets {
    return [objc_loadWeakRetained((id *)&self->_channelPresets) autorelease];
}

- (void)setChannelPresets:(id)arg1 {
    objc_storeWeak((id *)&self->_channelPresets, arg1);
}

- (id)recentChannelsDivider {
    return [objc_loadWeakRetained((id *)&self->_recentChannelsDivider) autorelease];
}

- (void)setRecentChannelsDivider:(id)arg1 {
    objc_storeWeak((id *)&self->_recentChannelsDivider, arg1);
}

- (id)recentChannelsMenuItem {
    return [objc_loadWeakRetained((id *)&self->_recentChannelsMenuItem) autorelease];
}

- (void)setRecentChannelsMenuItem:(id)arg1 {
    objc_storeWeak((id *)&self->_recentChannelsMenuItem, arg1);
}

@end
