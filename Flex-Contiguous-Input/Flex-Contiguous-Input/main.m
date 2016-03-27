//
//  main.m
//  Flex-Contiguous-Input
//
//  Created by Stanislaw Pankevich on 27/03/16.
//  Copyright © 2016 Stanislaw Pankevich. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "y.tab.h"

typedef struct yy_buffer_state * YY_BUFFER_STATE;

extern int yyparse();
extern YY_BUFFER_STATE yy_scan_string(const char * str);
extern void yy_delete_buffer(YY_BUFFER_STATE buffer);

int main(int argc, const char * argv[]) {
    @autoreleasepool {

        const char input[] = "FOO FOO FOO FO";

        YY_BUFFER_STATE yybuffer = yy_scan_string(input);
        yyparse();
        yy_delete_buffer(yybuffer);

    }
    return 0;
}
