//
//  TimeOutHander.m
//  CreditBank
//
//  Created by Eric on 15/5/7.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "TimeOutHander.h"

@implementation TimeOutHander

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (TimeOutHander *)timeOut:(int)longTime overTime:(NSString *)overTime ingTime:(NSString *)ingTime
{
    TimeOutHander *timeout = [[TimeOutHander alloc] init];
    [timeout setTimeOut:longTime overTime:overTime ingTime:ingTime];
    return timeout;
}

- (void)setTimeOut:(int)longTime overTime:(NSString *)overTime ingTime:(NSString *)ingTime
{
    __block int timeout = longTime; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            //dispatch_release(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                
                
                self.timeLabel.text = overTime;
            });
        }else{
            //int minutes = timeout / 60;
            int seconds = timeout % 200;
            NSString *strTime = [NSString stringWithFormat:@"%d%@", seconds, ingTime];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.timeLabel.text = strTime;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

@end
