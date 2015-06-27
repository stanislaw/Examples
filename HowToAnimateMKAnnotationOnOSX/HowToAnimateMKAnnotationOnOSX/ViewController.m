//
//  ViewController.m
//  HowToAnimateMKAnnotationOnOSX
//
//  Created by Stanislaw Pankevich on 27/06/15.
//  Copyright (c) 2015 Stanislaw Pankevich. All rights reserved.
//

#import <MapKit/MapKit.h>

#import "ViewController.h"

@interface Annotation : NSObject <MKAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@end

@implementation Annotation
@end

@interface ViewController () <MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.mapView.delegate = self;

    CLLocationCoordinate2D NYC         = CLLocationCoordinate2DMake(40.77, -73.98);
    CLLocationCoordinate2D destination = CLLocationCoordinate2DMake(NYC.latitude + 5, NYC.longitude + 5);

    Annotation *annotation = [Annotation new];
    annotation.coordinate = NYC;

    [self.mapView addAnnotation:annotation];
    self.mapView.centerCoordinate = NYC;

    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = 10;

        annotation.coordinate = destination;
    } completionHandler:^{
        NSLog(@"Animation complete");
    }];
}

@end
