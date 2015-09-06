//
//  ViewController.h
//  AdjustRegionToFitAnnotationCallout
//
//  Created by Stanislaw Pankevich on 17/12/13.
//  Copyright (c) 2013 Stanislaw Pankevich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapView.h"

@interface ViewController : UIViewController <MKMapViewDelegate>
@property (strong, nonatomic) MapView *mapView;
@end
