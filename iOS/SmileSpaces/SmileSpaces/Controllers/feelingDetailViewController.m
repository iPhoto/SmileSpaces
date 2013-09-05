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
#import "animatedProgress.h"

@interface feelingDetailViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *photosArray;
@property (nonatomic,strong) NSTimer *photosTimer;
@property (strong, nonatomic) DKLiveBlurView *imageView1;
@property (strong, nonatomic) DKLiveBlurView *imageView2;
@property (nonatomic) NSInteger currentAccuracy;
@property (nonatomic,strong) NSArray *sectionsColors;
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
    self.view.backgroundColor=[UIColor colorWithWhite:0.90 alpha:1.0];
    
    //Set the navigation bar hidden
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title=NSLocalizedString(@"zoneDetail", nil);
    
    //Setting currentAccuracy to initial Value
    self.currentAccuracy=16;
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
    
}
#pragma mark - TableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1: // Cultural & sports
            return 6;
            break;
        case 2:
            return 5; // Environment
            break;
        case 3:
            return 1; // Opinion
            break;
        case 4:
            return 3; // Security
            break;
        case 5:
            return 7; // Services & Health
            break;
        default:
            break;
    }
    
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section ==0 && indexPath.row ==0){
        UITableViewCell *graphCell= [tableView dequeueReusableCellWithIdentifier:@"graphCell"];
        RPRadarChart *chart=(RPRadarChart*)[graphCell viewWithTag:1];
        if(!chart){
            chart = [[RPRadarChart alloc] initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width)];
            chart.tag=1;
            chart.showGuideNumbers=NO;
            chart.showValues=NO;
            chart.triangleColors    = self.sectionsColors;
            chart.backgroundColor=[UIColor clearColor];
            chart.dotColor=[UIColor whiteColor];
            chart.lineColor=[UIColor whiteColor];


            
            [graphCell addSubview:chart];
            
        }
        
        chart.values=@[
                       @[@"Cultural",[NSNumber numberWithFloat:10.0f]],
                       @[@"Environ.",[NSNumber numberWithFloat:20.0f]],
                       @[@"Opinion",[NSNumber numberWithFloat:30.0f]],
                       @[@"Security",[NSNumber numberWithFloat:40.0f]],
                       @[@"Services",[NSNumber numberWithFloat:50.0f]],
                       ];
        //Disable selection style
        graphCell.selectionStyle = UITableViewCellSelectionStyleNone;

        return graphCell;
    }else{
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"basicDataCell"];
        cell.contentView.backgroundColor=[UIColor colorWithRed:24.0f/255 green:41.0f/255 blue:54.0f/255 alpha:1.0];
        
        //Setting the color of section
        UIView *sectionColor=(UIView*)[cell viewWithTag:1];
        sectionColor.backgroundColor=self.sectionsColors[indexPath.section-1];

        //Animated Progress
        animatedProgress *animated=(animatedProgress*)[cell viewWithTag:4];
        [animated setBackgroundColor:[UIColor colorWithRed:24.0f/255 green:41.0f/255 blue:54.0f/255 alpha:1.0]];
        [animated resetProgress];
        [animated setPercentage:0.5 withAnimation:YES andDuration:0.2];
        
        //Disable selection style
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section ==0 && indexPath.row ==0){
        // Chart cell
        return [UIScreen mainScreen].bounds.size.width;
    }else{
        // Basic cell
        return 49;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"titleCell"];
    UILabel *titleLabel=(UILabel*)[cell viewWithTag:1];
    titleLabel.text=@"";
    switch (section) {
        case 1: // Cultural & sports
            titleLabel.text=NSLocalizedString(@"Cultural&Sports", nil);
            break;
        case 2:
            titleLabel.text=NSLocalizedString(@"Environment", nil);
            break;
        case 3:
            titleLabel.text=NSLocalizedString(@"Opinion", nil);
            break;
        case 4:
            titleLabel.text=NSLocalizedString(@"Security", nil);
            break;
        case 5:
            titleLabel.text=NSLocalizedString(@"Services&Health", nil);
            break;
        default:
            break;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 0; //Graph header
    }else{
        return 44;
    }
}
#pragma mark - Lazy instantiation
-(NSArray*)sectionsColors{
    if(!_sectionsColors)
        _sectionsColors=@[
                          [UIColor colorWithRed:0.0f/255 green:194.0f/255 blue:229.0f/255 alpha:1.0],
                          [UIColor colorWithRed:53.0f/255 green:220.0f/255 blue:153.0f/255 alpha:1.0],
                          [UIColor colorWithRed:241.0f/255 green:192.0f/255 blue:72.0f/255 alpha:1.0],
                          [UIColor colorWithRed:241.0f/255 green:78.0f/255 blue:122.0f/255 alpha:1.0],
                          [UIColor colorWithRed:209.0f/255 green:109.0f/255 blue:216.0f/255 alpha:1.0],
                          ];
    return _sectionsColors;
}

@end
