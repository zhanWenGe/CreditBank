//
//  CacheDB.h
//  CreditBank
//
//  Created by 王德康 on 15/5/23.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface CacheDB : NSObject
@property(nonatomic, strong) FMDatabase *db;

// 打开数据库
- (BOOL)open;

// 创表
- (BOOL)createTables:(NSString *)sqlStr;

// 数据，插入，更新，删除
- (BOOL)exec:(NSString *)sql withArgumentsInArray:(NSArray *)args;
@end
