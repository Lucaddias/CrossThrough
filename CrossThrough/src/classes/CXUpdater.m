// CXUpdater.m — CrossThrough
#import "CXUpdater.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

#import "c_functions.h"

// One updater per bundle, keyed by the (unretained) bundle.
static NSMutableDictionary *_sharedUpdaters = nil;

@implementation CXUpdater

+ (id)sharedUpdater {
    return [self updaterForBundle:[NSBundle mainBundle]];
}

+ (id)updaterForBundle:(id)arg1 {
    NSBundle *bundle = arg1 ? arg1 : [NSBundle mainBundle];
    id updater = [_sharedUpdaters objectForKey:[NSValue valueWithNonretainedObject:bundle]];
    if (updater) {
        return updater;
    }
    // -initForBundle: registers the new updater in _sharedUpdaters, which
    // keeps it alive.
    return [[[[self class] alloc] initForBundle:bundle] autorelease];
}

- (id)initForBundle:(id)arg1 {
    self = [super init];
    NSBundle *bundle = arg1 ? arg1 : [NSBundle mainBundle];
    id existing = [_sharedUpdaters objectForKey:[NSValue valueWithNonretainedObject:bundle]];
    if (existing) {
        [self release];
        return [existing retain];
    }
    if (self) {
        if (!_sharedUpdaters) {
            _sharedUpdaters = [[NSMutableDictionary alloc] init];
        }
        [_sharedUpdaters setObject:self forKey:[NSValue valueWithNonretainedObject:bundle]];
        // CrossThrough: o self-update via Sparkle (appcast em
        // www.codeweavers.com/xml/versions/cxmac.xml) foi removido. Não criamos
        // o SPUUpdater nem o user driver; _updater fica nil e os métodos abaixo
        // viram no-ops (mensagens a nil). Assim o app não liga com o Sparkle.
    }
    return self;
}

- (id)init {
    return [self initForBundle:[NSBundle mainBundle]];
}

- (void)setUserAgentString {
    // Sparkle's agent ends in " Sparkle"; add the OS version in front of it.
    NSOperatingSystemVersion version = [[NSProcessInfo processInfo] operatingSystemVersion];
    NSString *replacement = [NSString stringWithFormat:@" (macOS %ld.%ld.%ld) Sparkle",
                             (long)version.majorVersion, (long)version.minorVersion, (long)version.patchVersion];
    [self->_updater setUserAgentString:[[self->_updater userAgentString] stringByReplacingOccurrencesOfString:@" Sparkle" withString:replacement]];
}

- (BOOL)automaticallyChecksForUpdates {
    return [self->_updater automaticallyChecksForUpdates];
}

- (void)setAutomaticallyChecksForUpdates:(BOOL)arg1 {
    [self->_updater setAutomaticallyChecksForUpdates:arg1];
}

- (CGFloat)updateCheckInterval {
    return [self->_updater updateCheckInterval];
}

- (void)checkForUpdates:(id)arg1 {
    [self->_updater checkForUpdates];
}

- (BOOL)validateMenuItem:(id)arg1 {
    if ([arg1 action] != @selector(checkForUpdates:)) {
        return YES;
    }
    return [self->_updater canCheckForUpdates];
}

- (void)checkForUpdatesInBackground {
    // An update the user driver deferred has to be shown in the foreground.
    if (self->_delayShowingUserUpdate) {
        [self checkForUpdates:nil];
    } else {
        [self->_updater checkForUpdatesInBackground];
    }
}

- (id)lastUpdateCheckDate {
    return [self->_updater lastUpdateCheckDate];
}

- (id)bestValidUpdateInAppcast:(id)arg1 forUpdater:(id)arg2 {
    id<CXUpdaterDelegate> delegate = [self delegate];
    if ([delegate respondsToSelector:@selector(bestValidUpdateInAppcast:forUpdater:)]) {
        return [delegate bestValidUpdateInAppcast:arg1 forUpdater:self];
    }
    return nil;
}

- (void)updaterDidNotFindUpdate:(id)arg1 {
    id<CXUpdaterDelegate> delegate = [self delegate];
    if ([delegate respondsToSelector:@selector(updaterDidNotFindUpdate:)]) {
        [delegate updaterDidNotFindUpdate:self];
    }
}

- (void)updater:(id)arg1 didAbortWithError:(id)arg2 {
    id<CXUpdaterDelegate> delegate = [self delegate];
    if ([delegate respondsToSelector:@selector(updaterDidAbortWithError:error:)]) {
        [delegate updaterDidAbortWithError:self error:arg2];
    }
}

- (void)updater:(id)arg1 userDidMakeChoice:(NSInteger)arg2 forUpdate:(id)arg3 state:(id)arg4 {
    id<CXUpdaterDelegate> delegate = [self delegate];
    // SPUUserUpdateChoice: 0 = skip, 1 = install, 2 = dismiss.
    if (arg2 == 2) {
        if ([delegate respondsToSelector:@selector(userDidCancelDownload:)]) {
            [delegate userDidCancelDownload:self];
        }
    } else if (arg2 == 0) {
        if ([delegate respondsToSelector:@selector(updater:userDidSkipThisVersion:)]) {
            [delegate updater:self userDidSkipThisVersion:arg3];
        }
    }
}

- (void)updater:(id)arg1 failedToDownloadUpdate:(id)arg2 error:(id)arg3 {
    id<CXUpdaterDelegate> delegate = [self delegate];
    if ([delegate respondsToSelector:@selector(updater:failedToDownloadUpdate:error:)]) {
        [delegate updater:self failedToDownloadUpdate:arg2 error:arg3];
    }
}

- (void)userDidCancelDownload:(id)arg1 {
    id<CXUpdaterDelegate> delegate = [self delegate];
    if ([delegate respondsToSelector:@selector(userDidCancelDownload:)]) {
        [delegate userDidCancelDownload:self];
    }
}

- (void)setNotLicensed:(BOOL)arg1 {
    [self->_userDriver setNotLicensed:arg1];
}

- (void)standardUserDriverWillHandleShowingUpdate:(BOOL)arg1 forUpdate:(id)arg2 state:(id)arg3 {
    if (!arg1) {
        self->_delayShowingUserUpdate = YES;
    }
}

- (void)standardUserDriverWillFinishUpdateSession {
    self->_delayShowingUserUpdate = NO;
}

- (id)delegate {
    return [objc_loadWeakRetained((id *)&self->_delegate) autorelease];
}

- (void)setDelegate:(id)arg1 {
    objc_storeWeak((id *)&self->_delegate, arg1);
}

- (void)setUpdateCheckInterval:(CGFloat)arg1 {
    self->_updateCheckInterval = arg1;
}

- (void)dealloc {
    [self->_updater release];
    [self->_userDriver release];
    objc_destroyWeak((id *)&self->_delegate);
    [super dealloc];
}

@end
