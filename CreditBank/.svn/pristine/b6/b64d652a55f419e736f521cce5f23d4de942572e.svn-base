//
//  UserInfoView.h
//  CreditBank
//
//  Created by Eric on 15/3/29.
//  Copyright (c) 2015年 Eric. All rights reserved.
//


#import <UIKit/UIKit.h>

@class UserInfoView;
@class CreditButton;
@class AddBrankCardButton;
@class UserCenterModel;

@protocol UserInfoViewDelegate <NSObject>
@optional
- (void)userInfoViewBtnInfo:(UserInfoView *)view infoBtn:(UIButton *)btn;
- (void)userInfoViewCreditBtnDown:(UserInfoView *)view CreditButton:(CreditButton *)btn;
- (void)userInfoViewBrankBtnDown:(UserInfoView *)view BrankButton:(CreditButton *)btn;
- (void)userInfoViewMessageBtnClicked:(UIButton *)btn;
- (void)userInfoViewAddBrankCard:(UserInfoView *)view addButton:(AddBrankCardButton *)btn;
@end

@interface UserInfoView : UIView

/**
 *  头像图标
 */
@property(nonatomic, weak) UIImageView *avatarImageView;

@property(nonatomic, weak) id <UserInfoViewDelegate> delegate;


@property (nonatomic, strong) UserCenterModel *userCenterModel;

- (void)setUserCenterModel:(UserCenterModel *)userCenterModel;
@end
