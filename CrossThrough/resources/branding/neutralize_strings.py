#!/usr/bin/env python3
# neutralize_strings.py — "shippar nossos próprios Localizable.strings".
#
# O bundle copia os Resources do app de referência (vendor/Resources). Este
# passo reescreve, APENAS no LADO DO VALOR das entradas `.strings`, o nome de
# produto "CrossOver" -> "CrossThrough". A CHAVE é preservada (o código a usa na
# busca via localizedStringForKey:), assim como o nome da empresa (CodeWeavers),
# os domínios (crossover.codeweavers.com, minúsculo) e qualquer identificador
# com.codeweavers.CrossOver.*, que não aparecem no lado do valor como produto.
#
# Idempotente (rodar de novo não muda nada) e preserva a codificação (UTF-16 LE
# com BOM, como a Apple gera .strings).
#
# Uso: neutralize_strings.py <dir-de-Resources> [DE] [PARA]
#
# Nota: as linhas do resumo de instalação ("CrossOver will download/install...")
# NÃO estão aqui — vêm do motor CrossTie/backend (SharedSupport); neutralizá-las
# é trabalho da Fase 3.
import os
import re
import sys
import codecs

# "key" = "value";  (aspas escapadas dentro de cada string são respeitadas)
ENTRY = re.compile(r'("(?:[^"\\]|\\.)*")(\s*=\s*)("(?:[^"\\]|\\.)*")(\s*;)')


def read_text(path):
    data = open(path, "rb").read()
    if data.startswith(codecs.BOM_UTF16_LE) or data.startswith(codecs.BOM_UTF16_BE):
        return data.decode("utf-16"), "utf-16"
    if data.startswith(codecs.BOM_UTF8):
        return data.decode("utf-8-sig"), "utf-8-sig"
    try:
        return data.decode("utf-8"), "utf-8"
    except UnicodeDecodeError:
        return data.decode("utf-16"), "utf-16"


def write_text(path, text, enc):
    if enc == "utf-16":
        open(path, "wb").write(codecs.BOM_UTF16_LE + text.encode("utf-16-le"))
    elif enc == "utf-8-sig":
        open(path, "wb").write(codecs.BOM_UTF8 + text.encode("utf-8"))
    else:
        open(path, "wb").write(text.encode("utf-8"))


def main(resdir, src="CrossOver", dst="CrossThrough"):
    def rewrite(m):
        key, op, val, semi = m.group(1), m.group(2), m.group(3), m.group(4)
        return key + op + val.replace(src, dst) + semi

    changed = 0
    for root, _dirs, files in os.walk(resdir):
        if not root.endswith(".lproj"):
            continue
        for f in files:
            if not f.endswith(".strings"):
                continue
            p = os.path.join(root, f)
            try:
                text, enc = read_text(p)
            except Exception as e:  # noqa: BLE001
                print(f"  aviso: não li {p}: {e}", file=sys.stderr)
                continue
            new = ENTRY.sub(rewrite, text)
            if new != text:
                write_text(p, new, enc)
                changed += 1
    print(f"neutralize_strings: {changed} arquivo(s) .strings atualizado(s)")


if __name__ == "__main__":
    resdir = sys.argv[1] if len(sys.argv) > 1 else "."
    a = sys.argv[2] if len(sys.argv) > 2 else "CrossOver"
    b = sys.argv[3] if len(sys.argv) > 3 else "CrossThrough"
    main(resdir, a, b)
