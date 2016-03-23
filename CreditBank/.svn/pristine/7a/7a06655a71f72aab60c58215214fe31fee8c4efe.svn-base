//
//  NSDate+Expand.m
//  CreditBank
//
//  Created by Eric on 15/4/9.
//  Copyright (c) 2015年 Eric. All rights reserved.
//



#import "NSDate+Expand.h"
static NSDateFormatter *dateForMatter;
@implementation NSDate (Expand)

+ (NSString *)getTime {
    
    // 今天日期
    NSDate * today = [NSDate date];
    
    // 获取系统时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    // 得到源日期与世界标准时间的偏移量
    NSInteger interval = [zone secondsFromGMTForDate:today];
    
    // 偏移多少秒后得到的新NSDate对象
    NSDate *localeDate = [today dateByAddingTimeInterval:interval];
    
    // 时间转换成时间戳
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[localeDate timeIntervalSince1970]];
    
    return timeSp;
}

- (NSString *)getDateTime {
    
    if (dateForMatter == nil) {
        
        // 获取系统时区
        NSTimeZone *zone   = [NSTimeZone systemTimeZone];
        dateForMatter      = [[NSDateFormatter alloc] init];
        
        [dateForMatter setTimeZone:zone];
    }

    [dateForMatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString *nowtimeStr = [dateForMatter stringFromDate:self];
    return nowtimeStr;
}

@end
