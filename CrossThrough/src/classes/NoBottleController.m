// NoBottleController.m — CrossThrough
#import "NoBottleController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"

@implementation NoBottleController

+ (id)keyPathsForValuesAffectingCanCreate {
    return [NSSet setWithObject:@"nameForNewBottle"];
}

- (id)initWithFileToLaunch:(id)arg1 {
    self = [super initWithWindowNibName:@"NoBottle"];
    if (self) {
        NSBundle *mb = [NSBundle mainBundle];
        self->suggestedBottleName = [[mb localizedStringForKey:@"New Bottle" value:@"" table:nil] copy];
        [self setFileToLaunchString:arg1];
        if (arg1) {
            NSURL *url = [NSURL fileURLWithPath:arg1];
            [self setFileToLaunch:url];
        }
    }
    return self;
}

- (void)dealloc {
    [self->suggestedBottleName release];
    [self->_fileToLaunch release];
    [self->_nameForNewBottle release];
    [self->_bottleTemplate release];
    [self->_fileToLaunchString release];
    [self->_templateArray release];
    [self->ProgBar release];
    [super dealloc];
}

- (void)awakeFromNib {
    [self setIsWorking:NO];
    NSString *unique = [[CXSetupLib bottleQueryClass] uniqueBottleName:self->suggestedBottleName];
    [self setNameForNewBottle:unique];
    
    NSArray *templates = [[CXSetupLib bottleManagementClass] templates];
    NSMutableArray *arr = [NSMutableArray array];
    [templates enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *displayName = [[CXSetupLib bottleManagementClass] displayNameForTemplate:obj];
        NSDictionary *dict = @{@"name": obj, @"displayName": displayName ?: obj};
        [arr addObject:dict];
        if (![self bottleTemplate] || [[self bottleTemplate] compare:@"win7"] != NSOrderedSame) {
            [self setBottleTemplate:obj];
        }
    }];
    [self setTemplateArray:arr];
}

- (void)createPressed:(id)arg1 {
    [self setIsWorking:YES];
    [NSThread detachNewThreadSelector:@selector(doCreate) toTarget:self withObject:nil];
}

- (void)doCreate {
    @autoreleasepool {
        id res = [[CXSetupLib bottleManagementClass] createBottle:[self nameForNewBottle] fromTemplate:[self bottleTemplate]];
        BOOL success = NO;
        if ([res isKindOfClass:[NSArray class]] && [res count] > 0) {
            success = [[res objectAtIndex:0] boolValue];
        }
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setIsWorking:NO];
                [self exitSuccess:nil];
            });
        } else {
            id errMsg = ([res isKindOfClass:[NSArray class]] && [res count] > 1) ? [res objectAtIndex:1] : @"Unknown error";
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setIsWorking:NO];
                [self createFailed:errMsg];
            });
        }
    }
}

- (void)createFailed:(id)arg1 {
    NSAlert *alert = [[NSAlert alloc] init];
    NSString *title = [[NSBundle mainBundle] localizedStringForKey:@"Bottle creation failed" value:@"" table:nil];
    [alert setMessageText:title];
    [alert setInformativeText:[arg1 description]];
    [alert beginSheetModalForWindow:[self window] completionHandler:nil];
    [alert release];
}

- (void)exitSuccess:(id)arg1 {
    [[self window] close];
    id col = [[CXSetupLib bottleCollectionClass] sharedCollection];
    [col refresh];
    id bottle = [col bottleWithName:[self nameForNewBottle]];
    [BottleMenuHandler toggleDefaultBottle:bottle];
    
    CXApplication *app = (CXApplication *)[CXApplication sharedApplication];
    [[app CXServer] runClient:[self fileToLaunchString] inBottle:[self nameForNewBottle]];
}

- (void)cancelPressed:(id)arg1 {
    [[self window] close];
    [[NSApplication sharedApplication] endSheet:[self window] returnCode:0];
}

- (void)scopeChanged:(id)arg1 {
    return;
}

- (BOOL)canCreate {
    return [[self nameForNewBottle] length] != 0;
}

- (id)fileToLaunch {
    return self->_fileToLaunch;
}

- (void)setFileToLaunch:(id)arg1 {
    if (self->_fileToLaunch != arg1) {
        [self->_fileToLaunch release];
        self->_fileToLaunch = [arg1 copy];
    }
}

- (id)nameForNewBottle {
    return self->_nameForNewBottle;
}

- (void)setNameForNewBottle:(id)arg1 {
    if (self->_nameForNewBottle != arg1) {
        [self->_nameForNewBottle release];
        self->_nameForNewBottle = [arg1 copy];
    }
}

- (id)bottleTemplate {
    return self->_bottleTemplate;
}

- (void)setBottleTemplate:(id)arg1 {
    if (self->_bottleTemplate != arg1) {
        [self->_bottleTemplate release];
        self->_bottleTemplate = [arg1 copy];
    }
}

- (id)fileToLaunchString {
    return self->_fileToLaunchString;
}

- (void)setFileToLaunchString:(id)arg1 {
    if (self->_fileToLaunchString != arg1) {
        [self->_fileToLaunchString release];
        self->_fileToLaunchString = [arg1 copy];
    }
}

- (BOOL)isWorking {
    return self->_isWorking;
}

- (void)setIsWorking:(BOOL)arg1 {
    self->_isWorking = arg1;
}

- (id)templateArray {
    return self->_templateArray;
}

- (void)setTemplateArray:(id)arg1 {
    if (self->_templateArray != arg1) {
        [self->_templateArray release];
        self->_templateArray = [arg1 copy];
    }
}

@end
