//
//  SettingViewController.m
//  CreditBank
//
//  Created by Eric on 15/4/4.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "SettingViewController.h"
#import "settingGroup.h"
#import "SettingArrowItem.h"
#import "MBProgressHUD+MJ.h"
#import "StatementViewController.h"
#import "PrefixHeader.pch"
#import "BlueButtonView.h"
#import "GraphPasswdViewController.h"
#import "SetGraphPasswdViewController.h"
#import "GraphPasswdViewController.h"
#import "NavigationController.h"
#import "LogoutHandler.h"
#import "AboutViewController.h"
#import "FeedbackViewController.h"
#import "HelpViewController.h"
#import "SafeViewController.h"


#import "Common.h"
#import "MJExtension.h"
#import "UpdateM.h"
#import "AnRequest.h"


@interface SettingViewController () <BlueButtonViewDelegate,UIAlertViewDelegate, UIActionSheetDelegate>
@property(nonatomic, strong) UpdateM *updateM;

@end

@implementation SettingViewController

#pragma mark SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";

    BlueButtonView *btnView = [[BlueButtonView alloc] initWithBtnTitle:@"注销"];
    btnView.frame = CGRectMake(0, 0, self.view.frame.size.width, 47);
    btnView.delegate = self;
    self.tableView.tableFooterView  = btnView;
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [NavigationController setNavigationBarDefault:self];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backBarButtonItem"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonClick)];
    
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)leftBarButtonClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark  - BlueButtonViewDelegate
- (void)btnClick:(id)view btn:(UIButton *)btn {
    
    // 退出登录确认框
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"退出后不会删除任何历史数据，下登录依然可以使用本账号" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"退出登录" otherButtonTitles:nil, nil];
    
    sheet.delegate  = self;
    
    [sheet showInView:self.view];
}


#pragma mark -- actionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
        // 退出登录
        [LogoutHandler logoutHandlerFromControllor:self];
    }
}

#pragma mark -- Method

- (void)setUpData {
    [self setUpGroup1];
    [self setUpGroup2];
    [self setUpGroup3];
}

#pragma mark --- TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1;
    }
    
    return 0;
}


- (void)setUpGroup0 {
    
    settingGroup *group2   = [[settingGroup alloc] init];
    SettingItem *Remind = [SettingArrowItem arrowItemWithTitle:@"提醒设置" pushController:[StatementViewController class]];
    
    group2.items = @[Remind];
    [self.data addObject:group2];
    
}

- (void)setUpGroup1 {
    
    settingGroup *group2    = [[settingGroup alloc] init];
    
    __weak typeof(self) settingController = self;
    SettingItem *lockPasswd = [SettingArrowItem arrowItemWithTitle:@"密码锁定" pushController:nil];
    lockPasswd.option = ^(SettingItem *item) {
        
        // 密码存在，要先验证密码
        NSString *passwd = [SetGraphPasswdViewController getPasswd];
        if (passwd.length) {
            
            GraphPasswdViewController *graphVc = [[GraphPasswdViewController alloc] init];
            graphVc.top = settingController;
            graphVc.checkRsetPasswd = YES;
            [settingController.navigationController pushViewController:graphVc animated:YES];
            
        } else {
            
            // 密码不存在，要去设置
            SetGraphPasswdViewController *setGraphVc = [[SetGraphPasswdViewController alloc] init];
            setGraphVc.top = settingController;
            [settingController.navigationController pushViewController:setGraphVc animated:YES];
        }

    };
    
    SettingItem *safeInfo   = [SettingArrowItem arrowItemWithTitle:@"安全承诺" pushController:[SafeViewController class]];
    group2.items            = @[lockPasswd, safeInfo];
    [self.data addObject:group2];
    
}

- (void)setUpGroup2 {
    
    settingGroup *group2   = [[settingGroup alloc] init];
    SettingItem *help = [SettingArrowItem arrowItemWithTitle:@"使用帮助" pushController:[HelpViewController class]];
    SettingItem *feedback = [SettingArrowItem arrowItemWithTitle:@"意见反馈" pushController:[FeedbackViewController class]];

    group2.items = @[help,feedback];
    [self.data addObject:group2];
}

- (void)setUpGroup3 {
    
    settingGroup *group1 = [[settingGroup alloc] init];
    SettingItem *about = [SettingArrowItem arrowItemWithTitle:@"关于我们" pushController:[AboutViewController class]];
    
    group1.items = @[about];
    [self.data addObject:group1];
    
}


@end
