//
//  MessageViewController.m
//  CreditBank
//
//  Created by Eric on 15/4/8.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageViewCell.h"
#import "PrefixHeader.pch"
#import "MessageListModel.h"

@interface MessageViewController ()

@property (nonatomic, strong) NSArray *messageArray;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ANLog(@"token : %@", self.token);
    UILabel *headView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    headView.backgroundColor = DEFALT_BG;
    headView.layer.borderColor = HDColor(213, 214, 214).CGColor;
    headView.layer.borderWidth = 0.5;
    self.tableView.tableHeaderView = headView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self getUserMessageDate];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.messageArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 创建cell
    MessageViewCell *cell = [MessageViewCell cellWithTableView:tableView];
    // 赋值给Model
    cell.messageListModel = [MessageListModel objectWithKeyValues:self.messageArray[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 67;
}

- (void)getUserMessageDate
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
    NSString *netStr = @"?anu=api/1/sys_message/get_sys_message_list";
    [anReq post:netStr params:dictionary successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.messageArray = [NSArray arrayWithArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}


@end
