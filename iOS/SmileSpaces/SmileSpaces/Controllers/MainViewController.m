//
//  MainViewController.m
//  SmileSpaces
//
//  Created by Pedro Piñera Buendía on 03/09/13.
//  Copyright (c) 2013 Trobi. All rights reserved.
//

#import "MainViewController.h"
#import "UIButton+PPiAwesome.h"
#import "Zone.h"
#import "feelingDetailViewController.h"
#define mapSpan 0.1
@interface MainViewController ()
@property (strong, nonatomic) IBOutlet ADClusterMapView *mapView;
@property (strong, nonatomic) IBOutlet UIButton *locationButton, *infoButton, *feelButton;
@property (nonatomic, strong) NSArray *zonesArray;
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
    
    //Downloading points
    [self downloadZones];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //Set the navigation bar hidden
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)initializeAll{
    
    //Mapview Initialize
    self.mapView = [[ADClusterMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.mapView setDelegate:self];
    [self.view addSubview:self.mapView];
    [self.view sendSubviewToBack:self.mapView];
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setUserTrackingMode:MKUserTrackingModeNone];
    
    //Centering in london
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = mapSpan;
    span.longitudeDelta = mapSpan;
    CLLocationCoordinate2D location=CLLocationCoordinate2DMake(51.508449, -0.120850);
    region.span = span;
    region.center = location;
    [self.mapView setRegion:region animated:YES];
    
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
    
    //Customizing navigation Bar
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor midnightBlueColor]];

    
}
#pragma mark - Actions
-(IBAction)centerUserMap:(id)sender{
    [self.mapView setRegion:MKCoordinateRegionMake(self.mapView.userLocation.coordinate, MKCoordinateSpanMake(0.01, 0.01)) animated:YES];

}
-(IBAction)addFeeling:(id)sender{
    // Opening add feeling View Controller to add a new Feeling
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                             bundle: nil];
    
    UIViewController *controller = (UIViewController*)[mainStoryboard
                                                       instantiateViewControllerWithIdentifier: @"addFeeling"];
    [self.navigationController pushViewController:controller animated:YES];

    
}

#pragma mark - Server
-(void)downloadZones{
    //Showing SVProgressHUD
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Loading", nil)];
    
    
    AFHTTPClient *client=[[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://trobi.me/"]];
    [client getPath:@"api/1/Cell/City/1" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Zones: %@",operation.responseString);
        @try{
            //Getting the points and updating MapView
            NSArray *array=[NSJSONSerialization JSONObjectWithData:operation.responseData options:kNilOptions error:nil][@"results"];
            NSMutableArray *pins=[NSMutableArray array];
            for (NSDictionary *zone in array){
                Zone *newZone=[[Zone alloc] initWithDict:zone];
                [pins addObject:newZone];
            }
            self.zonesArray=pins;
            
            //Updating mapView with PINS
            [self updateMapView];
        }
        @catch (NSException *e) {
            
        }
        @finally {
            //Dismiss SVProgressHUD
            [SVProgressHUD dismiss];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //Dismiss SVProgressHUD
        [SVProgressHUD dismiss];
    }];
}
-(void)updateMapView{
    //Reload mapview annotations
    [self.mapView setAnnotations:self.zonesArray];
}

#pragma mark - ADClusterMapViewDelegate
/**
 *	This method return the annotation View for a given Annotation
 *
 *	@param	mapView	mapView where annotations are going to be shown
 *	@param	annotation	annotation to be attached to a view
 *
 *	@return	the annotation view of the given annotation
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    MKAnnotationView * pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"ADClusterableAnnotation"];
    
    if (!pinView) {
        pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                               reuseIdentifier:@"ADClusterableAnnotation"];
    }
    else {
        pinView.annotation = annotation;
        
        pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                               reuseIdentifier:@"ADClusterableAnnotation"];
    }
    
    //Getting the zone linked and depending on the smileValue we set an icon or another
    // SMILE FACE   //
    //--------------//
    
    Zone *zoneAnnotation = [[[(ADClusterAnnotation *)annotation cluster] annotation] annotation];
    if (zoneAnnotation.smileValue.intValue>=0 && zoneAnnotation.smileValue.intValue<25) {
        pinView.image = [UIImage imageNamed:@"VUnhappyAnnotation.png"];
        
    }else if (zoneAnnotation.smileValue.intValue>=25 && zoneAnnotation.smileValue.intValue<50) {
        pinView.image = [UIImage imageNamed:@"UnhappyAnnotation.png"];
        
    }else if (zoneAnnotation.smileValue.intValue>=50 && zoneAnnotation.smileValue.intValue<75) {
        pinView.image = [UIImage imageNamed:@"HappyAnnotation.png"];
        
    }else if (zoneAnnotation.smileValue.intValue>=75 && zoneAnnotation.smileValue.intValue<100) {
        pinView.image = [UIImage imageNamed:@"VHappyAnnotation.png"];
        
    }
    pinView.canShowCallout = NO;
    return pinView;
}

/**
 *	This method return the annotation View for a given Annotation
 *
 *	@param	mapView	mapView where annotations are going to be shown
 *	@param	annotation	annotation to be attached to a view
 *
 *	@return	the annotation view of the given annotation
 */
- (MKAnnotationView *)mapView:(ADClusterMapView *)mapView viewForClusterAnnotation:(id<MKAnnotation>)annotation {
    
    
    MKAnnotationView * pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"ADMapCluster"];
    if (!pinView) {
        pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                               reuseIdentifier:@"ADMapCluster"];
    }            
    else {
        pinView.annotation = annotation;
        
        pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                               reuseIdentifier:@"ADClusterableAnnotation"];
    }
    //Calculating the average of origina annotations
    NSArray *annotations = [[(ADClusterAnnotation *)annotation cluster] originalAnnotations];
    float average=0;
    int total =0;
    for (ADMapPointAnnotation *zone in annotations){
        average+=[((Zone*)zone.annotation).smileValue intValue];
        total++;
    }
    average=average/total;
    if (average>=0 && average<25) {
        pinView.image = [UIImage imageNamed:@"VUnhappyAnnotation.png"];
        
    }else if (average>=25 && average<50) {
        pinView.image = [UIImage imageNamed:@"UnhappyAnnotation.png"];
        
    }else if (average>=50 && average<75) {
        pinView.image = [UIImage imageNamed:@"HappyAnnotation.png"];
        
    }else if (average>=75 && average<100) {
        pinView.image = [UIImage imageNamed:@"VHappyAnnotation.png"];
        
    }
    pinView.canShowCallout = NO;

    return pinView;
}



- (void)mapViewDidFinishClustering:(ADClusterMapView *)mapView {
    NSLog(@"Done");
}

- (NSInteger)numberOfClustersInMapView:(ADClusterMapView *)mapView {
    return 50;
}

- (double)clusterDiscriminationPowerForMapView:(ADClusterMapView *)mapView {
    return 1.0;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if(![view.annotation isKindOfClass:[MKUserLocation class]]) {
        [mapView setCenterCoordinate:[[view annotation] coordinate] animated:YES];
        
        //Callout para paradas normales
        if ([view.reuseIdentifier isEqualToString:@"ADClusterableAnnotation"]) {
            //We get the zone associated to the annotation
            //Generate detailViewController of this zone
            //Show its information in a more detailed way
            
            ADClusterAnnotation *annotation = (ADClusterAnnotation*)[view annotation];
            Zone *zone = [[[(ADClusterAnnotation *) annotation cluster] annotation] annotation];
            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                                     bundle: nil];
            
            feelingDetailViewController *controller = (feelingDetailViewController*)[mainStoryboard
                                                               instantiateViewControllerWithIdentifier: @"feelingDetail"];
            //Setting the properties to the ViewController
            controller.zoneId=zone.zoneId;
            controller.zoneDict=zone.zoneDict;
            
            //Presenting
            [self.navigationController pushViewController:controller animated:YES];
            
            //Callout para Clusters
        }else if([view.reuseIdentifier isEqualToString:@"ADMapCluster"]){
            //The annotation is a cluster ( of other annotations )
            [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"getCloserMap", nil)];
        }
    }
    
}

-(IBAction)centerMapInUser{
    [self.mapView setRegion:MKCoordinateRegionMake(self.mapView.userLocation.coordinate, MKCoordinateSpanMake(0.01, 0.01)) animated:YES];
}
#pragma mark - Lazy instantiation
-(NSArray*)zonesArray{
    if(!_zonesArray) _zonesArray=[[NSArray alloc] init];
    return _zonesArray;
}
@end
