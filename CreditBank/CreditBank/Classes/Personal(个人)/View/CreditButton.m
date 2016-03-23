//
//  CreditButton.m
//  CreditBank
//
//  Created by Eric on 15/3/29.
//  Copyright (c) 2015年 Eric. All rights reserved.
//


#import "CreditButton.h"
@interface CreditButton()
@property(nonatomic, weak) UILabel *leftLabel;
@end

@implementation CreditButton
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 左侧Label
        UIFont *systemFont  = [UIFont systemFontOfSize:15.0];
        UILabel *rightLabel = [[UILabel alloc] init];
        
        rightLabel.textAlignment = NSTextAlignmentLeft;
        rightLabel.textColor     = [UIColor blackColor];
        rightLabel.font          =  systemFont;
        
        [self addSubview:rightLabel];
        self.leftLabel = rightLabel;
        
        // 右侧Label
        self.titleLabel.font     = systemFont;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        
        // 选中图
        [self setBackgroundImage:[UIImage imageNamed:@"bgLine"] forState:UIControlStateNormal];
//        [self setBackgroundImage:[UIImage imageNamed:@"bgLine"] forState:UIControlStateHighlighted];
//        [self setBackgroundImage:[UIImage imageNamed:@"bgLineH"] forState:UIControlStateSelected];

        // 默认黑色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    return self;
}

- (void)setLeftLabelTitle:(NSString *)leftLabelTitle {
    self.leftLabel.text = leftLabelTitle;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat padding = 15;
    CGFloat rightLabelY = 0;
    CGFloat rightLabelW = self.frame.size.width * 0.4;
    CGFloat rightLabelH = self.frame.size.height;
    CGFloat rightLabelX = 0 + padding;
    self.leftLabel.frame = CGRectMake(rightLabelX, rightLabelY, rightLabelW, rightLabelH);
    
    CGFloat leftLabelY = 0;
    CGFloat leftLabelW = self.frame.size.width * 0.6;
    CGFloat leftLabelH = self.frame.size.height;
    CGFloat leftLabelX = CGRectGetMaxY(self.leftLabel.frame) + padding;
    self.titleLabel.frame = CGRectMake(leftLabelX, leftLabelY, leftLabelW, leftLabelH);
    
//    self.leftLabel.backgroundColor = [UIColor grayColor];
//    self.titleLabel.backgroundColor = [UIColor yellowColor];

}
@end
