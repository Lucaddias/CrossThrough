// SparkleCompat.m — CrossThrough
//
// O CrossOver usa o framework Sparkle (self-update via appcast em
// www.codeweavers.com/xml/versions/cxmac.xml). O CrossThrough não busca
// atualizações pela rede, então o atualizador já é inerte (CXUpdater
// sharedUpdater devolve nil, CXSparkleUserDriver não mostra nada).
//
// Mesmo inerte, três classes do Sparkle ainda eram referenciadas no link:
// SPUStandardUserDriver (superclasse de CXSparkleUserDriver), SPUUpdater
// (ivar de CXUpdater) e SUAppcastItem / SUStandardVersionComparator
// (usadas em bestValidUpdateInAppcast, que só rodaria com um appcast real).
//
// Este arquivo fornece implementações locais mínimas dessas classes, com a
// mesma superfície declarada em SparkleShim.h. Com isso o binário liga sem
// -framework Sparkle e o framework sai do bundle.

#import "SparkleShim.h"

@implementation SPUStandardUserDriver
@end

@implementation SPUUpdater {
    // O projeto usa contagem de referência manual (MRC), onde não dá para
    // sintetizar uma propriedade weak; guardamos o delegate como assign.
    __unsafe_unretained id<SPUUpdaterDelegate> _delegate;
}
- (id<SPUUpdaterDelegate>)delegate { return _delegate; }
- (void)setDelegate:(id<SPUUpdaterDelegate>)delegate { _delegate = delegate; }
- (void)checkForUpdates {
    // Sem busca de atualização pela rede.
}
@end

@implementation SUAppcastItem
@synthesize versionString;
@synthesize displayVersionString;
@synthesize date;
@end

@implementation SUStandardVersionComparator

+ (SUStandardVersionComparator *)defaultComparator {
    static SUStandardVersionComparator *shared = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{ shared = [[SUStandardVersionComparator alloc] init]; });
    return shared;
}

- (NSComparisonResult)compareVersion:(NSString *)versionA toVersion:(NSString *)versionB {
    if (!versionA) versionA = @"";
    if (!versionB) versionB = @"";
    return [versionA compare:versionB options:NSNumericSearch];
}

@end
