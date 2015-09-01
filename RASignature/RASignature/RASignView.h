//
//  RASignView.h
//  RASignature
//
//  Created by Rocky on 15/9/1.
//  Copyright (c) 2015年 Rocky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RASignView : UIView
/**
 *  线宽度 line width default is 1.0f
 */
@property (nonatomic, assign) CGFloat lineWidth;
/**
 *  线的颜色 line color default is black color
 */
@property (nonatomic, strong) UIColor *lineColor;
/**
 *  清屏  clear everything
 */
- (void)clearScreen;
/**
 *  获取签名图片
 *
 *  @return 如果已经在画板上签名返回图片 否则返回nil
 *          if signed return the sign image else return nil
 */
- (UIImage *)getSignImage;
@end
