# Ferramentas e módulos Perl de `SharedSupport/<Produto>`

Gerado por `.tools/make_index.py` a partir de [`tools.json`](tools.json). Os fatos (dependências, subs, opções, variáveis de ambiente, executáveis chamados) foram extraídos estaticamente; nenhum script foi executado.

## `bin/` (`<Produto>-Hosted Application`)

| Arquivo | Tipo | Linhas | Usa | Opções | Variáveis de ambiente | Chama |
|---|---|---|---|---|---|---|
| `autorun` | symlink → `wine` | | | | | |
| `cabextract` | Mach-O x86_64 | | | | | |
| `cxassoc` | perl | 1679 | `CXLog`, `CXUtils`, `CXAssoc`, `CXOpts`, `CXRecode`, `CXBottle`, `CXRWConfig`, `CXConfig` | `--create=s`, `--delete`, `--delete-filter=s`, `--mode=s`, `--mode-filter=s`, `--query`, `--query-filter=s`, `--list-files`, `--list-files-filter=s`, `--install`, `--install-filter=s`, `--uninstall` … (+28) | `PATH`, `CX_ROOT`, `CX_BOTTLE`, `WINEPREFIX` | `wine`, `cxassoc`, `locate_gui.sh` |
| `cxavscan` | perl | 289 | `CXLog`, `CXUtils`, `CXOpts`, `CXConfig` | `--quiet!`, `--gui!`, `--verbose!` | `PATH`, `CX_ROOT` | — |
| `cxbottle` | perl | 1740 | `CXLog`, `CXUtils`, `CXDebian`, `CXRPM`, `CXOpts`, `CXRecode`, `CXBottle`, `CXRWConfig`, `CXConfig` | `--create`, `--delete`, `--install`, `--uninstall`, `--removeall`, `--ro-desktopdata`, `--tar=s`, `--cpio=s`, `--deb`, `--rpm`, `--release=s`, `--hardcode` … (+21) | `PATH`, `CX_ROOT`, `TMPDIR`, `CX_BOTTLE`, `WINEPREFIX` | `wine`, `cxmenu`, `cxassoc` |
| `cxbounce` | Mach-O x86_64 | | | | | |
| `cxgarcon-terminal` | perl | 292 | `CXLog`, `CXUtils`, `CXOpts` | `--title=s`, `--remove`, `--e`, `--verbose!` | `PATH`, `CX_ROOT`, `HOME` | — |
| `cxgetsysinfo` | shell | 190 | — | — | `IFS`, `PATH` | — |
| `cxgettext` | Mach-O x86_64 | | | | | |
| `cxlogfilter` | perl | 333 | `CXOpts` | `--head=s`, `--tail=s`, `--extra=s`, `--fifo=s`, `--log=s` | `PATH`, `CX_ROOT` | — |
| `cxmenu` | perl | 1509 | `CXLog`, `CXUtils`, `CXMenu`, `CXOpts`, `CXRecode`, `CXBottle`, `CXRWConfig`, `CXConfig`, `CXMenuWindows` | `--create=s`, `--delete`, `--purge`, `--delete-filter=s`, `--mode=s`, `--mode-filter=s`, `--mmenu-never=s`, `--query`, `--query-filter=s`, `--list-files`, `--list-files-filter=s`, `--start=s` … (+30) | `PATH`, `CX_ROOT`, `CX_BOTTLE`, `WINEPREFIX` | `wine`, `locate_gui.sh` |
| `cxmessage` | perl | 96 | `CXLog` | — | `PATH`, `CX_ROOT` | — |
| `cxnativeopen` | perl | 317 | `CXLog`, `CXUtils`, `CXOpts` | `--background!`, `--verbose!` | `PATH`, `CX_ROOT` | — |
| `cxps2pdf` | shell | 20 | — | — | `CX_PS2PDF` | — |
| `cxreboot` | perl | 186 | `CXLog`, `CXUtils`, `CXOpts`, `CXBottle` | `--bottle=s`, `--scope=s`, `--verbose!` | `PATH`, `CX_ROOT`, `CX_BOTTLE` | `wine`, `cxmessage` |
| `cxselinux` | shell | 252 | — | — | `IFS`, `PATH`, `CX_ROOT`, `TMPDIR` | `cxmenu` |
| `cxstart` | symlink → `wine` | | | | | |
| `cxsu` | perl | 410 | `CXLog`, `CXUtils`, `CXOpts` | `--console`, `--description=s`, `--wait`, `--ignore-home`, `--parent=s`, `--verbose!` | `PATH`, `CX_ROOT`, `DISPLAY`, `TMPDIR`, `XAUTHORITY` | — |
| `cxtemplate` | perl | 228 | `CXLog`, `CXUtils`, `CXOpts` | `--template=s`, `--query=s`, `--param=s@`, `--verbose!` | `PATH`, `CX_ROOT` | — |
| `cxuninstall` | perl | 445 | `CXLog`, `CXUtils`, `CXOpts`, `CXBottle` | `--force`, `--verbose!` | `PATH`, `CX_ROOT`, `HOME`, `CX_PURGE`, `CX_BOTTLE_PATH`, `CX_MANAGED_BOTTLE_PATH`, `MOJOSETUP_LOG`, `CX_LOG`, `MOJOSETUP_LOGLEVEL` | `cxuninstall`, `wine`, `cxmenu`, `cxassoc`, `cxmessage` |
| `cxwinassoc` | perl | 291 | `CXLog`, `CXUtils`, `CXOpts`, `CXBottle` | `--class=s`, `--delete-class=s`, `--extension=s`, `--mime=s`, `--bottle=s`, `--scope=s`, `--verbose!` | `PATH`, `CX_ROOT`, `CX_BOTTLE` | `wine` |
| `locate_gui.sh` | shell | 588 | — | — | `IFS`, `PATH`, `HOME`, `ARGV`, `XDG_DATA_DIRS`, `XDG_DATA_HOME`, `CX_FLATPAK_ID`, `XDG_CONFIG_HOME`, `XDG_CONFIG_DIRS`, `XDG_DESKTOP_DIR` | — |
| `ps2pdf` | shell | 12 | — | — | — | — |
| `ps2pdf12` | shell | 7 | — | — | — | — |
| `ps2pdf13` | shell | 7 | — | — | — | — |
| `ps2pdf14` | shell | 7 | — | — | — | — |
| `ps2pdf_gs` | Mach-O x86_64 | | | | | |
| `ps2pdfwr` | shell | 44 | — | — | `GS_EXECUTABLE`, `OPTIONS` | — |
| `regedit` | symlink → `wine` | | | | | |
| `regsvr32` | symlink → `wine` | | | | | |
| `unrar` | Mach-O x86_64 | | | | | |
| `wine` | perl | 1247 | `CXLog`, `CXUtils`, `CXOpts`, `CXBottle`, `CXRWConfig` | `--bottle=s`, `--scope=s`, `--update-only`, `--ux-app=s`, `--cx-app=s`, `--wl-app=s`, `--wl32-app=s`, `--cx-hooks=s`, `--start=s`, `--start-only=s`, `--start-default=s`, `--start-mime=s` … (+27) | `PATH`, `CX_ROOT`, `CX_ENV`, `CX_DEBUGMSG`, `CX_BOTTLE`, `DISPLAY`, `WINEPREFIX`, `TMPDIR`, `CX_APPLEGPTK_LIBD3DSHARED_PATH`, `GST_PLUGIN_SYSTEM_PATH` … (+15) | `cxavscan` |
| `wineloader` | Mach-O x86_64 | | | | | |
| `wineprefixcreate` | perl | 363 | `CXLog`, `CXUtils`, `CXOpts`, `CXReplicateDir`, `CXConfig`, `CXUpgrade` | `--snapshot`, `--copy`, `--dry-run`, `--force!`, `--ref-dir=s`, `--verbose!` | `CX_ROOT`, `WINEPREFIX`, `HOME` | `wine` |
| `wineserver` | Mach-O x86_64 | | | | | |
| `wineshelllink` | perl | 150 | `CXLog`, `CXUtils`, `CXMenu`, `CXOpts`, `CXBottle`, `CXRecode` | `--desktop`, `--menu`, `--utf8`, `--root=s`, `--link=s`, `--descr=s`, `--icon=s`, `--path=s`, `--args=s`, `--workdir=s`, `--verbose!` | `CX_ROOT`, `WINEPREFIX`, `CX_BOTTLE`, `CX_MENU_INSTALL` | `cxmenu` |

## `lib/perl/` (módulos CodeWeavers)

| Módulo | Linhas | Pacotes | Usa | Usado por | Subs | Exporta | Variáveis de ambiente |
|---|---|---|---|---|---|---|---|
| `CXAssoc.pm` | 638 | `CXAssoc` | `CXLog`, `CXUtils` | `cxassoc`, `CXAssocCDE.pm`, `CXAssocMacOSX.pm`, `CXAssocMcap.pm`, `CXAssocXDG.pm`, `CXMimeMcap.pm` | 15 | — | `WINEPREFIX` |
| `CXAssocCDE.pm` | 527 | `CXAssocCDE` | `CXLog`, `CXUtils`, `CXCDE`, `CXAssoc` | — | 19 | — | `CX_TAGALL` |
| `CXAssocCheck.pm` | 185 | `CXAssocCheck` | `CXLog`, `CXUtils`, `CXBottle` | — | 10 | — | `CX_FLATPAK_ID` |
| `CXAssocDebian.pm` | 83 | `CXAssocDebian` | `CXLog`, `CXUtils`, `CXAssocMcap` | — | 7 | — | — |
| `CXAssocMacOSX.pm` | 696 | `CXAssocMacOSX` | `CXLog`, `CXXMLDOM`, `CXPlist`, `CXAssoc` | — | 27 | — | `CX_BOTTLE`, `WINEPREFIX`, `CX_ROOT` |
| `CXAssocMailcap.pm` | 78 | `CXAssocMailcap` | `CXLog`, `CXAssocMcap` | — | 5 | — | — |
| `CXAssocMcap.pm` | 195 | `CXAssocMcap` | `CXLog`, `CXMimeMcap`, `CXAssoc` | `CXAssocDebian.pm`, `CXAssocMailcap.pm` | 9 | — | `CX_TAGALL` |
| `CXAssocWindows.pm` | 104 | `CXAssocWindows` | `CXLog`, `CXUtils` | — | 9 | — | `CX_ROOT`, `CX_BOTTLE` |
| `CXAssocXDG.pm` | 1251 | `CXAssocXDG`, `Xml2MimeDB`, `ReadCXMimes` | `CXLog`, `CXUtils`, `CXAssoc`, `CXTinySAX`, `CXTinySAXBase`, `CXRecode`, `CXBottle`, `CXRWConfig` | — | 41 | — | `CX_TINYSAXDEBUG`, `WINEPREFIX`, `CX_TAGALL`, `PATH` |
| `CXBottle.pm` | 666 | `CXBottle` | `CXLog`, `CXUtils`, `CXRWConfig`, `CXConfig` | `cxassoc`, `cxbottle`, `cxmenu`, `cxreboot`, `cxuninstall`, `cxwinassoc`, `wine`, `wineshelllink`, `CXAssocCheck.pm`, `CXAssocXDG.pm`, `CXMenuShortcut.pm`, `CXMenuXDG.pm` | 29 | — | `CX_MANAGED_BOTTLE_PATH`, `CX_ROOT`, `CX_BOTTLE_PATH`, `CX_INITIALIZED`, `CX_BOTTLE`, `WINEPREFIX`, `CX_BOTTLE_LOCKED` |
| `CXCDE.pm` | 202 | `CXCDE` | `CXUtils`, `CXLog` | `CXAssocCDE.pm`, `CXMenuCDE.pm` | 4 | — | — |
| `CXConfig.pm` | 206 | `CXConfig`, `CXSection` | `CXLog`, `CXUtils` | `cxassoc`, `cxavscan`, `cxbottle`, `cxmenu`, `wineprefixcreate`, `CXBottle.pm`, `CXUtils.pm` | 12 | — | — |
| `CXDebian.pm` | 233 | `CXDebian` | `CXLog`, `CXUtils` | `cxbottle` | 6 | — | `PATH`, `CX_ROOT` |
| `CXLog.pm` | 174 | `CXLog` | — | `cxassoc`, `cxavscan`, `cxbottle`, `cxgarcon-terminal`, `cxmenu`, `cxmessage`, `cxnativeopen`, `cxreboot`, `cxsu`, `cxtemplate`, `cxuninstall`, `cxwinassoc`, `wine`, `wineprefixcreate`, `wineshelllink`, `CXAssoc.pm`, `CXAssocCDE.pm`, `CXAssocCheck.pm`, `CXAssocDebian.pm`, `CXAssocMacOSX.pm`, `CXAssocMailcap.pm`, `CXAssocMcap.pm`, `CXAssocWindows.pm`, `CXAssocXDG.pm`, `CXBottle.pm`, `CXCDE.pm`, `CXConfig.pm`, `CXDebian.pm`, `CXMenu.pm`, `CXMenuCDE.pm`, `CXMenuCheck.pm`, `CXMenuDebian.pm`, `CXMenuDtop.pm`, `CXMenuMacOSX.pm`, `CXMenuPerm.pm`, `CXMenuShortcut.pm`, `CXMenuWindows.pm`, `CXMenuXDG.pm`, `CXMimeMcap.pm`, `CXPlist.pm`, `CXRPM.pm`, `CXRWConfig.pm`, `CXRecode.pm`, `CXReplicateDir.pm`, `CXTinySAX.pm`, `CXTinySAXLog.pm`, `CXUpgrade.pm`, `CXUtils.pm`, `CXXMLDOM.pm` | 12 | `cxlog`, `cxname0`, `cxwarn`, `cxerr` | `CX_DEBUGMSG`, `CX_LOG` |
| `CXMenu.pm` | 586 | `CXMenu` | `CXLog`, `CXUtils`, `CXRWConfig` | `cxmenu`, `wineshelllink`, `CXMenuCDE.pm`, `CXMenuCheck.pm`, `CXMenuDebian.pm`, `CXMenuDtop.pm`, `CXMenuMacOSX.pm`, `CXMenuPerm.pm`, `CXMenuShortcut.pm`, `CXMenuWindows.pm`, `CXMenuXDG.pm` | 16 | — | `CX_ROOT` |
| `CXMenuCDE.pm` | 358 | `CXMenuCDE` | `CXLog`, `CXUtils`, `CXMenu`, `CXCDE` | — | 11 | — | `PATH` |
| `CXMenuCheck.pm` | 81 | `CXMenuCheck` | `CXLog`, `CXMenu` | — | 8 | — | `CX_ROOT` |
| `CXMenuDebian.pm` | 402 | `CXMenuDebian` | `CXLog`, `CXUtils`, `CXMenu` | — | 12 | — | `CX_TAGALL` |
| `CXMenuDtop.pm` | 495 | `CXMenuDtop` | `CXLog`, `CXUtils`, `CXMenu`, `CXRWConfig` | — | 14 | — | `CX_TAGALL`, `PATH`, `HOME` |
| `CXMenuMacOSX.pm` | 429 | `CXMenuMacOSX` | `CXLog`, `CXXMLDOM`, `CXPlist`, `CXMenu` | — | 14 | — | `CX_BOTTLE`, `WINEPREFIX`, `CX_ROOT` |
| `CXMenuPerm.pm` | 199 | `CXMenuPerm` | `CXLog`, `CXUtils`, `CXMenu`, `CXRWConfig` | — | 8 | — | `CX_TAGALL` |
| `CXMenuShortcut.pm` | 313 | `CXMenuShortcut` | `CXLog`, `CXUtils`, `CXMenu`, `CXBottle` | — | 11 | — | `PATH` |
| `CXMenuWindows.pm` | 255 | `CXMenuWindows` | `CXLog`, `CXUtils`, `CXMenu`, `CXRecode` | `cxmenu` | 12 | — | `CX_ROOT`, `CX_FLATPAK_ID`, `CX_BOTTLE`, `WINEPREFIX` |
| `CXMenuXDG.pm` | 802 | `CXMenuXDG` | `CXLog`, `CXUtils`, `CXXMLDOM`, `CXMenu`, `CXBottle` | — | 20 | — | `CX_TAGALL` |
| `CXMimeMcap.pm` | 749 | `CXMimeMcap`, `CXRWBlob` | `CXLog`, `CXUtils`, `CXAssoc` | `CXAssocMcap.pm` | 21 | — | `CX_TAGALL` |
| `CXOpts.pm` | 180 | `CXOpts` | — | `cxassoc`, `cxavscan`, `cxbottle`, `cxgarcon-terminal`, `cxlogfilter`, `cxmenu`, `cxnativeopen`, `cxreboot`, `cxsu`, `cxtemplate`, `cxuninstall`, `cxwinassoc`, `wine`, `wineprefixcreate`, `wineshelllink` | 4 | — | — |
| `CXPlist.pm` | 92 | `CXPlist` | `CXLog`, `CXXMLDOM` | `CXAssocMacOSX.pm`, `CXMenuMacOSX.pm` | 7 | — | — |
| `CXRPM.pm` | 198 | `CXRPM` | `CXLog`, `CXUtils` | `cxbottle` | 8 | — | `PATH`, `CX_ROOT` |
| `CXRWConfig.pm` | 634 | `CXRWSection`, `CXRWConfig` | `CXUtils`, `CXLog` | — | 35 | — | — |
| `CXRecode.pm` | 122 | `CXRecode` | `CXLog`, `CXUtils` | `cxassoc`, `cxbottle`, `cxmenu`, `wineshelllink`, `CXAssocXDG.pm`, `CXMenuWindows.pm` | 6 | — | — |
| `CXReplicateDir.pm` | 1426 | `CXReplicateDir` | `CXLog`, `CXUtils` | `wineprefixcreate` | 43 | — | — |
| `CXTinySAX.pm` | 166 | `CXTinySAX` | `CXUtils`, `CXLog`, `XML::RegExp` | `CXAssocXDG.pm` | 4 | — | — |
| `CXTinySAXBase.pm` | 55 | `CXTinySAXBase` | — | `CXAssocXDG.pm`, `CXTinySAXLog.pm`, `CXTinySAXMultiplexer.pm` | 7 | — | — |
| `CXTinySAXLog.pm` | 59 | `CXTinySAXLog` | `CXTinySAXBase`, `CXLog` | — | 6 | — | — |
| `CXTinySAXMultiplexer.pm` | 69 | `CXTinySAXMultiplexer` | `CXTinySAXBase` | — | 6 | — | — |
| `CXUpgrade.pm` | 650 | `CXUpgradeField`, `CXUpgradeSection`, `CXUpgrade` | `CXLog` | — | 32 | — | — |
| `CXUtils.pm` | 1496 | `CXUtils`, `CXShellCommand` | `CXLog`, `CXConfig` | `cxassoc`, `cxavscan`, `cxbottle`, `cxgarcon-terminal`, `cxmenu`, `cxnativeopen`, `cxreboot`, `cxsu`, `cxtemplate`, `cxuninstall`, `cxwinassoc`, `wine`, `wineprefixcreate`, `wineshelllink`, `CXAssoc.pm`, `CXAssocCDE.pm`, `CXAssocCheck.pm`, `CXAssocDebian.pm`, `CXAssocWindows.pm`, `CXAssocXDG.pm`, `CXBottle.pm`, `CXCDE.pm`, `CXConfig.pm`, `CXDebian.pm`, `CXMenu.pm`, `CXMenuCDE.pm`, `CXMenuDebian.pm`, `CXMenuDtop.pm`, `CXMenuPerm.pm`, `CXMenuShortcut.pm`, `CXMenuWindows.pm`, `CXMenuXDG.pm`, `CXMimeMcap.pm`, `CXRPM.pm`, `CXRWConfig.pm`, `CXRecode.pm`, `CXReplicateDir.pm`, `CXTinySAX.pm`, `CXXMLDOM.pm` | 74 | `cxbackquote`, `cxexec`, `cxgettext`, `cxmessage`, `cxdirname`, `cxbasename`, `cxmkpath`, `cxmv`, `cxsystem`, `cxwait`, `demangle_string`, `escape_string` … (+7) | `CX_ROOT`, `HOME`, `PATH`, `TMPDIR`, `DISPLAY`, `MATE_DESKTOP_SESSION_ID`, `KDE_FULL_SESSION`, `XDG_CURRENT_DESKTOP`, `DESKTOP_SESSION`, `GNOME_DESKTOP_SESSION_ID` |
| `CXXMLDOM.pm` | 400 | `CXXMLDOM` | `CXLog`, `CXUtils` | `CXAssocMacOSX.pm`, `CXMenuMacOSX.pm`, `CXMenuXDG.pm`, `CXPlist.pm` | 21 | `get_cdata`, `set_cdata`, `get_child`, `find_tag`, `find_next_tag`, `get_child_by_name`, `get_tag_by_path`, `create_element`, `add_element`, `add_new_element`, `set_element`, `remove_element` | — |

### Subs por módulo

- **`bin/cxassoc`**: `cxwhich`, `_cxdirname`, `locate_cx_root`, `get_filter_list`, `get_install_mode`, `update_field`, `normalize_eassocid`, `valid_mimetype`, `maybe_capitalize`, `build_assoc_db`
- **`bin/cxavscan`**: `cxwhich`, `_cxdirname`, `locate_cx_root`, `virus_dialog`, `scanner_dialog`
- **`bin/cxbottle`**: `cxwhich`, `_cxdirname`, `locate_cx_root`, `CXBDebian::new`, `CXBDebian::map_directory`, `CXBDebian::map_file`, `CXBRPM::map_directory`, `CXBRPM::map_file`, `get_tmpdir`, `create_and_lock_wineprefix`, `is_wineserver_running`, `lock_and_shutdown_bottle`
- **`bin/cxgarcon-terminal`**: `cxwhich`, `_cxdirname`, `locate_cx_root`, `read_autostart`, `write_autostart`
- **`bin/cxlogfilter`**: `cxwhich`, `_cxdirname`, `locate_cx_root`, `print_skipped`
- **`bin/cxmenu`**: `cxwhich`, `_cxdirname`, `locate_cx_root`, `get_filter_list`, `check_menu_path`, `path_to_components`, `update_field`
- **`bin/cxmessage`**: `cxwhich`, `_cxdirname`, `locate_cx_root`
- **`bin/cxnativeopen`**: `cxwhich`, `_cxdirname`, `locate_cx_root`, `compute_exit_code`
- **`bin/cxreboot`**: `cxwhich`, `_cxdirname`, `locate_cx_root`
- **`bin/cxsu`**: `cxwhich`, `_cxdirname`, `locate_cx_root`
- **`bin/cxtemplate`**: `cxwhich`, `_cxdirname`, `locate_cx_root`
- **`bin/cxuninstall`**: `cxwhich`, `_cxdirname`, `locate_cx_root`, `cellar_is_shared`, `stop_applications`, `uninstall`
- **`bin/cxwinassoc`**: `cxwhich`, `_cxdirname`, `locate_cx_root`, `set_extension_class`, `delete_class`, `create_class`
- **`bin/wine`**: `cxwhich`, `_cxdirname`, `locate_cx_root`, `get_template_directory`, `fatal_error`, `check_file`, `get_updater`, `prepend_env_path`, `read_env_from_string`, `dump_wine_environment`, `setup_wine_environment`, `is_valid_win_path`
- **`lib/perl/CXAssoc.pm`**: `get_icon_dir`, `get_icon`, `setup_from_best_eassoc`, `std_verb_names`, `compute_verb_name`, `remove_accelerators`, `init_mime_handler`, `mdb_add_mime`, `mdb_has_mime`, `mdb_get_mimes_from_ext`, `ignore_mime_alias`, `get_mimes`, `collect_unix_extensions`, `compare_sets`, `action`
- **`lib/perl/CXAssocCDE.pm`**: `read_mime_db`, `read_dt_file`, `create_mime`, `query_mime`, `get_mime_files`, `untag_mime`, `create_association`, `query_association`, `get_association_files`, `delete_association`, `detect`, `id`, `preinstall`, `install`, `query`, `get_files`, `uninstall`, `removeall`, `finalize`
- **`lib/perl/CXAssocCheck.pm`**: `detect`, `id`, `preinstall`, `get_script_base`, `install`, `query`, `get_files`, `uninstall`, `removeall`, `finalize`
- **`lib/perl/CXAssocDebian.pm`**: `read_mailcap`, `detect`, `id`, `get_association_files`, `get_files`, `removeall`, `finalize`
- **`lib/perl/CXAssocMacOSX.pm`**: `get_mac_assoc_components`, `get_mac_eassoc_components`, `get_mac_massoc_components`, `get_mac_components`, `component_to_dict`, `get_folder`, `init_xml`, `read_mime_db`, `create_mime`, `query_mime`, `untag_mime`, `create_association`, `query_association`, `delete_association`, `detect`, `id`, `preinstall`, `install`, `query`, `get_files`, `uninstall`, `removeall`, `set_path_closure`, `gc_get_folder_status`, `gc_delete_folder`, `garbage_collect`, `finalize`
- **`lib/perl/CXAssocMailcap.pm`**: `read_mailcap`, `detect`, `id`, `get_files`, `removeall`
- **`lib/perl/CXAssocMcap.pm`**: `create_association`, `query_association`, `delete_association`, `new`, `preinstall`, `install`, `query`, `uninstall`, `finalize`
- **`lib/perl/CXAssocWindows.pm`**: `detect`, `id`, `preinstall`, `install`, `query`, `get_files`, `uninstall`, `removeall`, `finalize`
- **`lib/perl/CXAssocXDG.pm`**: `Xml2MimeDB::new`, `Xml2MimeDB::encoding`, `Xml2MimeDB::recode`, `Xml2MimeDB::start_element`, `Xml2MimeDB::end_element`, `read_mime_db`, `ReadCXMimes::new`, `ReadCXMimes::encoding`, `ReadCXMimes::recode`, `ReadCXMimes::start_element`, `ReadCXMimes::end_element`, `ReadCXMimes::cdata`, `ReadCXMimes::comment`, `read_cxmimes`, `save_cxmimes`, `create_icon`, `delete_icon`, `get_icon_files`, `removeall_icon`, `create_mime`, `query_mime`, `get_mime_files`, `untag_mime`, `create_association`, `query_association`, `get_association_files`, `delete_association`, `read_defaults`, `create_default`, `query_default`, `get_default_files`, `delete_default`, `detect`, `id`, `preinstall`, `install`, `query`, `get_files`, `uninstall`, `removeall`, `finalize`
- **`lib/perl/CXBottle.pm`**: `set_environment`, `get_managed_bottle_dir`, `get_user_bottle_dir`, `get_rw_config_filename`, `lock_and_get_rw_config`, `get_<produto>_config`, `is_initialized`, `compute_new_wineprefix`, `find_bottle`, `is_wineprefix_valid`, `setup_bottle_wineprefix`, `get_bottle_lock_prefix`, `unlock_bottle`, `lock_bottle`, `read_bottle_config`, `setup_bottle_environment`, `get_bottle_mode`, `bottle_stub2managed`, `get_template_directory`, `get_bottle_tag`, `get_bottle_status`, `update_bottle`, `run_scripts`, `run_bottle_hooks`, `fix_item_ownership_permissions`, `fix_ownership_permissions`, `get_desktopdata_dir`, `removeall_desktopdata_dirs`, `count_user_bottles`
- **`lib/perl/CXCDE.pm`**: `new`, `save`, `is_empty`, `dump`
- **`lib/perl/CXConfig.pm`**: `CXSection::new`, `CXSection::get`, `CXSection::get_name`, `CXSection::get_field_list`, `CXSection::get_fields`, `new`, `read`, `get_filenames`, `get_section_keys`, `get_section_names`, `get_section`, `get`
- **`lib/perl/CXDebian.pm`**: `compute_package_name`, `new`, `add_install_path`, `add_file`, `add_tree`, `build`
- **`lib/perl/CXLog.pm`**: `open`, `fdopen`, `close`, `set_default_channel`, `get_filename`, `is_on`, `cxlog`, `cxlog_`, `cxname0`, `cxwarn`, `cxerr`, `cxtime`
- **`lib/perl/CXMenu.pm`**: `menu_to_lnk`, `set_path_closure`, `wineshelllink2cxmenu`, `get_default_icon`, `fill_icon_cache`, `get_icon_paths`, `get_mac_icon_path`, `get_unix_icon_path`, `get_default_icon_path`, `xdg_install_icons`, `xdg_get_icon_files`, `xdg_fill_desktop_entry`, `xdg_create_desktop_file`, `xdg_create_directory`, `garbage_collect`, `finalize`
- **`lib/perl/CXMenuCDE.pm`**: `read_dt_file`, `detect`, `id`, `install`, `query`, `get_files`, `uninstall`, `removeall`, `gc_get_folder_status`, `gc_delete_folder`, `finalize`
- **`lib/perl/CXMenuCheck.pm`**: `detect`, `id`, `install`, `query`, `get_files`, `uninstall`, `removeall`, `finalize`
- **`lib/perl/CXMenuDebian.pm`**: `detect`, `id`, `read_menu_file`, `create_component`, `install`, `query`, `get_files`, `uninstall`, `removeall`, `gc_get_folder_status`, `gc_delete_folder`, `finalize`
- **`lib/perl/CXMenuDtop.pm`**: `create_mangled_folder`, `new`, `detect`, `id`, `install`, `query`, `get_files`, `removeall_file`, `removeall_folder`, `uninstall`, `removeall`, `gc_get_folder_status`, `gc_delete_folder`, `gc_untag_folder`
- **`lib/perl/CXMenuMacOSX.pm`**: `get_mac_components`, `component_to_dict`, `get_folder`, `init_xml`, `detect`, `id`, `install`, `query`, `get_files`, `uninstall`, `removeall`, `gc_get_folder_status`, `gc_delete_folder`, `finalize`
- **`lib/perl/CXMenuPerm.pm`**: `detect`, `id`, `install`, `query`, `get_files`, `uninstall`, `removeall`, `finalize`
- **`lib/perl/CXMenuShortcut.pm`**: `detect`, `id`, `get_directories`, `is_shortcut_script`, `is_dir_in_path`, `install`, `query`, `get_files`, `uninstall`, `removeall`, `finalize`
- **`lib/perl/CXMenuWindows.pm`**: `remove_spaces`, `detect`, `id`, `get_wine_script`, `get_command`, `delete`, `install`, `query`, `get_files`, `uninstall`, `removeall`, `finalize`
- **`lib/perl/CXMenuXDG.pm`**: `get_root_menu`, `get_xpath`, `get_folder_by_xpath`, `get_xdg_basename`, `create_folder`, `delete_folder`, `setup_default_merge_dir`, `get_xdg_config`, `init_xml`, `new`, `detect`, `id`, `install`, `query`, `get_files`, `uninstall`, `removeall`, `gc_get_folder_status`, `gc_delete_folder`, `finalize`
- **`lib/perl/CXMimeMcap.pm`**: `CXRWBlob::get`, `CXRWBlob::get_created_by`, `CXRWBlob::is_<produto>_mimetype`, `CXRWBlob::modified`, `CXRWBlob::add`, `CXRWBlob::remove`, `CXRWBlob::remove_created_by`, `CXRWBlob::new`, `CXRWBlob::isempty`, `CXRWBlob::save`, `CXRWBlob::delete_or_save`, `read_rwmime`, `process_mime_file`, `read_mime_db`, `create_mime`, `query_mime`, `get_mime_files`, `untag_mime`, `get`, `removeall`, `finalize`
- **`lib/perl/CXOpts.pm`**: `new`, `add_flags`, `add_options`, `parse`
- **`lib/perl/CXPlist.pm`**: `get_key_by_name`, `get_key_by_value`, `get_value_by_key`, `get_value_by_name`, `add_key_with_string`, `add_key_with_child`, `add_key_with_new_tag`
- **`lib/perl/CXRPM.pm`**: `compute_package_name`, `escape_file_path`, `new`, `get_rpm_version`, `map_directory`, `map_file`, `create_image`, `build`
- **`lib/perl/CXRWConfig.pm`**: `CXRWSection::new`, `CXRWSection::_add_line`, `CXRWSection::_escape_string`, `CXRWSection::_unescape_char`, `CXRWSection::_unescape_string`, `CXRWSection::get_name`, `CXRWSection::get_field_list`, `CXRWSection::is_commented_out`, `CXRWSection::get`, `CXRWSection::_rebuild_line`, `CXRWSection::comment_out`, `CXRWSection::set`, `CXRWSection::remove`, `CXRWSection::remove_all`, `dump_fields`, `dump_lines`, `_add_section`, `append_section`, `get_section_keys`, `get_section_names`, `get_section`, `rename_section`, `remove_section`, `remove_all`, `set_shebang`, `get`, `set`, `new`, `uncache_file`, `get_filename`, `get_filenames`, `set_filename`, `is_modified`, `write`, `save`
- **`lib/perl/CXRecode.pm`**: `use_perl`, `recode_perl`, `recode_iconv`, `recode`, `to_sys`, `from_sys`
- **`lib/perl/CXReplicateDir.pm`**: `scan_tree`, `read_file_list`, `write_file_list`, `new`, `set_link_type`, `set_full_copy`, `set_policy_settings`, `action_noop`, `action_skip`, `action_cp`, `action_cpr`, `action_ln`, `action_lns`, `action_cpln`, `action_regoverride`, `action_regpreserve`, `action_ifeq_rm`, `action_ifne_cpln`, `action_chk_cpln`, `action_rm`, `action_rm_cp`, `action_rm_ln`, `action_rm_cpln`, `action_rm_new`, `action_rmdir`, `action_rmrf`, `action_rmrf_new`, `action_update`, `get_file_merge_column`, `get_linkfile_merge_column`, `get_directory_merge_column`, `get_linkdir_merge_column`, `get_conflict_merge_column`, `merge_tree_get_policy`, `merge_tree`, `dump_list`, `dump_array_list`, `dump_task_list`, `do_link_symbolic`, `do_link_hard`, `do_link_hard_symbolic`, `do_regappend`, `apply_changes`
- **`lib/perl/CXTinySAX.pm`**: `xml_decode`, `mangle_cdata`, `mangle_attribute`, `parse_file`
- **`lib/perl/CXTinySAXBase.pm`**: `new`, `init`, `encoding`, `start_element`, `end_element`, `cdata`, `comment`
- **`lib/perl/CXTinySAXLog.pm`**: `init`, `encoding`, `start_element`, `end_element`, `cdata`, `comment`
- **`lib/perl/CXTinySAXMultiplexer.pm`**: `new`, `encoding`, `start_element`, `end_element`, `cdata`, `comment`
- **`lib/perl/CXUpgrade.pm`**: `CXUpgradeField::new`, `CXUpgradeField::add_entry`, `CXUpgradeField::get_entries`, `CXUpgradeField::get_effective_entry`, `CXUpgradeField::get_value`, `CXUpgradeField::set_value`, `CXUpgradeSection::new`, `CXUpgradeSection::add_field`, `CXUpgradeSection::get_field`, `CXUpgradeSection::get_fields`, `CXUpgradeSection::remove_field`, `CXUpgradeSection::add_entry`, `CXUpgradeSection::get_entry`, `CXUpgradeSection::set_entry`, `CXUpgradeSection::get`, `CXUpgradeSection::set`, `build_entry_line`, `dump_fields`, `dump_lines`, `add_section`, `parse_variable`, `new`, `get_filename`, `get_section`, `get_sections`, `remove_section`, `rename_section`, `get`, `write`, `find_best_match`, `merge_field`, `merge`
- **`lib/perl/CXUtils.pm`**: `cxwhich`, `check_product_id`, `get_builtin_product_id`, `get_product_id_for_product`, `get_product_id`, `get_product_name`, `get_cellar_id`, `get_user_dir_for_product`, `get_user_dir`, `get_product_version`, `get_std_icon`, `get_cross_product_config`, `hash_string`, `base32`, `rfc822time`, `expand_tilde`, `expand_string`, `escape_string`, `unescape_string`, `mangle_string`, `demangle_string`, `cmdline2argv`, `expand_cmdline`, `shquote_string`, `argv2shcmd`, `glob2regexp`, `cxglob`, `delete_files`, `cxfind`, `get_wine_dir_id`, `get_unique_id`, `cxdirname`, `cxbasename`, `same_inode`, `get_symlink_target`, `dereference_symlink`, `cxrealpath`, `cxmkpath`, `cxmv`, `file_grep`, `get_cpio_o`, `get_tar`, `get_gzip`, `get_bzip2`, `generate_from_template`, `garbage_collect_subdirs`, `cxlock`, `cxunlock`, `cxexec`, `cxsystem`, `cxbackquote`, `CXShellCommand::dump_chunk`, `CXShellCommand::compute_logfile`, `CXShellCommand::build_cmdline`, `CXShellCommand::get_command_line`, `CXShellCommand::get_output`, `CXShellCommand::has_errors`, `CXShellCommand::run`, `CXShellCommand::get_exit_code`, `CXShellCommand::get_error_report`, `new_shell_command`, `cxmessage`, `cxwait`, `cxsu`, `get_desktop_environment`, `get_terminal_emulator`, `get_system_encoding`, `get_supported_locales`, `cxgetlang`, `cxsetlang`, `cxgetencoding`, `cxsetencoding`, `cxgettext`, `license_file_present`
- **`lib/perl/CXXMLDOM.pm`**: `get_xml_load_error`, `parse_xml_file`, `parse_xml_string`, `save_xml_file`, `is_unicode`, `utf8_to_unicode`, `unicode_to_utf8`, `string_properties`, `dump_dom`, `get_cdata`, `set_cdata`, `get_child`, `find_tag`, `find_next_tag`, `get_child_by_name`, `get_tag_by_path`, `create_element`, `add_element`, `add_new_element`, `set_element`, `remove_element`

## `lib/perl/XML/` (terceiros)

Cópias embarcadas de `XML::DOM`, `XML::SAX`, `XML::NamespaceSupport` e `XML::RegExp` (módulos CPAN). Só o inventário:

| Arquivo | Linhas | SHA-256 |
|---|---|---|
| `XML/DOM.pm` | 5009 | `6076ed1aa6965c5f` |
| `XML/NamespaceSupport.pm` | 583 | `b6c81ccb634c5ca3` |
| `XML/RegExp.pm` | 82 | `2f98f8fcf91bb676` |
| `XML/SAX.pm` | 379 | `3bc6dd82998186e8` |
| `XML/DOM/DOMException.pm` | 88 | `5a54b09c1d64adfd` |
| `XML/DOM/NamedNodeMap.pm` | 271 | `631cf86283780996` |
| `XML/DOM/NodeList.pm` | 46 | `badba7a897ca57c8` |
| `XML/Handler/BuildDOM.pm` | 338 | `85bae87bc26ad5df` |
| `XML/SAX/Base.pm` | 3164 | `99d94ce08d13ceaa` |
| `XML/SAX/DocumentLocator.pm` | 134 | `530c350abece6f02` |
| `XML/SAX/Exception.pm` | 126 | `8c1635d00e49e80d` |
| `XML/SAX/ParserFactory.pm` | 230 | `fb34ca100afb46df` |
| `XML/SAX/PurePerl.pm` | 751 | `c6018242cd871088` |
| `XML/SAX/PurePerl/DTDDecls.pm` | 603 | `787405d8010afbf6` |
| `XML/SAX/PurePerl/DebugHandler.pm` | 95 | `160169e2ddcb6cae` |
| `XML/SAX/PurePerl/DocType.pm` | 180 | `5836099017874f40` |
| `XML/SAX/PurePerl/EncodingDetect.pm` | 105 | `5ee51c54fa991eef` |
| `XML/SAX/PurePerl/Exception.pm` | 67 | `276b8797b227f03a` |
| `XML/SAX/PurePerl/NoUnicodeExt.pm` | 28 | `5935541788477530` |
| `XML/SAX/PurePerl/Productions.pm` | 147 | `1277ec969316b7d0` |
| `XML/SAX/PurePerl/Reader.pm` | 136 | `32dd4d797d6680bc` |
| `XML/SAX/PurePerl/UnicodeExt.pm` | 22 | `a060e22251b805e0` |
| `XML/SAX/PurePerl/XMLDecl.pm` | 129 | `699ca7ecd391cafc` |
| `XML/SAX/PurePerl/Reader/NoUnicodeExt.pm` | 25 | `08b8a5e3f5e29da3` |
| `XML/SAX/PurePerl/Reader/Stream.pm` | 84 | `c77a5fce1a8b136a` |
| `XML/SAX/PurePerl/Reader/String.pm` | 78 | `c4158b5e185e910d` |
| `XML/SAX/PurePerl/Reader/URI.pm` | 57 | `d03ec5e837f15635` |
| `XML/SAX/PurePerl/Reader/UnicodeExt.pm` | 23 | `1d36e9911c985f4f` |

## Integridade

| Arquivo | Bytes | SHA-256 |
|---|---|---|
| `bin/cabextract` | 101792 | `8529af3e22018492e19295415dbcebfba8ea66246229ba611a6b2d655c70369a` |
| `bin/cxassoc` | 58159 | `6f2caf10aeec5b91978887cb933697cbb75b7cbff5f697199d7037a8f6189795` |
| `bin/cxavscan` | 8553 | `495a2a8852f1b702701a3ac16dd3900fbd073042f3be78c4228cd506eb00814c` |
| `bin/cxbottle` | 56575 | `e0509d0ecad44ac59a610b337f884bd93304d3eb2e1efee3a96c7db4eeba4005` |
| `bin/cxbounce` | 31456 | `dab9f75ad6ff62d7947084de4d6818eb45cab2f2f4ac230d69ba4459855f500d` |
| `bin/cxgarcon-terminal` | 7204 | `f0efc8af6451d1ab05ebc79963b09dee83f2ccbe9b1770a882538d4f6f0179ad` |
| `bin/cxgetsysinfo` | 5319 | `aac26b36c73982e6d2dc7933c30fb38951161de0ee2decd8ed53dff3b03e8704` |
| `bin/cxgettext` | 31552 | `cfdb6ef8e8c3ad93bfee03bf54d98397d1bc1883948723fed00a743714ee5872` |
| `bin/cxlogfilter` | 8069 | `ba11637b137639c4fa6bcdd546f7c76fb387be7cfc3cbb465e731c422a6c6dda` |
| `bin/cxmenu` | 50674 | `4272df24fb104d7c69bcfbc66c24116634249c08b2121c95f5482902f4cc5ef3` |
| `bin/cxmessage` | 2333 | `6372a9fb2f9e0f2510b752e7518719f9d1e49d8e3fb5935eabc1967e18447259` |
| `bin/cxnativeopen` | 9240 | `f72afbc3acd754baa55894de4b7fabab4a4f724a402df2621d5b8996499ebb24` |
| `bin/cxps2pdf` | 579 | `72268589b732611af17196433f7561d359b6608f148913a78905481769a75cf1` |
| `bin/cxreboot` | 4627 | `47cb6f818a584b15210e5c2c516800fa98ce3bc6ad71357bbff81a599c684eb8` |
| `bin/cxselinux` | 5884 | `fbe28efaae9d031cbad3ac787123fd02edb066151a1674d803be118f6ab95a25` |
| `bin/cxsu` | 13190 | `6f28d91e1a1818530f7260f34aa64ccd4eb465d52e05cf0e12cf06cd84ad866d` |
| `bin/cxtemplate` | 5563 | `b606ae2ce463ce460f24366f96469b22deb496f13c950fc6cf73c67870e2a999` |
| `bin/cxuninstall` | 13529 | `cd80cb9f496c4d8e45c93ecdbfe49bd4b820468a4fed6c6808cc4f424afe16e8` |
| `bin/cxwinassoc` | 7770 | `9ef29ef381765ab508caf87e88f3f98ce11ff20e9729a8aef3fc21618aac03b8` |
| `bin/locate_gui.sh` | 14742 | `304cedf95db9282a8370600ff44641872d43e869c1019b68790dcb0d6d838fb8` |
| `bin/ps2pdf` | 272 | `1db131fe92b5106fcbe9bf1539cea9af6595085dbbabffc30ec408222d89b63b` |
| `bin/ps2pdf12` | 215 | `224b3536d3abfe57f42b95d5d0ef23170505e93fcfff8dc8240ba246e18d302d` |
| `bin/ps2pdf13` | 215 | `a3d0653159e64a9ed338947366605bcbb9de751571203d62aba385d50bb46e0f` |
| `bin/ps2pdf14` | 215 | `f41ae340a9faad07c77fd89ce3abda0beeb498f253398edf4d315f9277828f62` |
| `bin/ps2pdf_gs` | 10926960 | `fa6de92dfabd97d26b32f1097b4aaa32986d09752534f47b889b678cb86050f2` |
| `bin/ps2pdfwr` | 1104 | `b97a3154eeac52e864c3f4fb2c0b1a6f694a9e0248c422193484bee4476f840a` |
| `bin/unrar` | 358656 | `015609397d9d50452e02e9fec07c9e1a75e41196d418ba9114ef288a9eca3dee` |
| `bin/wine` | 42412 | `04da13c940c57919334520f2fee4adb2186edb41904faf8f86647a0a03114953` |
| `bin/wineloader` | 33040 | `ed1318f573bbcd7f153c6fc4c0de66dcf5642b5967e9665991503acb29ea9159` |
| `bin/wineprefixcreate` | 11816 | `50ecdcb536995c34670384239e8168e4ec9e893281f5d6e6a35773b288da6636` |
| `bin/wineserver` | 598160 | `f9c4ed146c7d6dfc94334255907d4e0658218585085ca2107a5181b4deb474fc` |
| `bin/wineshelllink` | 4127 | `9b90611b6f024b045f8814f85a45fde31c188b69a571a748f86fdbd567e2d77d` |
| `lib/perl/CXAssoc.pm` | 19614 | `58d3668a4d8f5a91b6718b5d7ad82d43b3f23f2e17ba563e0887210cfc4a0bdc` |
| `lib/perl/CXAssocCDE.pm` | 14725 | `ffdf6aa2123c7fa841468d7b304f75444670a91916a4f544ab94eb15b5c554b7` |
| `lib/perl/CXAssocCheck.pm` | 4575 | `e2663bef7f33ae192d50ac650a939a8e9847fffce4169954c9ed5156580f8699` |
| `lib/perl/CXAssocDebian.pm` | 1759 | `c64bb83f9e140fdb3c33ca2ede1a70a48e05d55d5dc5fa4e2a15a7edd55ddb9b` |
| `lib/perl/CXAssocMacOSX.pm` | 18827 | `731040a2a878b0196e11f1094835585d0b42920373ef52dfcf037e9991001732` |
| `lib/perl/CXAssocMailcap.pm` | 1629 | `e01dc28be39f1404a93ea7e15a784d176fdd7172b7e771d7cd9f0f2a4e7ccd11` |
| `lib/perl/CXAssocMcap.pm` | 5254 | `2010415741dbdd27606cf5ab308a432bdbbda8d98665ef94526a75fdbb1af1e9` |
| `lib/perl/CXAssocWindows.pm` | 2094 | `a4e9d834e6309db6ad073a9741d0aa0e9e891a65395f8f30765aa3d711557327` |
| `lib/perl/CXAssocXDG.pm` | 35851 | `844c76ba76b74b406f6480cddca2483c7e976103e3904c4f20804839180e606a` |
| `lib/perl/CXBottle.pm` | 18690 | `83b2c8e1432b00d6867099ee26e68b3b4bebbfa85e8036052660fc91f827c074` |
| `lib/perl/CXCDE.pm` | 4905 | `566aad7fa1d80edb9e64a9ec51032576b9eb032199a23e35306369a763052493` |
| `lib/perl/CXConfig.pm` | 4357 | `371a15037af98820bc196ca4405d588ae24458eb9fa698648547fa595a399548` |
| `lib/perl/CXDebian.pm` | 5914 | `1423cbb3a5a098b6c3530c548593ff8b55b5924071e482f0cdd6a3d10a672b40` |
| `lib/perl/CXLog.pm` | 3502 | `e44bfedce4a80a16c77072b36240505b7dd865f014db5d56d70220aa2a00d2f2` |
| `lib/perl/CXMenu.pm` | 16774 | `72b553a603b0c15f2c28ee54703896e9b3a8a8e7a02497d4926b24b1dee8c6e7` |
| `lib/perl/CXMenuCDE.pm` | 9730 | `29e7612c4dbe1634cb3d8b5536ffe31acd86d3fda4315f6d4c5ede4b52c8d67f` |
| `lib/perl/CXMenuCheck.pm` | 1515 | `730fcb13ced4fff2006d1b9493b54fbcf10bf1c53b7503db59c935b0f3c16afe` |
| `lib/perl/CXMenuDebian.pm` | 11766 | `71f4ebc206340464391ee99358c0e7b4be778fb5221f8b8c191a906d8e9d7c03` |
| `lib/perl/CXMenuDtop.pm` | 13941 | `f3e1370b39b3e7608db9dd1c79ba2ca588d9159b788c3d0a5990827e30562fc0` |
| `lib/perl/CXMenuMacOSX.pm` | 11623 | `4a0c82d52c02f613acb6f8fe9397c2bfed354a5fb074c1836d569a41045d3d2b` |
| `lib/perl/CXMenuPerm.pm` | 5002 | `1c2b68b2dec668985c0cc643f0ce2f8debf387f3323ec6d56803b9790b7ff7be` |
| `lib/perl/CXMenuShortcut.pm` | 8041 | `bff7b3d65c5527ca41aa0004c223e211edddffb64cfc51506862bb9b73c73163` |
| `lib/perl/CXMenuWindows.pm` | 6986 | `dd47d1ac446d161eb685679d831269227588387eea5430e019b57394a93eebf0` |
| `lib/perl/CXMenuXDG.pm` | 24838 | `b5b031203480c4cb03537113f3f13558faf16df538f2993e52ff138fec027941` |
| `lib/perl/CXMimeMcap.pm` | 24466 | `00b15617448d863676db40beb77f99e083c83b387970e9bf58792d252b36b9f7` |
| `lib/perl/CXOpts.pm` | 4512 | `4f6b2316fa05b5b6b54c6ace31a4915e9f0716950bb57c5f9f7a6cf2b6d1bf2e` |
| `lib/perl/CXPlist.pm` | 1797 | `639c6438d637d6d7fbde7a9d59bf09a38b44c79d7d7dcd6fb5eae80e1b95fc9d` |
| `lib/perl/CXRPM.pm` | 5567 | `d9800c3f20172add1613870c8c47413ac32a859506a8889275c88d6918d307b2` |
| `lib/perl/CXRWConfig.pm` | 17081 | `a37296c7de3106ea067872bace0d67d317c0893e5ab854296c9fd43457210431` |
| `lib/perl/CXRecode.pm` | 2751 | `06e87f4e61e136ebaee8b6970a998b53dfb8f1c67ca8c82556ff233779216e75` |
| `lib/perl/CXReplicateDir.pm` | 40989 | `3172344832a14cc1467221417adf61d772e8108ea7c92d4c29770f6e35e06888` |
| `lib/perl/CXTinySAX.pm` | 4190 | `e08c751b8884585ccf4a04080c2c60769f83d0dd4f3812aa9a91e9db1cc78eaf` |
| `lib/perl/CXTinySAXBase.pm` | 800 | `30538f7114aaf42c597c88357e3f457df0ef87c073b205b75d835bb1ef9e4a22` |
| `lib/perl/CXTinySAXLog.pm` | 1038 | `ac5690904d3a941c3b5b70b97571a7777742cc2ce3c5d72a8ea6a062a8fe22aa` |
| `lib/perl/CXTinySAXMultiplexer.pm` | 1341 | `63a9a378a7a69f05e2415de2c891f9d013b563e6cc2db7924b194b64971c0084` |
| `lib/perl/CXUpgrade.pm` | 17392 | `07e6f5c8fcf5718887b455eeeb95075b626dbef8338324cbc809cc4372a42512` |
| `lib/perl/CXUtils.pm` | 37120 | `0bb745249d9ff67e0a5a02467c3c21d756e7e637f0f61360c0a6784c95506893` |
| `lib/perl/CXXMLDOM.pm` | 9001 | `80a7fce73c4b9ff2487c0c544bc5c9d7c079145d2038a60ace89d1ce8c75e385` |
