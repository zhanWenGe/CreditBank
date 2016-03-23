//
//  AddBankHeadView.h
//  CreditBank
//
//  Created by Eric on 15/5/8.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankInfoModel.h"

@protocol AddBankHeadViewDelegate <NSObject>

@optional
- (void)AddBankHeadViewClickedAction:(UIView *)view button:(UIButton *)button index:(NSInteger)index;
@end


@interface AddBankHeadView : UIView

@property (nonatomic, retain) BankInfoModel *bankInfoModel;

/**
 *  积分总数
 */
@property (nonatomic, weak) UILabel *integralLabel;
/**
 *  可以兑换成积分宝积分数量
 */
@property (nonatomic, weak) UILabel *exchangedIntegralLabel;
/**
 *  自定义分数输入框
 */
@property (nonatomic, weak) UITextField *inputTextField;

@property (nonatomic, weak)  id <AddBankHeadViewDelegate> delegate;

+ (AddBankHeadView *)addBankHeadView;

@end
