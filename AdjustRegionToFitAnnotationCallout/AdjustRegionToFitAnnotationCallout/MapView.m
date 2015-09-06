//
//  MapView.m
//  AdjustRegionToFitAnnotationCallout
//
//  Created by Stanislaw Pankevich on 17/12/13.
//  Copyright (c) 2013 Stanislaw Pankevich. All rights reserved.
//

#import "MapView.h"

static inline CGRect CGRectTransformToContainRect(CGRect rectToTransform, CGRect rectToContain) {
    CGFloat diff;
    CGRect transformedRect = rectToTransform;


    // Transformed rect dimensions should encompass the dimensions of both rects
    transformedRect.size.width = MAX(CGRectGetWidth(rectToTransform), CGRectGetWidth(rectToContain));
    transformedRect.size.height = MAX(CGRectGetHeight(rectToTransform), CGRectGetHeight(rectToContain));


    // Comparing max X borders of both rects, adjust if
    if ((diff = CGRectGetMaxX(rectToContain) - CGRectGetMaxX(transformedRect)) > 0) {
        transformedRect.origin.x += diff;
    }
    // Comparing min X borders of both rects, adjust if
    else if ((diff = CGRectGetMinX(transformedRect) - CGRectGetMinX(rectToContain)) > 0) {
        transformedRect.origin.x -= diff;
    }


    // Comparing right borders of both rects, adjust if
    if ((diff = CGRectGetMaxY(rectToContain) - CGRectGetMaxY(transformedRect)) > 0) {
        transformedRect.origin.y += diff;
    }
    // Comparing left borders of both rects, adjust if
    else if ((diff = CGRectGetMinY(transformedRect) - CGRectGetMinY(rectToContain)) > 0) {
        transformedRect.origin.y -= diff;
    }


    return transformedRect;
}

@implementation MapView

- (void)adjustToContainAnnotationView:(AnnotationView *)annotationView animated:(BOOL)animated {
    // I just like this assert here
    NSParameterAssert(annotationView);

    CGRect annotationRect = [self convertRect:annotationView.annotationViewWithCalloutViewFrame toView:self];

    CGRect visibleRect = [self convertRegion:self.region toRectToView:self];

    CGRect adjustedRect = CGRectTransformToContainRect(visibleRect, annotationRect);

    MKCoordinateRegion adjustedRegion = [self convertRect:adjustedRect toRegionFromView:self];

    [self setRegion:[self regionThatFits:adjustedRegion] animated:animated];
}

@end
