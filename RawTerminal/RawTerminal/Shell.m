//
//  Shell.m
//  RawTerminal
//
//  Created by Stanislaw Pankevich on 20/12/15.
//  Copyright © 2015 Stanislaw Pankevich. All rights reserved.
//

#import "Shell.h"

#import "TTY.h"

@interface Shell ()

@property (readonly, nonatomic) TTY *tty;
@property (readonly, nonatomic) NSTask *task;

@end

@implementation Shell

- (instancetype)initWithTTY:(TTY *)tty {
    self = [super init];

    _tty = tty;

    _task = [self configureTask:[NSTask new]];

    return self;
}

#pragma mark -

- (int)processIdentifier {
    return self.task.processIdentifier;
}

#pragma mark -

- (void)launch {
    [self.task launch];
}

#pragma mark -

- (NSTask *)configureTask:(NSTask *)task {
    task.currentDirectoryPath = [@"~" stringByExpandingTildeInPath];

    task.launchPath = @"/bin/bash";

    task.arguments = @[];

    task.standardInput  = self.tty.slaveFileHandle;
    task.standardOutput = self.tty.slaveFileHandle;
    task.standardError  = self.tty.slaveFileHandle;

    task.terminationHandler = ^(NSTask *task) {
        exit(0);
    };
    
    return task;
}

@end
