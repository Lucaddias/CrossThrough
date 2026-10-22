# Makefile for CrossThrough
# Converts reverse-engineered CrossOver 26.3 code into a compilable macOS app.
#
# Etapa 1 da independência: o build não aponta para /Applications/CrossOver.app.
# O Python embarcado vem de vendor/Frameworks (vendor/setup.sh) e o Sparkle saiu
# do link (src/classes/SparkleCompat.m). O branding (ícone/logo, nome) e o backend
# ainda compartilhado (SharedSupport, Resources) são aplicados no empacotamento.

CC = xcrun clang
# CrossOver 26.3 is built for macOS 11.0 against the 15.1 SDK; AppKit picks its
# control and title bar styling from the linked SDK version, so match it.
MIN_MACOS = 11.0
LINKED_SDK = 15.1

VENDOR ?= vendor
FRAMEWORKS ?= $(VENDOR)/Frameworks
CROSSOVER_APP ?= /Applications/CrossOver.app
PYTHON_FRAMEWORK = $(FRAMEWORKS)/Python.framework

CFLAGS = -O2 -x objective-c \
         -mmacosx-version-min=$(MIN_MACOS) \
         -Wno-deprecated-declarations \
         -Wno-objc-designated-initializers \
         -Wno-objc-missing-super-calls \
         -I src/Headers \
         -I src/include \
         -F $(FRAMEWORKS)

LDFLAGS = -F $(FRAMEWORKS) \
          -mmacosx-version-min=$(MIN_MACOS) \
          -Wl,-platform_version,macos,$(MIN_MACOS),$(LINKED_SDK) \
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

# App icon: the controller art on a black macOS icon shape. `make icon`
# regenerates the PNG and the .icns from ICON_SOURCE.
ICON_SOURCE = resources/icon/controller.webp
ICON_MASK = $(CROSSOVER_APP)/Contents/Resources/app-icon-roundrect-mask.png
ICON_PNG = resources/icon/CrossThrough-1024.png
ICON = resources/icon/CrossThrough.icns

# Sidebar logo (light and dark, 1x and 2x); `make logo` regenerates it.
LOGO_DIR = resources/logo

INSTALL_DIR ?= /Applications
LSREGISTER = /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister

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
	@echo "Instalando Info.plist próprio e o branding..."
	@cp src/Info.plist $(APP_BUNDLE)/Contents/Info.plist
	@if [ -f $(ICON) ]; then cp $(ICON) $(APP_BUNDLE)/Contents/Resources/CrossThrough.icns; fi
	@if ls $(LOGO_DIR)/*.png >/dev/null 2>&1; then cp $(LOGO_DIR)/*.png $(APP_BUNDLE)/Contents/Resources/; fi
	@/usr/libexec/PlistBuddy -c "Set :CFBundleIconFile CrossThrough" $(APP_BUNDLE)/Contents/Info.plist 2>/dev/null || true
	@/usr/libexec/PlistBuddy -c "Delete :CFBundleIconName" $(APP_BUNDLE)/Contents/Info.plist 2>/dev/null || true
	@/usr/libexec/PlistBuddy -c "Add :CFBundleDisplayName string CrossThrough" $(APP_BUNDLE)/Contents/Info.plist 2>/dev/null || true
	@xattr -cr $(APP_BUNDLE)/Contents/MacOS 2>/dev/null || true
	@xattr -d com.apple.FinderInfo $(APP_BUNDLE) 2>/dev/null || true
	@codesign -f -s - $(TARGET) 2>/dev/null || true
	@codesign -f -s - $(APP_BUNDLE) 2>/dev/null || true
	@echo "App bundle created and signed at $(APP_BUNDLE)"

clean:
	rm -rf build

icon:
	swift tools/make_icon.swift $(ICON_SOURCE) $(ICON_MASK) $(ICON_PNG)
	rm -rf build/CrossThrough.iconset && mkdir -p build/CrossThrough.iconset
	for size in 16 32 128 256 512; do \
		sips -z $$size $$size $(ICON_PNG) --out build/CrossThrough.iconset/icon_$${size}x$${size}.png >/dev/null; \
		sips -z $$((size * 2)) $$((size * 2)) $(ICON_PNG) --out build/CrossThrough.iconset/icon_$${size}x$${size}@2x.png >/dev/null; \
	done
	iconutil -c icns build/CrossThrough.iconset -o $(ICON)

logo:
	swift tools/make_logo.swift $(ICON_SOURCE) $(LOGO_DIR)

# Everyday copy in $(INSTALL_DIR), without the test tools. Como o CrossThrough já
# tem Info.plist próprio, não precisa remover tipos herdados.
install: app
	rm -rf $(INSTALL_DIR)/CrossThrough.app
	ditto $(APP_BUNDLE) $(INSTALL_DIR)/CrossThrough.app
	rm -f $(addprefix $(INSTALL_DIR)/CrossThrough.app/Contents/MacOS/, test_wizard test_misc snapshot_ui download_probe)
	find $(INSTALL_DIR)/CrossThrough.app -not -type l -print0 | xargs -0 xattr -c
	@# codesign rejects links that leave the bundle: seal it without the
	@# SharedSupport link to CrossOver, then put the link back.
	rm $(INSTALL_DIR)/CrossThrough.app/Contents/SharedSupport
	codesign -f -s - $(INSTALL_DIR)/CrossThrough.app
	ln -s $(CROSSOVER_APP)/Contents/SharedSupport $(INSTALL_DIR)/CrossThrough.app/Contents/SharedSupport
	@# ditto keeps the build bundle's dates; a fresh one makes Finder and the
	@# Dock drop the cached icon.
	touch $(INSTALL_DIR)/CrossThrough.app
	$(LSREGISTER) -f $(INSTALL_DIR)/CrossThrough.app
	@echo "Installed $(INSTALL_DIR)/CrossThrough.app"

test: app build/obj/test_wizard.o test-misc
	@echo "Linking $(APP_BUNDLE)/Contents/MacOS/test_wizard..."
	$(CC) $(LDFLAGS) build/obj/test_wizard.o $(filter-out build/obj/main.o, $(OBJS)) -o $(APP_BUNDLE)/Contents/MacOS/test_wizard
	@echo "Running test_wizard inside app bundle..."
	@./$(APP_BUNDLE)/Contents/MacOS/test_wizard

test-misc: app build/obj/test_misc.o
	$(CC) $(LDFLAGS) build/obj/test_misc.o $(filter-out build/obj/main.o, $(OBJS)) -o $(APP_BUNDLE)/Contents/MacOS/test_misc
	@echo "Running test_misc inside app bundle..."
	@./$(APP_BUNDLE)/Contents/MacOS/test_misc

snapshot: app build/obj/snapshot_ui.o
	$(CC) $(LDFLAGS) build/obj/snapshot_ui.o $(filter-out build/obj/main.o, $(OBJS)) -o $(APP_BUNDLE)/Contents/MacOS/snapshot_ui
	@./$(APP_BUNDLE)/Contents/MacOS/snapshot_ui build/snapshots $(SNAPSHOT_PACKAGE)

# Lists the install engine tasks for $(PROBE_PACKAGE); PROBE_ARGS=--download
# also fetches its first download.
probe: app build/obj/download_probe.o
	$(CC) $(LDFLAGS) build/obj/download_probe.o $(filter-out build/obj/main.o, $(OBJS)) -o $(APP_BUNDLE)/Contents/MacOS/download_probe
	@./$(APP_BUNDLE)/Contents/MacOS/download_probe $(PROBE_PACKAGE) $(PROBE_ARGS)

build/obj/download_probe.o: tests/download_probe.m | $(PYTHON_FRAMEWORK)
	@mkdir -p build/obj
	$(CC) $(CFLAGS) -c $< -o $@

build/obj/snapshot_ui.o: tests/snapshot_ui.m | $(PYTHON_FRAMEWORK)
	@mkdir -p build/obj
	$(CC) $(CFLAGS) -c $< -o $@

build/obj/test_misc.o: tests/test_misc.m | $(PYTHON_FRAMEWORK)
	@mkdir -p build/obj
	$(CC) $(CFLAGS) -c $< -o $@

build/obj/test_wizard.o: tests/test_wizard.m | $(PYTHON_FRAMEWORK)
	@mkdir -p build/obj
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: all app clean icon logo install test test-misc snapshot probe vendor
