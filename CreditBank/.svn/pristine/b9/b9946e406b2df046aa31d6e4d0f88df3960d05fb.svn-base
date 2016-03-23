//
//  PlatButtonView.m
//  CreditBank
//
//  Created by Eric on 15/4/24.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "PlatButtonView.h"
#import "PrefixHeader.pch"
#import "PlatButtonModel.h"


@interface PlatButtonView()

/**
 *  积分导入按钮
 */
@property (nonatomic, weak) UIButton *integralImportBtn;
/**
 *  积分导入按钮图片
 */
@property (nonatomic, strong) UIImageView *integralImportImage;
/**
 *  积分导入标题
 */
@property (nonatomic, weak) UILabel *integralImportTitle;

/**
 *  积分换购按钮
 */
@property (nonatomic, weak) UIButton *integralExchangeBtn;
/**
 *  积分换购按钮图片
 */
@property (nonatomic, strong) UIImageView *integralExchangeImage;
/**
 *  积分换购标题
 */
@property (nonatomic, weak) UILabel *integralExchangeTitle;

/**
 *  手机充值按钮
 */
@property (nonatomic, weak) UIButton *mobileRechargeBtn;
/**
 *  手机充值按钮图片
 */
@property (nonatomic, strong) UIImageView *mobileRechargeImage;
/**
 *  手机充值标题
 */
@property (nonatomic, weak) UILabel *mobileRechargeTitle;

/**
 *  积分抽奖按钮
 */
@property (nonatomic, weak) UIButton *integralLotteryBtn;
/**
 *  积分抽奖按钮图片
 */
@property (nonatomic, strong) UIImageView *integralLotteryImage;
/**
 *  积分抽奖标题
 */
@property (nonatomic, weak) UILabel *integralLotteryTitle;



@end

#define TITLEFONT [UIFont systemFontOfSize:9]

@implementation PlatButtonView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setButtonView];
    }
    return self;
}

- (void)setButtonView
{
    // 积分导入按钮
    UIButton *integralImportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [integralImportBtn setImage:[UIImage imageNamed:@"jifendaoru"] forState:UIControlStateNormal];
    [self addSubview:integralImportBtn];
    [integralImportBtn addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    self.integralImportBtn = integralImportBtn;
    
    self.integralImportImage = [[UIImageView alloc] init];
    [self.integralImportBtn addSubview:self.integralImportImage];
    
    // 积分导入标题
    UILabel *integralImportTitle = [[UILabel alloc] init];
    integralImportTitle.text = @"积分导入";
    [self addSubview:integralImportTitle];
    integralImportTitle.textAlignment = NSTextAlignmentCenter;
    integralImportTitle.font = TITLEFONT;
    integralImportTitle.textColor = HDColor(32, 32, 32);
    self.integralImportTitle = integralImportTitle;
    
    // 积分换购按钮
    UIButton *integralExchangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [integralExchangeBtn setImage:[UIImage imageNamed:@"jifenhuangou"] forState:UIControlStateNormal];
    [self addSubview:integralExchangeBtn];
    [integralExchangeBtn addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    self.integralExchangeBtn = integralExchangeBtn;
    
    self.integralExchangeImage = [[UIImageView alloc] init];
    [self.integralExchangeBtn addSubview:self.integralExchangeImage];
    
    // 积分换购标题
    UILabel *integralExchangeTitle = [[UILabel alloc] init];
    integralExchangeTitle.text = @"积分换购";
    [self addSubview:integralExchangeTitle];
    integralExchangeTitle.textAlignment = NSTextAlignmentCenter;
    integralExchangeTitle.font = TITLEFONT;
    integralExchangeTitle.textColor = HDColor(32, 32, 32);
    self.integralExchangeTitle = integralExchangeTitle;
    
    // 手机充值按钮
    UIButton *mobileRechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [mobileRechargeBtn setImage:[UIImage imageNamed:@"shoujichongzhi"] forState:UIControlStateNormal];
    [self addSubview:mobileRechargeBtn];
    [mobileRechargeBtn addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    self.mobileRechargeBtn = mobileRechargeBtn;
    
    self.mobileRechargeImage = [[UIImageView alloc] init];
    [self.mobileRechargeBtn addSubview:self.mobileRechargeImage];
    
    // 手机充值标题
    UILabel *mobileRechargeTitle = [[UILabel alloc] init];
    mobileRechargeTitle.text = @"手机充值";
    [self addSubview:mobileRechargeTitle];
    mobileRechargeTitle.textAlignment = NSTextAlignmentCenter;
    mobileRechargeTitle.font = TITLEFONT;
    mobileRechargeTitle.textColor = HDColor(32, 32, 32);
    self.mobileRechargeTitle = mobileRechargeTitle;
    
    // 积分抽奖按钮
    UIButton *integralLotteryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [integralLotteryBtn setImage:[UIImage imageNamed:@"jifenchoujiang"] forState:UIControlStateNormal];
    [self addSubview:integralLotteryBtn];
    [integralLotteryBtn addTarget:self action:@selector(buttonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    self.integralLotteryBtn = integralLotteryBtn;
    
    self.integralLotteryImage = [[UIImageView alloc] init];
    [self.integralLotteryBtn addSubview:self.integralLotteryImage];
    
    // 积分抽奖标题
    UILabel *integralLotteryTitle = [[UILabel alloc] init];
    integralLotteryTitle.text = @"积分抽奖";
    [self addSubview:integralLotteryTitle];
    integralLotteryTitle.textAlignment = NSTextAlignmentCenter;
    integralLotteryTitle.font = TITLEFONT;
    integralLotteryTitle.textColor = HDColor(32, 32, 32);
    self.integralLotteryTitle = integralLotteryTitle;

}

- (void)setPlatButtonDataArray:(NSArray *)platButtonDataArray
{
    _platButtonDataArray = platButtonDataArray;
    
    PlatButtonModel *plantbuttonModel = nil;
    
    if (self.integralImportBtn) {
        plantbuttonModel = platButtonDataArray[0];
        [self.integralImportImage sd_setImageWithURL:[NSURL URLWithString:plantbuttonModel.cover] placeholderImage:nil];
        self.integralImportTitle.text = plantbuttonModel.name;
    }
    
    if (self.integralExchangeBtn) {
        plantbuttonModel = platButtonDataArray[1];
        [self.integralExchangeImage sd_setImageWithURL:[NSURL URLWithString:plantbuttonModel.cover] placeholderImage:nil];
        self.integralExchangeTitle.text = plantbuttonModel.name;
    }

    if (self.mobileRechargeBtn) {
        plantbuttonModel = platButtonDataArray[2];
        [self.mobileRechargeImage sd_setImageWithURL:[NSURL URLWithString:plantbuttonModel.cover] placeholderImage:nil];
        self.mobileRechargeTitle.text = plantbuttonModel.name;
    }
    
    if (self.integralLotteryBtn) {
        plantbuttonModel = platButtonDataArray[3];
        [self.integralLotteryImage sd_setImageWithURL:[NSURL URLWithString:plantbuttonModel.cover] placeholderImage:nil];
        self.integralLotteryTitle.text = plantbuttonModel.name;
    }
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat paddin = WIDTH * 20 / 320;
    CGFloat imageWithHigh = WIDTH * 43 / 320;
    CGFloat titleHigh = 11;
    // 积分导入按钮
    CGFloat integralImportBtnX = paddin;
    CGFloat integralImportBtnY = 15;
    CGFloat integralImportBtnW = imageWithHigh;
    CGFloat integralImportBtnH = imageWithHigh;
    self.integralImportBtn.frame = CGRectMake(integralImportBtnX, integralImportBtnY, integralImportBtnW, integralImportBtnH);
    self.integralImportImage.frame = self.integralImportBtn.imageView.frame;
    // 积分导入标题
    CGFloat integralImportTitleX = integralImportBtnX;
    CGFloat integralImportTitleY = CGRectGetMaxY(self.integralImportBtn.frame) + 3;
    CGFloat integralImportTitleW = imageWithHigh;
    CGFloat integralImportTitleH = titleHigh;
    self.integralImportTitle.frame = CGRectMake(integralImportTitleX, integralImportTitleY, integralImportTitleW, integralImportTitleH);
    
    // 积分换购按钮
    CGFloat integralExchangeBtnX = CGRectGetMaxX(self.integralImportBtn.frame) + (WIDTH - 2 * paddin - 4 * imageWithHigh) / 3;
    CGFloat integralExchangeBtnY = integralImportBtnY;
    CGFloat integralExchangeBtnW = imageWithHigh;
    CGFloat integralExchangeBtnH = imageWithHigh;
    self.integralExchangeBtn.frame = CGRectMake(integralExchangeBtnX, integralExchangeBtnY, integralExchangeBtnW, integralExchangeBtnH);
    self.integralExchangeImage.frame = self.integralExchangeBtn.imageView.frame;
    // 积分换购标题
    CGFloat integralExchangeTitleX = integralExchangeBtnX;
    CGFloat integralExchangeTitleY = integralImportTitleY;
    CGFloat integralExchangeTitleW = imageWithHigh;
    CGFloat integralExchangeTitleH = titleHigh;
    self.integralExchangeTitle.frame = CGRectMake(integralExchangeTitleX, integralExchangeTitleY, integralExchangeTitleW, integralExchangeTitleH);
    
    // 手机充值按钮
    CGFloat mobileRechargeBtnX = CGRectGetMaxX(self.integralExchangeBtn.frame) + (WIDTH - 2 * paddin - 4 * imageWithHigh) / 3;
    CGFloat mobileRechargeBtnY = integralImportBtnY;
    CGFloat mobileRechargeBtnW = imageWithHigh;
    CGFloat mobileRechargeBtnH = imageWithHigh;
    self.mobileRechargeBtn.frame = CGRectMake(mobileRechargeBtnX, mobileRechargeBtnY, mobileRechargeBtnW, mobileRechargeBtnH);
    self.mobileRechargeImage.frame = self.mobileRechargeBtn.imageView.frame;
    // 手机充值标题
    CGFloat mobileRechargeTitleX = mobileRechargeBtnX;
    CGFloat mobileRechargeTitleY = integralImportTitleY;
    CGFloat mobileRechargeTitleW = imageWithHigh;
    CGFloat mobileRechargeTitleH = titleHigh;
    self.mobileRechargeTitle.frame = CGRectMake(mobileRechargeTitleX, mobileRechargeTitleY, mobileRechargeTitleW, mobileRechargeTitleH);
    
    // 积分抽奖按钮
    CGFloat integralLotteryBtnX = CGRectGetMaxX(self.mobileRechargeBtn.frame) + (WIDTH - 2 * paddin - 4 * imageWithHigh) / 3;
    CGFloat integralLotteryBtnY = integralImportBtnY;
    CGFloat integralLotteryBtnW = imageWithHigh;
    CGFloat integralLotteryBtnH = imageWithHigh;
    self.integralLotteryBtn.frame = CGRectMake(integralLotteryBtnX, integralLotteryBtnY, integralLotteryBtnW, integralLotteryBtnH);
    self.integralLotteryImage.frame = self.integralLotteryBtn.imageView.frame;
    // 积分抽奖标题
    CGFloat integralLotteryTitleX = integralLotteryBtnX;
    CGFloat integralLotteryTitleY = integralImportTitleY;
    CGFloat integralLotteryTitleW = imageWithHigh;
    CGFloat integralLotteryTitleH = titleHigh;
    self.integralLotteryTitle.frame = CGRectMake(integralLotteryTitleX, integralLotteryTitleY, integralLotteryTitleW, integralLotteryTitleH);
    
}

+ (PlatButtonView *)plantButton:(UIView *)view
{
    PlatButtonView *platBttonView = [[PlatButtonView alloc] init];
    return platBttonView;
}

- (void)buttonClickedAction:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(platButtonClickedAction:button:index:)]) {
        if (btn == self.integralImportBtn) {
            [self.delegate platButtonClickedAction:self button:btn index:0];
            
        } else if (btn == self.integralExchangeBtn) {
            [self.delegate platButtonClickedAction:self button:btn index:1];
            
        } else if (btn == self.mobileRechargeBtn) {
            [self.delegate platButtonClickedAction:self button:btn index:2];
            
        } else if (btn == self.integralLotteryBtn) {
            [self.delegate platButtonClickedAction:self button:btn index:3];
            
        }
    }
}

@end
