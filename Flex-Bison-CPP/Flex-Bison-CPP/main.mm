//
//  main.m
//  Reentrant-Parser-Using-Flex-and-Bison
//
//  Created by Stanislaw Pankevich on 28/03/16.
//  Copyright © 2016 Stanislaw Pankevich. All rights reserved.
//

#include <Foundation/Foundation.h>

#include "ParserConsumer.h"

#include "parser.hpp"
#include "lexer.hpp"

extern YY_BUFFER_STATE yy_scan_string(const char * str);
extern void yy_delete_buffer(YY_BUFFER_STATE buffer);

@interface ParserConsumer : NSObject <ParserConsumer>
@end

@implementation ParserConsumer

- (void)parserDidParseString:(char *)string {
    printf("[Consumer, string] %s\n", string);
}

- (void)parserDidParseNumber:(int)number {
    printf("[Consumer: number] %d\n", number);
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        ParserConsumer *parserConsumer = [ParserConsumer new];

        char input[] = "RAINBOW UNICORN 1234 UNICORN";

        YY_BUFFER_STATE state = yy_scan_string(input);
        yyparse(parserConsumer);
        yy_delete_buffer(state);
    }

    return 0;
}
