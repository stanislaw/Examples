//
//  AnnotationView.m
//  AdjustRegionToFitAnnotationCallout
//
//  Created by Stanislaw Pankevich on 17/12/13.
//  Copyright (c) 2013 Stanislaw Pankevich. All rights reserved.
//

#import "AnnotationView.h"

@implementation AnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];

    self.frame = CGRectMake(0, 0, 32, 32);
    self.backgroundColor = [UIColor greenColor];
    
    return self;
}

- (void)showCalloutBubble {
    // This is a code where you create your custom annotation callout view
    // add add it using -[self addSubview:]
    // At the end of this method a callout view should be displayed.

    NSLog(@"Annotation selected , showing callout %@", self);

    [self addSubview:self.calloutView];
}

- (void)hideCalloutBubble {
    NSLog(@"Annotation deselected , hiding callout %@", self);

    [self.calloutView removeFromSuperview];
}

- (UIView *)calloutView {
    if (_calloutView == nil) {
        CGRect calloutFrame = CGRectZero;
        calloutFrame.size = self.annotationViewWithCalloutViewFrame.size;

        UIView *calloutView = [[UIView alloc] initWithFrame:calloutFrame];
        calloutView.backgroundColor = [UIColor grayColor];

        _calloutView = calloutView;
    }

    return _calloutView;
}

- (CGRect)annotationViewWithCalloutViewFrame {
    CGRect annotationViewWithCalloutViewFrame = self.frame;

    annotationViewWithCalloutViewFrame.size.width += CGRectGetWidth(self.frame) * 2;
    annotationViewWithCalloutViewFrame.size.height += CGRectGetHeight(self.frame) * 2;

    return annotationViewWithCalloutViewFrame;
}

@end
