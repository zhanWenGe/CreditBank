//
//  BankCardDetailsController.m
//  CreditBank
//
//  Created by Eric on 15/4/21.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "BrankCardDetailsController.h"
#import "settingGroup.h"
#import "SettingArrowItem.h"
//#import "SettingItem.h"
#import "CardDetailView.h"
#import "LotteryViewController.h"
#import "PrefixHeader.pch"
//#import "MBProgressHUD+MJ.h"
//#import "UserInfoView.h"
#import "BrankCardM.h"
#import "IntegralImportController.h"
#import "BankInfoModel.h"


@interface BrankCardDetailsController ()

@property (nonatomic, weak) CardDetailView *cardDetail;




@end

@implementation BrankCardDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的银行卡详情";    
    
}

- (void)setUpData
{
    [self setUpGroupIntroduce];
    [self setUpGroupImportIntegral];
}

- (void)setUpGroupIntroduce
{
    settingGroup *groupIntroduce   = [[settingGroup alloc] init];
    SettingItem *customViewItem = [SettingItem itemWithIcon:nil title:nil];
    
    CardDetailView *cardDetail = [[CardDetailView alloc] init];
    cardDetail.frame = CGRectMake(0, 0, self.view.frame.size.width, 70);
    cardDetail.brankCardModel = self.brankCardModel;
    customViewItem.height = 70;
    customViewItem.customView  = cardDetail;
    self.cardDetail = cardDetail;
    
    groupIntroduce.items = @[customViewItem];
    [self.data addObject:groupIntroduce];
}

- (void)setUpGroupImportIntegral
{
    settingGroup *groupImportIntegral = [[settingGroup alloc] init];
    SettingItem *importIntegral = [SettingArrowItem arrowItemWithTitle:[NSString stringWithFormat:@"   可导入 %@ 积分", self.brankCardModel.credit] pushController:nil];
    __weak typeof(self) brankCardDetail = self;
    importIntegral.option = ^(SettingItem *item){
        [brankCardDetail setClickedAction];
    };
    importIntegral.height = 49;
    importIntegral.titleColor = HDColor(13, 12, 12);
    groupImportIntegral.items = @[importIntegral];
    [self.data addObject:groupImportIntegral];
}


- (void)setClickedAction
{
    ANLog(@"setClickedAction");
    NSDictionary *tempDic = [NSDictionary dictionaryWithObjectsAndKeys:
                             self.brankCardModel.credit, @"bank_credit",            // 银行积分
                             self.brankCardModel.card_name, @"bank_info",           // 银行名称
                             self.brankCardModel.card_no_tail, @"bank_number",      // 银行卡尾号
                             self.brankCardModel.bank_rate, @"bank_rate",           // 汇率
                             self.brankCardModel.card_no, @"card_no",               // 卡号(全)
                             self.brankCardModel.bank_id, @"bank_id",               // 银行id
                             self.brankCardModel.is_credit_card, @"is_credit_card", nil];   // 是否为信用卡
                             
    BankInfoModel *bankInM = [BankInfoModel objectWithKeyValues:tempDic];
    
    
    ANLog(@"temp : %@", tempDic);
    IntegralImportController *integralImport = [[IntegralImportController alloc] init];
    integralImport.title = self.title;
    integralImport.bankInfoM = bankInM;
    [self.navigationController pushViewController:integralImport animated:YES];
}

@end
