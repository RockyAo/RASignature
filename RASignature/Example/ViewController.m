//
//  ViewController.m
//  RASignature
//
//  Created by Rocky on 15/8/27.
//  Copyright (c) 2015年 Rocky. All rights reserved.
//

#import "ViewController.h"
#import "RASignature.h"


#define RAMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define RAMainSCreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *signImageView;
@property(nonatomic,strong)RASignView *signView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (IBAction)hasHeaderButtonClick:(UIButton *)sender {
    
    
}
- (IBAction)noHeaderButtonClick:(UIButton *)sender {
    
    
}
- (IBAction)drawboardButtonClick:(UIButton *)sender {
    
    
}



#pragma mark getter and setter

- (RASignView *)signView{

    if (!_signView) {
        _signView = [[RASignView alloc] initWithFrame:CGRectMake(0, RAMainSCreenHeight - 200, RAMainScreenWidth, 200)];
        _signView.lineColor = [UIColor redColor];
        _signView.lineWidth = 2.0f;
    }
    return _signView;
}

@end
