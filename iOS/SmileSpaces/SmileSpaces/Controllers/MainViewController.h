//
//  MainViewController.h
//  SmileSpaces
//
//  Created by Pedro Piñera Buendía on 03/09/13.
//  Copyright (c) 2013 Trobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "PPiFlatSegmentedControl.h"
#import <ADClusterMapView.h>
#import "ADClusterAnnotation.h"

@interface MainViewController : UIViewController<ADClusterMapViewDelegate>
-(IBAction)centerMapInUser;
@end
