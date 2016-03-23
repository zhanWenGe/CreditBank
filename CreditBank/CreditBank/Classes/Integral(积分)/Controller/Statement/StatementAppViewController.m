//
//  StatementAppViewController.m
//  CreditBank
//
//  Created by 王德康 on 15/6/3.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "StatementAppViewController.h"
#import "StatementCell.h"
#import "UnlineButton.h"
#import "CateButton.h"
#import "CateSubButton.h"
#import "PrefixHeader.pch"
#import "StatementM.h"
#import "StatementList.h"
#import "MBProgressHUD+MJ.h"
#import "StatementNetWork.h"
#import "MJRefresh.h"

@interface StatementAppViewController ()<UITableViewDataSource, UITableViewDelegate, StatementNetWorkDelegate>
// 分类按钮
@property(nonatomic, weak) UIView *cateToolBarView;
// 分类下拉菜单按钮
@property(nonatomic, weak) UIView *cateSubviewsView;
// 遮罩层
@property(nonatomic, weak) UIButton *maskView;
// 下拉菜单是否打开
@property(nonatomic, assign) BOOL categoryViewOpen;

@property(nonatomic, weak) UITableView *tableView;
// 数据数组
@property(nonatomic, strong) NSMutableArray *data;
// 上一次选中的按钮
@property(nonatomic, strong) UIButton *lastSelectBtn;
// 网络层对象
@property(nonatomic, strong) StatementNetWork *statementNetWork;
@end

@implementation StatementAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"对账单";
    self.view.backgroundColor = DEFALT_BG;
    
    // 初始化分类
    [self setCategoryButton];
    [self setUpSubviewView];
    
    [self setUpTableView];

    // 网络请求层
    StatementNetWork *network = [[StatementNetWork alloc] init];
    network.delegate = self;
    
    network.pageNo = 1;
    network.type   = @"";
    
    self.statementNetWork = network;
    
    // 刷新数据
    [self.tableView.header beginRefreshing];
}


#pragma mark -- netWorkDelegate
// 没有更多数据代理
- (void)statementNetWork:(StatementNetWork *)statementNetWork loadErrorInfo:(NSString *)info {
    // 关闭刷新
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
    
    // 变为没有更多数据的状态
    [self.tableView.footer noticeNoMoreData];
}

// 数据请求完成代理
- (void)statementNetWork:(StatementNetWork *)statementNetWork loadDataFinish:(NSArray *)data {
    
    [self.tableView.header endRefreshing];

    ANLog(@"%ld", self.data.count);
    // 未有数据返回
    if (data.count == 0) {
        
        // 关闭刷新
        [self.tableView.footer noticeNoMoreData];
        
        // 移除历史数据
        [self.data removeAllObjects];
        
        // 隐藏表分割线
         self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        // 显示没有数据提示
        [self setNotDataHeaderView];
        
        [self.tableView reloadData];
        return;
    }
    
    // 显示分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.data = [NSMutableArray arrayWithArray:data];
    
    [self.tableView reloadData];
    
    // 是否有下一页数据
    if ([self.statementNetWork isMoreData]) {
        
        //  关闭下拉刷新状态
        [self.tableView.footer endRefreshing];
        
        // 添加传统的上拉刷新 (当第一屏幕加载完毕，才加载上拉刷新）
        __weak typeof(self) weakSelf = self;
        
        [self.tableView addLegendFooterWithRefreshingBlock:^{
            weakSelf.statementNetWork.pageNo++;
            [weakSelf.statementNetWork getData];
        }];
        
    } else {
        [self.tableView.footer noticeNoMoreData];
    }
}


- (void) noticeNoMoreData {}

#pragma mark -- tableViewDelegate

- (void)setUpTableView {
    
    CGFloat StatementTableViewX = 0;
    CGFloat StatementTableViewY = 99;
    CGFloat StatementTableViewW = WIDTH;
    CGFloat StatementTableViewH = HIGH - self.cateToolBarView.frame.size.height;
    
    CGRect  tableViewRect = CGRectMake(StatementTableViewX, StatementTableViewY, StatementTableViewW, StatementTableViewH);
    UITableView *tableView = [[UITableView alloc] initWithFrame:tableViewRect style:UITableViewStylePlain];
    
    tableView.backgroundColor = DEFALT_BG;
    tableView.contentInset = UIEdgeInsetsMake(-64, 0, 60, 0);

    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    [self.view sendSubviewToBack:tableView];
    
    self.tableView = tableView;
    
    self.tableView.rowHeight = 87;
    self.tableView.sectionHeaderHeight = 30;
    
    self.tableView.header.updatedTimeHidden = YES;
    
    // 下拉刷新
    __weak typeof(self) weakSelf = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        
        // 隐藏没有数据提示
        weakSelf.tableView.tableHeaderView = nil;
        
        // 清空原始数据
        [weakSelf.data removeAllObjects];
         weakSelf.data = nil;
        
        [weakSelf.statementNetWork clearData];
        
        // 页码还原
        weakSelf.statementNetWork.pageNo = 1;
        [weakSelf.statementNetWork getData];
    }];

}



// 一共有多少组数据
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView  {
    return self.data.count;
}

// 第 section 组 有多少行
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    StatementList *list = self.data[section];
    return list == nil ? 0 : [list.list count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] init];
    
    label.frame = CGRectMake(0, 0, self.view.frame.size.width, 46);
    label.backgroundColor = DEFALT_BG;
    label.font = [UIFont systemFontOfSize:12.0];
    
    label.layer.borderWidth = 1;
    label.layer.borderColor = DEFALT_BG.CGColor;
    
    StatementList *list = self.data[section];
    label.text = [NSString stringWithFormat:@"  %@", (list == nil ? @"" : list.month_info)];
    return label;
}

// 每一行显示怎样的cell
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StatementCell *cell = [StatementCell statementWithCell:tableView];
    StatementList *list = self.data[indexPath.section];
    cell.data = list.list[indexPath.row];
    return cell;
}

#pragma mark -- 初始化工具栏

/**
 *  没有数据的提示View
 */
- (void)setNotDataHeaderView {
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, WIDTH, 30);
    
    label.textAlignment = NSTextAlignmentCenter;
    [label setFont:[UIFont systemFontOfSize:14.0]];
    
    label.textColor = HDColor(90, 90, 90);
    label.text = @"暂无相关数据";
    
    self.tableView.tableHeaderView = label;
}


/**
 *  初始化工具栏按钮
 */
- (void)setCategoryButton {

    UIView *view = [[UIView alloc] init];
    
    CGFloat viewX = 0;
    CGFloat viewY = 64;
    CGFloat viewH = 35;
    CGFloat viewW = self.view.frame.size.width;
    view.frame = CGRectMake(viewX, viewY, viewW, viewH);
    view.backgroundColor = [UIColor whiteColor];
    
    // 全部
    UnlineButton *allButton = [UnlineButton buttonWithType:UIButtonTypeCustom];
    
    CGFloat allButtonX = 77;
    CGFloat allButtonY = 0;
    CGFloat allButtonW = 50;
    CGFloat allButtonH = view.frame.size.height;
    
    allButton.frame = CGRectMake(allButtonX, allButtonY, allButtonW, allButtonH);
    
    [allButton setTitle:@"全部" forState:UIControlStateNormal];
    allButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    allButton.tag = 1000;
    self.lastSelectBtn = allButton;
    
    [allButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [allButton addTarget:self action:@selector(allButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:allButton];
    
    // 分类
    CateButton *cateButton = [CateButton buttonWithType:UIButtonTypeCustom];
    
    CGFloat cateButtonY = 0;
    CGFloat cateButtonW = 50;
    CGFloat cateButtonH = view.frame.size.height;
    CGFloat cateButtonX = viewW - (allButtonX + cateButtonW);
    
    
    cateButton.frame = CGRectMake(cateButtonX, cateButtonY, cateButtonW, cateButtonH);
    
    [cateButton setTitle:@"分类" forState:UIControlStateNormal];
    cateButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    cateButton.tag = 1001;
    
    [cateButton addTarget:self action:@selector(allButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [view addSubview:cateButton];
    [self.view addSubview:view];
    self.cateToolBarView = view;
}


- (void)setSubviewsAnimate{
    
    CGRect rect =  self.cateSubviewsView.frame;
    CGFloat rectY = (self.cateToolBarView.frame.origin.y + self.cateToolBarView.frame.size.height);
    
    if (self.categoryViewOpen) {
        // 动画
        [UIView animateWithDuration:0.2 animations:^{
            self.cateSubviewsView.frame = CGRectMake(rect.origin.x, 0, rect.size.width, rect.size.height);
        } completion:^(BOOL finished) {
            self.categoryViewOpen = NO;
            // 关闭遮罩
            self.maskView.hidden = YES;
        }];
    } else {
        // 打开遮罩
        self.maskView.hidden = NO;
        
        [UIView animateWithDuration:0.2 animations:^{
            self.cateSubviewsView.frame = CGRectMake(rect.origin.x, rectY, rect.size.width, rect.size.height);
        } completion:^(BOOL finished) {
            self.categoryViewOpen = YES;
        }];
    }
}

/**
 *  工具栏按钮事件
 */
- (void)allButtonClick:(UIButton *)btn {
    
    if (self.lastSelectBtn) {
        self.lastSelectBtn.selected = NO;
        [self.lastSelectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    btn.selected = YES;
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    self.lastSelectBtn = btn;
    
    // 分类按钮
    if (btn.tag == 1001) {
        
        [self setSubviewsAnimate];
        
    } else if (btn.tag == 1000) {
        
        // 如果分类打开，先隐藏分类
        if (self.categoryViewOpen) {
            [self setSubviewsAnimate];
        }
        
        self.statementNetWork.type = @"";
        
        // 刷新数据
        [self.tableView.header beginRefreshing];
    }
}

// 分类按钮事件
- (void)subviewBtnClick:(UIButton *)btn {
    
    // 关闭弹层
    [self setSubviewsAnimate];
    
    // 修改类型
    self.statementNetWork.type = [NSString stringWithFormat:@"%ld", btn.tag];
    self.statementNetWork.pageNo = 1;
    
    // 请求数据
    [self.tableView.header beginRefreshing];
    
}

- (void) hideMaskView:(UIButton *)btn{
     [self setSubviewsAnimate];
}

/**
 * 初始化分类的子菜单
 */
- (void)setUpSubviewView {
    
    UIButton  *maskView = [[UIButton alloc] init];
    CGFloat maskViewX = 0;
    CGFloat maskViewY = 0;
    CGFloat maskViewW = self.view.frame.size.width;
    CGFloat maskViewH = self.view.frame.size.height;
    
    maskView.frame = CGRectMake(maskViewX, maskViewY, maskViewW, maskViewH);
    maskView.backgroundColor = [UIColor blackColor];
    [maskView addTarget:self action:@selector(hideMaskView:) forControlEvents:UIControlEventTouchUpInside];
    maskView.alpha = 0.2;
    
    
    UIView *cateSubviewsView = [[UIView alloc] init];
    
    CGFloat cateSubviewsViewX = 0;
    CGFloat cateSubviewsViewY = 0;
    CGFloat cateSubviewsViewW = self.view.frame.size.width;
    CGFloat cateSubviewsViewH = 95;
    
    cateSubviewsView.frame = CGRectMake(cateSubviewsViewX, cateSubviewsViewY, cateSubviewsViewW, cateSubviewsViewH);
    cateSubviewsView.alpha = 1;

    cateSubviewsView.layer.borderWidth = 1;
    cateSubviewsView.layer.borderColor = HDColor(215, 215, 215).CGColor;
    cateSubviewsView.backgroundColor = [UIColor whiteColor];
    
    NSArray *btntitles = [NSArray arrayWithObjects:@"商品兑换", @"游戏兑换", @"抽奖兑换", @"票务", @"积分导入", @"积分赚取", nil];
    NSArray *btntags = [NSArray arrayWithObjects:
                        [NSNumber numberWithInt:1],
                        [NSNumber numberWithInt:2],
                        [NSNumber numberWithInt:3],
                        [NSNumber numberWithInt:4],
                        [NSNumber numberWithInt:5],
                        [NSNumber numberWithInt:6],
                        [NSNumber numberWithInt:7],
                        nil];
    
    CGFloat shopImportBtnW = cateSubviewsViewW / 3 - 0.5;
    CGFloat shopImportBtnH = cateSubviewsViewH / 2;
    
    for (int i = 0; i < 6; i++) {
        
        // 添加商品导入
        CateSubButton *shopImportBtn = [CateSubButton buttonWithType:UIButtonTypeCustom];
        [shopImportBtn setTitle:[btntitles objectAtIndex:i] forState:UIControlStateNormal];
        
        shopImportBtn.rightLineView.hidden = NO;
        shopImportBtn.bottomLineView.hidden = NO;
        NSNumber *number = btntags[i];
        shopImportBtn.tag = [number intValue];
        
        int row = i / 3;
        int col = i % 3;
        
        CGFloat shopImportBtnX = shopImportBtnW * col;
        CGFloat shopImportBtnY = shopImportBtnH * row;
        
        if (col > 1) {
            shopImportBtn.rightLineView.hidden = YES;
        }
        
        if (row > 0) {
            shopImportBtn.bottomLineView.hidden = YES;
        }
        
        shopImportBtn.frame = CGRectMake(shopImportBtnX, shopImportBtnY, shopImportBtnW, shopImportBtnH);
        [shopImportBtn addTarget:self action:@selector(subviewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cateSubviewsView addSubview:shopImportBtn];
    }

    // 添加遮罩层
    [self.view addSubview:maskView];
    
    // 添加按钮容器
    [self.view addSubview:cateSubviewsView];
    
    // 所有的按钮应该隐藏在 全部，分类后面
    [self.view sendSubviewToBack:cateSubviewsView];
    
    // 遮罩层放在最后面
    [self.view sendSubviewToBack:maskView];

    self.cateSubviewsView = cateSubviewsView;
    self.maskView = maskView;
    
    self.maskView.hidden = YES;
    self.categoryViewOpen = NO;
}

@end
