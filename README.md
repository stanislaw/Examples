# Example

[Terminfo: left arrow is mapped to backspace code (8) on default OSX terminal. Why is it so? And how to change it?](http://stackoverflow.com/questions/34319160/terminfo-left-arrow-is-mapped-to-backspace-code-8-on-default-osx-terminal-wh)

- Start Raw Terminal (Xcode project in this branch)
- send "c" key two times
- send left arrow key two times
- send "d" two times
- send enter

```objective-c
Terminal *terminal = [Terminal new];

[terminal start];

sleep(1); // for terminal to read prompt

NSString *string1_twoLettersCC = @"cc";
NSString *string2_leftArrow_2x = @"\033[D\033[D";
NSString *string3_twoLettersDD = @"dd";
NSString *string4_LF           = @"\n";

NSData *data;

data = [string1_twoLettersCC dataUsingEncoding:NSUTF8StringEncoding];
[terminal sendData:data];

data = [string2_leftArrow_2x dataUsingEncoding:NSUTF8StringEncoding];
[terminal sendData:data];

data = [string3_twoLettersDD dataUsingEncoding:NSUTF8StringEncoding];
[terminal sendData:data];

data = [string4_LF dataUsingEncoding:NSUTF8StringEncoding];
[terminal sendData:data];

[[NSRunLoop currentRunLoop] run];
```

Bash maintains state correctly but codes that it returns for the above sequence of keys is quite confusing.

Output:

```
Inspecting data (length: 10) :b a s h - 3 . 2 $   
Inspecting data (length: 16) :c c 8 8 d c c 8 8 d c c 8 8 13 10 
Inspecting data (length: 31) :b a s h :   d d c c :   c o m m a n d   n o t   f o u n d 13 10 
Inspecting data (length: 10) :b a s h - 3 . 2 $   
```


