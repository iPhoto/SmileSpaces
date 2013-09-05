//
//  RPRadarChart.m
//  RadarChart
//
//                       Radar Chart
//
//
//  Created by Juan Pablo Illanes Sotta (@raspum) on 06-06-12.
//  Copyright (c) 2012 Juan Pablo Illanes Sotta. All rights reserved.

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

//----------------
//
//          Simple RadrChart that displays the data containded in
//  NSDictionary. Expects Keys to be the Var Name (Edge Label) and the 
//  Object to be an NSNumber with float values.
//
//--------------- 

#import <float.h>
#import "RPRadarChart.h"

@interface RPRadarChart ()

-(void) drawChartInContext:(CGContextRef) cx withKey: (NSString *)key;

@end

@implementation RPRadarChart
@synthesize values, backLineWidth, frontLineWidth, lineColor, fillColor, dotColor, dotRadius, drawGuideLines,showGuideNumbers, colors, showValues, fillArea;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        values = nil;
        maxSize = (frame.size.width>frame.size.height)  ? frame.size.width/2 - 25 : frame.size.height/2 - 25;
        backLineWidth = 1.0f;
        frontLineWidth = 2.0f;
        dotRadius = 3;
        drawGuideLines = YES;
        showGuideNumbers = YES;
        showValues = YES;
        fillArea = YES;
        lineColor = [UIColor redColor];
        dotColor = [UIColor redColor];
        fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.2];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    if(values == nil)
        return;
    CGContextRef cx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(cx, self.frame.size.width/2, self.frame.size.height/2);
    [self drawBackGroundInContext:cx];
    if(hasMultiDataSet)
    {
        for (NSString *key in values) 
        {
            [self drawChartInContext:cx withKey:key];
        }
    }else
        [self drawChartInContext:cx withKey:nil];
}

-(void) drawChartInContext:(CGContextRef) cx withKey: (NSString *)key
{
    CGContextSetLineWidth(cx, frontLineWidth);
    
    //NSDictionary *d = (key == nil) ? values : [values objectForKey:key] ;
    
    UIColor *flColor = fillColor;
    UIColor *stColor = lineColor;
    UIColor *dtColor = dotColor;
    
    if(colors != nil && key != nil)
    {
        /*int idx = [[values allKeys] indexOfObject:key];
        stColor = dtColor = [colors objectAtIndex:colors[idx]];
        flColor = [dtColor colorWithAlphaComponent:0.2];*/
    }
    
    float mvr = (2*M_PI) / [values count];
    float fx =0;
    float fy =0;
    int mi = 0;
    //DRAW LINES
    CGMutablePathRef path = CGPathCreateMutable();
    for (NSArray *ky in values)
    {
        float v = ([ky[1] floatValue] / maxValue) * maxSize;
        float a = (mvr * mi) - M_PI_2;
        float x = v * cos(a);
        float y = v * sin(a);
                
        
        
        if(fx == 0 && fy == 0)
        {
            CGPathMoveToPoint(path, NULL, x, y);
            fx = x;
            fy = y;
        }else
            CGPathAddLineToPoint(path, NULL, x,  y);
        mi++;
    }    
    CGPathAddLineToPoint(path, NULL, fx, fy);
    CGContextAddPath(cx, path);
    if(fillArea)
    {
        CGContextSetFillColorWithColor(cx, [UIColor whiteColor].CGColor);
        CGContextFillPath(cx);
    }
    CGContextSetStrokeColorWithColor(cx, stColor.CGColor);
    CGContextAddPath(cx, path);
    CGContextStrokePath(cx);
    
    
    // DRAW TRIANGLES
    mi=0;
    for (NSArray *ky in values)
    {
        CGMutablePathRef prevtrianglepath = CGPathCreateMutable();
        CGMutablePathRef nexttrianglepath = CGPathCreateMutable();

        float v = ([ky[1] floatValue] / maxValue) * maxSize;
        float a = (mvr * mi) - M_PI_2;
        float x = v * cos(a);
        float y = v * sin(a);
        
        //Getting the value of Next Point
        float v2=0;
        float v1=0;
        float a2=0;
        float a1=0;

        if (mi+1<values.count) {
            v2 = ([values[mi+1][1] floatValue] / maxValue) * maxSize;
            a2 = (mvr * (mi+1)) - M_PI_2;

        }else{
            v2 = ([values[0][1] floatValue] / maxValue) * maxSize;
            a2 = (mvr * (0)) - M_PI_2;

        }
        if (mi-1>=0) {
            v1 = ([values[mi-1][1] floatValue] / maxValue) * maxSize;
            a1 = (mvr * (mi-1)) - M_PI_2;
            
        }else{
            v1 = ([values[values.count-1][1] floatValue] / maxValue) * maxSize;
            a1 = (mvr * (values.count-1)) - M_PI_2;
            
        }

        
        float x2 = (v2 * cos(a2) + x)/2;
        float y2 = (v2 * sin(a2)+ y)/2;
        
        float x1 = (v1 * cos(a1) + x)/2;
        float y1 = (v1 * sin(a1)+ y)/2;
        
        CGContextSetFillColorWithColor(cx, [self darkerColorForColor:self.triangleColors[mi]].CGColor);
        CGContextSetLineWidth(cx, 0.0);
        
        //Draw previous triangle
        CGPathMoveToPoint(prevtrianglepath, NULL, 0, 0);
        CGPathAddLineToPoint(prevtrianglepath, NULL, x,  y);
        CGPathAddLineToPoint(prevtrianglepath, NULL, x1,  y1);
        CGPathAddLineToPoint(prevtrianglepath, NULL, 0,  0);
        CGContextAddPath(cx, prevtrianglepath);
        CGContextFillPath(cx);
        CGContextAddPath(cx, prevtrianglepath);
        CGContextStrokePath(cx);
        CGPathRelease(prevtrianglepath);

        
        CGContextSetFillColorWithColor(cx, [self lighterColorForColor:self.triangleColors[mi]].CGColor);
        //Draw next triangle
        CGPathMoveToPoint(nexttrianglepath, NULL, 0, 0);
        CGPathAddLineToPoint(nexttrianglepath, NULL, x,  y);
        CGPathAddLineToPoint(nexttrianglepath, NULL, x2,  y2);
        CGPathAddLineToPoint(nexttrianglepath, NULL, 0,  0);
        CGContextAddPath(cx, nexttrianglepath);
        CGContextFillPath(cx);
        CGContextAddPath(cx, nexttrianglepath);
        CGContextStrokePath(cx);
        CGPathRelease(nexttrianglepath);
        
        mi++;
    }
    
    //DRAW VALUES
    
    mi= 0;
    for (NSArray *ky in values)
    {
        float v = ([ky[1] floatValue] / maxValue) * maxSize;
        float a = (mvr * mi) - M_PI_2;
        float x = v * cos(a);
        float y = v * sin(a);
        
        //CGContextSetFillColorWithColor(cx, dtColor.CGColor);
        //CGContextFillEllipseInRect(cx, CGRectMake(x-dotRadius, y-dotRadius, dotRadius*2, dotRadius*2));
        if(showValues)
        {
            NSString *str = [NSString stringWithFormat:@"%1.0f",[ky[1] floatValue]];
            x += 5;
            y -= 7;     
            CGContextSetFillColorWithColor(cx, [UIColor whiteColor].CGColor);
            [str drawAtPoint:CGPointMake(x, y) withFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        }
        mi++;
    }    
    CGContextMoveToPoint(cx, 0, 0);
}

-(void) drawBackGroundInContext:(CGContextRef) cx
{
    CGContextSetLineWidth(cx, backLineWidth);
    
    float mvr = (2*M_PI) / [values count];
    float spcr = maxSize / 4;
    
    //Index Lines
    if(drawGuideLines)
    {
        CGContextSetStrokeColorWithColor(cx, [UIColor colorWithWhite:0.8 alpha:1].CGColor);
        
        for (int j = 0; j<=4; j++) 
        {
             float cur = j*spcr;
            CGContextStrokeEllipseInRect(cx, CGRectMake(-cur, -cur, cur*2, cur*2));
        }
        
//Straigh Lines...
//        for (int j = 0; j<=4; j++) {
//            float cur = j*spcr;
//            float x = cur * cos(-mvr - M_PI_2);
//            float y = cur * sin(-mvr - M_PI_2);
//            CGContextMoveToPoint(cx, x, y);
//            for (int i = 0; i < [d count]; i++)
//            {
//                float a = (mvr * i) - M_PI_2;
//                float x = cur * cos(a);
//                float y = cur * sin(a);
//                CGContextAddLineToPoint(cx, x , y);            
//            }
//        }
//-------------------------------
            CGContextStrokePath(cx);
    }
    //Base lines
    CGContextSetStrokeColorWithColor(cx, [UIColor whiteColor].CGColor);
    for (int i = 0; i < values.count; i++)
    {
        float a = (mvr * i) - M_PI_2;
        float x = maxSize * cos(a);
        float y = maxSize * sin(a);
        CGContextMoveToPoint(cx, 0, 0);
        CGContextAddLineToPoint(cx, x , y);
        
        CGContextStrokePath(cx);
        
        
        NSString *tx =  values[i][0];
        CGSize s =[tx sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        x-= s.width/2;
        y += (y>0) ? 10 : -20;        
        
        CGContextSetFillColorWithColor(cx, [UIColor colorWithRed:22.0f/255 green:160.0f/255 blue:133.0f/255 alpha:1.0].CGColor);

        [tx drawAtPoint:CGPointMake(x, y) withFont: [UIFont fontWithName:@"Helvetica-Bold" size:12]];
        
    }
    
    //Index Texts
    if(showGuideNumbers)
    {
        for(float i = spcr; i <= maxSize; i+=spcr)
        {        
            NSString *str = [NSString stringWithFormat:@"%1.0f",( i * maxValue) / maxSize];
            CGSize s = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:12]];
            float x = i * cos(M_PI_2) + 5 + s.width;
            float y = i * sin(M_PI_2) + 5;
            CGContextSetFillColorWithColor(cx, [UIColor whiteColor].CGColor);
            [str drawAtPoint:CGPointMake(- x, - y) withFont: [UIFont fontWithName:@"Helvetica" size:12]];
        }
    }
    CGContextMoveToPoint(cx, 0, 0);
    
}

#pragma mark - Setters


-(void) setValues:(NSArray *)val
{
    values = val;
    maxValue = -1;
    minValue = FLT_MAX; 
    for (NSArray *ky in values) {
        if([[ky class] isSubclassOfClass:[NSArray class]])
        {
            hasMultiDataSet = YES;
            for (NSArray *k in values)
            {
                float v = [k[1] floatValue];
                if(maxValue < v)
                    maxValue = v;
                if(minValue > v)
                    minValue = v;
            }
        }else
        {
            float v = [(id)ky floatValue];
            if(maxValue < v)
                maxValue = v;
            if(minValue > v)
                minValue = v;
        }
    }
    maxValue += (maxValue - minValue)/10;
    [self setNeedsDisplay];
}

-(void) setLineColor:(UIColor *)v
{ 
    lineColor = v;
    [self setNeedsDisplay];
    
}

-(void) setFillColor:(UIColor *)v
{ 
    fillColor = v;
    [self setNeedsDisplay];
    
}
-(void) setBackLineWidth:(float)v
{ 
    backLineWidth = v;
    [self setNeedsDisplay];    
}

-(void) setFrontLineWidth:(float)v
{ 
    frontLineWidth = v;
    [self setNeedsDisplay];    
}

-(void) setDotColor:(UIColor *)v
{ 
    dotColor = v;
    [self setNeedsDisplay];    
}

-(void) setDotRadius:(float) v
{ 
    dotRadius = v;
    [self setNeedsDisplay];    
}

-(void) setShowValues:(BOOL)v
{
    showValues = v;
    [self setNeedsDisplay];
}

-(void) setFillArea:(BOOL)v
{
    fillArea = v;
    [self setNeedsDisplay];
}


-(void) setDrawGuideLines:(BOOL)v
{
    drawGuideLines = v;
    [self setNeedsDisplay];
}

-(void) setShowGuideNumbers:(BOOL)v
{
    showGuideNumbers = v;
    [self setNeedsDisplay];
}
- (UIColor *)lighterColorForColor:(UIColor *)c
{
    float r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MIN(r + 0.08, 1.0)
                               green:MIN(g + 0.08, 1.0)
                                blue:MIN(b + 0.08, 1.0)
                               alpha:a];
    return nil;
}

- (UIColor *)darkerColorForColor:(UIColor *)c
{
    float r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.01, 0.0)
                               green:MAX(g - 0.01, 0.0)
                                blue:MAX(b - 0.01, 0.0)
                               alpha:a];
    return nil;
}

@end
