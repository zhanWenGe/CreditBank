//
//  IntegralViewController.m
//  CreditBank
//
//  Created by Eric on 15/3/23.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "IntegralViewController.h"
#import "IndexCell.h"
#import "PrefixHeader.pch"
#import "IndexM.h"
#import "IndexF.h"
#import "IndexModuleM.h"
#import "IndexModuleF.h"
#import "IndexModuleCell.h"
#import "ModuleButton.h"
#import "AddIntegralSourceController.h"
#import "ImpotSuccessController.h"
#import "ShopIndexViewController.h"
#import "IntegralImportController.h"
#import "BankInfoModel.h"
#import "StatementAppViewController.h"
#import "MJRefresh.h"
#import "IntegralCache.h"

@interface IntegralViewController ()<IndexCellDelegate, IndexModuleCellDelegate>
@property (nonatomic, strong) IndexF *indexF;
@property (nonatomic, strong) IndexModuleF *indexModuleF;

@property (nonatomic, retain) BankInfoModel *bankModel;
@property (nonatomic, copy) NSString *credit;
@property (nonatomic, retain) NSDictionary *news;
@property (nonatomic, retain) NSArray *buttonDataArray;
@property (nonatomic, copy) NSString *newsUrlString;
@property (nonatomic, copy) NSString *token;

@property (nonatomic, strong) IntegralCache *cache;

@end

@implementation IntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.token = [Common token];
    // 1.设置导航栏的内容
    [self setupNavBar];
//    [self getData:@"?anu=api/1/credit/get_credit_index"];
    
    // 获取缓存数据
    [self getLocalCache];
    
    self.view.backgroundColor = DEFALT_BG;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // userId Change
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticicationUserIdChangeId:) name:@"ChangeToken" object:nil];
    
    __weak typeof (self) weakSelf = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf getData:@"?anu=api/1/credit/get_credit_index"];
    }];
    
    // 3秒后自动恢复
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.header endRefreshing];
    });
    
    [self.tableView.legendHeader beginRefreshing];
       
}

// 加载本地缓存
- (void)getLocalCache {
    
    // 保存网络数据
    NSDictionary *json = [self.cache getCacheData];
    if (json != nil) {
        NSDictionary *responseObject = [json objectForKey:@"json"];
        // 刷新数据
        [self parseLoadData:responseObject];
        
    }
}

/**
 *  cache 对象的懒加载
 */
- (IntegralCache *)cache {
    if (_cache == nil) {
        _cache = [[IntegralCache alloc] init];
    }
    
    return _cache;
}

/**
 *  退出登录的通知
 */
- (void)noticicationUserIdChangeId:(NSNotification *)notification {
    self.token = [[notification userInfo] valueForKey:@"token"];
    if (self.token == nil) {
        // 回复默认数据
        ANLog(@"恢复默认数据");
    } else {
        // 拉取数据
         ANLog(@"拉取默认数据");
        [self getData:@"?anu=api/1/credit/get_credit_index"];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/**
 *  设置导航栏的内容
 */
- (void)setupNavBar
{
    // 左边的按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"对账单" style:UIBarButtonItemStylePlain target:self action:@selector(navLeftClickedAction:)];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStylePlain target:self action:@selector(navRightClickedAction:)];
    
}

/**
 *  nav左边对账单的点击事件
 */
- (void)navLeftClickedAction:(UIButton *)btn
{
    if (self.token == nil) {
        [Common userLogin:self];
    } else {
        StatementAppViewController *vc = [[StatementAppViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

/**
 *  nav右边的添加按钮的点击事件
 */
- (void)navRightClickedAction:(UIButton *)btn
{
    if (self.token == nil) {
        [Common userLogin:self];
    } else {
        AddIntegralSourceController *addIntegralSource = [[AddIntegralSourceController alloc] init];
        [self.navigationController pushViewController:addIntegralSource animated:YES];
    }
}

- (IndexF *) indexF {
    IndexM *m = [[IndexM alloc] init];
    m.integralLabelTitle = self.credit;
    m.recommendLabelTitle = self.news[@"title"];
    
    if (self.bankModel.bank_id.length != 0) {

        m.importPromptLabelTitle = [NSString stringWithFormat:@"您的%@有%@积分可导入", self.bankModel.bank_info, self.bankModel.bank_credit];
    }
    _indexF = [[IndexF alloc] init];
    _indexF.model = m;
    return _indexF;
}

- (IndexModuleF *)indexModuleF {
    
    IndexModuleF *f = [[IndexModuleF alloc] init];
    f.dataM = self.buttonDataArray;
    _indexModuleF = f;
    
    return _indexModuleF;
}

#pragma mark tableView -- DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat h;
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        h = self.indexF.cellHeight;
    } else {
        h = self.indexModuleF.cellHeight;
    }
    
    return h;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        IndexCell *cell = [IndexCell indexCellWithTableView:tableView];
        cell.delegate = self;
        cell.indexFrame = self.indexF;
        return cell;
    } else {
        IndexModuleCell *cell = [IndexModuleCell indexModuleCellWithTableView:tableView moduleCount:self.buttonDataArray.count];
        cell.data = self.buttonDataArray;
        cell.indexModuleF = self.indexModuleF;
        cell.delegate = self;
        return  cell;
    }

    return nil;
}

#pragma mark - IndexCell Delegate

/**
 *  导出积分立即查看
 */
- (void)IndexCell:(IndexCell *)cell importPromptBtnClick:(UIButton *)btn {
    ANLog(@" importPromptBtnClick");
    
    if (self.token == nil) {
        [Common userLogin:self];
    } else {
        IntegralImportController *integralImport = [[IntegralImportController alloc] init];
        integralImport.bankInfoM = self.bankModel;
        [self.navigationController pushViewController:integralImport animated:YES];
    }
}
/**
 *  赚取积分
 */
- (void)IndexCell:(IndexCell *)cell recommendBtnClick:(UIButton *)btn {
//    ANLog(@" recommendBtn Click");
    
    if (self.token == nil) {
        [Common userLogin:self];
    } else {
        ImpotSuccessController *importController = [[ImpotSuccessController alloc] init];
        importController.strUrl  = @"?anu=m/credit/credit_earn";
        
        [self.navigationController pushViewController:importController animated:YES];
    }
    
}
/**
 *  问号按钮
 */
- (void)IndexCell:(IndexCell *)cell helpBtnClick:(UIButton *)btn {
//    ANLog(@"help BtnClick");
    ImpotSuccessController *shopNavController = [[ImpotSuccessController alloc] init];
    shopNavController.strUrl  = self.newsUrlString;
    
    [self.navigationController pushViewController:shopNavController animated:YES];
    
}

#pragma mark - IndexModuleCell Delegate
/**
 *  模块点击的事件
 */
- (void)cell:(IndexModuleCell *)cell btnClick:(ModuleButton *)btn {
    
    IndexModuleM *indexM = self.buttonDataArray[btn.tag - 100];
    
    if (self.token == nil) { // 如果token为空,用户登录
        [Common userLogin:self];
    } else {
        if (btn.tag == 100) { // 跳转到换购页面, 此时需要右上角的更多按钮(用ShopIndexViewController)
            ShopIndexViewController *shopNavController = [[ShopIndexViewController alloc] init];
            shopNavController.strUrl  = indexM.url;
            [self.navigationController pushViewController:shopNavController animated:YES];
        } else { // 跳转到其余的页面
            if ([indexM.res_name isEqualToString:@"webview"]) {
                ImpotSuccessController *importNavController = [[ImpotSuccessController alloc] init];
                importNavController.strUrl  = indexM.url;
                [self.navigationController pushViewController:importNavController animated:YES];
            }
        }
    }
}

/**
 *  获取数据
 */
- (void)getData:(NSString *)netString
{
    if (self.token == nil) {
        
        [self postUserIdGetData:netString token:@"0"];
    } else {
        
        [self postUserIdGetData:netString token:self.token];
    }
}

- (void)postUserIdGetData:(NSString *)netString token:(NSString *)token
{
    NSString *time = [NSDate getTime];
    NSArray *arr = @[token, time];
    NSString *md5 = [Common paramsSign:arr];
    NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                 token, @"token",
                                 time, @"time",
                                 md5, @"sign",
                                 PLATFORMID, @"app_id", nil];
    
    AnRequest *anReq = [[AnRequest alloc] init];
    [anReq post:netString params:dictionary successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 保存网络数据
        [self.cache saveCacheData:responseObject];
        
        // 刷新数据
        [self parseLoadData:responseObject];

        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        ANLog(@"error: %@", operation);
        [self setAlertViewWithMessage:responseObject[@"error_info"]];
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        ANLog(@"fail: %@", error);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.header endRefreshing];
    });
}

// 解析数据并刷新 tableview
- (void)parseLoadData:(NSDictionary *)responseObject {
    
    NSArray *allKey = [responseObject allKeys];
    
    // 图标模块
    if ([allKey containsObject:@"imgs"]) {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[@"imgs"]) {
            IndexModuleM *indexModuleM = [IndexModuleM objectWithKeyValues:dic];
            [tempArray addObject:indexModuleM];
        }
        self.buttonDataArray = tempArray;
    }
    
    // 银行优惠
    if ([allKey containsObject:@"bank"]) {
        self.bankModel = [BankInfoModel objectWithKeyValues:responseObject[@"bank"]];
    }
    
    // 积分信息
    if ([allKey containsObject:@"credit"]) {
        self.credit = [NSString stringWithFormat:@"%@", responseObject[@"credit"]];
    }
    
    // 新闻
    if ([allKey containsObject:@"news"]) {
        self.news = [[NSDictionary alloc] initWithDictionary:responseObject[@"news"]];
    }
    
    // 新闻URL
    if ([allKey containsObject:@"news_url"]) {
        self.newsUrlString = responseObject[@"news_url"];
    }
}

/**
 *  填出提示框
 *
 *  @param message 提示信息
 */
- (void)setAlertViewWithMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles:nil, nil];
    [alertView show];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBarController.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

@end
