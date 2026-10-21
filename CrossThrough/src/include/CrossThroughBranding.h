// CrossThroughBranding.h — CrossThrough's own name and logo over the
// CrossOver resources the app bundle borrows.
#ifndef CrossThroughBranding_h
#define CrossThroughBranding_h

#import <Cocoa/Cocoa.h>

// CFBundleName of the running bundle ("CrossThrough").
NSString *CTApplicationName(void);

// Registers the CrossThrough logo under the names MainWindow.nib asks for
// (welcomeCrossOverIcon and its Preview twin). Call before the nib loads.
void CTRegisterBrandedLogo(void);

// Puts the application name in the About, Hide and Quit items of the
// application menu.
void CTBrandAppMenu(void);

#endif /* CrossThroughBranding_h */
