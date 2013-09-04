//
//  addFeelingViewController.m
//  SmileSpaces
//
//  Created by Pedro Piñera Buendía on 03/09/13.
//  Copyright (c) 2013 Trobi. All rights reserved.
//

#import "feelingDetailViewController.h"
#import "RPRadarChart.h"
#import "DKLiveBlurView.h"
@interface feelingDetailViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *photosArray;
@property (nonatomic,strong) NSTimer *photosTimer;
@property (strong, nonatomic) DKLiveBlurView *imageView1;
@property (strong, nonatomic) DKLiveBlurView *imageView2;
@end

@implementation feelingDetailViewController

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
	
    //Customizing background color
    self.view.backgroundColor=[UIColor colorWithWhite:0.03 alpha:1.0];
    
    //Customizing blur effect
    self.imageView1=[[DKLiveBlurView alloc] initWithFrame: self.view.bounds];
    self.imageView2=[[DKLiveBlurView alloc] initWithFrame: self.view.bounds];
    [self.view addSubview:self.imageView1];
    [self.view addSubview:self.imageView2];
    [self.view sendSubviewToBack:self.imageView1];
    [self.view sendSubviewToBack:self.imageView2];
    self.imageView1.alpha=1.0;
    self.imageView2.alpha=0.0;
    self.imageView1.scrollView = self.tableView;
    self.imageView2.scrollView = self.tableView;
    self.imageView1.glassColor=[UIColor blackColor];
    self.imageView2.glassColor=[UIColor blackColor];
    self.imageView1.isGlassEffectOn = YES;
    self.imageView2.isGlassEffectOn = YES;
    
    //Starting the timer
    [self.photosTimer fire];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidUnload{
    [super viewDidUnload];
    
    //Stopping NSTimer
    [self.photosTimer invalidate];
}
#pragma mark - TableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 0;
    }else if ( section == 1){
        return 0;
    }else if ( section == 2){
        return 20;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section==0){
        UIView *headerView=[tableView dequeueReusableCellWithIdentifier:@"topHeader"];
        return headerView;
    }else if (section == 1){
        UITableViewCell *graphCell= [tableView dequeueReusableCellWithIdentifier:@"graphCell"];
        RPRadarChart *chart=(RPRadarChart*)[graphCell viewWithTag:1];
        if(!chart){
            chart = [[RPRadarChart alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width/2-[UIScreen mainScreen].bounds.size.width*0.3, [UIScreen mainScreen].bounds.size.width*0.6, [UIScreen mainScreen].bounds.size.width*0.6)];
            chart.tag=1;
            chart.showGuideNumbers=NO;
            chart.showValues=NO;
            chart.colors=@[[UIColor whiteColor],
                           [UIColor whiteColor],
                           [UIColor whiteColor],
                           [UIColor whiteColor],
                           [UIColor whiteColor],
                           [UIColor whiteColor],
                           [UIColor whiteColor],
                           [UIColor whiteColor],
                           ];
            chart.backgroundColor=[UIColor clearColor];
            [graphCell addSubview:chart];
        }
        chart.values = [NSDictionary dictionaryWithObjectsAndKeys:
                        [NSNumber numberWithFloat:10.0f],@"Health",
                        [NSNumber numberWithFloat:20.0f],@"Love",
                        [NSNumber numberWithFloat:30.0f],@"Beer",
                        [NSNumber numberWithFloat:40.0f],@"Friends",
                        [NSNumber numberWithFloat:50.0f],@"Party",
                        [NSNumber numberWithFloat:60.0f],@"More party",
                        nil];
        
        return graphCell;
    }else{
        return nil;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0 || indexPath.section==1){
        return nil;
    }else{
        return [tableView dequeueReusableCellWithIdentifier:@"basicDataCell"];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return [UIScreen mainScreen].bounds.size.height*0.5;
;
    }else if ( section == 1){
        return [UIScreen mainScreen].bounds.size.height*0.5;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

#pragma mark - Image Rotation
-(void)rotatePhoto{
    if(self.photosArray.count==0){
        return;
    }
    
    if(self.tableView.contentOffset.y>=100){
        return;
    }
    //Generating randonNumber
    int randomNumber=arc4random_uniform(self.photosArray.count);
    
    //Getting the photo dict
    NSDictionary *photoDict=self.photosArray[randomNumber];
    
    //Setting photo
    NSString *photoString=[NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_b.jpg",photoDict[@"_farm"],photoDict[@"_server"],photoDict[@"_id"],photoDict[@"_secret"]];
    
   
    __weak DKLiveBlurView *wi1=self.imageView1;
    __weak DKLiveBlurView *wi2=self.imageView2;
    
        NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:photoString]];
        if(self.imageView1.alpha==0){
            [self.imageView1 setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                [wi1 setOriginalImage:image];
                [UIView animateWithDuration:0.9 animations:^{
                    wi2.alpha=0.0;
                    wi1.alpha=1.0;

                }];
            } failure:nil];
        }else{
            [self.imageView2 setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                [wi2 setOriginalImage:image];
                [UIView animateWithDuration:0.9 animations:^{
                    wi2.alpha=1.0;
                    wi1.alpha=0.0;
                }];
            } failure:nil];
        }
    
}
#pragma mark - Lazy instantiation
-(NSTimer*)photosTimer{
    if(!_photosTimer)_photosTimer=[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(rotatePhoto) userInfo:nil repeats:YES];
    return _photosTimer;
}
-(NSArray*)photosArray{
    if(!_photosArray){
        _photosArray=[NSArray array];
        
        //Starts downloading
        NSDictionary *params=@{@"method": @"flickr.photos.search",
                               @"api_key":flickr_api_key,
                               @"content_type":@"1", //Only photos
                               @"lat":@"51.503024",
                               @"lon":@"0.003390",
                               @"accuracy":@"14",
                               @"geo_context":@"2",//Outdoors
                               @"per_page":@"100"}; 
        AFHTTPClient *client=[[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://ycpi.api.flickr.com/services/rest/"]];
        [client getPath:nil parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Photographs downloaded");
            NSDictionary *photosDict=[NSDictionary dictionaryWithXMLString:operation.responseString];
            NSLog(@"Photos: %@",photosDict);
            
            //Extracting photo in the array
            if(photosDict[@"photos"] && photosDict[@"photos"][@"photo"] && photosDict[@"photos"][@"photo"]){
                self.photosArray=photosDict[@"photos"][@"photo"];
            }

            //Calling photo rotation
            [self rotatePhoto];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error getting photographs");
        }];
        
        
    }
    return _photosArray;
}
@end
