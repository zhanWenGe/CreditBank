//
//  ImpotSuccessController.m
//  CreditBank
//
//  Created by Eric on 15/5/13.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "ImpotSuccessController.h"
#import "PrefixHeader.pch"
#import <ShareSDK/ShareSDK.h>
#import "MBProgressHUD+MJ.h"
#import "AddIntegralSourceController.h"
#import "NSAddressBookUI.h"
#import "AddressBookM.h"
#import "ShareSaveApi.h"

#import "ShopIndexViewController.h"


@interface ImpotSuccessController ()<NSAddressBookUIDelegate>
@property(nonatomic, strong) NSAddressBookUI *addressBookUI;
@end

@implementation ImpotSuccessController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.url = self.strUrl;
    [self loadRequest];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:@"shareSuccess" object:@"canshu"];
    
}
//- (void)notificationAction:(NSNotification *)notification
//{
//    ANLog(@"%@", [notification.userInfo objectForKey:@"res_name"]);
//    if (notification.userInfo) {
//
//        [self postShareEarnCreditInfomation:@"?anu=api/1/credit_earn/earn_credit" resName:[notification.userInfo objectForKey:@"res_name"]];
//    } else {
//        self.url = @"?anu=m/credit/credit_earn";
//        [self loadRequest];
//    }
//}

/**
 *  手机充值历史
 */
- (void)setMobileTopItem {
    ImpotSuccessController *indexVc = [[ImpotSuccessController alloc] init];
    indexVc.strUrl = @"?anu=m/charge/history";
    [self.navigationController pushViewController:indexVc animated:YES];
    
}

/**
 *  所有的注册函数都必须写在这个方法中
 */
- (void) registerHandlerAll {
    
    
    __weak typeof(self) indexVC = self;
    
    // 银行卡积分导入成功 (继续导入按钮)
    [super registerHandler:@"setBankCardContinueToImport" respconseCallBack:^(NSDictionary * responseData) {
        NSDictionary *tokenDictionary = [NSDictionary dictionaryWithObject:[Common token] forKey:@"token"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeToken" object:nil userInfo:tokenDictionary];
        // 银行卡积分导入成功
        [indexVC.navigationController popToViewController:indexVC.navigationController.childViewControllers[1] animated:YES];
    }];
    
    // 充值卡积分充值成功 (继续导入按钮)
    [super registerHandler:@"setPrepaidContinueToImport" respconseCallBack:^(NSDictionary * responseData) {
        NSDictionary *tokenDictionary = [NSDictionary dictionaryWithObject:[Common token] forKey:@"token"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeToken" object:nil userInfo:tokenDictionary];
        // 充值卡积分充值成功
        ANLog(@"充值卡积分充值成功 (继续导入按钮)");
    }];
    
    
    // 银行卡积分导入成功 (完成按钮)
    [super registerHandler:@"setBankCardImportSuccess" respconseCallBack:^(NSDictionary * responseData) {
        // 银行卡积分导入成功
        
        ANLog(@"银行卡积分导入成功  %@", responseData[@"credit"]);
        NSDictionary *tokenDictionary = [NSDictionary dictionaryWithObject:[Common token] forKey:@"token"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeToken" object:nil userInfo:tokenDictionary];
        [indexVC.navigationController popToRootViewControllerAnimated:YES];
        
        ANLog(@"银行卡积分导入成功");
    }];
    
    // 充值卡积分充值成功 (完成按钮)
    [super registerHandler:@"setPrepaidImportSuccess" respconseCallBack:^(NSDictionary * responseData) {
        // 充值卡积分充值成功
        ANLog(@"充值卡积分充值成功");
        NSDictionary *tokenDictionary = [NSDictionary dictionaryWithObject:[Common token] forKey:@"token"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeToken" object:nil userInfo:tokenDictionary];
        [indexVC.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    // 设置手机充值历史按钮
    [super registerHandler:@"setMobileTopItem" respconseCallBack:^(NSDictionary * responseData) {
        // 充值历史
        indexVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mobile_history"] style:UIBarButtonItemStyleDone target:indexVC action:@selector(setMobileTopItem)];
    }];
    
    // 手机充值页面   跳转赚取积分
    [super registerHandler:@"setCreditEarnItem" respconseCallBack:^(NSDictionary * responseData) {
        ImpotSuccessController *importVc = [[ImpotSuccessController alloc] init];
        importVc.strUrl = @"?anu=m/credit/credit_earn";
        [indexVC.navigationController pushViewController:importVc animated:YES];
    }];
    
    // 打开通讯录
    [super registerHandler:@"setShowAddBookController" respconseCallBack:^(NSDictionary * responseData) {
        
        NSAddressBookUI *addressBookUI = [[NSAddressBookUI alloc] init];
        addressBookUI.delegate = indexVC;
        [addressBookUI callAddressUI:indexVC];
        indexVC.addressBookUI = addressBookUI;
    }];
    
    // 手机充值成功页面出现时调用
    [super registerHandler:@"setMobilTopUpSuccess" respconseCallBack:^(id responseData) {
        ANLog(@"手机充值成功页面出现");
        NSDictionary *tokenDictionary = [NSDictionary dictionaryWithObject:[Common token] forKey:@"token"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeToken" object:nil userInfo:tokenDictionary];
    }];
    
    // 手机充值成功页面的分享到朋友圈按钮点击时调用
    [super registerHandler:@"setShareContent" respconseCallBack:^(id responseData) {
        // 分享
        NSString *token = [Common token];
        [ShareSaveApi shareContentFromDictionary:responseData showView:self.view token:token shareSucc:^(id shareType) {
            ImpotSuccessController *importIndexVc = [[ImpotSuccessController alloc] init];
            importIndexVc.strUrl = @"?anu=m/credit/credit_earn";
            [self.navigationController pushViewController:importIndexVc animated:YES];
        }];
    }];
    
    // 积分兑换,确认兑换
    [super registerHandler:@"setMakeSureChangeCredit" respconseCallBack:^(NSDictionary * responseData) {
        // 通知登录成功
        NSDictionary *tokenDictionary = [NSDictionary dictionaryWithObject:[Common token] forKey:@"token"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeToken" object:nil userInfo:tokenDictionary];
    }];
    
    // 赚取积分页面  领取积分
    [super registerHandler:@"setDoTheTaskToReceiveCredit" respconseCallBack:^(NSDictionary * responseData) {
        ANLog(@"领取积分");
        NSDictionary *tokenDictionary = [NSDictionary dictionaryWithObject:[Common token] forKey:@"token"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeToken" object:nil userInfo:tokenDictionary];
    }];
    
    // 游戏礼包 (积分兑换)
    [super registerHandler:@"setGameExchangeCredit" respconseCallBack:^(id responseData) {
        
        NSDictionary *tokenDictionary = [NSDictionary dictionaryWithObject:[Common token] forKey:@"token"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeToken" object:nil userInfo:tokenDictionary];
    }];
    
}


#pragma mark -- NSAddressBookUIDelegate
- (void)NSAddressBookUI:(NSAddressBookUI *)addressBook didSelectedPeopleProperty:(AddressBookM *)bookModel {
    ANLog(@"%@", bookModel);
     [super callHandler:@"setPhoneNum" params:[NSDictionary dictionaryWithObject:bookModel.tel forKey:@"phone"]];
}

//- (void)postShareEarnCreditInfomation:(NSString *)netString resName:(NSString *)resName
//{
//    NSString *token = [Common token];
//    NSString *res_name = resName;
//    NSString *time = [NSDate getTime];
//    
//    NSArray *arr = @[token, resName, time];
//    NSString *md5 = [Common paramsSign:arr];
//    
//    NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
//                                 token, @"token",
//                                 res_name, @"res_name",
//                                 time, @"time",
//                                 md5, @"sign",
//                                 PLATFORMID, @"app_id", nil];
//    ANLog(@"--->>>--- : %@", dictionary);
//    
//    AnRequest *anReq = [[AnRequest alloc] init];
//    [anReq post:netString params:dictionary successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        ANLog(@"%@", responseObject);
//        self.url = @"?anu=m/credit/credit_earn";
//        [self loadRequest];
//        
//    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
//        ANLog(@"error: %@", operation);
//    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
//        ANLog(@"fail: %@", error);
//    }];
//}

@end
