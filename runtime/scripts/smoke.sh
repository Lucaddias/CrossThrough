#!/bin/bash
# runtime/scripts/smoke.sh — prova que o runtime montado funciona sozinho.
#
# Uso: scripts/smoke.sh [caminho-do-runtime]   (padrão: $OUT)
#
# Cria uma bottle descartável e roda, em ordem:
#   1. wineboot --init           a bottle nasce (system32, registro, Mono/Gecko)
#   2. cmd /c ver                o Windows responde
#   3. tlstest.exe x2            HTTPS via schannel/GnuTLS: aceita certificado
#                                válido, recusa um inválido
#   4. fonttest.exe              fontes TrueType via FreeType
#   5. htmltest.exe x2           mshtml com o Wine Gecko (64 e 32-bit)
#   6. dotnettest.cs             compilado e executado com o Wine Mono
#   7. vktest.exe                Vulkan via winevulkan -> MoltenVK
#   8. cabextract                abre um .cab feito pelo cabarc do Wine
#   9. winetricks                aplica um verbo de configuração na bottle
#  10. d3d11test.exe x3          Direct3D 11 em wined3d, DXVK e DXMT (64-bit)
#  11. d3d11test32.exe           o mesmo em 32-bit (WoW64), nos três backends
#
# Também é a referência executável do contrato que o app segue: o ambiente de
# execução (env_cmd), o do winetricks (winetricks_env) e a troca de backend
# gráfico por bottle (use_backend).
source "$(dirname "$0")/common.sh"

RT=$(cd "${1:-$OUT}" && pwd)
[ -x "$RT/bin/wine" ] || die "runtime não encontrado em $RT"
export PATH="/opt/homebrew/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# --- programas de teste (mingw-w64) -----------------------------------------
TB=$WORK/tests
mkdir -p "$TB"
T=$RUNTIME_DIR/tests
x86_64-w64-mingw32-gcc -O2 -o "$TB/d3d11test.exe" "$T/d3d11test.c" -ld3d11 -ldxgi -ldxguid -luuid
i686-w64-mingw32-gcc   -O2 -o "$TB/d3d11test32.exe" "$T/d3d11test.c" -ld3d11 -ldxgi -ldxguid -luuid
x86_64-w64-mingw32-gcc -O2 -o "$TB/vktest.exe" "$T/vktest.c"
x86_64-w64-mingw32-gcc -O2 -municode -o "$TB/tlstest.exe" "$T/tlstest.c" -lwinhttp
x86_64-w64-mingw32-gcc -O2 -o "$TB/fonttest.exe" "$T/fonttest.c" -lgdi32
x86_64-w64-mingw32-gcc -O2 -o "$TB/htmltest.exe" "$T/htmltest.c" -lole32 -loleaut32 -luuid
i686-w64-mingw32-gcc   -O2 -o "$TB/htmltest32.exe" "$T/htmltest.c" -lole32 -loleaut32 -luuid
# Ferramenta para conferir a janela de um programa aberto (não é um teste daqui; ver README).
x86_64-w64-mingw32-gcc -O2 -municode -o "$TB/wininspect.exe" "$T/wininspect.c" -lcomctl32 -luser32

# Os programas rodam com o diretório atual em $TB, como o app faz (o diretório
# do .exe): o DXVK grava ali o log (<exe>_d3d11.log) e o cache de shaders.
cd "$TB"

# --- ambiente ---------------------------------------------------------------
PREFIX=$WORK/smoke-prefix
OVERRIDES=""

# O ambiente mínimo que o app usa para rodar qualquer coisa numa bottle. As
# bibliotecas do runtime são achadas por rpath; DYLD_FALLBACK_LIBRARY_PATH
# fica de fora de propósito, para o teste provar que o rpath basta.
# env_cmd preenche ENV_CMD (um comando de verdade, que o perl do check pode exec).
env_cmd() {
  ENV_CMD=(env -i HOME="$HOME" USER="$USER" TMPDIR="${TMPDIR:-/tmp}" PATH="/usr/bin:/bin:/usr/sbin:/sbin"
           LANG="${LANG:-en_US.UTF-8}" WINEPREFIX="$PREFIX" WINEDEBUG="${WINEDEBUG:--all}"
           WINEDLLOVERRIDES="$OVERRIDES")
}
wine_env() { env_cmd; "${ENV_CMD[@]}" "$@"; }
# O winetricks recebe o Wine do runtime por WINE/WINESERVER e acha o cabextract
# pelo PATH. Cache e configuração ficam fora do HOME (o app usa os dele), e
# sem a checagem de versão nova, que baixaria o script de novo.
winetricks_env() {
  WINETRICKS_ENV=(WINE="$RT/bin/wine" WINESERVER="$RT/bin/wineserver"
                  PATH="$RT/bin:/usr/bin:/bin:/usr/sbin:/sbin"
                  XDG_CACHE_HOME="$TB/cache" XDG_CONFIG_HOME="$TB/config"
                  WINETRICKS_LATEST_VERSION_CHECK=disabled)
}
# Caminho Unix -> caminho Windows pelo drive Z: (que o Wine mapeia para /).
winpath() { local p=${1//\//\\}; printf 'Z:%s' "$p"; }

# Bottle nova a cada execução (o wineserver -k só alcança a bottle de teste).
wine_env "$RT/bin/wineserver" -k 2>/dev/null || true
rm -rf "$PREFIX"

# Backend gráfico da bottle: DLLs nativas em system32/syswow64 + ordem de carga.
#   wined3d: as DLLs do próprio Wine (builtin)  — padrão, nada a copiar
#   dxvk:    lib/dxvk (D3D9/10/11 -> Vulkan -> MoltenVK)
#   dxmt:    lib/dxmt (D3D10/11 -> Metal; o winemetal já está em lib/wine)
use_backend() {
  local sys64=$PREFIX/drive_c/windows/system32 sys32=$PREFIX/drive_c/windows/syswow64 dlls f
  case "$1" in
    wined3d) dlls="d3d9 d3d10 d3d10_1 d3d10core d3d11 dxgi" ;;
    dxvk)    dlls="d3d9 d3d10 d3d10_1 d3d10core d3d11 dxgi" ;;
    dxmt)    dlls="d3d10core d3d11 dxgi" ;;
  esac
  # Sempre volta ao estado do Wine antes de aplicar o novo backend.
  for f in d3d9 d3d10 d3d10_1 d3d10core d3d11 dxgi; do
    cp "$RT/lib/wine/x86_64-windows/$f.dll" "$sys64/$f.dll"
    cp "$RT/lib/wine/i386-windows/$f.dll"   "$sys32/$f.dll"
  done
  if [ "$1" = wined3d ]; then
    OVERRIDES="$(echo $dlls | tr ' ' ',')=b"
    return
  fi
  for f in $dlls; do
    cp "$RT/lib/$1/x86_64-windows/$f.dll" "$sys64/$f.dll"
    cp "$RT/lib/$1/i386-windows/$f.dll"   "$sys32/$f.dll"
  done
  OVERRIDES="$(echo $dlls | tr ' ' ',')=n,b"
}

# --- execução ---------------------------------------------------------------
pass=0; failed=()
# check_cmd <nome> <padrão esperado na saída> <comando...>
# Roda o comando no ambiente da bottle, com limite de 180 s.
check_cmd() {
  local name=$1 want=$2 out rc; shift 2
  printf '  %-34s ' "$name"
  env_cmd
  # A saída vai para um arquivo, não para um pipe: processos que o programa
  # deixa vivos (conhost, winedbg) segurariam o pipe e travariam o teste.
  rc=0
  perl -e 'alarm shift; exec @ARGV or die "exec: $!\n"' 180 "${ENV_CMD[@]}" "$@" > "$TB/check.log" 2>&1 || rc=$?
  # 142 = SIGALRM: o tempo acabou; encerra tudo o que ficou rodando na bottle.
  [ $rc -ne 142 ] || wine_env "$RT/bin/wineserver" -k 2>/dev/null || true
  out=$(cat "$TB/check.log")
  if [ $rc -eq 0 ] && grep -qE "$want" <<<"$out"; then
    echo "ok   $(grep -E 'backend:|adapter:|device 0|https:|ignorando|Windows|fonte:|innerText:|runtime:' <<<"$out" | tr '\n' ' ' | cut -c1-110)"
    pass=$((pass + 1))
  else
    echo "FALHOU (rc=$rc)"; sed 's/^/      | /' <<<"$out" | tail -15
    failed+=("$name")
  fi
}
# check <nome> <padrão> <argumentos do wine...>
check() { local name=$1 want=$2; shift 2; check_cmd "$name" "$want" "$WINE" "$@"; }

WINE=$RT/bin/wine
log "Runtime: $RT ($(wine_env "$WINE" --version))"
check "wineboot --init" "" wineboot --init
wine_env "$RT/bin/wineserver" -w
if [ -f "$PREFIX/drive_c/windows/system32/kernel32.dll" ]; then pass=$((pass + 1))
else failed+=("bottle sem system32"); fi
check "cmd /c ver" "Windows" cmd /c ver
check "TLS: certificado válido" "^OK" "$TB/tlstest.exe" dl.winehq.org /wine/
check "TLS: certificado inválido recusado" "^OK" "$TB/tlstest.exe" --reject self-signed.badssl.com /
check "Fontes (FreeType)" "^OK" "$TB/fonttest.exe"
check "HTML 64-bit (Gecko)" "^OK" "$TB/htmltest.exe"
check "HTML 32-bit (Gecko)" "^OK" "$TB/htmltest32.exe"
# O .NET é testado com o compilador da própria bottle (vem no Wine Mono).
cp "$T/dotnettest.cs" "$TB/dotnettest.cs"
rm -f "$TB/dotnettest.exe"
check "C# compila (csc do Mono)" "" 'C:\windows\Microsoft.NET\Framework\v4.0.30319\csc.exe' \
  -nologo "-out:$(winpath "$TB/dotnettest.exe")" "$(winpath "$TB/dotnettest.cs")"
check ".NET executa (Mono)" "^OK" "$TB/dotnettest.exe"
check "Vulkan (MoltenVK)" "^OK" "$TB/vktest.exe"
# cabextract: o .cab vem do cabarc do Wine, com um conteúdo que muda a cada vez.
token="cabextract-ok-$RANDOM$RANDOM"
printf '%s\n' "$token" > "$TB/cabtest.txt"
rm -f "$TB/cabtest.cab"
check "cabarc cria um .cab" "" cabarc -m mszip N "$(winpath "$TB/cabtest.cab")" "$(winpath "$TB/cabtest.txt")"
check_cmd "cabextract abre o .cab" "^$token\$" "$RT/bin/cabextract" -p "$TB/cabtest.cab"
# winetricks: um verbo que só grava no registro, sem download. bgr grava a
# orientação 0; o padrão do Wine é 1 (RGB), então o 0 só aparece se ele rodou.
winetricks_env
rm -rf "$TB/cache" "$TB/config"
check_cmd "winetricks fontsmooth=bgr" "" "${WINETRICKS_ENV[@]}" "$RT/share/winetricks/winetricks" -q fontsmooth=bgr
check "winetricks gravou o registro" "FontSmoothingOrientation +REG_DWORD +0x0([^0-9a-fA-F]|$)" \
  reg query 'HKCU\Control Panel\Desktop' /v FontSmoothingOrientation
for backend in wined3d dxvk dxmt; do
  use_backend $backend
  check "D3D11 64-bit / $backend" "backend: $backend" "$TB/d3d11test.exe"
  check "D3D11 32-bit / $backend" "backend: $backend" "$TB/d3d11test32.exe"
done
wine_env "$RT/bin/wineserver" -k 2>/dev/null || true

echo
if [ ${#failed[@]} -eq 0 ]; then
  log "Todos os $pass testes passaram."
else
  warn "$pass passaram; falharam: ${failed[*]}"
  exit 1
fi
