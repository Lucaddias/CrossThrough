// NewBottleController.m — CrossThrough
#import "NewBottleController.h"
#import "CrossThrough.h"
#import "HopperCompat.h"
#import "CXSetupLib.h"

@implementation NewBottleController

+ (id)keyPathsForValuesAffectingCanCreate {
    return [NSSet setWithObject:@"bottleName"];
}

- (id)init {
    self = [super initWithWindowNibName:@"NewBottle"];
    if (self) {
        NSString *suggested = [[NSBundle mainBundle] localizedStringForKey:@"New Bottle" value:@"" table:nil];
        [self setSuggestedBottleName:suggested];
    }
    return self;
}

- (void)dealloc {
    [_bottle release];
    [_suggestedBottleName release];
    [_archiveURL release];
    [_bottleName release];
    [_bottleToCopy release];
    [_bottleTemplate release];
    [_templateArray release];
    [super dealloc];
}

- (void)setCopyMode:(BOOL)arg1 withBottleToCopy:(id)arg2 {
    self->_copyMode = arg1;
    NSWindow *win = [self window];
    if (arg1) {
        NSString *fmt = [[NSBundle mainBundle] localizedStringForKey:@"Make a Copy of %@" value:@"" table:nil];
        NSString *title = [NSString stringWithFormat:fmt, arg2];
        [win setTitle:title];
        [self setBottleToCopy:arg2];
    } else {
        NSString *title = [[NSBundle mainBundle] localizedStringForKey:@"Create a Bottle" value:@"" table:nil];
        [win setTitle:title];
        [self setBottleToCopy:nil];
    }
}

- (void)setupGUI {
    [self setIsWorking:NO];
    NSString *unique = [[CXSetupLib bottleQueryClass] uniqueBottleName:[self suggestedBottleName]];
    [self setBottleName:unique];

    NSArray *templates = [[CXSetupLib bottleManagementClass] templates];
    NSMutableArray *templateList = [NSMutableArray array];

    [templates enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id template, NSUInteger idx, BOOL *stop) {
        NSString *displayName = [[CXSetupLib bottleManagementClass] displayNameForTemplate:template];
        NSDictionary *dict = @{@"name": template, @"displayName": (displayName ?: @"")};
        [templateList addObject:dict];

        NSString *currentTemplate = [self bottleTemplate];
        if (currentTemplate != nil) {
            if ([currentTemplate compare:@"win10_64"] != NSOrderedSame) {
                [self setBottleTemplate:template];
            }
        } else {
            [self setBottleTemplate:template];
        }
    }];
    [self setTemplateArray:templateList];

    [self window];
    if ([[self sourceBottleLabel] isHiddenOrHasHiddenAncestor]) {
        id superview = [[self sourceBottleLabel] superview];
        id c1 = [self nameLabelCopyingLabelWidths];
        id c2 = [self sourceBottleToCreatingSpacer];
        if (c1 && c2) {
            [superview removeConstraints:@[c1, c2]];
        }
    }
    if ([[self bottleTypePopUp] isHiddenOrHasHiddenAncestor]) {
        id superview = [[self bottleTypePopUp] superview];
        id c1 = [self nameLabelTypeLabelWidths];
        id c2 = [self typeToCreatingSpacer];
        if (c1 && c2) {
            [superview removeConstraints:@[c1, c2]];
        }
    }
    if ([[self archivePathControl] isHiddenOrHasHiddenAncestor]) {
        id superview = [[self archivePathControl] superview];
        id c1 = [self nameLabelRestoringLabelWidths];
        id c2 = [self archiveToCreatingSpacer];
        if (c1 && c2) {
            [superview removeConstraints:@[c1, c2]];
        }
    }
}

- (void)createPressed:(id)arg1 {
    [self setIsWorking:YES];
    [NSThread detachNewThreadSelector:@selector(doCreate) toTarget:self withObject:nil];
}

- (void)doCreate {
    @autoreleasepool {
        NSArray *result = nil;
        if ([self copyMode]) {
            result = [[CXSetupLib bottleManagementClass] duplicateBottle:[self bottleName] fromBottle:[self bottleToCopy]];
        } else {
            if ([self archiveURL] != nil) {
                result = [[CXSetupLib bottleManagementClass] restoreBottle:[self bottleName] fromArchive:[[self archiveURL] path]];
            } else {
                result = [[CXSetupLib bottleManagementClass] createBottle:[self bottleName] fromTemplate:[self bottleTemplate]];
            }
        }

        BOOL success = NO;
        if ([result count] > 0) {
            success = [[result objectAtIndex:0] boolValue];
        }
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[[CXSetupLib bottleCollectionClass] sharedCollection] refresh];
                id bottle = [[[CXSetupLib bottleCollectionClass] sharedCollection] bottleWithName:[self bottleName]];
                [self setBottle:bottle];
                [self setIsWorking:NO];
                [self exitSuccess:nil];
            });
        } else {
            id errorMsg = [result count] > 1 ? [result objectAtIndex:1] : @"Unknown error";
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setIsWorking:NO];
                [self createFailed:errorMsg];
            });
        }
    }
}

- (void)createFailed:(id)arg1 {
    NSAlert *alert = [[NSAlert alloc] init];
    NSString *msg = [[NSBundle mainBundle] localizedStringForKey:@"Bottle creation failed" value:@"" table:nil];
    [alert setMessageText:msg];
    [alert setInformativeText:arg1 ?: @""];
    [alert beginSheetModalForWindow:[self window] completionHandler:nil];
    [alert release];
}

- (void)exitSuccess:(id)arg1 {
    [[self window] close];
    [[NSApplication sharedApplication] endSheet:[self window] returnCode:NSModalResponseOK];
}

- (void)cancelPressed:(id)arg1 {
    [[self window] close];
    [[NSApplication sharedApplication] endSheet:[self window] returnCode:NSModalResponseCancel];
}

- (BOOL)canCreate {
    NSString *name = [self bottleName];
    if ([name length] != 0) {
        NSNumber *valid = [[CXSetupLib bottleQueryClass] isValidNewBottleName:name];
        return [valid boolValue];
    }
    return NO;
}

- (id)bottle {
    return self->_bottle;
}

- (void)setBottle:(id)arg1 {
    if (self->_bottle != arg1) {
        [self->_bottle release];
        self->_bottle = [arg1 retain];
    }
}

- (id)suggestedBottleName {
    return self->_suggestedBottleName;
}

- (void)setSuggestedBottleName:(id)arg1 {
    if (self->_suggestedBottleName != arg1) {
        [self->_suggestedBottleName release];
        self->_suggestedBottleName = [arg1 copy];
    }
}

- (id)archiveURL {
    return self->_archiveURL;
}

- (void)setArchiveURL:(id)arg1 {
    if (self->_archiveURL != arg1) {
        [self->_archiveURL release];
        self->_archiveURL = [arg1 copy];
    }
}

- (id)bottleTypePopUp {
    return self->_bottleTypePopUp;
}

- (void)setBottleTypePopUp:(id)arg1 {
    self->_bottleTypePopUp = arg1;
}

- (id)nameLabelTypeLabelWidths {
    return self->_nameLabelTypeLabelWidths;
}

- (void)setNameLabelTypeLabelWidths:(id)arg1 {
    self->_nameLabelTypeLabelWidths = arg1;
}

- (id)typeToCreatingSpacer {
    return self->_typeToCreatingSpacer;
}

- (void)setTypeToCreatingSpacer:(id)arg1 {
    self->_typeToCreatingSpacer = arg1;
}

- (id)sourceBottleLabel {
    return self->_sourceBottleLabel;
}

- (void)setSourceBottleLabel:(id)arg1 {
    self->_sourceBottleLabel = arg1;
}

- (id)nameLabelCopyingLabelWidths {
    return self->_nameLabelCopyingLabelWidths;
}

- (void)setNameLabelCopyingLabelWidths:(id)arg1 {
    self->_nameLabelCopyingLabelWidths = arg1;
}

- (id)sourceBottleToCreatingSpacer {
    return self->_sourceBottleToCreatingSpacer;
}

- (void)setSourceBottleToCreatingSpacer:(id)arg1 {
    self->_sourceBottleToCreatingSpacer = arg1;
}

- (id)archivePathControl {
    return self->_archivePathControl;
}

- (void)setArchivePathControl:(id)arg1 {
    self->_archivePathControl = arg1;
}

- (id)nameLabelRestoringLabelWidths {
    return self->_nameLabelRestoringLabelWidths;
}

- (void)setNameLabelRestoringLabelWidths:(id)arg1 {
    self->_nameLabelRestoringLabelWidths = arg1;
}

- (id)archiveToCreatingSpacer {
    return self->_archiveToCreatingSpacer;
}

- (void)setArchiveToCreatingSpacer:(id)arg1 {
    self->_archiveToCreatingSpacer = arg1;
}

- (id)bottleName {
    return self->_bottleName;
}

- (void)setBottleName:(id)arg1 {
    if (self->_bottleName != arg1) {
        [self willChangeValueForKey:@"canCreate"];
        [self->_bottleName release];
        self->_bottleName = [arg1 copy];
        [self didChangeValueForKey:@"canCreate"];
    }
}

- (id)bottleToCopy {
    return self->_bottleToCopy;
}

- (void)setBottleToCopy:(id)arg1 {
    if (self->_bottleToCopy != arg1) {
        [self->_bottleToCopy release];
        self->_bottleToCopy = [arg1 copy];
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

- (id)templateArray {
    return self->_templateArray;
}

- (void)setTemplateArray:(id)arg1 {
    if (self->_templateArray != arg1) {
        [self->_templateArray release];
        self->_templateArray = [arg1 copy];
    }
}

- (BOOL)copyMode {
    return self->_copyMode;
}

- (BOOL)isWorking {
    return self->_isWorking;
}

- (void)setIsWorking:(BOOL)arg1 {
    self->_isWorking = arg1;
}

@end
