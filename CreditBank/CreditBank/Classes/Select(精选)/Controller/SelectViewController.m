//
//  SelectViewController.m
//  CreditBank
//
//  Created by Eric on 15/3/23.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "SelectViewController.h"
#import "IndexViewController.h"
#import "Push.h"
#import "HDTitleButton.h"
#import "PrefixHeader.pch"
#import "FocusModel.h"
#import "SliderView.h"
#import "PlatButtonView.h"
#import "MallCell.h"
#import "TicketCell.h"
#import "GameCell.h"
#import "GraphPasswdViewController.h"
#import "NavigationController.h"
#import "ShopIndexViewController.h"
#import "UpdateVersion.h"
#import "SingleLogin.h"
#import "AddIntegralSourceController.h"
#import "PlatButtonModel.h"
#import "ListModel.h"
#import "ImpotSuccessController.h"
#import "MJRefresh.h"
#import "IndexCache.h"
#import "NetWorkTools.h"

@interface SelectViewController () <SliderViewDelegate, UITableViewDataSource, UITableViewDelegate, PlatButtonViewDelegate, MallCellDelegate, TicketCellDelegate, GameCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
/**
 *  轮播图
 */
@property(nonatomic, weak) SliderView *sliderView;
/**
 *  快速入口的视图
 */
@property (nonatomic, weak) PlatButtonView *platView;


@property(nonatomic, strong) Push *push;
/**
 *  轮播图数据
 */
@property (nonatomic, strong) NSArray *focusArray;

@property (nonatomic, strong) NSArray *listArray;

/**
 *  快捷入口数据
 */
@property (nonatomic, strong) NSArray *platButtonArray;
/**
 *  提示版本更新类
 */
@property (nonatomic, strong) UpdateVersion *updateV;

@property (nonatomic, weak) HDTitleButton *titleButton;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, strong) IndexCache *cache;
/**
 *  网络监控类
 */
@property (nonatomic, strong) NetWorkTools *netWorkTools;
@end

@implementation SelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 当前用户是否可以在当前设备登陆
    [SingleLogin checkSingleDeviceLogin];
    
    // 提示版本更新
    UpdateVersion *UpdateV = [[UpdateVersion alloc] init];
    self.updateV = UpdateV;
    [UpdateV checkUpdateVersion];
    
    // 手势密码
    [GraphPasswdViewController showGraphPasswdController:self];
    
    [self setUpPush];

    // 1.设置自定义tableView
    [self setMyTableView];
    
    // 2.设置导航栏的内容
    [self setupNavBar];
    
    // 3.设置轮播图
    [self setSliderView];
    
    // 获取缓存数据
    [self getLocalCache];
    
    // 网络监控
    [self setUpNetWorkState];
}

/**
 *  注册消息推送
 */
- (void)setUpPush {
    
    // Push 注册本地通知 和 上报 Registration ID
    self.push = [[Push alloc] init];
    self.push.tabBarController = self.tabBarController;
}

/**
 *  网络监控
 */
- (void)setUpNetWorkState {
    self.netWorkTools = [[NetWorkTools alloc] init];
    self.netWorkTools.currentController = self.tabBarController;
    [self.netWorkTools checkNetworkState];
}



- (void)dealloc {
    self.netWorkTools = nil;
    self.cache = nil;
    self.push = nil;
}



/**
 *  cache 对象的懒加载
 */
- (IndexCache *)cache {
    if (_cache == nil) {
        _cache = [[IndexCache alloc] init];
    }
    
    return _cache;
}

#pragma mark -- 控件设置

/**
 *  设置自定义tableView
 */
- (void)setMyTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
//    [self.tableView registerClass:[MallCell class] forCellReuseIdentifier:@"mall"];
//    [self.tableView registerClass:[TicketCell class] forCellReuseIdentifier:@"ticket"];
//    [self.tableView registerClass:[GameCell class] forCellReuseIdentifier:@"game"];
    
    
    __weak typeof (self) weakSelf = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
         [weakSelf getInformationDate];
    }];
    
    // 3秒后自动恢复
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.header endRefreshing];
    });
    
    [self.tableView.legendHeader beginRefreshing];
    
}


/**
 *  设置轮播图
 */
- (void)setSliderView
{

    // 背景View
    UIView *headView = [[UIView alloc] init];
    
    // 轮播图
    SliderView *sliderView = [[SliderView alloc] init];
    sliderView.delegate    = self;
    
    CGFloat sliderViewX = 0;
    CGFloat sliderViewY = 0;
    CGFloat sliderViewW = WIDTH;
    CGFloat sliderViewH = WIDTH * 125 / 320;
    
    sliderView.frame = CGRectMake(sliderViewX, sliderViewY, sliderViewW, sliderViewH);
    [headView addSubview:sliderView];
    self.sliderView  = sliderView;
    
    // 专题按钮
    PlatButtonView *platView = [PlatButtonView plantButton:nil];
    platView.delegate = self;
    CGFloat platViewX = 0;
    CGFloat platViewY = CGRectGetMaxY(sliderView.frame);
    CGFloat platViewW = WIDTH;
    CGFloat platViewH = WIDTH * 80 / 320;
    platView.frame = CGRectMake(platViewX, platViewY, platViewW, platViewH);
    self.platView = platView;
    [headView addSubview:platView];
    
    headView.frame = CGRectMake(0, 0, WIDTH, sliderViewH + platViewH);
    self.tableView.tableHeaderView = headView;
    
    // 左右都可以滑动
    self.sliderView.ScrollToCenter = YES;

}

- (void)platButtonClickedAction:(UIView *)view button:(UIButton *)button index:(NSInteger)index
{
    // ANLog(@"---------------%ld", index);
    if (self.token == nil) {
        [Common userLogin:self];
    } else {
        PlatButtonModel *palButtnModel = self.platButtonArray[index];
        
        if ([palButtnModel.res_name isEqualToString:@"webview"]) {
            if (index == 2) {// 当是手机充值的时候跳转到importSuccess页
                ImpotSuccessController *importSuccess = [[ImpotSuccessController alloc] init];
                importSuccess.strUrl = palButtnModel.url;
                [self.navigationController pushViewController:importSuccess animated:YES];
            }
            else {
            ShopIndexViewController *shopIndexVc = [[ShopIndexViewController alloc] init];
            shopIndexVc.strUrl = palButtnModel.url;
            [self.navigationController pushViewController:shopIndexVc animated:YES];
            }
        }
        
        if ([palButtnModel.res_name isEqualToString:@"link"]) {
            AddIntegralSourceController *addIntegralSource = [[AddIntegralSourceController alloc] init];
            [self.navigationController pushViewController:addIntegralSource animated:YES];
        } else {
            
        }
    }
}

/**
 *  设置导航栏的内容
 */
- (void)setupNavBar
{
    // 中间的按钮
    HDTitleButton *titleButton = [HDTitleButton titleButton];
    titleButton.backgroundColor = HDColor(235, 235, 235);
    titleButton.titleLabel.font = [UIFont systemFontOfSize:12];
    titleButton.leftImage.image = [UIImage imageNamed:@"titleBtn_left"];
    
    // 图标
    [titleButton setImage:[UIImage imageWithName:@"titleBtn_right"] forState:UIControlStateNormal];
    // 位置和尺寸
    titleButton.frame = CGRectMake(0, 0, 0, 25);
    // 文字
    [titleButton setTitle:@"0" forState:UIControlStateNormal];
    
//    [titleButton addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.titleView = titleButton;
//    self.titleButton = titleButton;
}

#pragma mark -- 事件触发
/**
 *  标题按钮点击方法
 */
- (void)titleButtonClicked:(HDTitleButton *)titleButton
{
    if (self.token == nil) {
        [Common userLogin:self];
    } else {
        
        AddIntegralSourceController *addIntegralSource = [[AddIntegralSourceController alloc] init];
        [self.navigationController pushViewController:addIntegralSource animated:YES];
        
    }
}

/**
 *  轮播图点击
 */
- (void)SliderView:(SliderView *)view didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FocusModel *fModel = self.focusArray[indexPath.item % self.focusArray.count];
    if ([fModel.res_name isEqualToString:@"import"]) {
        AddIntegralSourceController *addIntegralSource = [[AddIntegralSourceController alloc] init];
        [self.navigationController pushViewController:addIntegralSource animated:YES];
    } else {
        ImpotSuccessController *shopIndexVc = [[ImpotSuccessController alloc] init];
        shopIndexVc.strUrl = fModel.link;
        [self.navigationController pushViewController:shopIndexVc animated:YES];
    }

}

#pragma mark -- tableViewdelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH - 100, 30)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, WIDTH/2, sectionView.frame.size.height)];
    titleLabel.font = [UIFont systemFontOfSize:14];
    [sectionView addSubview:titleLabel];
    
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeSystem];
    moreButton.titleLabel.font = [UIFont systemFontOfSize:13];
    moreButton.frame = CGRectMake(WIDTH - 60, 10, 60, sectionView.frame.size.height - 10);
    moreButton.titleLabel.font = [UIFont systemFontOfSize:12];
    moreButton.frame = CGRectMake(WIDTH - 50, 10, 40, sectionView.frame.size.height - 10);
    [moreButton setTitle:@"更多>>" forState:UIControlStateNormal];
    moreButton.tag = section + 10000;
    [moreButton addTarget:self action:@selector(moreButtonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    [sectionView addSubview:moreButton];
    
    ListModel *listModel = self.listArray[section];
    titleLabel.text = listModel.name;
    
    return sectionView;
}

- (void)moreButtonClickedAction:(UIButton *)btn
{
    ListModel *listModel = self.listArray[btn.tag - 10000];
    
    // 商城首页
    ShopIndexViewController *shopIndexVc = [[ShopIndexViewController alloc] init];
    shopIndexVc.strUrl = listModel.more_link;
    [self.navigationController pushViewController:shopIndexVc animated:YES];

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListModel *listModel = self.listArray[indexPath.section];

    if ([listModel.templateName isEqualToString:@"shop"]) {
        MallCell *mallCell = [MallCell mallCellView:tableView];
//        MallCell *mallCell = [tableView dequeueReusableCellWithIdentifier:@"mall"];
        mallCell.listModel = listModel;
        mallCell.delegate = self;
        return mallCell;
    } else if ([listModel.templateName isEqualToString:@"ticket"]) {
        TicketCell *ticketCell = [TicketCell tickCellView:tableView];
//        TicketCell *ticketCell = [tableView dequeueReusableCellWithIdentifier:@"ticket"];
        ticketCell.listModel = listModel;
        ticketCell.delegate = self;
        return ticketCell;
    } else {
        GameCell *gameCell = [GameCell gameCellView:tableView];
//        GameCell *gameCell = [tableView dequeueReusableCellWithIdentifier:@"game"];
        gameCell.listModel = listModel;
        gameCell.delegate = self;
        return gameCell;
    }
}
- (void)gameButtonClickedAction:(UIView *)view button:(UIButton *)button index:(NSInteger)index link:(NSString *)link
{
    ShopIndexViewController *shopIndexVc = [[ShopIndexViewController alloc] init];
    shopIndexVc.strUrl = link;
    [self.navigationController pushViewController:shopIndexVc animated:YES];
}
- (void)tickButtonClickedAction:(UIView *)view button:(UIButton *)button index:(NSInteger)index link:(NSString *)link
{
    ShopIndexViewController *shopIndexVc = [[ShopIndexViewController alloc] init];
    shopIndexVc.strUrl = link;
    [self.navigationController pushViewController:shopIndexVc animated:YES];
}
- (void)mallButtonClickedAction:(UIView *)view button:(UIButton *)button index:(NSInteger)index link:(NSString *)link
{
    ShopIndexViewController *shopIndexVc = [[ShopIndexViewController alloc] init];
    shopIndexVc.strUrl = link;
    [self.navigationController pushViewController:shopIndexVc animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListModel *listModel = self.listArray[indexPath.section];
    if ([listModel.templateName isEqualToString:@"shop"]) {
        return (WIDTH - 3 * MALL_CELL_PADDIN) * 0.5 + MALL_CELL_PADDIN;
    } else {
        return 2 * (WIDTH * 87 / 300 + MALL_CELL_PADDIN);
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBarController.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
    
    self.token = [Common token];
    NSString *creadit = [[NSUserDefaults standardUserDefaults] objectForKey:@"credit"];
    if (creadit != nil) {
        [self.titleButton setTitle:creadit forState:UIControlStateNormal];
    }

}

// 解析数据并刷新 tableview
- (void)parseLoadData:(NSDictionary *)responseObject {
    
    // ANLog(@"%@", responseObject);
    
    // 轮播图数据
    NSMutableArray *focTempArr = [NSMutableArray array];
    for (NSDictionary *dic in responseObject[@"focus"]) {
        FocusModel *focM = [FocusModel objectWithKeyValues:dic];
        [focTempArr addObject:focM];
    }
    
    self.focusArray = [NSArray arrayWithArray:focTempArr];
    self.sliderView.data = self.focusArray;
    [self.sliderView.collectionView reloadData];
    
    // 快捷入口数据
    NSMutableArray *platButtonTempArr = [NSMutableArray array];
    
    for (NSDictionary *dic in responseObject[@"imgs"]) {
        PlatButtonModel *platM = [PlatButtonModel objectWithKeyValues:dic];
        [platButtonTempArr addObject:platM];
    }
    
    self.platButtonArray = [NSArray arrayWithArray:platButtonTempArr];
    self.platView.platButtonDataArray = self.platButtonArray;
    
    // 列表数据
    NSMutableArray *listTempArr = [NSMutableArray array];
    for (NSDictionary *dic in responseObject[@"list"]) {
        ListModel *listModel = [ListModel objectWithKeyValues:dic];
        [listTempArr addObject:listModel];
    }
    self.listArray = [NSArray arrayWithArray:listTempArr];
    [self.tableView reloadData];
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

// 加载网络数据
- (void)getInformationDate
{
    NSString *time = [NSDate getTime];
    NSArray *arr = @[time];
    NSString *md5 = [Common paramsSign:arr];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                time, @"time",
                                md5, @"sign",
                                PLATFORMID, @"app_id", nil];
    
    AnRequest *anReq = [[AnRequest alloc] init];
    NSString *netStr = @"?anu=api/1/goods/jingxuan_info";
    [anReq post:netStr params:dictionary successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 保存网络数据
        [self.cache saveCacheData:responseObject];
        
        // 刷新数据
        [self parseLoadData:responseObject];
        
        [self.tableView.header endRefreshing];
        
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {

    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.header endRefreshing];
    });
}




@end
