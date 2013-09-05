//
//  RPRadarChart.h
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


#import <UIKit/UIKit.h>

@interface RPRadarChart : UIView
{
    NSArray *values; // Key are names.
    
    NSArray *colors; //Any number
    
    float backLineWidth;
    float frontLineWidth;
    float dotRadius;
    UIColor *dotColor;
    UIColor *lineColor;
    UIColor *fillColor;
    BOOL drawGuideLines;
    BOOL showGuideNumbers;
    BOOL showValues;
    BOOL hasMultiDataSet;
    BOOL fillArea;
    
    //Private
    float maxSize;
    float maxValue;
    float minValue;
}
@property (nonatomic, strong) NSArray *values;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) UIColor *lineColor, *fillColor, *dotColor;
@property (nonatomic) float backLineWidth, frontLineWidth, dotRadius;
@property (nonatomic) BOOL drawGuideLines, showGuideNumbers, showValues, fillArea;
@property (nonatomic,strong) NSArray *triangleColors;

@end
