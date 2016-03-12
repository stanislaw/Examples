//
//  ViewController.m
//  ScrollableTextView
//
//  Created by Stanislaw Pankevich on 12/03/16.
//  Copyright © 2016 Stanislaw Pankevich. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGFloat margin = 20;

    NSRect scrollViewRect = NSMakeRect(
        margin,
        margin,
        self.view.bounds.size.width - margin * 2,
        self.view.bounds.size.height - margin * 2
    );

    NSScrollView *scrollview = [[NSScrollView alloc] initWithFrame:scrollViewRect];
    scrollview.backgroundColor = [[NSColor blueColor] colorWithAlphaComponent:0.2];
    scrollview.drawsBackground = YES;

    NSSize contentSize = [scrollview contentSize];

    scrollview.borderType = NSGrooveBorder;

    scrollview.hasVerticalScroller = YES;
    scrollview.hasHorizontalScroller = NO;

    scrollview.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;

    NSTextView *theTextView = [[NSTextView alloc] initWithFrame:scrollview.bounds];
    theTextView.drawsBackground = NO;

    theTextView.minSize = NSMakeSize(0.0, contentSize.height);
    theTextView.maxSize = NSMakeSize(CGFLOAT_MAX, CGFLOAT_MAX);

    theTextView.verticallyResizable = YES;
    theTextView.horizontallyResizable = NO;

    theTextView.autoresizingMask = NSViewWidthSizable;

    theTextView.textContainer.containerSize = NSMakeSize(contentSize.width, CGFLOAT_MAX);
    theTextView.textContainer.widthTracksTextView = YES;

    NSString *string = @"Once upon a time there was a little-known patent clerk in Bern who received a disappointing annual performance review in ’05";

    [theTextView insertText:string replacementRange:NSMakeRange(0, 0)];

    scrollview.documentView = theTextView;

    [self.view addSubview:scrollview];
}

@end
