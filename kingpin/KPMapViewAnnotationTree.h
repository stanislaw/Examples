//
//  KPMapViewAnnotationTree.h
//  kingpin
//
//  Created by Stanislaw Pankevich on 10/02/16.
//  Copyright © 2016 smahmood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface KPMapViewAnnotationTree : NSObject

@property (strong, readonly, nonatomic) NSSet *annotations;

- (id)initWithAnnotations:(NSArray *)annotations;
- (NSArray *)annotationsInMapRect:(MKMapRect)rect;

@end
