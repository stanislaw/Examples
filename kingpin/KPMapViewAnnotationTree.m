//
//  KPMapViewAnnotationTree.m
//  kingpin
//
//  Created by Stanislaw Pankevich on 10/02/16.
//  Copyright © 2016 smahmood. All rights reserved.
//

#import "KPMapViewAnnotationTree.h"

@interface KPMapViewAnnotationTree ()
@property (nonatomic, strong) MKMapView *mapView;
@end

@implementation KPMapViewAnnotationTree

- (id)initWithAnnotations:(NSArray *)annotations {
    self = [super init];

    if (self) {
        self.mapView = [[MKMapView alloc] initWithFrame:CGRectZero];

        [self.mapView addAnnotations:annotations];
    }

    return self;
}

- (NSArray *)annotationsInMapRect:(MKMapRect)rect {
    if (MKMapRectGetMaxX(rect) > MKMapRectWorld.size.width) {
        MKMapRect rectLeft = MKMapRectMake(
            rect.origin.x,
            rect.origin.y,
            MKMapRectWorld.size.width - rect.origin.x,
            rect.size.height
        );

        NSArray *annosLeft = [self.mapView annotationsInMapRect:rectLeft].allObjects;

        MKMapRect rectRight = MKMapRectMake(
                                           0,
                                           rect.origin.y,
                                           fmod(MKMapRectGetMaxX(rect), MKMapRectWorld.size.width),
                                           rect.size.height
                                           );
        NSArray *annosRight = [self.mapView annotationsInMapRect:rectRight].allObjects;

        return [annosLeft arrayByAddingObjectsFromArray:annosRight];
    }

    NSArray *annos = [self.mapView annotationsInMapRect:rect].allObjects;

    return annos;
}

- (NSSet *)annotations {
    return [NSSet setWithArray:self.mapView.annotations];
}

@end
