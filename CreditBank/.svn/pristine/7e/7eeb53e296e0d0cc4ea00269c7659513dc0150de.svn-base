//
//  AboutViewController.m
//  CreditBank
//
//  Created by Eric on 15/4/21.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "AboutViewController.h"
#import "SettingArrowItem.h"
#import "settingGroup.h"
#import "AboutHeaderView.h"
#import "AboutViewModel.h"


@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AboutHeaderView *aboutView = [AboutHeaderView aboutWithView];
    self.tableView.tableHeaderView = aboutView;
}

#pragma mark -- Method
- (void)setUpData {
    [self setUpGroup];
}

#pragma mark --- TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 20;
    }
    
    return 0;
}

- (void)setUpGroup {
    
    __weak typeof (self) aboutController = self;
    
    settingGroup *group2   = [[settingGroup alloc] init];
    SettingItem *score = [SettingArrowItem arrowItemWithTitle:@"给我评分" pushController:nil];
    score.option = ^(SettingItem *item){
        
        AboutViewModel *aboutViewModel = [[AboutViewModel alloc] init];
        [aboutViewModel requestAboutData:^(AboutM *m) {
            [aboutController openScore:m.appstore];
            
        } errBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            ANLog(@"%@", responseObject);
        } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            ANLog(@"%@", error);
        }];

    };
    
    SettingItem *weibo = [SettingArrowItem arrowItemWithTitle:@"官方微博" pushController:nil];
    weibo.option = ^(SettingItem *item){
        
        AboutViewModel *aboutViewModel = [[AboutViewModel alloc] init];
        [aboutViewModel requestAboutData:^(AboutM *m) {
            [aboutController openWeibo:m.weibo];
            
        } errBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            ANLog(@"%@", responseObject);
        } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            ANLog(@"%@", error);
        }];
        
    };
    
    group2.items = @[score,weibo];
    [self.data addObject:group2];
}

- (void)openScore:(NSString *)appid{

    NSString *url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8", appid];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (void)openWeibo:(NSString *)url{
    ANLog(@"%@", url);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
@end
