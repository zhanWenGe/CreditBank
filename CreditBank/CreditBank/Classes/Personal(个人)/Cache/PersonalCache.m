//
//  PersonalCache.m
//  CreditBank
//
//  Created by 王德康 on 15/6/16.
//  Copyright (c) 2015年 Eric. All rights reserved.
//


#import "PersonalCache.h"
@interface PersonalCache()
@property(nonatomic, copy) NSString *tableName;
@end


@implementation PersonalCache
- (instancetype)init {
    self = [super init];
    if (self) {
        
        // 初始化表
        self.tableName = @"personal_index";
        
        NSString *createTableSql = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, token text, json blob);", self.tableName];
        [super createTables:createTableSql];
    }
    
    return self;
}

// 缓存数据
- (void)saveCacheData:(NSDictionary *)dict token:(NSString *)token {
    
    NSString *delSql = [NSString stringWithFormat:@"delete from %@ where id >= ?;", self.tableName];
    [super exec:delSql withArgumentsInArray:[NSArray arrayWithObjects:@"1", nil]];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    
    NSString *insertSql = [NSString stringWithFormat:@"insert into %@ (json, token) values (?, ?);", self.tableName];
    [super exec:insertSql withArgumentsInArray:[NSArray arrayWithObjects:data, token, nil]];
}


// 获取缓存数据
- (NSDictionary *)getCacheData :(NSString *)token  {
    NSMutableDictionary *mutbaleDict = nil;
    
    NSString *selectSql = [NSString stringWithFormat:@"select * from %@ where token = \"%@\" order by id DESC LIMIT 1;", self.tableName, token];
    
    // 1.查询数据
    FMResultSet *rs = [self.db executeQuery:selectSql];
    
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
