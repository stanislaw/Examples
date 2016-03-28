# Reentrant parser with Flex and Bison

> flex has the ability to generate a reentrant C scanner. This is accomplished by specifying %option reentrant (‘-R’) The generated scanner is both portable, and safe to use in one or more separate threads of control. The most common use for reentrant scanners is from within multi-threaded applications. Any thread may create and execute a reentrant flex scanner without the need for synchronization with other threads. 

from [19 Reentrant C Scanners](http://flex.sourceforge.net/manual/Reentrant.html).

## Fast clone command

```
git clone git@github.com:stanislaw/Examples.git --branch 20160328-reentrant-parser-with-flex-and-bison --single-branch 20160328-reentrant-parser-with-flex-and-bison

```

## Setup

- Xcode 7, Objective-C, Flex and Bison

- `bin/` folder contains latest Flex and Bison binaries obtained using homebrew because default OSX bison is 2006 old. See also [What is the reason for some of the Linux tools on OS X being so old? Is this related to GPL licensing?](https://www.quora.com/What-is-the-reason-for-some-of-the-Linux-tools-on-OS-X-being-so-old-Is-this-related-to-GPL-licensing).

- Parser generation is written in Makefile and thus happens outside of Xcode. The make invocation is included to Xcode project as Run Script Build Phase.

