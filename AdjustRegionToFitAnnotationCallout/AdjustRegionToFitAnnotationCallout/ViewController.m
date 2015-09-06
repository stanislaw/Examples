//
//  ViewController.m
//  AdjustRegionToFitAnnotationCallout
//
//  Created by Stanislaw Pankevich on 17/12/13.
//  Copyright (c) 2013 Stanislaw Pankevich. All rights reserved.
//

#import "ViewController.h"

#import "Annotation.h"
#import "AnnotationView.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect mapFrame = self.view.bounds;
    //mapFrame.origin.y = 20;
    //mapFrame.size.height = 460;
    MapView *mapView = [[MapView alloc] initWithFrame:mapFrame];
    
    mapView.region = [mapView regionThatFits:MKCoordinateRegionMakeWithDistance([self MoscowLocationKuzminki].coordinate, 50000, 50000)];
    mapView.delegate = self;

    [self.view addSubview:mapView];

    for (int i = 0; i < 10; i++) {
        CLLocation *randomCoordinate = [self randomLocation];

        Annotation *annotation = [[Annotation alloc] init];
        annotation.coordinate = randomCoordinate.coordinate;

        [mapView addAnnotation:annotation];
    }

    self.mapView = mapView;
}

#pragma mark 
#pragma mark <MKMapViewDelegate>

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *annotationIdentifier = @"Annotation";
    if ([annotation isKindOfClass:[Annotation class]]) {
        AnnotationView *annotationView = (AnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];

        if (annotationView == nil) {
            annotationView = [[AnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
        } else {
            annotationView.annotation = annotation;
        }

        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MapView *)mapView didSelectAnnotationView:(AnnotationView *)view {

    // AnnotationPresenter is just a class that contains information to be displayed on callout annotation view
    if ([view.annotation isKindOfClass:[Annotation class]]) {
        // Hide another annotation if it is shown
        if (mapView.selectedAnnotationView != nil && [mapView.selectedAnnotationView isKindOfClass:[AnnotationView class]] && mapView.selectedAnnotationView != view) {
            [mapView.selectedAnnotationView hideCalloutBubble];
            mapView.selectedAnnotationView = nil;
        }
        mapView.selectedAnnotationView = view;

        // This just adds *calloutView* as a subview
        [view showCalloutBubble];

        [mapView adjustToContainAnnotationView:view animated:YES];
    }
}

- (void)mapView:(MapView *)mapView didDeselectAnnotationView:(AnnotationView *)view {
    if ([view.annotation isKindOfClass:[Annotation class]]) {
        [view hideCalloutBubble];
        self.mapView.selectedAnnotationView = nil;
    }
}

#pragma mark 
#pragma mark Private

- (CLLocation *)randomLocation {
    double (^random_double_with_range)(double min, double max) = ^(double min, double max) {
        unsigned long precision = 10000000;
        return ((double)arc4random_uniform(((max - min) * precision)))/precision + min;
    };

    CLLocationCoordinate2D SWNEBoxes[2] = { CLLocationCoordinate2DMake(55.576792, 37.395973), CLLocationCoordinate2DMake(55.911118, 37.836113) }; // Moscow

    CLLocationDegrees randomCityLatitude = random_double_with_range(SWNEBoxes[0].latitude, SWNEBoxes[1].latitude);
    CLLocationDegrees randomCityLongitude = random_double_with_range(SWNEBoxes[0].longitude, SWNEBoxes[1].longitude);

    return [[CLLocation alloc] initWithLatitude:randomCityLatitude longitude:randomCityLongitude];
}

- (CLLocation *)MoscowLocationKuzminki {
    return [[CLLocation alloc] initWithLatitude:55.699102 longitude:37.743183];
}


@end
