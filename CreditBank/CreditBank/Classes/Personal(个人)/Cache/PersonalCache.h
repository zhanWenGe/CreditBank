//
//  PersonalCache.h
//  CreditBank
//
//  Created by 王德康 on 15/6/16.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "CacheDB.h"

@interface PersonalCache : CacheDB
// 缓存数据
- (void)saveCacheData:(NSDictionary *)dict token:(NSString *)token;

// 获取缓存
- (NSDictionary *)getCacheData :(NSString *)token ;

@end
