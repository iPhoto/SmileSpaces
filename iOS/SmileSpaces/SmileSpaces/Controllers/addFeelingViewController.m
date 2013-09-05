//
//  addFeelingViewController.m
//  SmileSpaces
//
//  Created by Pedro Piñera Buendía on 04/09/13.
//  Copyright (c) 2013 Trobi. All rights reserved.
//

#import "addFeelingViewController.h"
#import "ILColorPickerView.h"
#import "UIImage+FontAwesome.h"
#import "NSString+FontAwesome.h"
#import "AFImageRequestOperation.h"

#define table_header_height 44
#define table_footer_height 25

@interface addFeelingViewController ()
@property (nonatomic,strong) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *photosArray;
@end

@implementation addFeelingViewController

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
    self.view.backgroundColor=background_grey;
    
    //Set the navigation bar hidden
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
    //Setting the title
    self.title=NSLocalizedString(@"addFeeling", nil);
    
    
    //Adding FLAT bar button
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [button setBackgroundColor:[UIColor midnightBlueColor]];
    [button setTitle:NSLocalizedString(@"Back", nil) forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBack=[[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem=barBack;
    
}
-(void)back{
    // Going back
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{

}

#pragma mark - TableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        int total= 3;
        total += self.photosArray.count!=0?1:0; //If we've photos, we show it
        total += 1; //Title
        return total;
    }else if ( section == 1){
        // Social cells
        return 4;
    }
    else if ( section == 2){
        // Send Cell
        return 1;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, table_footer_height)];
    footerView.backgroundColor=[UIColor clearColor];
    return footerView;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ( indexPath.row==0 && indexPath.section!=2){ //The title of section
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"titleCell"];
        UILabel *headerTitle=(UILabel*)[cell viewWithTag:1];        
        switch (indexPath.section) {
            case 0:
                headerTitle.text=NSLocalizedString(@"SizeYourFeeling", nil);
                break;
            case 1:
                headerTitle.text=NSLocalizedString(@"SocialAnalysis", nil);
                break;
            default:
                break;
        }
        //Disable selection style
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }

    
    if(indexPath.section ==0 && indexPath.row ==1){ //Color information
        //Generating and setting de cell
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"basicCell"];
        
        //Setting the format
        cell.contentView.backgroundColor=[UIColor colorWithRed:18.0f/255 green:137.0f/255 blue:114.0f/255 alpha:1.0];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

        
        //Getting views
        UILabel *titleLabel=(UILabel*)[cell viewWithTag:2];
        UILabel *iconLabel=(UILabel*)[cell viewWithTag:4];


        //Setting the values
        titleLabel.text=NSLocalizedString(@"colorMood", nil);
        iconLabel.font=[UIFont fontWithName:@"FontAwesome" size:15];
        iconLabel.text=[NSString fontAwesomeIconStringForEnum:FAIconSmile];

        //Disable selection style
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if(indexPath.section ==0 && indexPath.row ==2){ //Color selection
        //Generating and setting de cell
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"colorPickerCell"];
        
        //Disable selection style
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section ==0 && indexPath.row ==3){ //Photo titlte
        //Generating and setting de cell
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"addPhotoCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

        //Getting views
        UILabel *titleLabel=(UILabel*)[cell viewWithTag:2];
        UILabel *iconLabel=(UILabel*)[cell viewWithTag:4];


        //Setting values
        titleLabel.text=NSLocalizedString(@"addPhoto", nil);
        iconLabel.font=[UIFont fontWithName:@"FontAwesome" size:15];
        iconLabel.text=[NSString fontAwesomeIconStringForEnum:FAIconPlus];
       
        //Disable selection style
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;

    }
    else if ( indexPath.section == 1){ //Social analysis
        //Generating and setting de cell
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"socialCell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        //Getting views
        UILabel *titleLabel=(UILabel*)[cell viewWithTag:2];
        FUISwitch *cellSwitch=(FUISwitch*)[cell viewWithTag:3];
        UILabel *iconLabel=(UILabel*)[cell viewWithTag:4];
         iconLabel.font=[UIFont fontWithName:@"FontAwesome" size:15];
        
        //Setting values
        cellSwitch.onColor = [UIColor turquoiseColor];
        cellSwitch.offColor = [UIColor cloudsColor];
        cellSwitch.onBackgroundColor = [UIColor midnightBlueColor];
        cellSwitch.offBackgroundColor = [UIColor darkGrayColor];
        cellSwitch.offLabel.font = [UIFont boldFlatFontOfSize:14];
        cellSwitch.onLabel.font = [UIFont boldFlatFontOfSize:14];
        
        switch (indexPath.row) {
            case 1:
                titleLabel.text=@"Facebook";
                iconLabel.text=[NSString fontAwesomeIconStringForEnum:FAIconFacebook];
                break;
            case 2:
                titleLabel.text=@"Twitter";
                iconLabel.text=[NSString fontAwesomeIconStringForEnum:FAIconTwitter];
                break;
            case 3:
                titleLabel.text=@"Github";
                iconLabel.text=[NSString fontAwesomeIconStringForEnum:FAIconGithub];
                break;

            default:
                break;
        }

        //Disable selection style
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.section ==2 && indexPath.row ==0){ //Send button
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"basicCell"];
        
        //Setting the format
        cell.contentView.backgroundColor=[UIColor colorWithRed:18.0f/255 green:137.0f/255 blue:114.0f/255 alpha:1.0];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        //Getting views
        UILabel *titleLabel=(UILabel*)[cell viewWithTag:2];
        titleLabel.text=NSLocalizedString(@"SendFeeling", nil);

        
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section ==0 && indexPath.row ==0){ //Color title
        return 45;
    }else if(indexPath.section ==0 && indexPath.row ==1){ //Color selection
        return 50;
    }else if(indexPath.section ==0 && indexPath.row ==2){ //Photo titlte
        return 45;
    }else {
        return 45;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return table_footer_height;
}

#pragma mark - Lazy instantiation
-(NSMutableArray*)photosArray{
    if(!_photosArray)_photosArray=[[NSMutableArray alloc] init];
    return _photosArray;
}

@end
