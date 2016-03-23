//
//  IntegralCache.h
//  CreditBank
//
//  Created by Eric on 15/6/16.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "CacheDB.h"

@interface IntegralCache : CacheDB

// 缓存数据
- (void)saveCacheData:(NSDictionary *)dict;

// 获取缓存
- (NSDictionary *)getCacheData;

@end
