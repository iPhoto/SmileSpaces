//
//  animatedProgress.m
//  SmileSpaces
//
//  Created by Pedro Piñera Buendía on 05/09/13.
//  Copyright (c) 2013 Trobi. All rights reserved.
//

#import "animatedProgress.h"
@interface animatedProgress ()
@property (nonatomic,strong) UIView *topView;
@end
@implementation animatedProgress

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _backgroundColor=[UIColor whiteColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andBackgroundColor:(UIColor*)color
{
    self = [super initWithFrame:frame];
    if (self) {
        _backgroundColor=color;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* fillColor = [UIColor colorWithRed: 0 green: 0.886 blue: 0 alpha: 1];
    UIColor* color = [UIColor colorWithRed: 0.886 green: 0 blue: 0 alpha: 1];
    UIColor* color2 = [UIColor colorWithRed: 1 green: 1 blue: 0.114 alpha: 1];
    
    //// Gradient Declarations
    NSArray* gradientColors = [NSArray arrayWithObjects:
                               (id)color.CGColor,
                               (id)color2.CGColor,
                               (id)fillColor.CGColor, nil];
    CGFloat gradientLocations[] = {0, 0.46, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: rect];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    CGContextDrawLinearGradient(context, gradient, rect.origin, CGPointMake(rect.size.width, rect.size.height), 0);
    CGContextRestoreGState(context);
    
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);

    //Adding topview
    if(!_topView){
        _topView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:_topView];
    }
    self.topView.backgroundColor=self.backgroundColor;
    self.topView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

-(void)setPercentage:(float) percentage withAnimation:(BOOL)animated andDuration:(CGFloat)duration{
    CGRect newFrame=CGRectMake(self.frame.size.width-self.frame.size.width*percentage, 0, self.frame.size.width*(1-percentage), self.frame.size.height);
    
    if(!animated){
        self.topView.frame=newFrame;
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            for ( int i=0;i<=(int)(percentage*100);i++){
                dispatch_async(dispatch_get_main_queue(), ^{
                    CGRect frame=CGRectMake(self.frame.size.width*(((float)i)/100), 0, self.frame.size.width*(1-((float)i)/100), self.frame.size.height);
                    self.topView.frame=frame;
                });
                [NSThread sleepForTimeInterval:0.01];
            }
    });
}
-(void)resetProgress{
    self.topView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
#pragma mark - Setters
-(void)setBackgroundColor:(UIColor *)backgroundColor{
    _backgroundColor=backgroundColor;
    [self setNeedsDisplay];
}

@end
