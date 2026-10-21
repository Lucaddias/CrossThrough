# Makefile for CrossThrough
# Converts reverse-engineered CrossOver 26.3 code into a compilable macOS app

CC = xcrun clang
# CrossOver 26.3 is built for macOS 11.0 against the 15.1 SDK; AppKit picks its
# control and title bar styling from the linked SDK version, so match it.
MIN_MACOS = 11.0
LINKED_SDK = 15.1
CFLAGS = -O2 -x objective-c \
         -mmacosx-version-min=$(MIN_MACOS) \
         -Wno-deprecated-declarations \
         -Wno-objc-designated-initializers \
         -Wno-objc-missing-super-calls \
         -I src/Headers \
         -I src/include \
         -F /Applications/CrossOver.app/Contents/Frameworks

LDFLAGS = -F /Applications/CrossOver.app/Contents/Frameworks \
          -mmacosx-version-min=$(MIN_MACOS) \
          -Wl,-platform_version,macos,$(MIN_MACOS),$(LINKED_SDK) \
          -framework Cocoa \
          -framework Security \
          -framework SecurityFoundation \
          -framework SystemConfiguration \
          -framework WebKit \
          -framework Sparkle \
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
ICON_MASK = /Applications/CrossOver.app/Contents/Resources/app-icon-roundrect-mask.png
ICON_PNG = resources/icon/CrossThrough-1024.png
ICON = resources/icon/CrossThrough.icns

# Sidebar logo (light and dark, 1x and 2x); `make logo` regenerates it.
LOGO_DIR = resources/logo

INSTALL_DIR ?= /Applications
LSREGISTER = /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister

all: $(TARGET)

$(TARGET): $(OBJS)
	@mkdir -p build
	@echo "Linking $(TARGET)..."
	$(CC) $(LDFLAGS) $(OBJS) -o $(TARGET)
	@echo "Build successful: $(TARGET)"

build/obj/main.o: src/main.m
	@mkdir -p build/obj
	$(CC) $(CFLAGS) -c $< -o $@

build/obj/c_functions.o: src/c_functions.m
	@mkdir -p build/obj
	$(CC) $(CFLAGS) -c $< -o $@

build/obj/%.o: src/classes/%.m
	@mkdir -p build/obj
	$(CC) $(CFLAGS) -c $< -o $@

app: $(TARGET)
	@echo "Packaging $(APP_BUNDLE)..."
	@mkdir -p $(APP_BUNDLE)/Contents/MacOS
	@mkdir -p $(APP_BUNDLE)/Contents/Frameworks
	@cp $(TARGET) $(APP_BUNDLE)/Contents/MacOS/CrossThrough
	@ln -sf CrossThrough $(APP_BUNDLE)/Contents/MacOS/CrossOver
	@if [ -d /Applications/CrossOver.app/Contents/Frameworks ]; then \
		cp -R /Applications/CrossOver.app/Contents/Frameworks/ $(APP_BUNDLE)/Contents/Frameworks/; \
	fi
	@if [ -d /Applications/CrossOver.app/Contents/SharedSupport ]; then \
		rm -rf $(APP_BUNDLE)/Contents/SharedSupport; \
		ln -sf /Applications/CrossOver.app/Contents/SharedSupport $(APP_BUNDLE)/Contents/SharedSupport; \
	fi
	@if [ -d /Applications/CrossOver.app/Contents/Resources ]; then \
		cp -R /Applications/CrossOver.app/Contents/Resources $(APP_BUNDLE)/Contents/; \
	fi
	@if [ -f /Applications/CrossOver.app/Contents/Info.plist ]; then \
		cp /Applications/CrossOver.app/Contents/Info.plist $(APP_BUNDLE)/Contents/; \
		/usr/libexec/PlistBuddy -c "Set :CFBundleExecutable CrossThrough" $(APP_BUNDLE)/Contents/Info.plist 2>/dev/null || true; \
		/usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier com.crossthrough.app" $(APP_BUNDLE)/Contents/Info.plist 2>/dev/null || true; \
		/usr/libexec/PlistBuddy -c "Set :CFBundleName CrossThrough" $(APP_BUNDLE)/Contents/Info.plist 2>/dev/null || true; \
		/usr/libexec/PlistBuddy -c "Delete :CFBundleDisplayName" $(APP_BUNDLE)/Contents/Info.plist 2>/dev/null || true; \
		/usr/libexec/PlistBuddy -c "Add :CFBundleDisplayName string CrossThrough" $(APP_BUNDLE)/Contents/Info.plist 2>/dev/null || true; \
		cp $(ICON) $(APP_BUNDLE)/Contents/Resources/CrossThrough.icns; \
		cp $(LOGO_DIR)/*.png $(APP_BUNDLE)/Contents/Resources/; \
		/usr/libexec/PlistBuddy -c "Set :CFBundleIconFile CrossThrough" $(APP_BUNDLE)/Contents/Info.plist 2>/dev/null || true; \
		/usr/libexec/PlistBuddy -c "Delete :CFBundleIconName" $(APP_BUNDLE)/Contents/Info.plist 2>/dev/null || true; \
	fi
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

# Everyday copy in $(INSTALL_DIR), without the test tools. It drops the
# document types, URL schemes and exported file types inherited from
# CrossOver's Info.plist, so CrossOver keeps opening .exe, .c4p and CrossTie
# links.
install: app
	rm -rf $(INSTALL_DIR)/CrossThrough.app
	ditto $(APP_BUNDLE) $(INSTALL_DIR)/CrossThrough.app
	rm -f $(addprefix $(INSTALL_DIR)/CrossThrough.app/Contents/MacOS/, test_wizard test_misc snapshot_ui download_probe)
	for key in CFBundleDocumentTypes CFBundleURLTypes UTExportedTypeDeclarations; do \
		/usr/libexec/PlistBuddy -c "Delete :$$key" $(INSTALL_DIR)/CrossThrough.app/Contents/Info.plist 2>/dev/null || true; \
	done
	find $(INSTALL_DIR)/CrossThrough.app -not -type l -print0 | xargs -0 xattr -c
	@# codesign rejects links that leave the bundle: seal it without the
	@# SharedSupport link to CrossOver, then put the link back.
	rm $(INSTALL_DIR)/CrossThrough.app/Contents/SharedSupport
	codesign -f -s - $(INSTALL_DIR)/CrossThrough.app
	ln -s /Applications/CrossOver.app/Contents/SharedSupport $(INSTALL_DIR)/CrossThrough.app/Contents/SharedSupport
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

build/obj/download_probe.o: tests/download_probe.m
	@mkdir -p build/obj
	$(CC) $(CFLAGS) -c $< -o $@

build/obj/snapshot_ui.o: tests/snapshot_ui.m
	@mkdir -p build/obj
	$(CC) $(CFLAGS) -c $< -o $@

build/obj/test_misc.o: tests/test_misc.m
	@mkdir -p build/obj
	$(CC) $(CFLAGS) -c $< -o $@

build/obj/test_wizard.o: tests/test_wizard.m
	@mkdir -p build/obj
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: all app clean icon logo install test test-misc snapshot probe
