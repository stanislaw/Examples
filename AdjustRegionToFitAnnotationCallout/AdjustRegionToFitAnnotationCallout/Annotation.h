//
//  Annotation.h
//  AdjustRegionToFitAnnotationCallout
//
//  Created by Stanislaw Pankevich on 17/12/13.
//  Copyright (c) 2013 Stanislaw Pankevich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface Annotation : NSObject <MKAnnotation>
@property (nonatomic) CLLocationCoordinate2D coordinate;
@end
