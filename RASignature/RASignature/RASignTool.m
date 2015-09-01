//
//  RASignTool.m
//  RASignature
//
//  Created by Rocky on 15/9/1.
//  Copyright (c) 2015年 Rocky. All rights reserved.
//

#import "RASignTool.h"

#define RAMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define RAMainSCreenHeight [UIScreen mainScreen].bounds.size.height

static RASignTool *signTool = nil;

@interface RASignTool ()
@property(nonatomic,copy)SignImageBlock signImage;
@property(nonatomic,copy)IconImageBlock iconImage;
@end

@implementation RASignTool{

    UIView *hideView;
}


#pragma mark private method
+ (RASignTool *)shareInstance{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        signTool = [[RASignTool alloc] init];
    });
    return signTool;
}

- (void)openSignViewWithViewController:(UIViewController *)viewController SignImage:(SignImageBlock)signIamge{

    _signImage = signIamge;
    [self setSignViewWithViewController:viewController shouldShowHeaderCarmeraView:NO];
}

- (void)openSignViewWithViewController:(UIViewController *)viewController SignImage:(SignImageBlock)signIamge iconImage:(IconImageBlock)iconImage{
    
    _signImage = signIamge;
    _iconImage = iconImage;
    [self setSignViewWithViewController:viewController shouldShowHeaderCarmeraView:YES];
}

- (void)closeTheSignView{

    [self closePop];
}

-(void)closePop{
    [CATransaction begin];
    [UIView animateWithDuration:0.25f animations:^{
        hideView.frame = CGRectMake(RAMainScreenWidth, 0, RAMainScreenWidth, RAMainSCreenHeight);
    } completion:^(BOOL finished) {
        //都关闭啊都关闭
        //        _viewController.navigationController.navigationBarHidden = NO;
        hideView.window.windowLevel = UIWindowLevelNormal;
        [hideView removeFromSuperview];
        hideView = nil;
        
    }];
    [CATransaction commit];
}

- (void)setSignViewWithViewController:(UIViewController *)viewController shouldShowHeaderCarmeraView:(BOOL)should{
    
    

}
#pragma mark life circle

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        hideView = [[UIView alloc] init];
        hideView.backgroundColor = [UIColor whiteColor];
        _autoClose = YES;
    }
    return self;
}

@end
