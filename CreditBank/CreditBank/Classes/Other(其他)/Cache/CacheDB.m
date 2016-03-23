//
//  CacheDB.m
//  CreditBank
//
//  Created by 王德康 on 15/5/23.
//  Copyright (c) 2015年 Eric. All rights reserved.
//


#import "CacheDB.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseQueue.h"
#import "PrefixHeader.pch"

@interface CacheDB()
@end

@implementation CacheDB

- (instancetype)init {
    self = [super init];
    if (self) {
        [self open];
    }
    
    return self;
}


- (void)dealloc {
    [self close];
}

/**
 *  获取存放数据的沙盒
 *
 *  @return <#return value description#>
 */
- (NSString *)getDataBaseFilePath {
    // 得到沙盒目录
    NSArray *dataPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // 获取Document目录
    NSMutableString *document = [dataPaths lastObject];
    
    // sqlite 路径
    NSString *path = [document stringByAppendingPathComponent:@"db.sqlite"];
    
    return path;
}

/**
 *  打开数据库
 */
-(BOOL)open {
    NSString *dataPath = [self getDataBaseFilePath];
    // ANLog(@"%@", dataPath);
    
    _db = [[FMDatabase alloc] initWithPath:dataPath];
    return [_db open];
}

/**
 *  创建表结构
 *  @params sqlStr 创建表的SQL
 */
- (BOOL)createTables:(NSString *)sqlStr{
    BOOL result = [_db executeUpdate:sqlStr];
    return result;
}

/**
 *  更新表数据
 *  @params sql 插入数据的SQL
 *  @params args 参数列表
 */
- (BOOL)exec:(NSString *)sql withArgumentsInArray:(NSArray *)args {
    return [_db executeUpdate:sql withArgumentsInArray:args];
}


- (NSDictionary *)query
{
    NSMutableDictionary *mutbaleDict = nil;
    
    // 1.查询数据
    FMResultSet *rs = [self.db executeQuery:@"select * from credit_index order by id DESC LIMIT 1;"];
    
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

/**
 *  关闭数据库
 */
-(void)close{
    [_db close];
}
@end
