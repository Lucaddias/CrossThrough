# Módulos Python de `SharedSupport/CrossOver/lib/python`

Os 50 módulos vêm só como bytecode CPython 3.13 (`.pyc` hash-based, flags 3). Para cada um há um esboço reconstruído em [`outline/`](outline) e a desmontagem completa em [`dis/`](dis). Gerado por `.tools/make_index.py` a partir de [`modules.json`](modules.json).

| Módulo | Docstring | Classes | Funções | Code objects | Instruções | Importa (internos) | Importa (externos) |
|---|---|---|---|---|---|---|---|
| [`appdetector`](outline/appdetector.py) | — | `InstalledApplication`, `AppDetector` | 5 | 16 | 1048 | `bottlequery`, `c4profilesmanager`, `cxglob`, `cxlog`, `cxobjc`, `cxutils`, `distversion` | — |
| [`bottlecollection`](outline/bottlecollection.py) | — | `BottleCollection` | 1 | 20 | 636 | `bottlequery`, `bottlewrapper`, `cxobjc`, `distversion` | — |
| [`bottlemanagement`](outline/bottlemanagement.py) | — | `BottleManagement` | 17 | 19 | 1066 | `bottlequery`, `cxlog`, `cxobjc`, `cxproduct`, `cxutils`, `distversion` | — |
| [`bottlequery`](outline/bottlequery.py) | — | `BottleQuery`, `NotFoundError`, `AsyncManipResult`, `_BottleManipulator` | 34 | 59 | 4505 | `cxconfig`, `cxevent`, `cxlog`, `cxobjc`, `cxproduct`, `cxutils`, `distversion` | — |
| [`bottlewrapper`](outline/bottlewrapper.py) | — | `BottleWrapper`, `BottleWrapperOperation`, `AddMenuObserversOperation`, `LoadApplicationInfoOperation`, `LoadControlPanelInfoOperation`, `LoadHighResolutionInfoOperation`, `SetHighResolutionEnabledStateOperation`, `SetIsDefaultOperation` … (+4) | 0 | 167 | 5453 | `appdetector`, `bottlemanagement`, `bottlequery`, `c4profilesmanager`, `cxconfig`, `cxdiag`, `cxfsnotifier`, `cxlog`, `cxmenu`, `cxobjc`, `cxutils`, `distversion`, `pyop` | — |
| [`c4parser`](outline/c4parser.py) | — | `_C4PHandler`, `C4PFile` | 0 | 77 | 4917 | `c4profiles`, `cxlog` | — |
| [`c4profiles`](outline/c4profiles.py) | Defines classes to represent and manipulate the C4 profile information. | `C4Condition`, `C4ConditionUnary`, `C4ConditionNot`, `C4ConditionNary`, `C4ConditionAnd`, `C4ConditionOr`, `C4ConditionCompare`, `C4ConditionMatch` … (+18) | 15 | 149 | 6685 | `cxconfig`, `cxlog`, `cxproduct`, `cxurlget`, `cxutils`, `distversion`, `iso8601` | — |
| [`c4profilesmanager`](outline/c4profilesmanager.py) | Handles refreshing and reading the C4 profile information. | `_C4PSource`, `C4Profiles`, `C4ProfilesSet` | 7 | 28 | 1508 | `c4parser`, `c4profiles`, `cddetector`, `cxlog`, `cxobjc`, `cxproduct`, `cxutils`, `distversion`, `downloaddetector`, `fileupdate` | — |
| [`cddetector`](outline/cddetector.py) | — | `CDDetector` | 2 | 4 | 228 | `cxlog`, `cxobjc`, `cxproduct`, `globtree` | — |
| [`cxaiebase`](outline/cxaiebase.py) | — | `AIETask`, `AIENop`, `AIETaskGroup`, `AIEScheduler` | 2 | 45 | 1408 | `cxlog`, `cxobjc` | — |
| [`cxaiecore`](outline/cxaiecore.py) | — | `AIECore` | 1 | 58 | 4504 | `appdetector`, `bottlequery`, `cxaiebase`, `cxaiemedia`, `cxlog`, `cxutils`, `distversion`, `globtree` | — |
| [`cxaiemedia`](outline/cxaiemedia.py) | — | `AIEInsertMedia`, `AIEReleaseMedia`, `AIEDownload`, `AIEScanMedia` | 9 | 48 | 2370 | `cxaiebase`, `cxhtmlutils`, `cxlog`, `cxproduct`, `cxurlget`, `cxutils`, `globtree` | — |
| [`cxaiemisc`](outline/cxaiemisc.py) | — | `AIECXFixes`, `AIECreateBottle`, `AIEPreAssoc`, `AIESyncMenu`, `AIESyncAssoc` | 2 | 25 | 752 | `bottlemanagement`, `cxaiebase`, `cxfixes`, `cxutils`, `distversion` | — |
| [`cxaiengine`](outline/cxaiengine.py) | This is the Application Installation Engine, AIE for short. | `Engine` | 0 | 11 | 1182 | `appdetector`, `bottlequery`, `c4profiles`, `cxaiebase`, `cxaiecore`, `cxaiemedia`, `cxaiemisc`, `cxlog`, `cxobjc`, `cxutils`, `systeminfo` | — |
| [`cxassoc`](outline/cxassoc.py) | — | `Error`, `Association`, `CXAssocPrefs` | 2 | 19 | 857 | `bottlequery`, `cxconfig`, `cxlog`, `cxutils` | — |
| [`cxconfig`](outline/cxconfig.py) | Provides support for reading and modifying configuration files. | `Section`, `Raw`, `File`, `_StackSection`, `Stack` | 1 | 69 | 2809 | `cxfsnotifier`, `cxlog`, `cxobservable`, `cxutils` | `UserDict` |
| [`cxdiag`](outline/cxdiag.py) | Provides efficient access to the cxdiag diagnostics. | `CXDiag` | 4 | 16 | 853 | `bottlequery`, `cxconfig`, `cxlog`, `cxproduct`, `cxutils`, `cxwhich`, `distversion` | — |
| [`cxevent`](outline/cxevent.py) | — | `Event`, `AsyncResult` | 0 | 14 | 277 | `cxutils` | — |
| [`cxfixes`](outline/cxfixes.py) | — | — | 41 | 48 | 3352 | `cxfixesdialog`, `cxfixesobjs`, `cxfixesparser`, `cxlog`, `cxproduct`, `cxutils`, `distversion`, `fileupdate`, `globtree` | `checkgtk`, `cxguitools`, `gi` |
| [`cxfixesdialog`](outline/cxfixesdialog.py) | — | `FixDialog` | 0 | 9 | 467 | `cxutils` | `gi` |
| [`cxfixesobjs`](outline/cxfixesobjs.py) | Defines classes to represent and manipulate the CXFixes information. | `CXDistGlob`, `CXDistribution`, `CXProduct`, `CXDistFix`, `CXFix`, `CXFixes` | 3 | 36 | 1588 | `cxutils` | — |
| [`cxfixesparser`](outline/cxfixesparser.py) | — | `_CXFixesHandler` | 1 | 43 | 2160 | `cxfixesobjs`, `cxlog` | — |
| [`cxfsnotifier`](outline/cxfsnotifier.py) | Monitors the filesystem and notifies the registered observers of any change | `_Path`, `PollingFSNotifier` | 6 | 24 | 831 | `cxlog`, `cxobservable`, `cxutils` | — |
| [`cxglob`](outline/cxglob.py) | — | `FileGlobTree`, `RegistryGlobTree` | 1 | 14 | 527 | `bottlequery`, `c4profiles`, `cxutils`, `globtree` | — |
| [`cxhtmlutils`](outline/cxhtmlutils.py) | — | — | 4 | 5 | 604 | `cxutils` | — |
| [`cxlog`](outline/cxlog.py) | Handles logging and error reporting. | — | 16 | 17 | 574 | — | — |
| [`cxmenu`](outline/cxmenu.py) | — | `Error`, `CXMenu`, `MenuItem`, `MenuPrefs` | 8 | 36 | 1522 | `bottlequery`, `cxconfig`, `cxfsnotifier`, `cxlog`, `cxobjc`, `cxobservable`, `cxutils` | — |
| [`cxobjc`](outline/cxobjc.py) | Helpers to simplify calling  Python functions from Objective-C code using | `CXMacObject`, `Proxy`, `_ObjCDecorator`, `CXMacObject` | 12 | 25 | 521 | — | `Foundation`, `objc` |
| [`cxobservable`](outline/cxobservable.py) | Provides a framework for classes that have observable properties. | `Object` | 0 | 8 | 307 | — | — |
| [`cxopt`](outline/cxopt.py) | — | `Parser` | 0 | 4 | 126 | — | — |
| [`cxproduct`](outline/cxproduct.py) | — | — | 23 | 24 | 953 | `cxconfig`, `cxobservable`, `cxutils`, `distversion` | `Foundation` |
| [`cxurlget`](outline/cxurlget.py) | — | `_FetchContentHandler` | 2 | 12 | 300 | `cxurlget_base`, `cxurlget_nsurl`, `cxurlget_urllib`, `distversion` | — |
| [`cxurlget_base`](outline/cxurlget_base.py) | — | `StopDownload`, `UrlError`, `HttpError`, `UrlGetterBase` | 3 | 19 | 445 | `cxutils` | — |
| [`cxurlget_nsurl`](outline/cxurlget_nsurl.py) | — | `_UrlGetterDelegate`, `UrlGetter` | 0 | 11 | 607 | `cxurlget_base` | `Foundation`, `objc` |
| [`cxurlget_urllib`](outline/cxurlget_urllib.py) | — | `DownloadError`, `UrlGetter` | 2 | 14 | 1278 | `cxlog`, `cxurlget_base`, `proxyinfo` | — |
| [`cxutils`](outline/cxutils.py) | — | `CXUtils`, `FileDigest`, `FLock` | 52 | 68 | 4341 | `cxlog`, `cxobjc`, `distversion` | `BaseDirectory`, `Foundation`, `xdg` |
| [`cxwhich`](outline/cxwhich.py) | — | — | 1 | 2 | 123 | — | — |
| [`demoutils`](outline/demoutils.py) | — | `DemoUtils` | 16 | 18 | 1144 | `c4profilesmanager`, `cxconfig`, `cxlog`, `cxobjc`, `cxutils`, `distversion`, `fileupdate`, `proxyinfo` | — |
| [`distversion`](outline/distversion.py) | — | — | 0 | 1 | 32 | — | — |
| [`downloaddetector`](outline/downloaddetector.py) | — | `ConstGlobTree` | 3 | 7 | 218 | `globtree` | — |
| [`fileupdate`](outline/fileupdate.py) | Updates a file, checking the signature if needed. | — | 5 | 6 | 714 | `cxlog`, `cxurlget`, `cxutils`, `cxwhich` | — |
| [`globtree`](outline/globtree.py) | — | `GlobNode`, `GlobTree`, `FileGlobTree`, `FileContentGlobTree` | 1 | 20 | 1402 | `cxlog`, `cxutils` | — |
| [`iconutils`](outline/iconutils.py) | — | `IconUtils` | 0 | 8 | 293 | `cxobjc`, `cxproduct`, `cxurlget`, `cxutils` | — |
| [`installtask`](outline/installtask.py) | — | `SourceMedia`, `TargetBottle`, `TargetTemplate`, `InstallTaskDelegate`, `InstallTask` | 2 | 128 | 6669 | `bottlemanagement`, `bottlequery`, `c4profiles`, `c4profilesmanager`, `cxaiemedia`, `cxdiag`, `cxfixes`, `cxlog`, `cxobjc`, `cxproduct`, `cxutils`, `distversion`, `downloaddetector` | — |
| [`iso8601`](outline/iso8601.py) | ISO 8601 date time string parsing | `ParseError`, `Utc`, `FixedOffset` | 2 | 14 | 319 | — | — |
| [`proxyinfo`](outline/proxyinfo.py) | — | `DynamicProxyHandler` | 14 | 23 | 1082 | `cxlog`, `cxproduct`, `cxutils`, `distversion` | `PyKDE4`, `PyQt4`, `gi`, `libproxy` |
| [`pyop`](outline/pyop.py) | — | `PythonOperation`, `PythonOperationQueue` | 3 | 21 | 659 | `cxlog` | `Foundation`, `PyObjCTools`, `gi` |
| [`ratingutils`](outline/ratingutils.py) | — | `RatingUtils` | 1 | 7 | 498 | `cxlog`, `cxobjc`, `cxproduct`, `cxurlget`, `cxutils`, `distversion`, `proxyinfo`, `systeminfo`, `webutils` | — |
| [`systeminfo`](outline/systeminfo.py) | — | `SystemInfo` | 4 | 7 | 511 | `cxdiag`, `cxobjc`, `cxutils`, `distversion` | `gi` |
| [`webutils`](outline/webutils.py) | — | `WebUtils` | 4 | 6 | 281 | `cxlog`, `cxobjc`, `cxproduct`, `cxurlget`, `cxutils`, `distversion`, `fileupdate`, `proxyinfo` | — |

## Quem importa quem

- `appdetector` ← `bottlewrapper`, `cxaiecore`, `cxaiengine`, `libcxsetup`
- `bottlecollection` ← `libcxsetup`
- `bottlemanagement` ← `bottlewrapper`, `cxaiemisc`, `installtask`, `libcxsetup`
- `bottlequery` ← `appdetector`, `bottlecollection`, `bottlemanagement`, `bottlewrapper`, `cxaiecore`, `cxaiengine`, `cxassoc`, `cxdiag`, `cxglob`, `cxmenu`, `installtask`, `libcxsetup`
- `bottlewrapper` ← `bottlecollection`, `libcxsetup`
- `c4parser` ← `c4profilesmanager`
- `c4profiles` ← `c4parser`, `c4profilesmanager`, `cxaiengine`, `cxglob`, `installtask`
- `c4profilesmanager` ← `appdetector`, `bottlewrapper`, `demoutils`, `installtask`, `libcxsetup`
- `cddetector` ← `c4profilesmanager`, `libcxsetup`
- `cxaiebase` ← `cxaiecore`, `cxaiemedia`, `cxaiemisc`, `cxaiengine`
- `cxaiecore` ← `cxaiengine`
- `cxaiemedia` ← `cxaiecore`, `cxaiengine`, `installtask`
- `cxaiemisc` ← `cxaiengine`
- `cxaiengine` ← `libcxsetup`
- `cxassoc` ← —
- `cxconfig` ← `bottlequery`, `bottlewrapper`, `c4profiles`, `cxassoc`, `cxdiag`, `cxmenu`, `cxproduct`, `demoutils`
- `cxdiag` ← `bottlewrapper`, `installtask`, `systeminfo`
- `cxevent` ← `bottlequery`
- `cxfixes` ← `cxaiemisc`, `installtask`
- `cxfixesdialog` ← `cxfixes`
- `cxfixesobjs` ← `cxfixes`, `cxfixesparser`
- `cxfixesparser` ← `cxfixes`
- `cxfsnotifier` ← `bottlewrapper`, `cxconfig`, `cxmenu`
- `cxglob` ← `appdetector`
- `cxhtmlutils` ← `cxaiemedia`
- `cxlog` ← `appdetector`, `bottlemanagement`, `bottlequery`, `bottlewrapper`, `c4parser`, `c4profiles`, `c4profilesmanager`, `cddetector`, `cxaiebase`, `cxaiecore`, `cxaiemedia`, `cxaiengine`, `cxassoc`, `cxconfig`, `cxdiag`, `cxfixes`, `cxfixesparser`, `cxfsnotifier`, `cxmenu`, `cxurlget_urllib`, `cxutils`, `demoutils`, `fileupdate`, `globtree`, `installtask`, `libcxsetupbase`, `proxyinfo`, `pyop`, `ratingutils`, `webutils`
- `cxmenu` ← `bottlewrapper`, `libcxsetup`
- `cxobjc` ← `appdetector`, `bottlecollection`, `bottlemanagement`, `bottlequery`, `bottlewrapper`, `c4profilesmanager`, `cddetector`, `cxaiebase`, `cxaiengine`, `cxmenu`, `cxutils`, `demoutils`, `iconutils`, `installtask`, `ratingutils`, `systeminfo`, `webutils`
- `cxobservable` ← `cxconfig`, `cxfsnotifier`, `cxmenu`, `cxproduct`
- `cxopt` ← —
- `cxproduct` ← `bottlemanagement`, `bottlequery`, `c4profiles`, `c4profilesmanager`, `cddetector`, `cxaiemedia`, `cxdiag`, `cxfixes`, `iconutils`, `installtask`, `libcxsetup`, `proxyinfo`, `ratingutils`, `webutils`
- `cxurlget` ← `c4profiles`, `cxaiemedia`, `fileupdate`, `iconutils`, `ratingutils`, `webutils`
- `cxurlget_base` ← `cxurlget`, `cxurlget_nsurl`, `cxurlget_urllib`
- `cxurlget_nsurl` ← `cxurlget`
- `cxurlget_urllib` ← `cxurlget`
- `cxutils` ← `appdetector`, `bottlemanagement`, `bottlequery`, `bottlewrapper`, `c4profiles`, `c4profilesmanager`, `cxaiecore`, `cxaiemedia`, `cxaiemisc`, `cxaiengine`, `cxassoc`, `cxconfig`, `cxdiag`, `cxevent`, `cxfixes`, `cxfixesdialog`, `cxfixesobjs`, `cxfsnotifier`, `cxglob`, `cxhtmlutils`, `cxmenu`, `cxproduct`, `cxurlget_base`, `demoutils`, `fileupdate`, `globtree`, `iconutils`, `installtask`, `proxyinfo`, `ratingutils`, `systeminfo`, `webutils`
- `cxwhich` ← `cxdiag`, `fileupdate`
- `demoutils` ← `libcxsetup`
- `distversion` ← `appdetector`, `bottlecollection`, `bottlemanagement`, `bottlequery`, `bottlewrapper`, `c4profiles`, `c4profilesmanager`, `cxaiecore`, `cxaiemisc`, `cxdiag`, `cxfixes`, `cxproduct`, `cxurlget`, `cxutils`, `demoutils`, `installtask`, `proxyinfo`, `ratingutils`, `systeminfo`, `webutils`
- `downloaddetector` ← `c4profilesmanager`, `installtask`
- `fileupdate` ← `c4profilesmanager`, `cxfixes`, `demoutils`, `webutils`
- `globtree` ← `cddetector`, `cxaiecore`, `cxaiemedia`, `cxfixes`, `cxglob`, `downloaddetector`
- `iconutils` ← `libcxsetup`
- `installtask` ← `libcxsetup`
- `iso8601` ← `c4profiles`
- `proxyinfo` ← `cxurlget_urllib`, `demoutils`, `ratingutils`, `webutils`
- `pyop` ← `bottlewrapper`
- `ratingutils` ← `libcxsetup`
- `systeminfo` ← `cxaiengine`, `ratingutils`
- `webutils` ← `libcxsetup`, `ratingutils`

## Fontes `.py` em `Contents/Resources`

| Arquivo | Linhas | Classes | Funções | Importa (internos) | Importa (externos) |
|---|---|---|---|---|---|
| `Contents/Resources/libcxsetup.py` | 48 | `CXSetup` | — | `appdetector`, `bottlecollection`, `bottlemanagement`, `bottlequery`, `bottlewrapper`, `c4profilesmanager`, `cddetector`, `cxaiengine`, `cxmenu`, `cxproduct`, `demoutils`, `iconutils`, `installtask`, `ratingutils`, `webutils` | — |
| `Contents/Resources/libcxsetupbase.py` | 24 | — | `dump_stacks` | `cxlog` | `Foundation`, `PyObjCTools` |

## Integridade

| Arquivo | Bytes | SHA-256 | `co_filename` |
|---|---|---|---|
| `lib/python/appdetector.pyc` | 14198 | `740b1822331b7b71ca63e287f10d2e21649e2e569bb5ad04e18bc30e3bd7ad91` | `SharedSupport/CrossOver/lib/python/appdetector.py` |
| `lib/python/bottlecollection.pyc` | 8989 | `d4562b7e589280a3f79fcfa7518f4a6669545a7906639640bce80aec865dec65` | `SharedSupport/CrossOver/lib/python/bottlecollection.py` |
| `lib/python/bottlemanagement.pyc` | 13742 | `9237f9f66462eb48715e8293b8fea76f565ca909c17c3b6438c81fb10d86ac1b` | `SharedSupport/CrossOver/lib/python/bottlemanagement.py` |
| `lib/python/bottlequery.pyc` | 51287 | `304121786818f1581df0fef203e0b2acb1123ed62466001e0b031792b6053d62` | `SharedSupport/CrossOver/lib/python/bottlequery.py` |
| `lib/python/bottlewrapper.pyc` | 81344 | `7d846409683eba269a64f501572345a90e486bd5d87512d93b0f2aac414c616f` | `SharedSupport/CrossOver/lib/python/bottlewrapper.py` |
| `lib/python/c4parser.pyc` | 63885 | `aa917152601f5c4770811c46a8f86ad0d787b25e1236f114bf3890c7ea3cff61` | `SharedSupport/CrossOver/lib/python/c4parser.py` |
| `lib/python/c4profiles.pyc` | 85590 | `97e58ea547361bb8eb8a68fabc70d0c97e83a068fb7bc032aa660bb045bcf9d5` | `SharedSupport/CrossOver/lib/python/c4profiles.py` |
| `lib/python/c4profilesmanager.pyc` | 19894 | `b80f8825765da2c0b9987713c18890ed129232709025b6a06c0e19349c9315c9` | `SharedSupport/CrossOver/lib/python/c4profilesmanager.py` |
| `lib/python/cddetector.pyc` | 2994 | `b97968b2325e11812fc3807de98afaba7634d585b762e5fe2944881099fa443f` | `SharedSupport/CrossOver/lib/python/cddetector.py` |
| `lib/python/cxaiebase.pyc` | 22848 | `7f1336e43c14120a9c6770cf9c8a910f944de2638bc06ff952ace5fb62984b1b` | `SharedSupport/CrossOver/lib/python/cxaiebase.py` |
| `lib/python/cxaiecore.pyc` | 61417 | `0d54e7d82f5dcd62da56dec18446f6d1807e208c01158a0376299e2165eebe22` | `SharedSupport/CrossOver/lib/python/cxaiecore.py` |
| `lib/python/cxaiemedia.pyc` | 33235 | `fe61401c49d3f286aaa33a69c6d832610ab57578ade4356dcd626f8c3c2ff499` | `SharedSupport/CrossOver/lib/python/cxaiemedia.py` |
| `lib/python/cxaiemisc.pyc` | 11222 | `c807afe3e461affa5f4df2653f3aad8fa779cec740f3afed230b030408640125` | `SharedSupport/CrossOver/lib/python/cxaiemisc.py` |
| `lib/python/cxaiengine.pyc` | 22609 | `513abfc7082b59a282977bbea2f593cb0b0a7cd3cbef20201bf601b5c0fad0d7` | `SharedSupport/CrossOver/lib/python/cxaiengine.py` |
| `lib/python/cxassoc.pyc` | 11867 | `cec75a2c27af8c80e4692ceeaf7831388604340d59306f2724f54e7c78bd1cf7` | `SharedSupport/CrossOver/lib/python/cxassoc.py` |
| `lib/python/cxconfig.pyc` | 43866 | `9d66adb564b8cdb2d66f1536102475a63c0d56a0878dad5cd8de190429e3542b` | `SharedSupport/CrossOver/lib/python/cxconfig.py` |
| `lib/python/cxdiag.pyc` | 11920 | `7b5616dbc2938e5c71ec880cac6e1c7fc0ff57cf2567a164284614b03781843d` | `SharedSupport/CrossOver/lib/python/cxdiag.py` |
| `lib/python/cxevent.pyc` | 4234 | `4cd1492b50fc57fea37aa1e4d1acf8439210b216f62aa85ce8291bb35c239848` | `SharedSupport/CrossOver/lib/python/cxevent.py` |
| `lib/python/cxfixes.pyc` | 35930 | `72d3c3fb8f6d81c84348ba5036981a808e82b661b88b8b8ffb74c551175f6489` | `SharedSupport/CrossOver/lib/python/cxfixes.py` |
| `lib/python/cxfixesdialog.pyc` | 6983 | `c36c699fa7ebc093f57676ea31be93f00560ab7fb0950a2c46b614220dbcfd69` | `SharedSupport/CrossOver/lib/python/cxfixesdialog.py` |
| `lib/python/cxfixesobjs.pyc` | 19815 | `7dde856579c3713d7ad63d8c725ddb64980d773b794f54fce9a2b8c40e3fe930` | `SharedSupport/CrossOver/lib/python/cxfixesobjs.py` |
| `lib/python/cxfixesparser.pyc` | 30117 | `9caae448992d707a68534705092195b86f1202bb586b4d23dfc8400118d667a3` | `SharedSupport/CrossOver/lib/python/cxfixesparser.py` |
| `lib/python/cxfsnotifier.pyc` | 12591 | `f714ae939a0a144f3a867915741b8221f4e255ccc8bb7102bff7bf8141292eb8` | `SharedSupport/CrossOver/lib/python/cxfsnotifier.py` |
| `lib/python/cxglob.pyc` | 6692 | `aec1ce27b83b267a38128035d62c925e3aa28f138f5527d7b648d6b77eb00e73` | `SharedSupport/CrossOver/lib/python/cxglob.py` |
| `lib/python/cxhtmlutils.pyc` | 7294 | `bcc8b623180323a294e624e716de79ab10b67c69514f544f2540db0320171a32` | `SharedSupport/CrossOver/lib/python/cxhtmlutils.py` |
| `lib/python/cxlog.pyc` | 8472 | `03a684e64e5801eae4262dfb34987bf484eab714b60f5631098393ac6ff75fe7` | `SharedSupport/CrossOver/lib/python/cxlog.py` |
| `lib/python/cxmenu.pyc` | 20146 | `94cdd0e792736a711621f10472432cdfaf3294151e534779c6203beab2286603` | `SharedSupport/CrossOver/lib/python/cxmenu.py` |
| `lib/python/cxobjc.pyc` | 10224 | `26595b9f3ffedbb6910c46a70ad14e6907ef294f91d3d1f66262aef1ae3214ea` | `SharedSupport/CrossOver/lib/python/cxobjc.py` |
| `lib/python/cxobservable.pyc` | 5025 | `4601ee97ece4076a7e8d1e9c68a3b19744b52936ade6171a079a2bbe3597ac2e` | `SharedSupport/CrossOver/lib/python/cxobservable.py` |
| `lib/python/cxopt.pyc` | 1575 | `2b80ac83bf2758fea623d75868a19a0d59b1aef9747a151de497a405b9a287c3` | `SharedSupport/CrossOver/lib/python/cxopt.py` |
| `lib/python/cxproduct.pyc` | 16633 | `475567cdeed613754d9865ac5d028274f1f29ab3d75ccd04a1d7fc832aa80abe` | `SharedSupport/CrossOver/lib/python/cxproduct.py` |
| `lib/python/cxurlget.pyc` | 4803 | `395d687aedcc967c5da217d18db856c81a4340a0c6247551bd5ab8d4c0601b2d` | `SharedSupport/CrossOver/lib/python/cxurlget.py` |
| `lib/python/cxurlget_base.pyc` | 7021 | `60bd7ef418e8cede125f442716c313a97a4222b0d7cca2f00bfad72a7d1e7c7b` | `SharedSupport/CrossOver/lib/python/cxurlget_base.py` |
| `lib/python/cxurlget_nsurl.pyc` | 9335 | `5d9b58b150b10dd46777d245679bd9728b1e923c792b0053eb6fb9edf7b1e53a` | `SharedSupport/CrossOver/lib/python/cxurlget_nsurl.py` |
| `lib/python/cxurlget_urllib.pyc` | 15728 | `7f8717382845fc82718e3b3f66297ae3fba62e6e0b5445160518ec91a190d099` | `SharedSupport/CrossOver/lib/python/cxurlget_urllib.py` |
| `lib/python/cxutils.pyc` | 50997 | `bcfb45568380f0f13e5d1051a28371b2bbd483d0149328e34ca66a84da7b7a50` | `SharedSupport/CrossOver/lib/python/cxutils.py` |
| `lib/python/cxwhich.pyc` | 1975 | `c88f28b131c0c75ff60122cf6ed4e3ee876c6ce32bd70d98e0f7f7be0c4e36c8` | `SharedSupport/CrossOver/lib/python/cxwhich.py` |
| `lib/python/demoutils.pyc` | 16669 | `458c6d7f3bb6842441db5599888e05a96bdd3c9a9a0697ba237791aa6430c1ed` | `SharedSupport/CrossOver/lib/python/demoutils.py` |
| `lib/python/distversion.pyc` | 840 | `fcb04aaf86783e0a9a431d5fa9313fb0b6d9ba27f86d6926457f64d8457bd2c2` | `SharedSupport/CrossOver/lib/python/distversion.py` |
| `lib/python/downloaddetector.pyc` | 3107 | `db2e9b670e7ccc859d6bec3e70edc8e346400c810f9250918999a011904f21fb` | `SharedSupport/CrossOver/lib/python/downloaddetector.py` |
| `lib/python/fileupdate.pyc` | 8836 | `f1e331a52be1b444bf4e3ea7e04253d8526ca0b901bce053cf64cfd1b86cca19` | `SharedSupport/CrossOver/lib/python/fileupdate.py` |
| `lib/python/globtree.pyc` | 16668 | `c383918a060cd72d9b088c91963220bfaff82f451ead8f20c72e3bda40534152` | `SharedSupport/CrossOver/lib/python/globtree.py` |
| `lib/python/iconutils.pyc` | 4216 | `8e32a6790aff321e77222e96208e5f114c51f001bf2d117d42407839999fbdfe` | `SharedSupport/CrossOver/lib/python/iconutils.py` |
| `lib/python/installtask.pyc` | 101147 | `2d3964d40793079d58d229cb4b18578f53175bb7a87bec5e30a1a5024eb1a2fb` | `SharedSupport/CrossOver/lib/python/installtask.py` |
| `lib/python/iso8601.pyc` | 5063 | `f3d5c262af43b79e7cd59951c2834a86004604b7931830cb5187e64391da653a` | `SharedSupport/CrossOver/lib/python/iso8601.py` |
| `lib/python/proxyinfo.pyc` | 14667 | `92b63b676b7db9be3fa3675222ec6dc58cf02cef03ad8ad17dc90c27489cd2c4` | `SharedSupport/CrossOver/lib/python/proxyinfo.py` |
| `lib/python/pyop.pyc` | 9327 | `f7d527420578cd39cf109a31ec3c57a3119bdf1c5ca146df97d8bda19d2f562e` | `SharedSupport/CrossOver/lib/python/pyop.py` |
| `lib/python/ratingutils.pyc` | 6063 | `c535139474521ab9d373b2b94552525b4e26f4fe334018ba075b2e5cf3ff85c2` | `SharedSupport/CrossOver/lib/python/ratingutils.py` |
| `lib/python/systeminfo.pyc` | 6299 | `2673e079df5c3cb5683e0d6e0f43ba330ccd7a83e0f077b27a46f8c12fb3f57c` | `SharedSupport/CrossOver/lib/python/systeminfo.py` |
| `lib/python/webutils.pyc` | 3709 | `07ca9b7cff072733a5095ca3a713d639186624972449e67e2d9182b467d362c4` | `SharedSupport/CrossOver/lib/python/webutils.py` |
| `Contents/Resources/libcxsetup.py` | 1128 | `62ae1c5737452dbf0eac7305ff35ccd54873d79011d4323d08d9e57812512bc3` | — |
| `Contents/Resources/libcxsetupbase.py` | 581 | `aa31e0817c397aee72d7a72403084b149360a6e5484cd3a1d86092fcd881c72c` | — |
