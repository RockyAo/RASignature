//
//  RAPainBezierPath.h
//  RASignature
//
//  Created by Rocky on 15/9/1.
//  Copyright (c) 2015年 Rocky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RAPainBezierPath : UIBezierPath
/**
 *  线条颜色
 */
@property (nonatomic, strong) UIColor *color;
/**
 *  画线
 *
 *  @param width  线宽度
 *  @param color  颜色
 *  @param startP 起始点
 *
 *  @return 线条
 */
+ (instancetype)paintPathWithLineWidth:(CGFloat)width lineColor:(UIColor *)color startPoint:(CGPoint)startPoint;

@end
