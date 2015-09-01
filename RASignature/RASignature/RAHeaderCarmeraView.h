//
//  RAHeaderCarmeraView.h
//  RASignature
//
//  Created by Rocky on 15/9/1.
//  Copyright (c) 2015年 Rocky. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AvcaptureImageBlock)(UIImage *newImage);
@interface RAHeaderCarmeraView : UIView
- (void)takePhoto:(AvcaptureImageBlock)imageBlock;
@end
