//
//  Shell.h
//  RawTerminal
//
//  Created by Stanislaw Pankevich on 20/12/15.
//  Copyright © 2015 Stanislaw Pankevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTY;

@interface Shell : NSObject

@property (readonly, nonatomic) int processIdentifier;

- (instancetype)initWithTTY:(TTY *)tty;

- (void)launch;

@end
