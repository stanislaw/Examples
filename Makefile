CC:=/opt/llvm-5.0.0/bin/clang
CFLAGS:=-O0 -g -flto -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk # with -flto the results look weird
# CFLAGS:=-O0 -g -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk # without -flto the results look consistent

run: compile
	./main

compile: clean
	$(CC) $(CFLAGS) -c lib.c -o lib.o
	$(CC) -shared lib.o -o libStan.dylib
	$(CC) $(CFLAGS) -L./ -lStan main.c -o main

clean:
	rm -rfv *.o
	rm -rfv *.dylib
	rm -rfv main
