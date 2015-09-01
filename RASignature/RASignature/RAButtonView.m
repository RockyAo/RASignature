//
//  RAButtonView.m
//  RASignature
//
//  Created by Rocky on 15/9/1.
//  Copyright (c) 2015年 Rocky. All rights reserved.
//

#import "RAButtonView.h"
#import "UIView+RASignViewExtension.h"

#define RARGBColor(r,g,b) ([UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1])

@interface RAButtonView ()
//返回
@property(nonatomic,strong)UIButton *back;
//重签
@property(nonatomic,strong)UIButton *reSign;
//确定
@property(nonatomic,strong)UIButton *confirm;
//提示文字
@property(nonatomic,strong)UILabel *titleText;
//工具栏
@property(nonatomic,strong)UIView *toolBar;
@property(nonatomic,assign)BOOL isSet;
@end
@implementation RAButtonView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubviews];
    }
    return self;
}

//创建子控件
- (void)setUpSubviews{
    
    //    self.backgroundColor = [UIColor redColor];
    self.titleText = [[UILabel alloc] init];
    self.titleText.numberOfLines = 0;
    self.titleText.text = @"";
    self.titleText.textColor = RARGBColor(120, 120, 120);
    self.titleText.font = [UIFont systemFontOfSize:15];
    //    self.titleText.backgroundColor = [UIColor redColor];
    [self addSubview:self.titleText];
    
    self.toolBar = [[UIView alloc] init];
    [self addSubview:self.toolBar];
    
    self.back = [self creatButtonWithName:@"返回" backGroundColor:RARGBColor(16, 166, 79)];
    [self.back addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolBar addSubview:self.back];
    
    self.reSign = [self creatButtonWithName:@"重签" backGroundColor:RARGBColor(16, 166, 79)];
    [self.reSign addTarget:self action:@selector(reSignBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolBar addSubview:self.reSign];
    
    self.confirm = [self creatButtonWithName:@"确认" backGroundColor:RARGBColor(16, 166, 79)];
    [self.confirm addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolBar addSubview:self.confirm];
    
    self.isSet = NO;
}
//创建按钮
- (UIButton *)creatButtonWithName:(NSString *)name backGroundColor:(UIColor *)color{
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:name forState:UIControlStateNormal];
    [btn setTitle:name forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    btn.layer.cornerRadius = 10;
    [btn setBackgroundColor:color];
    return btn;
}

#pragma mark 布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    [self setSubviewFrame];
    
    if (!self.isSet) {
        [self setData];
        self.isSet = YES;
    }
}
- (void)setData{
    
    if ([self.delegate respondsToSelector:@selector(setTitleLabelText)]) {
        self.titleText.text = [self.delegate setTitleLabelText];
    }
    if ([self.delegate respondsToSelector:@selector(setTitleLabelTextColor)]) {
        self.titleText.textColor = [self.delegate setTitleLabelTextColor];
    }
    if ([self.delegate respondsToSelector:@selector(settitleLabelTextFont)]) {
        self.titleText.font = [self.delegate settitleLabelTextFont];
    }
    
    if ([self.delegate respondsToSelector:@selector(setAllButtonBackGroundColor)]) {
        UIColor *color = [self.delegate setAllButtonBackGroundColor];
        [self.back setBackgroundColor:color];
        [self.reSign setBackgroundColor:color];
        [self.confirm setBackgroundColor:color];
    }
    if ([self.delegate respondsToSelector:@selector(setBackButtonBackgroundColor)]) {
        [self.back setBackgroundColor:[self.delegate setBackButtonBackgroundColor]];
    }
    if ([self.delegate respondsToSelector:@selector(setReSignButtonBackgroundColor)]) {
        [self.reSign setBackgroundColor:[self.delegate setReSignButtonBackgroundColor]];
    }
    if ([self.delegate respondsToSelector:@selector(setConfirmButtonBackgroundColor)]) {
        [self.confirm setBackgroundColor:[self.delegate setConfirmButtonBackgroundColor]];
    }
}

//布局
- (void)setSubviewFrame{
    
    CGFloat margin = 10;
    self.titleText.frame = CGRectMake(margin, margin, self.width - 2*margin , self.height - 64 - margin);
    self.toolBar.frame = CGRectMake(margin, CGRectGetMaxY(self.titleText.frame)+margin, self.width - 2*margin, 44);
    CGFloat buttonW = self.toolBar.width/3-2*margin;
    CGFloat buttonH = self.toolBar.height;
    self.back.frame = CGRectMake(2*margin, 0, buttonW, buttonH);
    self.reSign.frame = CGRectMake(CGRectGetMaxX(self.back.frame)+margin, 0, buttonW, buttonH);
    self.confirm.frame = CGRectMake(CGRectGetMaxX(self.reSign.frame)+margin, 0, buttonW, buttonH);
}
#pragma mark 按钮点击方法
//返回
- (void)backBtnClick:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(backButtonDidClick:)]) {
        
        [self.delegate backButtonDidClick:sender];
    }
}
//重签
- (void)reSignBtnClick:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(reSignButtonDidClick:)]) {
        [self.delegate reSignButtonDidClick:sender];
    }
}

//确认
- (void)confirmBtnClick:(UIButton *)sender{
    
    if ([self.delegate respondsToSelector:@selector(confimButtonDidClick:)]) {
        [self.delegate confimButtonDidClick:sender];
    }
}

@end
