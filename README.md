# How to join two pieces of one token that are obtained from two consequent portions of input?

Original StackOverflow topic: [How to join two pieces of one token that are obtained from two consequent portions of input?](http://stackoverflow.com/questions/36242886/how-to-join-two-pieces-of-one-token-that-are-obtained-from-two-consequent-portio).

Fast clone command:

```
git clone git@github.com:stanislaw/Examples.git --branch 20160322-flex-contigous-input --single-branch 20160322-flex-contigous-input
```

## Problem

Lexer panics at partial unfinished token "FO" (should be FOO) (first commit: "Initial problem")

```
--accepting rule at line 22 ("FOO")
--accepting rule at line 26 (" ")
--accepting rule at line 22 ("FOO")
--accepting rule at line 26 (" ")
--accepting rule at line 22 ("FOO")
--accepting rule at line 26 (" ")
--(end of buffer or a NUL)
--accepting default rule ("F")
flex scanner jammed
Program ended with exit code: 2
```

## Solution

Lexer handles partial tokens correctly when custom YY_INPUT macros is used (second commit: "Endless input parsing using custom YY_INPUT")

```
--(end of buffer or a NUL)
--accepting rule at line 25 ("FOO")
--accepting rule at line 29 (" ")
--(end of buffer or a NUL)
--accepting rule at line 25 ("FOO")
--accepting rule at line 29 (" ")
--accepting rule at line 25 ("FOO")
--(end of buffer or a NUL)
--accepting rule at line 25 ("FOO")
--accepting rule at line 29 (" ")
--(end of buffer or a NUL)
--accepting rule at line 25 ("FOO")
--accepting rule at line 29 (" ")
--accepting rule at line 25 ("FOO")
--(end of buffer or a NUL)
--accepting rule at line 25 ("FOO")
--accepting rule at line 29 (" ")
--(end of buffer or a NUL)
--accepting rule at line 25 ("FOO")
--accepting rule at line 29 (" ")
--accepting rule at line 25 ("FOO")
--(end of buffer or a NUL)
--accepting rule at line 25 ("FOO")
--accepting rule at line 29 (" ")
```

