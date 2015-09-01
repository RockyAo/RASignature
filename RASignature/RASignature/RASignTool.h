//
//  RASignTool.h
//  RASignature
//
//  Created by Rocky on 15/9/1.
//  Copyright (c) 2015年 Rocky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void(^SignImageBlock)(UIImage *signImage);
typedef void(^IconImageBlock)(UIImage *iconImage);


@interface RASignTool : NSObject
/**
 *  是否自动关闭 default is yes
 */
@property(nonatomic,assign)BOOL autoClose;

+ (RASignTool *)shareInstance;

/**
 *  开启签名面板（有拍照）
 *
 *  @param viewController 要在哪个控制器上显示
 *  @param signIamge      签名照片
 *  @param iconImage      相机拍摄头像照片
 */
- (void)openSignViewWithViewController:(UIViewController *)viewController SignImage:(SignImageBlock)signIamge iconImage:(IconImageBlock)iconImage;

/**
 *  开启签名面板（无拍照）
 *
 *  @param viewController 需要在哪个控制器上显示
 *  @param signIamge 签名图片
 */
- (void)openSignViewWithViewController:(UIViewController *)viewController SignImage:(SignImageBlock)signIamge;

/**
 *  关闭签名面板
 */
- (void)closeTheSignView;

@end
