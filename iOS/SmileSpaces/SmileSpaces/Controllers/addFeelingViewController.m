//
//  addFeelingViewController.m
//  SmileSpaces
//
//  Created by Pedro Piñera Buendía on 03/09/13.
//  Copyright (c) 2013 Trobi. All rights reserved.
//

#import "addFeelingViewController.h"
@interface addFeelingViewController ()
@property (strong, nonatomic) IBOutlet UIView *tableView;

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
	
    //Customizing navigation bar
    self.title=NSLocalizedString(@"Feeling",nil);
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor midnightBlueColor]];
    
    //Customizing background color
    self.view.backgroundColor=[UIColor colorWithWhite:0.95 alpha:1.0];
    

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
