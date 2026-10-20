// CXBundle.m — CrossThrough
#import "CXBundle.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation CXBundle

+ (id)bundleWithURL:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r20 = [arg2 retain];
     *   r19 = [[self alloc] initWithURL:r20];
     *   [r20 release];
     *   r0 = [r19 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)initWithURL:(id)arg1 {
    self = [super init];
    if (self) {
        // Initialized
    }
    return self;
}

- (void)dealloc {
    return;
}

- (id)objectForInfoDictionaryKey:(id)arg1 {
    /*
     * Decompiled from CrossOver 26.3:
     *   r20 = [arg2 retain];
     *   r19 = [CFBundleGetValueForInfoDictionaryKey([self cfBundle], r20) retain];
     *   [r20 release];
     *   r0 = [r19 autorelease];
     *   return r0;
     */
    return nil;
}

- (id)bundleIdentifier {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self cfBundle];
     *   r0 = CFBundleGetIdentifier(r0);
     *   return r0;
     */
    return nil;
}

- (id)executablePath {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self cfBundle];
     *   r0 = CFBundleCopyExecutableURL(r0);
     *   r19 = r0;
     *   r0 = [r0 path];
     *   r0 = [r0 retain];
     *   r20 = r0;
     *   r21 = [r0 copy];
     *   [r20 release];
     *   [r19 release];
     *   r0 = [r21 autorelease];
     *   return r0;
     */
    return nil;
}

- (NSUInteger)helperVersion {
    /*
     * Decompiled from CrossOver 26.3:
     *   r0 = [self cfBundle];
     *   r0 = CFBundleGetValueForInfoDictionaryKey(r0, @"CXHelperAppVersion");
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   r20 = [r0 unsignedIntValue];
     *   [r19 release];
     *   r0 = r20;
     *   return r0;
     */
    return 0;
}

- (id)icon {
    /*
     * Decompiled from CrossOver 26.3:
     *   var_30 = r24;
     *   decomp_var_28 = r23;
     *   r31 = r31 + 0xffffffffffffffc0;
     *   var_20 = r22;
     *   decomp_var_18 = r21;
     *   var_10 = r20;
     *   decomp_var_8 = r19;
     *   saved_fp = r29;
     *   decomp_var_m8 = r30;
     *   r21 = self;
     *   r0 = [self objectForInfoDictionaryKey:@"CFBundleIconFile"];
     *   r0 = [r0 retain];
     *   r19 = r0;
     *   if (r0 != 0x0) {
     *   r0 = [r21 cfBundle];
     *   r0 = CFBundleCopyResourceURL(r0, r19, @"icns", 0x0);
     *   r20 = r0;
     *   if (r0 != 0x0) {
     *   r0 = [NSImage alloc];
     *   r0 = [r0 initWithContentsOfURL:r20];
     *   r22 = r0;
     *   if (r0 == 0x0) {
     *   r23 = [[NSWorkspace sharedWorkspace] retain];
     *   r0 = [r21 url];
     *   r0 = [r0 retain];
     *   ... (46 more lines)
     */
    return nil;
}

- (id)url {
    return self->_url;
}

- (void)setUrl:(id)arg1 {
    self->_url = arg1;
}

- (id *)cfBundle {
    return self->_cfBundle;
}

- (void)setCfBundle:(void *)arg1 {
    self->_cfBundle = arg1;
}

@end
