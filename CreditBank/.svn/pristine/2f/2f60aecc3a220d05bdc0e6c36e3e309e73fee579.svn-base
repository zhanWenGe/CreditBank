//
//  ModuleButton.m
//  CreditBank
//
//  Created by Eric on 15/5/2.
//  Copyright (c) 2015年 Eric. All rights reserved.
//



#import "ModuleButton.h"

@interface ModuleButton()

@end

@implementation ModuleButton

/**
 *  复写UIButton 初始化方法
 *  增加分割线子控件
 */
+ (instancetype)buttonWithType:(UIButtonType)buttonType {
    
    // 右侧分割线
    UIView *rightLineview = [[UIView alloc] init];
    rightLineview.backgroundColor = [UIColor blackColor];
    rightLineview.hidden = YES;
    rightLineview.alpha  = 0.2;
    
    ModuleButton *btn = [super buttonWithType:buttonType];
    [btn addSubview:rightLineview];
    btn.rightLineView = rightLineview;
    
    // 底部分割线
    UIView *bottomLineview = [[UIView alloc] init];
    bottomLineview.backgroundColor = [UIColor blackColor];
    bottomLineview.hidden = YES;
    bottomLineview.alpha  = 0.2;
    
    
    [btn addSubview:bottomLineview];
    btn.bottomLineView = bottomLineview;
    
    return btn;
}

/**
 *  分割线Frame
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat lineViewX = self.frame.size.width - 0.5;
    CGFloat lineViewY = 0;
    CGFloat lineViewW = 0.5;
    CGFloat lineViewH = self.frame.size.height;
    self.rightLineView.frame = CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH);
    
    
    CGFloat bottomLineX = 0;
    CGFloat bottomLineY = self.frame.size.height - 0.5;
    CGFloat bottomLineW = self.frame.size.width;
    CGFloat bottomLineH = 0.5;
    self.bottomLineView.frame = CGRectMake(bottomLineX, bottomLineY, bottomLineW, bottomLineH);
}

/**
 *  调整title的位置
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = 20;
    CGFloat titleX = 0 ;
    CGFloat titleY = contentRect.size.height * 0.65;
    
    CGRect titleRect = CGRectMake(titleX, titleY, titleW, titleH);
    return titleRect;
}

/**
 *  调整image位置
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageW = 40;
    CGFloat imageH = 40;
    CGFloat imageX = (contentRect.size.width - imageW) * 0.5;
    CGFloat imageY = (contentRect.size.height - imageH) * 0.30;
    
    CGRect imageRect = CGRectMake(imageX, imageY, imageW, imageH);
    return imageRect;
}
@end
