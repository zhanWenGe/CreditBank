//
//  LotteryViewController.m
//  CreditBank
//
//  Created by Eric on 15/3/29.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "LotteryViewController.h"
#import "PrefixHeader.pch"
#import "LotteryCell.h"
#import "LotteryModel.h"

@interface LotteryViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation LotteryViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = DEFALT_BG;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 106;
    [self getLotteryListDate];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LotteryCell *cell = [LotteryCell cellWithInit:tableView];
    cell.lotteryModel = [LotteryModel objectWithKeyValues:self.dataArray[indexPath.row]];
    
    return cell;
}

- (void)getLotteryListDate
{
    NSArray *arr = @[self.token, @1, CURRENTTIME];
    NSString *md5 = [Common paramsSign:arr];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.token, @"token",
                                @1, @"page_no",
                                CURRENTTIME, @"time",
                                md5, @"sign",
                                PLATFORMID, @"app_id", nil];
    
    AnRequest *anReq = [[AnRequest alloc] init];
    NSString *netStr = @"?anu=api/1/lottery_record/get_lottery_record_list";
    [anReq post:netStr params:dictionary successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dataArray = [NSArray arrayWithArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}


@end
