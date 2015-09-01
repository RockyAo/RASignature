//
//  RAButtonView.h
//  RASignature
//
//  Created by Rocky on 15/9/1.
//  Copyright (c) 2015年 Rocky. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RAButtonViewDelegate <NSObject>
- (void)confimButtonDidClick:(UIButton *)sender;
- (void)backButtonDidClick:(UIButton *)sender;
- (void)reSignButtonDidClick:(UIButton *)sender;

@optional
//设置提示文字
- (NSString *)setTitleLabelText;
//设置提示文字字体
- (UIFont *)settitleLabelTextFont;
//设置提示文字颜色
- (UIColor *)setTitleLabelTextColor;
//设置所有按钮背景颜色
- (UIColor *)setAllButtonBackGroundColor;
//设置确定按钮背景颜色
- (UIColor *)setConfirmButtonBackgroundColor;
//设置返回按钮背景颜色
- (UIColor *)setBackButtonBackgroundColor;
//设置重新签名按钮颜色
- (UIColor *)setReSignButtonBackgroundColor;
@end

@interface RAButtonView : UIView
@property (nonatomic,weak)id<RAButtonViewDelegate> delegate;
@end
