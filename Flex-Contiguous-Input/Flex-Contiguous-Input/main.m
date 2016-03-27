//
//  main.m
//  Flex-Contiguous-Input
//
//  Created by Stanislaw Pankevich on 27/03/16.
//  Copyright © 2016 Stanislaw Pankevich. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "y.tab.h"

int readInputForLexer( char *buffer, int *numBytesRead, int maxBytesToRead );

typedef struct yy_buffer_state * YY_BUFFER_STATE;

extern int yyparse();
extern YY_BUFFER_STATE yy_scan_string(const char * str);
extern void yy_delete_buffer(YY_BUFFER_STATE buffer);

extern int yydebug;

int readInputForLexer(char *buffer, int *numBytesRead, int maxBytesToRead) {
    static int Flip = 0;

    if ((Flip++ % 2) == 0) {
        strcpy(buffer, "FOO F");

        *numBytesRead = 5; // IMPORTANT: this is 5, not 6, to cut off \0 so that Flex asks for more input
    } else {
        strcpy(buffer, "OO FOO");
        *numBytesRead = 6; // IMPORTANT: this is 6, not 7, to cut off \0 so that Flex asks for more input
    }

    return 0;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        yyparse();
    }
    return 0;
}
