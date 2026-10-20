// HopperCompat.h — Runtime shims and compatibility macros for Hopper pseudocode
#ifndef HopperCompat_h
#define HopperCompat_h

#import <Cocoa/Cocoa.h>
#import <objc/runtime.h>
#import <objc/message.h>

#ifdef __cplusplus
extern "C" {
#endif

// Runtime helpers
FOUNDATION_EXPORT void objc_storeStrong(id *location, id obj);
FOUNDATION_EXPORT id objc_retainAutoreleaseReturnValue(id obj);
FOUNDATION_EXPORT id objc_unsafeClaimAutoreleasedReturnValue(id obj);
FOUNDATION_EXPORT void objc_enumerationMutation(id collection);

// Common macros in pseudocode
#define sign_extend_64(x) ((int64_t)(x))
#define q0 ((id)0)
#define q1 ((id)0)
#define q2 ((id)0)
#define q3 ((id)0)

// Ivar offset helper
#define ivar_offset(name) (&((struct { int32_t val; }){ 0 }).val)

// Conditional assembly fallback
#define ASM_COND(expr) (0)

#ifdef __cplusplus
}
#endif

#endif /* HopperCompat_h */
