//
//  RASignView.m
//  RASignature
//
//  Created by Rocky on 15/9/1.
//  Copyright (c) 2015年 Rocky. All rights reserved.
//

#import "RASignView.h"
#import "RAPainBezierPath.h"

#define RARGBColor(r,g,b) ([UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1])
#define RADefaultLineColor [UIColor blackColor]
#define RADefaultLineWidth 1.0f

@interface RASignView ()
//曲线
@property(nonatomic,strong)UIBezierPath *path;
//曲线集合
@property(nonatomic,strong)NSMutableArray *pathArray;

@property(nonatomic,assign)BOOL isSign;

@end
@implementation RASignView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RARGBColor(226, 226, 226);
        _isSign = NO;
        
    }
    return self;
}


#pragma mark 懒加载
- (NSMutableArray *)pathArray{
    
    if (!_pathArray) {
        _pathArray = [NSMutableArray array];
    }
    
    return _pathArray;
}

// 获取触摸点
- (CGPoint)pointWithTouches:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    
    return [touch locationInView:self];
}

//确定起点
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    if (touches.count > 1) {
        return;
    }
    
    self.isSign = YES;

    CGPoint point = [self pointWithTouches:touches];
    
    if (!self.lineWidth) {
        self.lineWidth = RADefaultLineWidth;
    }
    if (!self.lineColor) {
        self.lineColor = RADefaultLineColor;
    }
    RAPainBezierPath *bezierPath = [RAPainBezierPath paintPathWithLineWidth:self.lineWidth lineColor:self.lineColor startPoint:point];
    
    self.path = bezierPath;
    [self.pathArray addObject:self.path];
}

//确定终点
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    CGPoint point = [self pointWithTouches:touches];
    
    [self.path addLineToPoint:point];
    //重新绘制
    [self setNeedsDisplay];
}

// 把之前的全部清空 重新绘制
- (void)drawRect:(CGRect)rect
{
    if (!self.pathArray.count) return;
    
    // 遍历所有的路径绘制
    for (RAPainBezierPath *path in self.pathArray) {
        
        if ([path isKindOfClass:[UIImage class]]) { // UIImage
            UIImage *image = (UIImage *)path;
            [image drawAtPoint:CGPointZero];
        }else{
            
            [path.color set];
            [path stroke];
        }
    }
}

//清屏
- (void)clearScreen{
    
    self.isSign = NO;
    [self.pathArray removeAllObjects];
    [self setNeedsDisplay];
}

- (UIImage *)getSignImage{
    
    if (self.isSign) {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        // 把画板上的内容渲染到上下文
        [self.layer renderInContext:ctx];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }else{
    
        return nil;
    }
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
}

@end
