//
//  TTY.h
//  RawTerminal
//
//  Created by Stanislaw Pankevich on 20/12/15.
//  Copyright © 2015 Stanislaw Pankevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTY : NSObject

@property (readonly, nonatomic) NSString *name;

@property (readonly, nonatomic) NSFileHandle *masterFileHandle;
@property (readonly, nonatomic) NSFileHandle *slaveFileHandle;

@end
