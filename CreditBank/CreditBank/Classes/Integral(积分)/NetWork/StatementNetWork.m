//
//  StatementNetWork.m
//  CreditBank
//
//  Created by 王德康 on 15/6/4.
//  Copyright (c) 2015年 Eric. All rights reserved.
//  对账单网络请求

#import "StatementNetWork.h"
#import "PrefixHeader.pch"
#import "StatementM.h"
#import "StatementList.h"

@interface StatementNetWork ()
// 总页码
@property(nonatomic, assign) int totalPage;
@property(nonatomic, strong) NSMutableArray *data;
@end

@implementation StatementNetWork

// 清除数据
- (void)clearData {
    [self.data removeAllObjects];
    _data = nil;
}

// 判断是否有更多的数据
-(BOOL)isMoreData {
    if (self.pageNo + 1 < self.totalPage && self.totalPage > 0) {
        return YES;
    }
    
    return NO;
}

// 网络请求完毕数据归纳
-(void)setData:(NSMutableArray *)data {
    if (_data == nil) {
        _data = data;
    } else {
        
        // 初始化没有当前连接上个月份的数据
        _cureenSection = NO;
        
        // 本月的情况，本月的没有一次性加载完
        StatementList *lastList = [self.data lastObject];
        if (lastList) {
            
            for (StatementList *tmpList in data) {
                if ([lastList.month_info isEqualToString:tmpList.month_info] ) {
                    
                    NSMutableArray *tmpArr = [NSMutableArray arrayWithArray:lastList.list];
                    for (StatementM *statementM in tmpList.list) {
                        
                        [tmpArr addObject:statementM];
                        _cureenSection = YES;
                    }
                    
                    lastList.list = tmpArr;
                    
                }else {
                    
                    [_data addObject:tmpList];
                }
            }
        }
        // 保存这次请求的数据
        _lastData = data;
    }
}

#pragma mark -- 网络请求
- (void)getData {
    
    NSString *token = [Common token];
    NSString *time = [NSDate getTime];
    
    NSArray  *arr  = @[token, [NSString stringWithFormat:@"%d", self.pageNo], time];
    NSString *md5  = [Common paramsSign:arr];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                token, @"token",
                                self.type,@"type",
                                [NSString stringWithFormat:@"%d", self.pageNo] , @"page_no",
                                time, @"time",
                                md5, @"sign",nil];
    
    
    AnRequest *anReq = [[AnRequest alloc] init];
    NSString *netStr = @"?anu=api/1/credit_statements/get_credit_statements_list";
    
    // 页码超出范围
    if (self.pageNo > self.totalPage && self.totalPage > 0) {
        if ([self.delegate respondsToSelector:@selector(statementNetWork:loadErrorInfo:)]) {
            [self.delegate statementNetWork:self loadErrorInfo:@"没有更多数据"];
        }
        return;
    }
    
    
    [anReq post:netStr params:dictionary successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *data = [NSMutableArray array];
        if ([Common isKeyDictionary:@"total_page" dict:responseObject]) {
            _totalPage  = [responseObject[@"total_page"] intValue];
        }
        
        if ([Common isKeyDictionary:@"list" dict:responseObject]) {
            NSArray *dicList = (NSArray *)responseObject[@"list"];
            
            if (dicList) {
                for (NSDictionary *dicInfo in dicList) {
                    StatementList *statementList = [[StatementList alloc] init];
                    
                    // 月份具体内容
                    if ([Common isKeyDictionary:@"list" dict:dicInfo]) {
                        NSMutableArray *tmpArr = [NSMutableArray array];
                        
                        for (NSDictionary *dic in dicInfo[@"list"]) {
                            StatementM *statementData = [StatementM objectWithKeyValues:dic];
                            [tmpArr addObject:statementData];
                        }
                        
                        statementList.list = tmpArr;
                    }
                    
                    // 月份字符串
                    if ([Common isKeyDictionary:@"month_info" dict:dicInfo]) {
                        statementList.month_info = dicInfo[@"month_info"];
                    }
                    
                    [data addObject:statementList];
                }
            }
            
        }
        
        // 赋值
        self.data = data;
        
        if ([self.delegate respondsToSelector:@selector(statementNetWork:loadDataFinish:)]) {
            [self.delegate statementNetWork:self loadDataFinish:self.data];
        }
        
        
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        ANLog(@"filed responseObject : %@", responseObject);
        
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        ANLog(@"error : %@", error);
        
    }];
}
@end
