//
//  ShopIndexViewController.m
//  CreditBank
//
//  Created by 王德康 on 15/5/6.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "ShopIndexViewController.h"
#import "PrefixHeader.pch"
#import <ShareSDK/ShareSDK.h>
#import "MBProgressHUD+MJ.h"
#import "ShareSaveApi.h"
#import "SelectViewController.h"

@interface ShopIndexViewController ()

@end

@implementation ShopIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];

     self.url = (self.strUrl.length > 0) ? self.strUrl : @"?anu=m/shop";
    [self loadRequest];
    
}


/**
 *  商城分类导航
 */
- (void) navRightBtnClick {
    
    ShopIndexViewController *shopNavController = [[ShopIndexViewController alloc] init];
    shopNavController.strUrl  = @"?anu=m/shop/shop_nav";
    
    [self.navigationController pushViewController:shopNavController animated:YES];
}


- (void)shopShareBtnClick {
    
    NSString  *token  = [Common token];
    if (token == nil) {
        [Common userLogin:self];
        return;
    }

    // 拉取分享信息
    [super callHandler:@"getShareData" params:nil callBackHandler:^(id responseData) {
        // 分享
        // [ShareSaveApi shareContentFromDictionary:responseData showView:self.view token:token];
        [ShareSaveApi shareContentFromDictionary:responseData showView:self.view token:token shareSucc:^(id shareType) {
            ShopIndexViewController *shopIndexVc = [[ShopIndexViewController alloc] init];
            shopIndexVc.strUrl = @"?anu=m/credit/credit_earn";
            [self.navigationController pushViewController:shopIndexVc animated:YES];
        }];
    }];

}


/**
 *  所有的注册函数都必须写在这个方法中
 */
- (void) registerHandlerAll {
    
    
    __weak typeof(self) indexVC = self;
    // 设置商城首页的右侧按钮
    [super registerHandler:@"setShopNavigationItem" respconseCallBack:^(NSDictionary * responseData) {
        // 商城分类导航
        indexVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shop_nav"] style:UIBarButtonItemStyleDone target:indexVC action:@selector(navRightBtnClick)];
    }];
    
    // 设置商城首页的右侧按钮
    [super registerHandler:@"setShopShareNavigationItem" respconseCallBack:^(NSDictionary * responseData) {
        // 商城分类导航
        indexVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shop_share"] style:UIBarButtonItemStyleDone target:indexVC action:@selector(shopShareBtnClick)];
    }];
    
    // 调用登录窗口
    [super registerHandler:@"setUserLoginItem" respconseCallBack:^(NSDictionary * responseData) {
        [Common userLogin:indexVC];
    }];
    
    
    
    
}

@end
