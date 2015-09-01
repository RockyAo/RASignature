//
//  RAHeaderCarmeraView.m
//  RASignature
//
//  Created by Rocky on 15/9/1.
//  Copyright (c) 2015年 Rocky. All rights reserved.
//

#import "RAHeaderCarmeraView.h"
#import <AVFoundation/AVFoundation.h>
#import "UIView+RASignViewExtension.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define RAMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define RAMainSCreenHeight [UIScreen mainScreen].bounds.size.height

@interface RAHeaderCarmeraView ()
@property (strong, nonatomic) AVCaptureSession* session;
//@property (strong, nonatomic) AVCaptureDevice* device;
@property (strong, nonatomic) AVCaptureDeviceInput* captureInput;
@property (strong, nonatomic) AVCaptureStillImageOutput* imageOutput;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer* cameraLayer;
@property (strong, nonatomic) AVCaptureConnection* videoConnection;
@property(nonatomic,copy)AvcaptureImageBlock imageBlock;

@end
@implementation RAHeaderCarmeraView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initCameraDevice];
    }
    return self;
}
#pragma 初始化相机
- (void)initCameraDevice
{
    //创建会话层
    AVCaptureSession* session = [[AVCaptureSession alloc] init];
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    self.session = session;
    //创建配置输入输出
    //    AVCaptureDevice* device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //    [device lockForConfiguration:nil];
    //    [device unlockForConfiguration];
    //    self.device = device;
    
    NSError* error;
    AVCaptureDeviceInput* captureInput = [AVCaptureDeviceInput deviceInputWithDevice:[self cameraWithPosition:AVCaptureDevicePositionFront] error:&error];
    self.captureInput = captureInput;
    if (!captureInput) {
        
        NSLog(@"%@", error);
        
        return;
    }
    
    [session addInput:captureInput];
    
    AVCaptureStillImageOutput* imageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary* outputSittings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
    self.imageOutput = imageOutput;
    [imageOutput setOutputSettings:outputSittings];
    [session addOutput:imageOutput];
    
    self.cameraLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    
    self.cameraLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.layer addSublayer:self.cameraLayer];
    
    //设置connection
    AVCaptureConnection* videoConnection = [self.imageOutput connectionWithMediaType:AVMediaTypeVideo];
    self.videoConnection = videoConnection;
    
    //设置方向
    //    AVCaptureVideoOrientation videoOrientation = AVCaptureVideoOrientationPortrait;
    
    //    switch ([UIApplication sharedApplication].keyWindow.rootViewController.interfaceOrientation) {
    //        case UIInterfaceOrientationLandscapeLeft:
    //            videoOrientation = AVCaptureVideoOrientationLandscapeLeft;
    //            break;
    //        case UIInterfaceOrientationLandscapeRight:
    //            videoOrientation = AVCaptureVideoOrientationLandscapeRight;
    //            break;
    //        case UIInterfaceOrientationPortraitUpsideDown:
    //            videoOrientation = AVCaptureVideoOrientationPortraitUpsideDown;
    //            break;
    //        default:
    //            videoOrientation = AVCaptureVideoOrientationPortrait;
    //            break;
    //    }
    
    self.cameraLayer.connection.videoOrientation = AVCaptureVideoOrientationLandscapeRight;
}
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}

//开启相机
- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.cameraLayer.frame = CGRectMake(0, 0, self.width, self.height);
    [self.session startRunning];
}

//关闭相机
- (void)dealloc{
    
    [self.session stopRunning];
    
}

#pragma mark 牌照方法
- (void)takePhoto:(AvcaptureImageBlock)imageBlock{
    
    if (!self.videoConnection) {
        
        NSLog(@"拍摄失败");
    }
    _imageBlock = imageBlock;
    
    [self.imageOutput captureStillImageAsynchronouslyFromConnection:self.videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError* error) {
        
        if (error) {
            NSLog(@"拍摄失败%@",error);
        }
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        
        UIImage *image = [UIImage imageWithData:imageData];
        
        UIImage *newImage = [self rotateImage:image orient:UIImageOrientationDown];
        
        imageBlock(newImage);
    }];
}

//翻转图片用
- (UIImage *)rotateImage:(UIImage *)aImage orient:(UIImageOrientation)orient{
    
    CGImageRef imgRef = aImage.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    CGRect bounds = CGRectMake(0, 0, width, height);
    
    
    CGFloat scaleRatio = 1;
    
    
    CGFloat boundHeight;
    
    
    switch(orient)
    
    {
            
        case UIImageOrientationUp: //EXIF = 1
            
            transform = CGAffineTransformIdentity;
            
            break;
            
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            
            transform = CGAffineTransformMakeTranslation(width, 0.0);
            
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            
            break;
            
            
        case UIImageOrientationDown: //EXIF = 3
            
            transform = CGAffineTransformMakeTranslation(width, height);
            
            transform = CGAffineTransformRotate(transform, M_PI);
            
            break;
            
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            
            transform = CGAffineTransformMakeTranslation(0.0, height);
            
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            
            break;
            
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            transform = CGAffineTransformMakeTranslation(height, width);
            
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            
            break;
            
            
        case UIImageOrientationLeft: //EXIF = 6
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            transform = CGAffineTransformMakeTranslation(0.0, width);
            
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            
            break;
            
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            
            
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            
            break;
            
            
        case UIImageOrientationRight: //EXIF = 8
            
            boundHeight = bounds.size.height;
            
            bounds.size.height = bounds.size.width;
            
            bounds.size.width = boundHeight;
            
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            
            break;
            
            
        default:
            
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    
    UIGraphicsBeginImageContext(bounds.size);
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        
        CGContextTranslateCTM(context, -height, 0);
        
    }
    
    else {
        
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        
        CGContextTranslateCTM(context, 0, -height);
        
    }
    
    
    CGContextConcatCTM(context, transform);
    
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    return imageCopy;
    
}

@end
