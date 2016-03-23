//
//  CateSubButton.m
//  CreditBank
//
//  Created by 王德康 on 15/6/3.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "CateSubButton.h"

@implementation CateSubButton
/**
 *  复写UIButton 初始化方法
 *  增加分割线子控件
 */
+ (instancetype)buttonWithType:(UIButtonType)buttonType {
    
    // 右侧分割线
    UIView *rightLineview = [[UIView alloc] init];
    rightLineview.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0];
    rightLineview.hidden = YES;
    
    CateSubButton *btn = [super buttonWithType:buttonType];
    [btn addSubview:rightLineview];
    btn.rightLineView = rightLineview;
    
    // 底部分割线
    UIView *bottomLineview = [[UIView alloc] init];
    bottomLineview.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1.0];
    bottomLineview.hidden = YES;
    
    
    [btn addSubview:bottomLineview];
    btn.bottomLineView = bottomLineview;
    
    btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
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
@end
