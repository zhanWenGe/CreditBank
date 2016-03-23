//
//  OrderViewController.m
//  CreditBank
//
//  Created by Eric on 15/3/29.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "OrderViewController.h"
#import "LineButton.h"

@interface OrderViewController ()
@property(nonatomic, strong) NSArray *data;
@end

@implementation OrderViewController

- (instancetype) initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的订单";
    
    // 筛选按钮
    UIView *headerView = [[UIView alloc] init];
    headerView.frame   = CGRectMake(0, 0, self.view.frame.size.width, 40);
    headerView.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = headerView;
    
    // 全部按钮
//    LineButton *allBtn = [LineButton buttonWithType:UIButtonTypeCustom];
    
    // 未发货按钮
//    LineButton *UnfilledBtn = [LineButton buttonWithType:UIButtonTypeCustom];

    // 已按钮
}



- (NSArray *)data {
    if (_data == nil) {
        
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"branklist.plist" ofType:nil];
//        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
//        
//        NSMutableArray *tmpArr = [NSMutableArray array];
//        for (NSDictionary *dic in arr) {
//            BrankCardM *card = [BrankCardM cardWithDic:dic];
//            [tmpArr addObject:card];
//        }
        
        // _data = tmpArr;
    }
    
    return _data;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    BrankCell *cell = [BrankCell cellWithInit:tableView];
//    cell.cardM = self.data[indexPath.row];
//    return cell;
//}

@end
