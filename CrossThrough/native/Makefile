# Makefile — reconstruções nativas do backend do CrossOver 26.3
#
# wineloader : o carregador do Wine (dlopen ntdll.so + __wine_main).
#              Compilado para x86_64 para casar com o alvo (bin/wineloader é
#              thin x86_64). Em Apple Silicon corre sob Rosetta 2.
# server-demo: a camada cliente de socket + passagem de fd do wineserver,
#              com auto-verificação (SCM_RIGHTS) que corre na arquitetura nativa.

CC       = xcrun clang
CFLAGS   = -O2 -Wall -Wextra -Wno-unused-parameter
BUILD    = build

all: $(BUILD)/wineloader $(BUILD)/server-demo

# Carregador: mesmo alvo que o binário enviado (x86_64).
$(BUILD)/wineloader: loader/wineloader.c
	@mkdir -p $(BUILD)
	$(CC) $(CFLAGS) -arch x86_64 $< -o $@
	@echo "OK: $@ (x86_64; corre sob Rosetta em Apple Silicon)"

# Demo da camada de socket/fd: arquitetura nativa, para correr o self-test.
$(BUILD)/server-demo: server/wine_server.c server/wine_server.h
	@mkdir -p $(BUILD)
	$(CC) $(CFLAGS) -DWINE_SERVER_DEMO server/wine_server.c -o $@
	@echo "OK: $@"

# Compila a camada de socket como objeto de biblioteca (sem main).
$(BUILD)/wine_server.o: server/wine_server.c server/wine_server.h
	@mkdir -p $(BUILD)
	$(CC) $(CFLAGS) -c server/wine_server.c -o $@

check: $(BUILD)/server-demo
	@./$(BUILD)/server-demo

clean:
	rm -rf $(BUILD)

.PHONY: all check clean
