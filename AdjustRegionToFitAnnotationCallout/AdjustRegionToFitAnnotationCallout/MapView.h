//
//  MapView.h
//  AdjustRegionToFitAnnotationCallout
//
//  Created by Stanislaw Pankevich on 17/12/13.
//  Copyright (c) 2013 Stanislaw Pankevich. All rights reserved.
//

#import <MapKit/MapKit.h>

#import "AnnotationView.h"

@interface MapView : MKMapView

@property (strong, nonatomic) AnnotationView *selectedAnnotationView;

- (void)adjustToContainAnnotationView:(AnnotationView *)annotationView animated:(BOOL)animated;

@end

