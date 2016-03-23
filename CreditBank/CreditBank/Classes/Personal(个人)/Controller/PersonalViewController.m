//
//  PersonalViewController.m
//  CreditBank
//
//  Created by Eric on 15/3/29.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "PersonalViewController.h"
#import "settingGroup.h"
#import "SettingArrowItem.h"
#import "MBProgressHUD+MJ.h"
#import "OrderViewController.h"
#import "LotteryViewController.h"
#import "TicketViewController.h"
#import "FavViewController.h"
#import "UserInfoView.h"
#import "CreditListViewController.h"
#import "CardListViewController.h"
#import "ProfileControllerView.h"
#import "SettingViewController.h"
#import "PrefixHeader.pch"
#import "MessageViewController.h"
#import "UserCenterModel.h"
#import "ImpotSuccessController.h"
#import "AddIntegralSourceController.h"
#import "StatementAppViewController.h"
#import "PersonalCache.h"
#import "MJRefresh.h"


@interface PersonalViewController ()<UserInfoViewDelegate>

@property (nonatomic, strong) NSDictionary *userCenterData;
@property (nonatomic, strong) UserInfoView *userInfoView;
@property (nonatomic, strong) UserCenterModel *userCenterModel;

@property (nonatomic, weak) SettingItem *lottery;
@property (nonatomic, weak) SettingItem *ticket;
@property (nonatomic, weak) SettingItem *fav;

@property (nonatomic, copy) NSString *token;
// 数据缓存对象
@property (nonatomic, strong) PersonalCache *cache;


@end

@implementation PersonalViewController


#pragma mark -- 缓存处理
/**
 *  cache 对象的懒加载
 */
- (PersonalCache *)cache {
    if (_cache == nil) {
        _cache = [[PersonalCache alloc] init];
    }
    
    return _cache;
}

// 加载本地缓存
- (void)getLocalCache {
    
    // 保存网络数据
    NSDictionary *json = [self.cache getCacheData:[Common token]];
    if (json != nil) {
        NSDictionary *responseObject = [json objectForKey:@"json"];
        // 刷新数据
        [self parseLoadData:responseObject];
        
    } 
}


#pragma mark -- UserInfoViewDelegateEvent
/**
 *  添加银行卡
 */
- (void)userInfoViewAddBrankCard:(UserInfoView *)view addButton:(AddBrankCardButton *)btn
{
    if (self.token == nil) {
        [Common userLogin:self];
    } else {
        AddIntegralSourceController *addIntegralSource = [[AddIntegralSourceController alloc] init];
        [self.navigationController pushViewController:addIntegralSource animated:YES];
    }
//    ANLog(@"添加银行卡");
}

/**
 *  积分点击
 */
- (void)userInfoViewCreditBtnDown:(UserInfoView *)view CreditButton:(CreditButton *)btn{
    if (self.token == nil) {
        [Common userLogin:self];
    } else {
    
        AddIntegralSourceController *addIntegralSource = [[AddIntegralSourceController alloc] init];
        [self.navigationController pushViewController:addIntegralSource animated:YES];
        
    }
}

/**
 *  银行列表按钮点击
 */
- (void)userInfoViewBrankBtnDown:(UserInfoView *)view BrankButton:(CreditButton *)btn {
    if (self.token == nil) {
        [Common userLogin:self];
    } else {
        CardListViewController *brankController = [[CardListViewController alloc] init];
        brankController.token = self.token;
        [self.navigationController pushViewController:brankController animated:YES];
    }
//    ANLog(@"银行列表按钮点击");
}

/**
 *  消息按钮的点击
 */
- (void)userInfoViewMessageBtnClicked:(UIButton *)btn
{
    if (self.token == nil) {
        [Common userLogin:self];
    } else {
        
        MessageViewController *messageVC = [[MessageViewController alloc] init];
        messageVC.title = @"消息";
        messageVC.token = self.token;
        [self.navigationController pushViewController:messageVC animated:YES];
    }

}

#pragma mark --- TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1;
    }
    
    return 0;
}

#pragma mark --- Controller Method

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    ANLog(@"%@",path);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settingIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(settingClick)];
    
    self.token = [Common token];
    
    // userId Change
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticicationUserIdChangeId:) name:@"ChangeToken" object:nil];
    
    __weak typeof (self) weakSelf = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf getPersonalInfoDate];
    }];
    
    // 5秒后自动恢复
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.header endRefreshing];
    });
    
    if (self.token) {
        [self.tableView.legendHeader beginRefreshing];
    }


}

/**
 *  退出登录的通知
 */
- (void)noticicationUserIdChangeId:(NSNotification *)notification {
   self.token = [[notification userInfo] valueForKey:@"token"];
    if (self.token == nil) {
        [self setDefaultData];
         ANLog(@"个人中心-恢复默认数据");
    } else {
        ANLog(@"个人中心-拉取数据");
        // 拉取数据
        [self getPersonalInfoDate];
    }
}

/**
 *  设置用户未登录默认数据
 */
- (void)setDefaultData {
    
    ANLog(@"setDefaultData");
    UserCenterModel *userModel = [[UserCenterModel alloc]init];
    
    // 默认头像
    userModel.avatar = @"";
    
    // 电话
    userModel.mobile = @"未登录";
    
    // 银行卡
    userModel.card_num = @"0";
    
    // 积分
    userModel.credit = @"0";
    
    // 安全等级
    userModel.safe_level = 0;
    
    self.userInfoView.userCenterModel = userModel;
    
    [self.tableView reloadData];

    [self.tableView.header endRefreshing];

}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 设置控制器
- (void)settingClick {
    if (self.token == nil) {
        [Common userLogin:self];
    } else {
        SettingViewController *vc = [[SettingViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)setUpData {
    [self setUpGroup0];
    [self setUpGroup1];
    [self setUpGroup2];

    
    ANLog(@"%@",   self.token);
    
    // 用户登录加载缓存数据(注意数据初始化，必须在此)
    if (self.token) {
        ANLog(@"getLocalCache");
        [self getLocalCache];
    } else {
        // 显示默认数据
        [self setDefaultData];
    }
}


- (void)setUpGroup0 {
    settingGroup *group0   = [[settingGroup alloc] init];
    SettingItem *customViewItem = [SettingItem itemWithIcon:nil title:nil];
    
    UserInfoView *userInfoView = [[UserInfoView alloc] init];
    userInfoView.delegate = self;
    userInfoView.frame = CGRectMake(0, 0, self.view.frame.size.width, 120);
    userInfoView.backgroundColor = [UIColor grayColor];
    customViewItem.height = 121;
    customViewItem.customView  = userInfoView;
    self.userInfoView = userInfoView;
    
    
    
    __weak typeof(self) Personal = self;
    customViewItem.option = ^(SettingItem *item){
        
        if (Personal.token == nil) {
            [Common userLogin:Personal];
        } else {
            ProfileControllerView *profileController = [[ProfileControllerView alloc] init];
            profileController.token = Personal.token;
            
            //更改头像的block
            [profileController changeImageWithBlock:^(UIImage *image) {
                Personal.userInfoView.avatarImageView.image = image;
            }];
            
            [Personal.navigationController pushViewController:profileController animated:YES];
        }
    };
    
    group0.items = @[customViewItem];
    [self.data addObject:group0];
}


- (void)setUpGroup2 {
    
    settingGroup *group2   = [[settingGroup alloc] init];
    SettingItem *statement = [SettingArrowItem arrowItemWithIcon:@"Cell_Statement"
                                                               title:@"对账单"
                                                  pushController:nil];
    __weak typeof(self) personal = self;
    statement.option = ^(SettingItem *item){
        
        if (self.token == nil) {
            [Common userLogin:self];
            return;
        }
        
        StatementAppViewController *statementController = [[StatementAppViewController alloc] init];
        [personal.navigationController pushViewController:statementController animated:YES];
        
    };
    
    group2.items = @[statement];
    [self.data addObject:group2];
    
}

- (void)setUpGroup1 {
    
    settingGroup *group1 = [[settingGroup alloc] init];
    SettingItem *lottery = [SettingArrowItem arrowItemWithIcon:@"Cell_Lottery"
                                                         title:@"抽奖记录"
                                                pushController:nil];
    self.lottery = lottery;
    
//    __weak typeof(self) Personal = self;
//    lottery.option = ^(SettingItem *item){
//        LotteryViewController *lotteryController = [[LotteryViewController alloc] init];
//        if (Personal.token == nil) {
//            [Common userLogin:Personal];
//        } else {
//            lotteryController.token = Personal.token;
//            [Personal.navigationController pushViewController:lotteryController animated:YES];
//        }
//    };
    
    
    SettingItem *ticket  = [SettingArrowItem arrowItemWithIcon:@"Cell_Ticket"
                                                         title:@"我的票务"
                                                pushController:nil];
    self.ticket = ticket;
    SettingItem *fav     = [SettingArrowItem arrowItemWithIcon:@"Cell_Fav"
                                                         title:@"我的收藏"
                                                pushController:nil];
    fav.option = ^(SettingItem *item){
        
//        StatementViewController *statementViewController = [[StatementViewController alloc] init];
//        statementViewController.strUrl  = @"?anu=m/user/center/fav";
        
        // [Personal.navigationController pushViewController:statementViewController animated:YES];
    };
    
    self.fav = fav;
    group1.items = @[lottery, ticket, fav];
    [self.data addObject:group1];
    
}


/**
 * 解析数据并刷新 tableview
 */
- (void)parseLoadData:(NSDictionary *)responseObject {
    
    UserCenterModel *userModel = [UserCenterModel objectWithKeyValues:responseObject];
    self.userInfoView.userCenterModel = userModel;
    [self.tableView reloadData];
}


- (void)getPersonalInfoDate
{
    
    if (self.token == nil) {
        [self setDefaultData];
//        [Common userLogin:self];
    } else {
        
        NSString *time = [NSDate getTime];
        NSArray *arr = @[self.token, time];
        NSString *md5 = [Common paramsSign:arr];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    self.token, @"token",
                                    time, @"time",
                                    md5, @"sign",
                                    PLATFORMID, @"app_id", nil];
        
        AnRequest *anReq = [[AnRequest alloc] init];
        NSString *netStr = @"?anu=api/1/user/get_user_related";
        [anReq get:netStr params:dictionary successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
            
               NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
               NSLog(@"%@", path);
            
            // 解析数据
            [self parseLoadData:responseObject];
            
            // 保存网络数据
            [self.cache saveCacheData:responseObject token:[Common token]];
            
            [self.tableView.header endRefreshing];

            
        } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
            ANLog(@"filed responseObject : %@", responseObject);
        } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
            ANLog(@"error : %@", error);
        }];
    }
}

@end
