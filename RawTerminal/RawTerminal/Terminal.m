//
//  Terminal.m
//  RawTerminal
//
//  Created by Stanislaw Pankevich on 20/12/15.
//  Copyright © 2015 Stanislaw Pankevich. All rights reserved.
//

#import "Terminal.h"

#import "TTY.h"
#import "Shell.h"

@interface Terminal ()

@property (strong, nonatomic) TTY *tty;
@property (strong, nonatomic) Shell *shell;

@end

@implementation Terminal

- (instancetype)init {
    self = [super init];

    TTY *tty = [[TTY alloc] init];
    self.tty = tty;

    self.shell = [[Shell alloc] initWithTTY:tty];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReadData:)
                                                 name:NSFileHandleReadCompletionNotification
                                               object:[self.tty masterFileHandle]];

    return self;
}

- (void)start {
    [self.shell launch];

    printf("Started with pid: %d\n", self.shell.processIdentifier);

    [[self.tty masterFileHandle] readInBackgroundAndNotify];
}

- (void)sendData:(NSData *)data {
    [self.tty.masterFileHandle writeData:data];
}

#pragma mark - Events

- (void)didReadData:(NSNotification *)notification {
    NSData *data = [[notification userInfo] objectForKey:NSFileHandleNotificationDataItem];

    if (data.length == 0) {
        return;
    }

    InspectData(data);
    
    [[notification object] readInBackgroundAndNotify];
}

static inline void InspectData(NSData *data) {
    char *bytes = (char *)data.bytes;

    printf("Inspecting data (length: %tu) :", data.length);

    for (int i = 0; i < data.length; i++) {
        char c = bytes[i];

        if (c == 27) {
            printf("ESC ");
        }

        else if (c >= 32 && c <= 126) {
            printf("%c ", (unsigned char)bytes[i]);
        }

        else {
            printf("%d ", (unsigned char)bytes[i]);
        }
    }
    
    printf("\n");
}

@end
