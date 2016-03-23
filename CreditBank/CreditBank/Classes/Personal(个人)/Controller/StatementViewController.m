//
//  StatementViewController.m
//  CreditBank
//
//  Created by Eric on 15/3/29.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "StatementViewController.h"
#import "PrefixHeader.pch"
#import <ShareSDK/ShareSDK.h>
#import "MBProgressHUD+MJ.h"

@interface StatementViewController ()

@end

@implementation StatementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.url = self.strUrl;
    [self loadRequest];
    
}


/**
 *  所有的注册函数都必须写在这个方法中
 */
- (void) registerHandlerAll {
    
    
//    __weak typeof(self) indexVC = self;
//    
//    // 银行卡积分导入成功 (继续导入按钮)
//    [super registerHandler:@"setBankCardContinueToImport" respconseCallBack:^(NSDictionary * responseData) {
//        // 银行卡积分导入成功
//        [indexVC.navigationController popToViewController:indexVC.navigationController.childViewControllers[1] animated:YES];
//    }];
//    
//    // 充值卡积分充值成功 (继续导入按钮)
//    [super registerHandler:@"setPrepaidContinueToImport" respconseCallBack:^(NSDictionary * responseData) {
//        // 充值卡积分充值成功
//        ANLog(@"充值卡积分充值成功 (继续导入按钮)");
//    }];
//    
//    
//    
//    
//    // 银行卡积分导入成功 (完成按钮)
//    [super registerHandler:@"setBankCardImportSuccess" respconseCallBack:^(NSDictionary * responseData) {
//        // 银行卡积分导入成功
//        [indexVC.navigationController popToRootViewControllerAnimated:YES];
//        
//        ANLog(@"银行卡积分导入成功");
//    }];
//    
//    // 充值卡积分充值成功 (完成按钮)
//    [super registerHandler:@"setPrepaidImportSuccess" respconseCallBack:^(NSDictionary * responseData) {
//        // 充值卡积分充值成功
//        //        indexVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shop_share"] style:UIBarButtonItemStyleDone target:indexVC action:@selector(shopShareBtnClick)];
//        ANLog(@"充值卡积分充值成功");
//        
//        [indexVC.navigationController popToRootViewControllerAnimated:YES];
//    }];
    
    
}

@end
