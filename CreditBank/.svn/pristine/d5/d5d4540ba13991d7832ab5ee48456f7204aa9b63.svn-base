//
//  BrankListViewController.m
//  CreditBank
//
//  Created by Eric on 15/3/30.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "CardListViewController.h"
#import "PrefixHeader.pch"
#import "BrankCardM.h"
#import "BrankCell.h"
#import "BrankCardDetailsController.h"

@interface CardListViewController ()
@property(nonatomic, strong) NSArray *dataArray;

@end

@implementation CardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的银行卡";
    self.view.backgroundColor = DEFALT_BG;
    // 取消默认分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tableView.rowHeight = 120;
    
    [self getBrankCardListDate];

    
}

- (instancetype)init
{
    return [super initWithStyle:UITableViewStylePlain];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BrankCell *cell = [BrankCell cellWithInit:tableView];
    
    cell.cardM = [BrankCardM objectWithKeyValues:self.dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BrankCardM *brankCardModel = [BrankCardM objectWithKeyValues:self.dataArray[indexPath.row]];
    BrankCardDetailsController *brankCardDetailVC = [[BrankCardDetailsController alloc] init];
    brankCardDetailVC.token = self.token;
    brankCardDetailVC.brankCardModel = brankCardModel;
    [self.navigationController pushViewController:brankCardDetailVC animated:YES];
    
}

- (void)getBrankCardListDate
{
    NSString *time = [NSDate getTime];
    NSArray *arr = @[self.token, @1, time];
    NSString *md5 = [Common paramsSign:arr];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.token, @"token",
                                @1, @"page_no",
                                time, @"time",
                                md5, @"sign",
                                PLATFORMID, @"app_id", nil];
    
    AnRequest *anReq = [[AnRequest alloc] init];
    NSString *netStr = @"?anu=api/1/card/get_card_list";
    [anReq post:netStr params:dictionary successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataArray = [NSArray arrayWithArray:responseObject[@"list"]];
        ANLog(@"%@", self.dataArray);
        [self.tableView reloadData];
        
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

@end
