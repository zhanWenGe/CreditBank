//
//  BlueButtonView.m
//  CreditBank
//
//  Created by Eric on 15/4/4.
//  Copyright (c) 2015年 Eric. All rights reserved.
//


#import "BlueButtonView.h"
#import "PrefixHeader.pch"

@interface BlueButtonView()

@property(nonatomic, weak) UIButton *btn;
@end

@implementation BlueButtonView

- (instancetype)initWithBtnTitle:(NSString *)btnTitle {
    if (self = [super init]) {
        [self setUp:btnTitle];
    }
    
    return self;
}

- (void)setUp:(NSString *)btnTitle {
    
    // 1、创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    self.btn = btn;
    
    // 2、设置数据
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    btn.backgroundColor = [UIColor colorWithRed:53/255.0 green:152/255.0 blue:219/255.0 alpha:1.0];
    self.backgroundColor = DEFALT_BG;
    

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat btnY = 0;
    CGFloat btnX = 27;
    CGFloat btnW = self.frame.size.width - btnX * 2;
    CGFloat btnH = self.frame.size.height;
    self.btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
}

- (void)btnClick {
    if ([self.delegate respondsToSelector:@selector(btnClick:btn:)]) {
        [self.delegate btnClick:self btn:self.btn];
    }
}

- (void)setBtnTitle:(NSString *)title state:(UIControlState)state {
    [self.btn setTitle:title forState:state];
}

- (void)setBtnBgColor:(UIColor *)color {
    self.btn.backgroundColor = color;
}
@end
