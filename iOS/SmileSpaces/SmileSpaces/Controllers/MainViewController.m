//
//  MainViewController.m
//  SmileSpaces
//
//  Created by Pedro Piñera Buendía on 03/09/13.
//  Copyright (c) 2013 Trobi. All rights reserved.
//

#import "MainViewController.h"
#import "UIButton+PPiAwesome.h"

#define mapSpan 0.005
@interface MainViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIButton *locationButton, *infoButton, *feelButton;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //Initialize all necesary in MainViewController View
    [self initializeAll];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

-(void)initializeAll{
    //Location Button
    [self.locationButton setIsAwesome:YES];
    [self.locationButton setButtonIcon:@"icon-location-arrow"];
    [self.locationButton setButtonText:@"" ];
    [self.locationButton setTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor whiteColor]} forUIControlState:UIControlStateNormal];
    [self.locationButton setTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor whiteColor],@"IconFont":[UIFont fontWithName:@"FontAwesome" size:16]} forUIControlState:UIControlStateHighlighted];
    [self.locationButton setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.3] forUIControlState:UIControlStateNormal];
    [self.locationButton setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.5] forUIControlState:UIControlStateHighlighted];
    self.locationButton.frame=CGRectMake(10, 10, 44, 44);
    [self.locationButton setRadius:0.0];
    [self.locationButton addTarget:self action:@selector(centerUserMap:) forControlEvents:UIControlEventTouchUpInside];
    self.locationButton.layer.borderColor=[UIColor colorWithRed:0.0f/255 green:160.0f/255 blue:133.0f/255 alpha:0.1].CGColor;
    self.locationButton.layer.shadowRadius=1.0;
    self.locationButton.layer.shadowOpacity=1.0;
    self.locationButton.layer.shadowColor=[UIColor colorWithWhite:0.0 alpha:0.5].CGColor;
    self.locationButton.layer.shadowOffset=CGSizeMake(0, 1);
    self.locationButton.layer.borderWidth=0.5;
    [self.view addSubview:self.locationButton];
    
    //Feel Button
    [self.feelButton setIsAwesome:YES];
    [self.feelButton setButtonIcon:@"icon-heart"];
    [self.feelButton setIconPosition:IconPositionLeft];
    [self.feelButton setButtonText:@"Add feeling" ];
    [self.feelButton setTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor whiteColor],@"IconFont":[UIFont fontWithName:@"FontAwesome" size:16]} forUIControlState:UIControlStateNormal];
    [self.feelButton setTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor whiteColor],@"IconFont":[UIFont fontWithName:@"FontAwesome" size:16]} forUIControlState:UIControlStateHighlighted];

    [self.feelButton setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.3] forUIControlState:UIControlStateNormal];
    [self.feelButton setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.5] forUIControlState:UIControlStateHighlighted];
    self.feelButton.frame=CGRectMake(55, 10, 170, 44);
    [self.feelButton setRadius:0.0];
    [self.feelButton setSeparation:2];
    self.feelButton.layer.shadowRadius=1.0;
    self.feelButton.layer.shadowOpacity=1.0;
    self.feelButton.layer.shadowColor=[UIColor colorWithWhite:0.0 alpha:0.5].CGColor;
    self.feelButton.layer.shadowOffset=CGSizeMake(0, 1);
    self.feelButton.layer.borderColor=[UIColor colorWithRed:0.0f/255 green:160.0f/255 blue:133.0f/255 alpha:0.1].CGColor;
    [self.feelButton addTarget:self action:@selector(addFeeling:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.feelButton];
    
    //Map
    [self.mapView setShowsUserLocation:YES];
    self.mapView.delegate = self;

    
}
#pragma mark - Actions
-(IBAction)addFeeling:(id)sender{
    [self performSegueWithIdentifier:@"feelingDetail" sender:self];
}
-(IBAction)centerUserMap:(id)sender{
    [self mapView:self.mapView didUpdateUserLocation:self.mapView.userLocation];
}

#pragma mark - MapView Delegate
- (void)mapView:(MKMapView *)aMapView didUpdateUserLocation:(MKUserLocation *)aUserLocation {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = mapSpan;
    span.longitudeDelta = mapSpan;
    CLLocationCoordinate2D location;
    location.latitude = aUserLocation.coordinate.latitude;
    location.longitude = aUserLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [aMapView setRegion:region animated:YES];
}
@end
