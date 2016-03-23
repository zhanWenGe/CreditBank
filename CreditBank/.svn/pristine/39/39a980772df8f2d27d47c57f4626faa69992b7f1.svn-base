//
//  AddIntegralSourceController.m
//  CreditBank
//
//  Created by Eric on 15/5/4.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "AddIntegralSourceController.h"
#import "PrefixHeader.pch"
#import "BarkModel.h"
#import "OtherCardMordel.h"
#import "OtherCardCell.h"
#import "BarkImportController.h"
#import "ImpotSuccessController.h"


@interface AddIntegralSourceController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *saveCardArray;
@property (nonatomic, retain) NSArray *creditCardArray;
@property (nonatomic, retain) NSArray *otherArray;

@end

@implementation AddIntegralSourceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"添加积分来源";
    self.view.backgroundColor = DEFALT_BG;
    
    [self setMyTableView];
    [self setCreditSourceData];
    
    
}

- (void)setMyTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"bark"];
    
}

#pragma mark - tableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"bark"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    BarkModel *barkM = [[BarkModel alloc] init];
    OtherCardMordel *otherM = [[OtherCardMordel alloc] init];
    if (indexPath.section == 0) {
        barkM = self.creditCardArray[indexPath.row];
        cell.textLabel.text = barkM.name;
        return cell;
    } else if (indexPath.section == 1) {
        barkM = self.saveCardArray[indexPath.row];
        cell.textLabel.text = barkM.name;
        return cell;
    } else {
        OtherCardCell *OtherCell = [OtherCardCell otherCardCellView:tableView];
        OtherCell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellarrow"]];
        otherM = self.otherArray[indexPath.row];
        OtherCell.textLabel.text = otherM.name;
        [OtherCell.imageView sd_setImageWithURL:[NSURL URLWithString:otherM.icon] placeholderImage:[UIImage imageNamed:@"addIntegral_chongzhi"]];
        return OtherCell;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.creditCardArray.count;
    } else if (section == 1) {
        return self.saveCardArray.count;
    } else {
        return self.otherArray.count;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return 48;
    }
    return 37;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 0.1;
    }
    return 48;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewCell *sectionView = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 48)];
    sectionView.backgroundColor = [UIColor whiteColor];
    sectionView.textLabel.font = [UIFont systemFontOfSize:15];
    if (section == 0) {
        sectionView.imageView.image = [UIImage imageNamed:@"addIntegral_credit"];
        sectionView.accessoryView = [[UIImageView alloc] initWithImage:nil];
        sectionView.textLabel.text = @"信用卡";
        sectionView.userInteractionEnabled = NO;
    } else if (section == 1) {
        sectionView.imageView.image = [UIImage imageNamed:@"addIntegral_card"];
        sectionView.accessoryView = [[UIImageView alloc] initWithImage:nil];
        sectionView.textLabel.text = @"储蓄卡";
        sectionView.userInteractionEnabled = NO;
    }
    return sectionView;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ANLog(@"section : %ld, row : %ld", indexPath.section, indexPath.row);
    BarkModel *barkM = [[BarkModel alloc] init];
    OtherCardMordel *otherM = [[OtherCardMordel alloc] init];
    BarkImportController *barkImportVC = [[BarkImportController alloc] init];
    if (indexPath.section == 0) {
        barkM = self.creditCardArray[indexPath.row];
        barkImportVC.title = [NSString stringWithFormat:@"%@导入", barkM.name];
        barkImportVC.type = @"1";
        barkImportVC.bankId = barkM.bank_id;
        [self.navigationController pushViewController:barkImportVC animated:YES];
    } else if (indexPath.section == 1) {
        barkM = self.saveCardArray[indexPath.row];
        barkImportVC.title = [NSString stringWithFormat:@"%@导入", barkM.name];
        barkImportVC.type = @"2";
        barkImportVC.bankId = barkM.bank_id;
        [self.navigationController pushViewController:barkImportVC animated:YES];
    } else {
        otherM = self.otherArray[indexPath.row];
        if (indexPath.row == 0) {
            
            ImpotSuccessController *shopNavController = [[ImpotSuccessController alloc] init];
            shopNavController.strUrl  = @"?anu=m/card_exchange/credit_import?id=1001616032426000";
            
            shopNavController.title = [NSString stringWithFormat:@"%@导入", otherM.name];
//            barkImportVC.bankId = otherM.other_id;
            [self.navigationController pushViewController:shopNavController animated:YES];
        }
    }
    
    
}

- (void)setCreditSourceData
{
    NSString *time = [NSDate getTime];
    NSArray *arr = @[time];
    NSString *md5 = [Common paramsSign:arr];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                time, @"time",
                                md5, @"sign",
                                PLATFORMID, @"app_id", nil];
    
    AnRequest *anReq = [[AnRequest alloc] init];
    NSString *netStr = @"?anu=api/1/credit/credit_source_page";
    [anReq post:netStr params:dictionary successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
//        ANLog(@"%@", responseObject);
        
        // 信用卡
        NSMutableArray *creditMarr = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[@"credit_card"]) {
            BarkModel *barkM = [BarkModel objectWithKeyValues:dic];
            [creditMarr addObject:barkM];
        }
        self.creditCardArray = [NSArray arrayWithArray:creditMarr];
        
        // 储蓄卡
        NSMutableArray *saveMarr = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[@"save_card"]) {
            BarkModel *barkM = [BarkModel objectWithKeyValues:dic];
            [saveMarr addObject:barkM];
        }
        self.saveCardArray = [NSArray arrayWithArray:saveMarr];
        
        // 其他
        NSMutableArray *otherMarr = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[@"other"]) {
            OtherCardMordel *otherM = [OtherCardMordel objectWithKeyValues:dic];
            [otherMarr addObject:otherM];
        }
        
        self.otherArray = [NSArray arrayWithArray:otherMarr];
        
        [self.tableView reloadData];
        
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

@end
