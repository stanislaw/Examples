//
//  TerminalLikeTextView.m
//  NSTextView-Terminal-Like-Clicks
//
//  Created by Stanislaw Pankevich on 22/03/16.
//  Copyright © 2016 Stanislaw Pankevich. All rights reserved.
//

#import "TerminalLikeTextView.h"

static const NSUInteger kCursorLocationSnapshotNotExists = NSUIntegerMax;

@interface TerminalLikeTextView () <NSTextViewDelegate>

@property (assign, nonatomic) NSUInteger cursorLocationSnapshot;
@property (assign, nonatomic) BOOL mouseDownFlag;

@end

@implementation TerminalLikeTextView

- (id)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];

    if (self == nil) return nil;

    self.mouseDownFlag = NO;
    self.cursorLocationSnapshot = kCursorLocationSnapshotNotExists;

    self.editable = YES;   // default
    self.selectable = YES; // default

    self.delegate = self;

    return self;
}

- (void)updateInsertionPointStateAndRestartTimer:(BOOL)flag {
    if (self.mouseDownFlag) {
        return;
    }

    [super updateInsertionPointStateAndRestartTimer:flag];
}

#pragma mark - NSTextView: Events

- (void)keyDown:(NSEvent *)event {
    NSString *characters = event.characters;

    [self insertTextToCurrentPosition:characters];
}

- (void)mouseDown:(NSEvent *)theEvent {
    self.mouseDownFlag = YES;

    [super mouseDown:theEvent];

    self.mouseDownFlag = NO;
}

#pragma mark - <NSTextViewDelegate>

- (NSRange)textView:(NSTextView *)textView willChangeSelectionFromCharacterRange:(NSRange)oldSelectedCharRange toCharacterRange:(NSRange)newSelectedCharRange {

    if (self.mouseDownFlag && self.cursorLocationSnapshot == kCursorLocationSnapshotNotExists) {
        self.cursorLocationSnapshot = oldSelectedCharRange.location;
    }

    return newSelectedCharRange;
}

#pragma mark - Insertion

- (void)insertTextToCurrentPosition:(NSString *)text {
    if (self.cursorLocationSnapshot != kCursorLocationSnapshotNotExists) {
        self.selectedRange = NSMakeRange(self.cursorLocationSnapshot, 0);
        self.cursorLocationSnapshot = kCursorLocationSnapshotNotExists;
    }

    [self insertText:text replacementRange:NSMakeRange(self.selectedRange.location, 0)];
}

@end
