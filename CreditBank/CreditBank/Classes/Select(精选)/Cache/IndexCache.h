//
//  IndexCache.h
//  CreditBank
//
//  Created by 王德康 on 15/5/24.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "CacheDB.h"

@interface IndexCache : CacheDB

// 缓存数据
- (void)saveCacheData:(NSDictionary *)dict;

// 获取缓存
- (NSDictionary *)getCacheData;

@end
