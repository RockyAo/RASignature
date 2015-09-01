//
//  RAPainBezierPath.m
//  RASignature
//
//  Created by Rocky on 15/9/1.
//  Copyright (c) 2015年 Rocky. All rights reserved.
//

#import "RAPainBezierPath.h"

@implementation RAPainBezierPath
+ (instancetype)paintPathWithLineWidth:(CGFloat)width lineColor:(UIColor *)color startPoint:(CGPoint)startPoint{
    
    RAPainBezierPath *path = [[RAPainBezierPath alloc] init];
    path.lineWidth = width;
    path.color = color;
    [path moveToPoint:startPoint];
    
    return path;
}

@end
