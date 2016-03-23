//
//  IntegralCache.m
//  CreditBank
//
//  Created by Eric on 15/6/16.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "IntegralCache.h"

@implementation IntegralCache

- (instancetype)init {
    self = [super init];
    if (self) {
        [super createTables:@"create table if not exists credit_integral (id integer primary key autoincrement, token text, json blob);"];
    }
    
    return self;
}

// 缓存数据
- (void)saveCacheData:(NSDictionary *)dict {
    [super exec:@"delete from credit_integral where id > ?;" withArgumentsInArray:[NSArray arrayWithObjects:@"1", nil]];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [super exec:@"insert into credit_integral (json, token) values (?, ?);" withArgumentsInArray:[NSArray arrayWithObjects:data, @"", nil]];
}


// 获取缓存数据
- (NSDictionary *)getCacheData {
    NSMutableDictionary *mutbaleDict = nil;
    
    // 1.查询数据
    FMResultSet *rs = [self.db executeQuery:@"select * from credit_integral order by id DESC LIMIT 1;"];
    
    // 返回数据集合
    if (rs.next) {
        int ID             = [rs intForColumn:@"id"];
        NSString *token    = [rs stringForColumn:@"token"];
        NSDictionary *json = [NSKeyedUnarchiver unarchiveObjectWithData:[rs dataForColumn:@"json"]];
        
        mutbaleDict = [NSMutableDictionary dictionary];
        [mutbaleDict setObject:@(ID) forKey:@"ID"];
        [mutbaleDict setObject:token forKey:@"token"];
        [mutbaleDict setObject:json  forKey:@"json"];
    }
    
    return mutbaleDict;
}

@end
