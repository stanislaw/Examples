//
//  main.m
//  RawTerminal
//
//  Created by Stanislaw Pankevich on 20/12/15.
//  Copyright © 2015 Stanislaw Pankevich. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Terminal.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
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
    }

    return 0;
}
