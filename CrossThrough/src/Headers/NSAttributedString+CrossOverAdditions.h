// NSAttributedString+CrossOverAdditions.h — CrossThrough
#ifndef NSAttributedString_CrossOverAdditions_h
#define NSAttributedString_CrossOverAdditions_h

#import <Cocoa/Cocoa.h>
#import "CrossThroughProtocols.h"
#import "SparkleShim.h"
#import "PythonShim.h"


@interface NSAttributedString (CrossOverAdditions)

// Class Methods
+ (id)cx_attributedStringWithHTML:(id)arg1 font:(id)arg2;
+ (id)cx_attributedStringWithHTML:(id)arg1;

// Instance Methods
- (id)cx_attributedStringByRemovingTrailingWhitespaceAndNewlines;

@end

#endif /* NSAttributedString_CrossOverAdditions_h */
