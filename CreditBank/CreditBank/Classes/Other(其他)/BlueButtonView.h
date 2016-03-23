//
//  BlueButtonView.h
//  CreditBank
//
//  Created by Eric on 15/4/4.
//  Copyright (c) 2015年 Eric. All rights reserved.
//



#import <UIKit/UIKit.h>

@protocol BlueButtonViewDelegate <NSObject>
@optional
- (void)btnClick:(id)view btn:(UIButton *)btn;
@end

@interface BlueButtonView : UIView
@property(nonatomic, weak) IBOutlet id <BlueButtonViewDelegate> delegate;
/**
 *  设置按钮的标题
 *
 *  @param title 标题
 *  @param state 按钮状态
 */
- (void)setBtnTitle:(NSString *)title state:(UIControlState)state;
/**
 *  设置按钮背景颜色
 */
- (void)setBtnBgColor:(UIColor *)color;
/**
 *  初始化一个带按钮的View
 */
- (instancetype)initWithBtnTitle:(NSString *)btnTitle;
@end
