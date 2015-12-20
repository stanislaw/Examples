//
//  Terminal.h
//  RawTerminal
//
//  Created by Stanislaw Pankevich on 20/12/15.
//  Copyright © 2015 Stanislaw Pankevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TerminalClient <NSObject>

@end

@interface Terminal : NSObject

- (void)start;

- (void)sendData:(NSData *)data;

@end
