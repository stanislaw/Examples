//
//  main.m
//  Xcode-Analyzer-Uninitialized-Value-Bug
//
//  Created by Stanislaw Pankevich on 15/06/15.
//  Copyright (c) 2015 Stanislaw Pankevich. All rights reserved.
//

#import <Foundation/Foundation.h>

int **Grid2DCreateRaw(NSUInteger gridSize) {
    if (gridSize == 0) {
        return NULL;
    }

    int **grid = malloc((gridSize + 2) * sizeof(int *));

    for (NSUInteger col = 0; col < (gridSize + 2); col++) {
        grid[col] = malloc((gridSize + 2) * sizeof(int));
    }

    memset(grid[0], 0, (gridSize + 2) * sizeof(int));

    return grid;
}

void Grid2DFree(int **grid, NSUInteger gridSize) {
    for (NSUInteger col = 0; col < (gridSize + 2); col++) {
        free(grid[col]);
    }
    free(grid);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSUInteger size = (NSUInteger)1.0; // analyzer warning appears

        // NSUInteger size = (NSUInteger)1; // analyzer warning does not appear

        int **grid = Grid2DCreateRaw(size);

        if (grid == NULL) {
            return 0;
        }

        Grid2DFree(grid, size);
    }
    
    return 0;
}
