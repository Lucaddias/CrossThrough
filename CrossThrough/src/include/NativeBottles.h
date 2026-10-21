// NativeBottles.h — CrossThrough
//
// Reconstrução NATIVA (Objective-C) do módulo de bottles do CrossOver 26.3,
// substituindo a camada Python fechada (bottlewrapper/bottlecollection/
// bottlemanagement/bottlequery .pyc chamados via PyObjC).
//
// A superfície de seletores e propriedades segue sharedsupport/python/BRIDGE.md
// e os esboços em sharedsupport/python/outline/*.py. Os comandos para cxbottle,
// wine e cxmanip, e as chaves de cxbottle.conf, vêm desses esboços — ver
// NATIVE_BOTTLES.md para o mapeamento item a item e o que é inferência.
//
// As classes BottleWrapper/BottleCollection/BottleManagement/BottleQuery são
// declaradas em PythonShim.h (a interface que a GUI compila). Aqui declaramos
// apenas o material de suporte e os seletores adicionais (named selectors do
// BRIDGE) como categorias, para não recolidir com aquelas declarações.

#ifndef NativeBottles_h
#define NativeBottles_h

#import <Cocoa/Cocoa.h>
#import "PythonShim.h"   // @interface BottleWrapper/BottleCollection/...

#pragma mark - cxbottle.conf (INI)

// Leitor/escritor do cxbottle.conf de uma bottle. Formato INI: secções em
// [Secção] e linhas chave=valor. Espelha get_config/set_config_value/
// unset_config_value do bottlewrapper, com bloqueio de ficheiro ao gravar.
@interface CXBottleConfig : NSObject
+ (instancetype)configWithPath:(NSString *)path;         // <prefix>/cxbottle.conf
- (NSString *)stringForSection:(NSString *)section key:(NSString *)key default:(NSString *)def;
- (BOOL)boolForSection:(NSString *)section key:(NSString *)key default:(BOOL)def;
- (void)setString:(NSString *)value section:(NSString *)section key:(NSString *)key;
- (void)unsetSection:(NSString *)section key:(NSString *)key;
- (BOOL)save;                                            // lock + reescrita atómica
@end

#pragma mark - Caminhos e ferramentas

// Resolução de caminhos de bottle (espelha cxproduct/bottlequery).
@interface CXBottlePaths : NSObject
+ (NSString *)crossOverRoot;                             // CX_ROOT
+ (NSString *)privateBottleDir;                          // ~/…/CrossOver/Bottles (ou pref BottleDir)
+ (NSArray<NSString *> *)reservedNames;                  // default, icons, installers, logs, tie
+ (NSArray<NSString *> *)bottleNames;                    // bottles válidas (têm system.reg + cxbottle.conf)
+ (NSString *)prefixForBottle:(NSString *)name;          // WINEPREFIX, ou nil
+ (NSString *)configPathForBottle:(NSString *)name;      // <prefix>/cxbottle.conf
+ (NSString *)defaultBottleName;                         // alvo do symlink "default", ou nil
+ (BOOL)isValidWinePrefix:(NSString *)prefix;            // existe + system.reg + cxbottle.conf
@end

// Resultado de uma execução de ferramenta (espelha o par (success, err_msg)).
@interface CXToolResult : NSObject
@property (nonatomic) BOOL success;
@property (nonatomic, copy) NSString *output;
@end

// Executor dos utilitários Perl do backend (cxbottle, wine, cxsu), com os
// vetores de argumentos exatos documentados nos esboços.
@interface CXBottleTool : NSObject
+ (NSString *)toolPath:(NSString *)name;                 // CX_ROOT/bin/<name>
// Executa e recolhe stdout+stderr (equivalente a cxutils.run(..., GRAB)).
+ (CXToolResult *)run:(NSArray<NSString *> *)argv;
+ (CXToolResult *)run:(NSArray<NSString *> *)argv env:(NSDictionary *)extraEnv;
// Executa e devolve só o código de saída (equivalente a os.system()).
+ (int)system:(NSArray<NSString *> *)argv;
@end

#pragma mark - Classes nativas (CT*)

// As classes recebem nomes de runtime distintos (CT*) para NÃO colidirem com
// as classes homónimas que o PyObjC ainda regista ao importar os módulos
// Python restantes (C4Profiles, InstallTask, …). O CXSetupLib devolve estas
// classes nos getters bottleWrapperClass/bottleCollectionClass/… e a GUI
// continua a vê-las através dos tipos BottleWrapper/BottleCollection/… de
// PythonShim.h (via `id`). Métodos implementados mas não declarados aqui são
// chamados pela GUI por esses tipos ou por KVC/Cocoa Bindings.

@interface CTBottleQuery : NSObject
+ (id)uniqueBottleName:(id)inBasename;
+ (id)isValidNewBottleName:(id)name;
@end

@interface CTBottleManagement : NSObject
+ (id)templates;
+ (id)displayNameForTemplate:(id)template;
+ (id)createBottle:(id)name fromTemplate:(id)tmpl;
+ (id)duplicateBottle:(id)name fromBottle:(id)src;
+ (id)restoreBottle:(id)name fromArchive:(id)archive;
+ (id)archiveBottle:(id)name toPath:(id)path;
// Funções de módulo de bottlemanagement.py, aqui como métodos de classe.
+ (BOOL)quitBottle:(NSString *)name;
+ (BOOL)killBottle:(NSString *)name;
+ (BOOL)isRunning:(NSString *)name;
+ (BOOL)deleteBottle:(NSString *)name managed:(BOOL)managed;
+ (BOOL)renameBottle:(NSString *)name to:(NSString *)newName;
+ (BOOL)setDefaultBottle:(NSString *)name state:(BOOL)state;
+ (BOOL)getUpToDate:(NSString *)name scope:(NSString *)scope;
@end

@interface CTBottleWrapper : NSObject
- (instancetype)initWithName:(NSString *)name;
- (NSString *)name;
- (NSString *)displayName;
- (void)addMenuObservers;
- (void)removeMenuObservers;
- (void)removeObservers;
- (BOOL)is32Bit;
@end

@interface CTBottleCollection : NSObject
+ (id)sharedCollection;
- (void)refresh;
- (void)reset;
- (id)bottleList;
- (id)bottleWithName:(id)name;
- (void)refreshDefaultBottle;
- (void)addChangeDelegate:(id)d;
- (void)removeChangeDelegate:(id)d;
@end

#endif /* NativeBottles_h */
