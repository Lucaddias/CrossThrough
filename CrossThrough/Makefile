# Makefile for CrossThrough
# Converts reverse-engineered CrossOver 26.3 code into a compilable macOS app

CC = xcrun clang
CFLAGS = -O2 -x objective-c \
         -Wno-deprecated-declarations \
         -Wno-objc-designated-initializers \
         -Wno-objc-missing-super-calls \
         -I src/Headers \
         -I src/include \
         -F /Applications/CrossOver.app/Contents/Frameworks

LDFLAGS = -F /Applications/CrossOver.app/Contents/Frameworks \
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

build/obj/test_wizard.o: tests/test_wizard.m
	@mkdir -p build/obj
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: all app clean test
