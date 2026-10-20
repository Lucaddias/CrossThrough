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
	@if [ -d /Applications/CrossOver.app/Contents/Resources ]; then \
		cp -R /Applications/CrossOver.app/Contents/Resources $(APP_BUNDLE)/Contents/; \
	fi
	@if [ -f /Applications/CrossOver.app/Contents/Info.plist ]; then \
		cp /Applications/CrossOver.app/Contents/Info.plist $(APP_BUNDLE)/Contents/; \
	fi
	@echo "App bundle created at $(APP_BUNDLE)"

clean:
	rm -rf build

.PHONY: all app clean
