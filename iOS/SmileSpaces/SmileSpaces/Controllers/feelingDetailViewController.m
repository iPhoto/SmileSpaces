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
    
    //Downloading information of zone
    [self getZoneInformation];
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
                       @[@"Cultural",@([self.zoneDict[@"felixCultural"] intValue])],
                       @[@"Environ.",@([self.zoneDict[@"felixEnvironment"] intValue])],
                       @[@"Opinion",@([self.zoneDict[@"felixOpinion"] intValue])],
                       @[@"Security",@([self.zoneDict[@"felixSecurity"] intValue])],
                       @[@"Services",@([self.zoneDict[@"felixServices"] intValue])],
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

        //Reset Progress
        animatedProgress *animated=(animatedProgress*)[cell viewWithTag:4];
        [animated setBackgroundColor:[UIColor colorWithRed:24.0f/255 green:41.0f/255 blue:54.0f/255 alpha:1.0]];
        [animated resetProgress];
        
        //Disable selection style
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        /**
         *	Assigning Values
         */
        UILabel *valueLabel=(UILabel*)[cell viewWithTag:3];
        UILabel *titleLabel=(UILabel*)[cell viewWithTag:2];

        //Museums
        if(indexPath.section==1 && indexPath.row ==0){ //Museums
            NSDictionary* museums;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"Museos"]){
                    museums=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"Museums", nil);
            if(museums){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[museums[@"value"] intValue]];
                [animated setPercentage:[museums[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
               valueLabel.text=@"";
                return cell;
            }
        }
        
        //Sport centers
        if(indexPath.section==1 && indexPath.row ==1){ //Sports centers
            NSDictionary* SportsCenters;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"SportsCenters"]){
                    SportsCenters=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"SportsCenters", nil);
            if(SportsCenters){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[SportsCenters[@"value"] intValue]];
                [animated setPercentage:[SportsCenters[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        //Bookshops
        if(indexPath.section==1 && indexPath.row ==2){
            NSDictionary* Bookshops;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"Librerias"]){
                    Bookshops=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"Bookshops", nil);
            if(Bookshops){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[Bookshops[@"value"] intValue]];
                [animated setPercentage:[Bookshops[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        //Theaters
        if(indexPath.section==1 && indexPath.row ==3){
            NSDictionary* Theaters;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"Teatros"]){
                    Theaters=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"Theaters", nil);
            if(Theaters){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[Theaters[@"value"] intValue]];
                [animated setPercentage:[Theaters[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        //TouristAttractions
        if(indexPath.section==1 && indexPath.row ==4){
            NSDictionary* TouristAttractions;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"TouristAttractions"]){
                    TouristAttractions=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"TouristAttractions", nil);
            if(TouristAttractions){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[TouristAttractions[@"value"] intValue]];
                [animated setPercentage:[TouristAttractions[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        //leisureAreas
        if(indexPath.section==1 && indexPath.row ==5){
            NSDictionary* leisureAreas;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"LocalesOcio"]){
                    leisureAreas=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"leisureAreas", nil);
            if(leisureAreas){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[leisureAreas[@"value"] intValue]];
                [animated setPercentage:[leisureAreas[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        //parks
        if(indexPath.section==2 && indexPath.row ==0){
            NSDictionary* parks;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"Parques"]){
                    parks=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"parks", nil);
            if(parks){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[parks[@"value"] intValue]];
                [animated setPercentage:[parks[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        //Gardens
        if(indexPath.section==2 && indexPath.row ==1){
            NSDictionary* gardens;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"Huertas"]){
                    gardens=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"gardens", nil);
            if(gardens){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[gardens[@"value"] intValue]];
                [animated setPercentage:[gardens[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        //Gardens
        if(indexPath.section==2 && indexPath.row ==1){
            NSDictionary* gardens;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"Huertas"]){
                    gardens=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"gardens", nil);
            if(gardens){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[gardens[@"value"] intValue]];
                [animated setPercentage:[gardens[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        //Ecological Footprint
        if(indexPath.section==2 && indexPath.row ==2){
            NSDictionary* ecologicalFootprint;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"HuellaEcologica"]){
                    ecologicalFootprint=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"ecologicalFootprint", nil);
            if(ecologicalFootprint){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[ecologicalFootprint[@"value"] intValue]];
                [animated setPercentage:[ecologicalFootprint[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        //CO2Emissions
        if(indexPath.section==2 && indexPath.row ==3){
            NSDictionary* CO2Emissions;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"CO2Emissions"]){
                    CO2Emissions=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"CO2Emissions", nil);
            if(CO2Emissions){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[CO2Emissions[@"value"] intValue]];
                [animated setPercentage:[CO2Emissions[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        //Noise
        if(indexPath.section==2 && indexPath.row ==4){
            NSDictionary* noise;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"ContaminacionRuido"]){
                    noise=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"noise", nil);
            if(noise){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[noise[@"value"] intValue]];
                [animated setPercentage:[noise[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        //Trees
        if(indexPath.section==2 && indexPath.row ==5){
            NSDictionary* Trees ;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"Arboles"]){
                    Trees=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"Trees", nil);
            if(Trees){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[Trees[@"value"] intValue]];
                [animated setPercentage:[Trees[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        //Noise
        if(indexPath.section==2 && indexPath.row ==5){
            NSDictionary* noise;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"ContaminacionRuido"]){
                    noise=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"noise", nil);
            if(noise){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[noise[@"value"] intValue]];
                [animated setPercentage:[noise[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        //HappySurveis
        if(indexPath.section==3 && indexPath.row ==0){
            NSDictionary* HappySurveis;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"HappySurveis"]){
                    HappySurveis=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"HappySurveis", nil);
            if(HappySurveis){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[HappySurveis[@"value"] intValue]];
                [animated setPercentage:[HappySurveis[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }

        //HappySurveis
        if(indexPath.section==3 && indexPath.row ==0){
            NSDictionary* HappySurveis;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"HappySurveis"]){
                    HappySurveis=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"HappySurveis", nil);
            if(HappySurveis){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[HappySurveis[@"value"] intValue]];
                [animated setPercentage:[HappySurveis[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        //Thefts
        if(indexPath.section==4 && indexPath.row ==0){
            NSDictionary* Thefts;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"Robos"]){
                    Thefts=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"Thefts", nil);
            if(Thefts){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[Thefts[@"value"] intValue]];
                [animated setPercentage:[Thefts[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        //Fires
        if(indexPath.section==4 && indexPath.row ==1){
            NSDictionary* Fires;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"Incencios"]){
                    Fires=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"Fires", nil);
            if(Fires){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[Fires[@"value"] intValue]];
                [animated setPercentage:[Fires[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        //Crime ratio
        if(indexPath.section==4 && indexPath.row ==2){
            NSDictionary* CrimeRatio;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"CrimeRatio"]){
                    CrimeRatio=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"CrimeRatio", nil);
            if(CrimeRatio){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[CrimeRatio[@"value"] intValue]];
                [animated setPercentage:[CrimeRatio[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        //Public toilets
        if(indexPath.section==5 && indexPath.row ==0){
            NSDictionary* PublicToilets;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"PublicToilets"]){
                    PublicToilets=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"PublicToilets", nil);
            if(PublicToilets){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[PublicToilets[@"value"] intValue]];
                [animated setPercentage:[PublicToilets[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        //Schools
        if(indexPath.section==5 && indexPath.row ==1){
            NSDictionary* schools;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"Schools"]){
                    schools=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"schools", nil);
            if(schools){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[schools[@"value"] intValue]];
                [animated setPercentage:[schools[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        //Suicide Rate
        if(indexPath.section==5 && indexPath.row ==2){
            NSDictionary* SuicideRate;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"SuicideRate"]){
                    SuicideRate=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"schools", nil);
            if(SuicideRate){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[SuicideRate[@"value"] intValue]];
                [animated setPercentage:[SuicideRate[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        //Hospitals
        if(indexPath.section==5 && indexPath.row ==3){
            NSDictionary* Hospitals;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"Hospitales"]){
                    Hospitals=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"Hospitals", nil);
            if(Hospitals){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[Hospitals[@"value"] intValue]];
                [animated setPercentage:[Hospitals[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        //Health Centers
        if(indexPath.section==5 && indexPath.row ==4){
            NSDictionary* HealthCenters;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"HealthCenters"]){
                    HealthCenters=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"HealthCenters", nil);
            if(HealthCenters){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[HealthCenters[@"value"] intValue]];
                [animated setPercentage:[HealthCenters[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        
        //Educative Centers
        if(indexPath.section==5 && indexPath.row ==5){
            NSDictionary* EducativeCenters;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"CentrosEducativos"]){
                    EducativeCenters=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"EducativeCenters", nil);
            if(EducativeCenters){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[EducativeCenters[@"value"] intValue]];
                [animated setPercentage:[EducativeCenters[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        //Educative Centers
        if(indexPath.section==5 && indexPath.row ==5){
            NSDictionary* EducativeCenters;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"CentrosEducativos"]){
                    EducativeCenters=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"EducativeCenters", nil);
            if(EducativeCenters){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[EducativeCenters[@"value"] intValue]];
                [animated setPercentage:[EducativeCenters[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
        //Railway Station
        if(indexPath.section==5 && indexPath.row ==6){
            NSDictionary* RailwayStation;
            for(NSDictionary *dict in self.zoneParameters){
                if([dict[@"dataType"] isEqualToString:@"RailwayStation"]){
                    RailwayStation=dict;
                    break;
                }
            }
            titleLabel.text=NSLocalizedString(@"EducativeCenters", nil);
            if(RailwayStation){
                valueLabel.text=[NSString stringWithFormat:@"%d%%",[RailwayStation[@"value"] intValue]];
                [animated setPercentage:[RailwayStation[@"value"] floatValue]/100 withAnimation:YES andDuration:0.1];
                return cell;
            }else{
                valueLabel.text=@"";
                return cell;
            }
        }
        
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
#pragma mark - ACtions
-(void)getZoneInformation{
    AFHTTPClient *client=[[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://trobi.me/"]];
    [client getPath:[NSString stringWithFormat:@"api/1/Data/%@",self.zoneId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Zones: %@",operation.responseString);
        @try{
            self.zoneParameters=[NSJSONSerialization JSONObjectWithData:operation.responseData options:kNilOptions error:nil][@"results"];
            [self.tableView reloadData];
        }
        @catch (NSException *e) {
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}
#pragma mark - Lazy instantiation
-(NSArray*)zoneParameters{
    if(!_zoneParameters)_zoneParameters=@[]; return _zoneParameters;
}
@end
