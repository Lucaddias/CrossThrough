// NSMutableAttributedString+CrossOverAdditions.h — CrossThrough
#ifndef NSMutableAttributedString_CrossOverAdditions_h
#define NSMutableAttributedString_CrossOverAdditions_h

#import <Cocoa/Cocoa.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@interface NSMutableAttributedString (CrossOverAdditions)

// Class Methods
+ (id)cx_attributedStringWithHTML:(id)arg1 font:(id)arg2;
+ (id)cx_attributedStringWithHTML:(id)arg1;

// Instance Methods
- (void)cx_removeTrailingWhitespaceAndNewlines;

@end

#endif /* NSMutableAttributedString_CrossOverAdditions_h */
