//
//  UserInfoView.m
//  CreditBank
//
//  Created by Eric on 15/3/29.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#define USERINFOFONTSIZE 15

#import "UserInfoView.h"
#import "CreditButton.h"
#import "PrefixHeader.pch"
#import "UserCenterModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AddBrankCardButton.h"
#import "ImpotSuccessController.h"


@interface UserInfoView()

/**
 *  电话图标
 */
@property(nonatomic, weak) UILabel *telLabel;
/**
 *  电话和安全等级容器
 */
@property(nonatomic, weak) UIView *telBoxView;
/**
 *  安全等级标题
 */
@property(nonatomic, weak) UILabel *safeTitleLevel;
/**
 *  安全等级1
 */
@property(nonatomic, weak) UIView *safeLevelView1;
/**
 *  安全等级2
 */
@property(nonatomic, weak) UIView *safeLevelView2;
/**
 *  安全等级3
 */
@property(nonatomic, weak) UIView *safeLevelView3;
/**
 *  消息图标
 */
@property(nonatomic, weak) UIButton *messageIcon;
/**
 *  详情图标
 */
@property(nonatomic, weak) UIButton *infoIcon;


/**
 *  背景图片
 */
@property(nonatomic, weak) UIImageView  *bgImageView;

/**
 *  积分按钮
 */
@property(nonatomic, weak) CreditButton *leftButton;
/**
 *  银行卡按钮
 */
@property(nonatomic, weak) CreditButton *rightButton;
/**
 *  添加银行卡按钮
 */
@property (nonatomic, weak) AddBrankCardButton *addBtn;






@end
@implementation UserInfoView

- (void)setUserCenterModel:(UserCenterModel *)userCenterModel
{
    ANLog(@"setUserCenterModel");
    _userCenterModel = userCenterModel;
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:userCenterModel.avatar]
                                placeholderImage:[UIImage imageNamed:@"avatar"]];
    
    self.telLabel.text =  userCenterModel.mobile;
    
    [self.rightButton setTitle:[NSString stringWithFormat:@"%@ 张", userCenterModel.card_num] forState:UIControlStateNormal];
    
    if ([userCenterModel.card_num isEqual:@"0"] || [userCenterModel.card_num isEqual:@0]) {
        self.addBtn.hidden = NO;
    } else {
        self.addBtn.hidden = YES;
    }

    if ([userCenterModel.credit isEqualToString:@"0"] ) {
        [self.leftButton setTitle:[NSString stringWithFormat:@"%@ 积分", userCenterModel.credit] forState:UIControlStateNormal];
    } else {
        [self.leftButton setTitle:[NSString stringWithFormat:@"%@ 分", userCenterModel.credit] forState:UIControlStateNormal];
    }
    
//    ImpotSuccessController *importSuccess = [[ImpotSuccessController alloc] init];
//    [importSuccess changeCreditWithBlock:^(NSString *credit) {
//        [self.leftButton setTitle:[NSString stringWithFormat:@"%@ 分", credit] forState:UIControlStateNormal];
//    }];
    

    if (userCenterModel.has_message == 1) {
        [self.messageIcon setImage:[UIImage imageNamed:@"message_new"] forState:UIControlStateNormal];
        
    } else {
        [self.messageIcon setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    }
    
    if (1 == [userCenterModel.safe_level intValue]) {
        [self setSafelevelBackgrandColorR1:17 G1:237 B1:110
                                        R2:255 G2:255 B2:255
                                        R3:255 G3:255 B3:255];
    } else if (2 == [userCenterModel.safe_level intValue]) {
        [self setSafelevelBackgrandColorR1:17 G1:237 B1:110
                                        R2:17 G2:237 B2:110
                                        R3:255 G3:255 B3:255];
    } else if (3 == [userCenterModel.safe_level intValue]) {
        [self setSafelevelBackgrandColorR1:17 G1:237 B1:110
                                        R2:17 G2:237 B2:110
                                        R3:17 G3:237 B3:110];
    } else {
        [self setSafelevelBackgrandColorR1:255 G1:255 B1:255
                                        R2:255 G2:255 B2:255
                                        R3:255 G3:255 B3:255];
    }
    
    // 强制刷新位置
    [self layoutSubviews];
}

- (void)setSafelevelBackgrandColorR1:(CGFloat)r1 G1:(CGFloat)g1 B1:(CGFloat)b1
                                  R2:(CGFloat)r2 G2:(CGFloat)g2 B2:(CGFloat)b2
                                  R3:(CGFloat)r3 G3:(CGFloat)g3 B3:(CGFloat)b3
{
    self.safeLevelView1.backgroundColor = HDColor(r1, g1, b1);
    self.safeLevelView2.backgroundColor = HDColor(r2, g2, b2);
    self.safeLevelView3.backgroundColor = HDColor(r3, g3, b3);
}

- (instancetype)init {
    if (self = [super init]) {
        
        // 1、背景
        UIImageView *bgImageView = [[UIImageView alloc] init];
        bgImageView.image = [UIImage imageNamed:@"UserInfoBg"];
        bgImageView.userInteractionEnabled = YES;
        [self addSubview:bgImageView];
        self.bgImageView = bgImageView;
        
        // 1、头像 105 * 108
        UIImageView *avatarImageView = [[UIImageView alloc] init];
//        avatarImageView.backgroundColor = [UIColor redColor];
        [bgImageView addSubview:avatarImageView];
        self.avatarImageView = avatarImageView;
        avatarImageView.image = [UIImage imageNamed:@"avatar"];
        
        // 电话和安全等级的容器
        UIView *telBoxView = [[UIView alloc] init];
        [bgImageView addSubview:telBoxView];
        self.telBoxView = telBoxView;
        
        // 2、电话
        UILabel *telLabel = [[UILabel alloc] init];
        telLabel.font = [UIFont systemFontOfSize:USERINFOFONTSIZE];
        telLabel.textColor = [UIColor whiteColor];
        telLabel.textAlignment = NSTextAlignmentLeft;
        [telBoxView addSubview:telLabel];
        self.telLabel = telLabel;
        
        // 3、安全等级标题
        UILabel *safeTitleLabel = [[UILabel alloc] init];
        safeTitleLabel.font = [UIFont systemFontOfSize:11];
        safeTitleLabel.textColor = [UIColor whiteColor];
        safeTitleLabel.textAlignment = NSTextAlignmentLeft;
        safeTitleLabel.text = @"安全等级:";
        [self.telBoxView addSubview:safeTitleLabel];
        self.safeTitleLevel = safeTitleLabel;
        
        // 安全等级符号
        UIView *safeLevelView1 = [[UIView alloc] init];
        [self.telBoxView addSubview:safeLevelView1];
        safeLevelView1.backgroundColor = HDColor(255, 255, 255);
        self.safeLevelView1 = safeLevelView1;

        
        UIView *safeLevelView2 = [[UIView alloc] init];
        [self.telBoxView addSubview:safeLevelView2];
        safeLevelView2.backgroundColor = HDColor(255, 255, 255);
        self.safeLevelView2 = safeLevelView2;

        UIView *safeLevelView3 = [[UIView alloc] init];
        [self.telBoxView addSubview:safeLevelView3];
        safeLevelView3.backgroundColor = HDColor(255, 255, 255);
        self.safeLevelView3 = safeLevelView3;
        
        // 4、消息图标
        UIButton *messageIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [telBoxView addSubview:messageIcon];
        self.messageIcon = messageIcon;
        [self.messageIcon addTarget:self action:@selector(messageIconClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        // 5、查看详情按钮
        UIButton *infoIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [infoIcon setBackgroundImage:[UIImage imageNamed:@"user_arrow"] forState:UIControlStateNormal];
        [infoIcon addTarget:self action:@selector(userInfoClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:infoIcon];
        self.infoIcon = infoIcon;
        
        // 积分按钮
        CreditButton *leftBtn = [CreditButton buttonWithType:UIButtonTypeCustom];
        leftBtn.leftLabelTitle = @"积分";
        [self addSubview:leftBtn];
        
        // 设置按钮数据
        [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(creditBtnTouchDown:) forControlEvents:UIControlEventTouchDown];
        [leftBtn addTarget:self action:@selector(creditBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];

        // [leftBtn setTitle:@"0 积分" forState:UIControlStateNormal];
        self.leftButton = leftBtn;
        
        // 银行卡按钮
        CreditButton *rightBtn  = [CreditButton buttonWithType:UIButtonTypeCustom];
        rightBtn.leftLabelTitle = @"银行卡";
//        [rightBtn setTitle:@"1张" forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(brankBtnTouchDown:) forControlEvents:UIControlEventTouchDown];
        [rightBtn addTarget:self action:@selector(brankBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        
        // 添加银行卡
        AddBrankCardButton *addBtn = [AddBrankCardButton buttonWithType:UIButtonTypeCustom];
        [addBtn setTitleColor:HDColor(55, 156, 218) forState:UIControlStateNormal];
        addBtn.backgroundColor = [UIColor whiteColor];
        [addBtn addTarget:self action:@selector(addBrankCardClickedAction:) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn addSubview:addBtn];
        self.addBtn = addBtn;

        [self addSubview:rightBtn];
        self.rightButton = rightBtn;
        
        
        // 注册通知
//        NSNotificationCenter *noticCenter = [NSNotificationCenter defaultCenter];
//        [noticCenter addObserver:self selector:@selector(notificationAction:) name:@"changeCredit" object:nil];
       
        
    }
    
    return self;
}

//- (void)notificationAction:(NSNotification *)notification
//{
//    NSString *str = [notification.userInfo objectForKey:@"credit"];
//    [self.leftButton setTitle:str forState:UIControlStateNormal];
//}

//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

#pragma mark -- Events
- (void)addBrankCardClickedAction:(AddBrankCardButton*)btn
{
    if ([self.delegate respondsToSelector:@selector(userInfoViewAddBrankCard:addButton:)]) {
        [self.delegate userInfoViewAddBrankCard:self addButton:btn];
    }
}

/**
 *  消息按钮触发事件
 */
- (void)messageIconClicked:(UIButton *)btn
{
    [btn setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(userInfoViewBrankBtnDown:BrankButton:)]) {
        [self.delegate userInfoViewMessageBtnClicked:btn];
    }
}

/**
 *  银行卡列表
 */
- (void)brankBtnTouchUpInside:(CreditButton *)btn {
    btn.selected  = NO;
    
    if ([self.delegate respondsToSelector:@selector(userInfoViewBrankBtnDown:BrankButton:)]) {
        [self.delegate userInfoViewBrankBtnDown:self BrankButton:btn];
    }
}

/**
 *  积分跳转
 *
 *  @param btn btn description
 */
- (void)creditBtnTouchUpInside:(CreditButton *)btn {
    btn.selected  = NO;
    
    if ([self.delegate respondsToSelector:@selector(userInfoViewCreditBtnDown:CreditButton:)]) {
        [self.delegate userInfoViewCreditBtnDown:self CreditButton:btn];
    }
}

/**
 *  用户详情跳转
 */
- (void)userInfoClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(userInfoViewBtnInfo:infoBtn:)]) {
        [self.delegate userInfoViewBtnInfo:self infoBtn:btn];
    }
}

- (void)brankBtnTouchDown:(CreditButton *)btn{
    btn.selected = YES;
}

- (void)creditBtnTouchDown:(CreditButton *)btn{
    btn.selected = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 背景图片
    CGFloat bgX = 0;
    CGFloat bgY = 0;
    CGFloat bgW = self.frame.size.width;
    CGFloat bgH = 80;
    
    self.bgImageView.frame = CGRectMake(bgX, bgY, bgW, bgH);
    
    // 头像
    
    CGFloat avatarX = 24;
    CGFloat avatarW = 53;
    CGFloat avatarH = 53;
    CGFloat avatarY = (bgH - avatarH) * 0.5;
    self.avatarImageView.frame = CGRectMake(avatarX, avatarY, avatarW, avatarH);
    
    // 头像圆角
    self.avatarImageView.layer.cornerRadius = avatarH / 2.0;
    self.avatarImageView.layer.masksToBounds = YES;
    
    // 头像边框
    self.avatarImageView.layer.borderColor = HDColor(220, 209, 200).CGColor;
    self.avatarImageView.layer.borderWidth = 2.0;
    
    // 电话和安全等级的容器
    CGFloat telBoxX = CGRectGetMaxX(self.avatarImageView.frame) + 13;
    CGFloat telBoxW = 135;
    CGFloat telBoxH = avatarH - 10;
    CGFloat telBoxY = (bgH - telBoxH) * 0.5;
    self.telBoxView.frame = CGRectMake(telBoxX, telBoxY, telBoxW, telBoxH);
    
    // 电话
    CGFloat telX = 0;
    CGFloat telY = 0;
    CGFloat telH = 17;
    
    // 需要最大宽度
    CGSize nameMaxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    CGSize nameSize = [Common sizeWithText:self.userCenterModel.mobile font:[UIFont systemFontOfSize:USERINFOFONTSIZE] maxSize:nameMaxSize];
    
    self.telLabel.frame = CGRectMake(telX, telY, nameSize.width, telH);
    
    // 消息图标
    CGFloat msgX = CGRectGetMaxX(self.telLabel.frame) + 5;
    CGFloat msgY = 0;
    CGFloat msgW = 15;
    CGFloat msgH = 15;
    
    self.messageIcon.frame = CGRectMake(msgX, msgY, msgW, msgH);
//    [self.messageIcon setImage:[UIImage imageNamed:@"message_new"] forState:UIControlStateNormal];
    
    CGFloat safeTitleX = 0;
    CGFloat safeTitleW = 50;
    CGFloat safeTitleH = 25;
    CGFloat safeTitleY = telBoxH - safeTitleH;
    
    // 安全等级标题
    self.safeTitleLevel.frame = CGRectMake(safeTitleX, safeTitleY, safeTitleW, safeTitleH);
    
    // 安全等级符号
    CGFloat safeLevelViewPadding = 2;
    CGFloat safeLevelView1W = 10;
    CGFloat safeLevelView1H = 3;
    CGFloat safeLevelView1X = CGRectGetMaxX(self.safeTitleLevel.frame);
    CGFloat safeLevelView1Y = (safeTitleH - safeLevelView1H) * 0.5 + safeTitleY ;

    self.safeLevelView1.frame = CGRectMake(safeLevelView1X, safeLevelView1Y, safeLevelView1W, safeLevelView1H);
    
    CGFloat safeLevelView2X = CGRectGetMaxX(self.safeLevelView1.frame) + safeLevelViewPadding;
    self.safeLevelView2.frame = CGRectMake(safeLevelView2X, safeLevelView1Y, safeLevelView1W, safeLevelView1H);
    
    CGFloat safeLevelView3X = CGRectGetMaxX(self.safeLevelView2.frame) + safeLevelViewPadding;
    self.safeLevelView3.frame = CGRectMake(safeLevelView3X, safeLevelView1Y, safeLevelView1W, safeLevelView1H);
    
    // 详情图标
    CGFloat infoIconW = 11;
    CGFloat infoIconH = 20;
    CGFloat infoIconX = bgW - infoIconW - 10;
    CGFloat infoIconY = (bgH - infoIconH) * 0.5;
    self.infoIcon.frame = CGRectMake(infoIconX, infoIconY, infoIconW, infoIconH);
    
    // 积分Box
    CGFloat margin  = 0.5;
    CGFloat leftBtnX = 0;
    CGFloat leftBtnY = CGRectGetMaxY(self.bgImageView.frame);
    CGFloat leftBtnW = self.frame.size.width * 0.5 - margin;
    CGFloat leftBtnH = 41;
    self.leftButton.frame = CGRectMake(leftBtnX, leftBtnY, leftBtnW, leftBtnH);
    
    CGFloat rightBtnX = CGRectGetMaxX(self.leftButton.frame) + margin;;
    CGFloat rightBtnY = CGRectGetMaxY(self.bgImageView.frame);
    CGFloat rightBtnW = self.frame.size.width * 0.5;
    CGFloat rightBtnH = leftBtnH;
    self.rightButton.frame = CGRectMake(rightBtnX, rightBtnY, rightBtnW, rightBtnH);
    
    
    self.addBtn.frame = CGRectMake(0, 0, rightBtnW, rightBtnH);

}



@end
