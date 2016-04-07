//
//  main.m
//  Reentrant-Parser-Using-Flex-and-Bison
//
//  Created by Stanislaw Pankevich on 28/03/16.
//  Copyright © 2016 Stanislaw Pankevich. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ParserConsumer.h"

#import "parser.h"
#import "lexer.h"

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

        yyscan_t scanner;

        if (yylex_init(&scanner)) {
            perror("yylex_init error");
        }

        char input[] = "RAINBOW UNICORN 1234 UNICORN garbage garbage";

        yy_scan_string(input, scanner);

        yyparse(scanner, parserConsumer);

        yylex_destroy(scanner);
    }

    return 0;
}
