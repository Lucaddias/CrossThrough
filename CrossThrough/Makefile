# Makefile for CrossThrough
# Converts reverse-engineered CrossOver 26.3 code into a compilable macOS app.
#
# Etapa 1 da independência: o build não aponta mais para
# /Applications/CrossOver.app. Os frameworks que ligamos (Python embarcado)
# vêm de vendor/Frameworks, populado por vendor/setup.sh. O Sparkle saiu:
# não há atualização pela rede, e ligamos com src/classes/SparkleCompat.m.
#
# O backend ainda compartilhado (SharedSupport: Wine, Python, Perl) e os
# recursos de interface (Resources: nibs, ícones) continuam vindo de um
# CrossOver instalado, só no empacotamento (make app) — são as etapas 2 a 5.
# Troque CROSSOVER_APP para apontar outra instalação, se precisar.

CC = xcrun clang

VENDOR ?= vendor
FRAMEWORKS ?= $(VENDOR)/Frameworks
CROSSOVER_APP ?= /Applications/CrossOver.app
PYTHON_FRAMEWORK = $(FRAMEWORKS)/Python.framework

CFLAGS = -O2 -x objective-c \
         -Wno-deprecated-declarations \
         -Wno-objc-designated-initializers \
         -Wno-objc-missing-super-calls \
         -I src/Headers \
         -I src/include \
         -F $(FRAMEWORKS)

LDFLAGS = -F $(FRAMEWORKS) \
          -framework Cocoa \
          -framework Security \
          -framework SecurityFoundation \
          -framework SystemConfiguration \
          -framework WebKit \
          -framework Python \
          -rpath @loader_path/../Frameworks \
          -rpath @executable_path/../Frameworks

SRC_CLASSES = $(wildcard src/classes/*.m)
OBJS = build/obj/main.o build/obj/c_functions.o $(patsubst src/classes/%.m, build/obj/%.o, $(SRC_CLASSES))
TARGET = build/CrossThrough
APP_BUNDLE = build/CrossThrough.app

all: $(TARGET)

# Garante o Python.framework vendorizado antes de compilar/ligar.
$(PYTHON_FRAMEWORK):
	@echo "Python.framework ausente em $(FRAMEWORKS); rodando vendor/setup.sh..."
	@CROSSOVER_APP="$(CROSSOVER_APP)" bash $(VENDOR)/setup.sh

vendor: $(PYTHON_FRAMEWORK)

$(TARGET): $(PYTHON_FRAMEWORK) $(OBJS)
	@mkdir -p build
	@echo "Linking $(TARGET)..."
	$(CC) $(LDFLAGS) $(OBJS) -o $(TARGET)
	@echo "Build successful: $(TARGET)"

build/obj/main.o: src/main.m | $(PYTHON_FRAMEWORK)
	@mkdir -p build/obj
	$(CC) $(CFLAGS) -c $< -o $@

build/obj/c_functions.o: src/c_functions.m | $(PYTHON_FRAMEWORK)
	@mkdir -p build/obj
	$(CC) $(CFLAGS) -c $< -o $@

build/obj/%.o: src/classes/%.m | $(PYTHON_FRAMEWORK)
	@mkdir -p build/obj
	$(CC) $(CFLAGS) -c $< -o $@

app: $(TARGET)
	@echo "Packaging $(APP_BUNDLE)..."
	@mkdir -p $(APP_BUNDLE)/Contents/MacOS
	@mkdir -p $(APP_BUNDLE)/Contents/Frameworks
	@cp $(TARGET) $(APP_BUNDLE)/Contents/MacOS/CrossThrough
	@ln -sf CrossThrough $(APP_BUNDLE)/Contents/MacOS/CrossOver
	@echo "Copiando frameworks vendorizados..."
	@cp -R $(FRAMEWORKS)/ $(APP_BUNDLE)/Contents/Frameworks/
	@echo "Instalando Info.plist próprio..."
	@cp src/Info.plist $(APP_BUNDLE)/Contents/Info.plist
	@if [ -d $(CROSSOVER_APP)/Contents/SharedSupport ]; then \
		rm -rf $(APP_BUNDLE)/Contents/SharedSupport; \
		ln -sf $(CROSSOVER_APP)/Contents/SharedSupport $(APP_BUNDLE)/Contents/SharedSupport; \
	else \
		echo "aviso: SharedSupport (backend/Wine) não encontrado em $(CROSSOVER_APP); o app compila mas não roda bottles."; \
	fi
	@if [ -d $(CROSSOVER_APP)/Contents/Resources ]; then \
		cp -R $(CROSSOVER_APP)/Contents/Resources $(APP_BUNDLE)/Contents/; \
	else \
		echo "aviso: Resources (nibs/ícones) não encontrados em $(CROSSOVER_APP); a interface não carregará."; \
	fi
	@xattr -cr $(APP_BUNDLE)/Contents/MacOS 2>/dev/null || true
	@xattr -d com.apple.FinderInfo $(APP_BUNDLE) 2>/dev/null || true
	@codesign -f -s - $(TARGET) 2>/dev/null || true
	@codesign -f -s - $(APP_BUNDLE) 2>/dev/null || true
	@echo "App bundle created and signed at $(APP_BUNDLE)"

clean:
	rm -rf build

test: app build/obj/test_wizard.o
	@echo "Linking $(APP_BUNDLE)/Contents/MacOS/test_wizard..."
	$(CC) $(LDFLAGS) build/obj/test_wizard.o $(filter-out build/obj/main.o, $(OBJS)) -o $(APP_BUNDLE)/Contents/MacOS/test_wizard
	@echo "Running test_wizard inside app bundle..."
	@./$(APP_BUNDLE)/Contents/MacOS/test_wizard

build/obj/test_wizard.o: tests/test_wizard.m | $(PYTHON_FRAMEWORK)
	@mkdir -p build/obj
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: all app clean test vendor
