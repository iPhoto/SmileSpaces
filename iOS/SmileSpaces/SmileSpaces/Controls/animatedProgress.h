//
//  animatedProgress.h
//  SmileSpaces
//
//  Created by Pedro Piñera Buendía on 05/09/13.
//  Copyright (c) 2013 Trobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface animatedProgress : UIView

@property (nonatomic,strong) UIColor* backgroundColor;

-(void)setPercentage:(float) percentage withAnimation:(BOOL)animated andDuration:(CGFloat)duration;
-(void)resetProgress;

@end
