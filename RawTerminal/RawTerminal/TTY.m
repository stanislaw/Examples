//
//  TTY.m
//  RawTerminal
//
//  Created by Stanislaw Pankevich on 20/12/15.
//  Copyright © 2015 Stanislaw Pankevich. All rights reserved.
//

#import "TTY.h"

#import <util.h>

@interface TTY ()

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSFileHandle *masterFileHandle;
@property (strong, nonatomic) NSFileHandle *slaveFileHandle;

@end

@implementation TTY

- (id)init {
    if (self = [super init]) {
        int masterfd, slavefd;
        char devname[64];

        if (openpty(&masterfd, &slavefd, devname, NULL, NULL) == -1) {
            [NSException raise:@"OpenPtyErrorException"
                        format:@"%s", strerror(errno)];
        }

        _name = [[NSString alloc] initWithCString:devname encoding:NSUTF8StringEncoding];

        _slaveFileHandle = [[NSFileHandle alloc] initWithFileDescriptor:slavefd
                                                         closeOnDealloc:YES];

        _masterFileHandle = [[NSFileHandle alloc] initWithFileDescriptor:masterfd
                                                          closeOnDealloc:YES];
    }
    
    return self;
}

@end
