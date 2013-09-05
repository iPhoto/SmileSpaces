//
//  addFeelingViewController.h
//  SmileSpaces
//
//  Created by Pedro Piñera Buendía on 03/09/13.
//  Copyright (c) 2013 Trobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlatUIKit.h"

@interface feelingDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong ) NSString *zoneId;
@property (nonatomic,strong) NSDictionary *zoneDict;
@property (nonatomic,strong) NSArray *zoneParameters;
@end
