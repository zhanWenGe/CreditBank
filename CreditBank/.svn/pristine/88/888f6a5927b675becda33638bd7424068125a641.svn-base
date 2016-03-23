//
//  UnlockView.h
//  滑动解锁-001
//
//  Created by Eric on 15/4/2.
//  Copyright (c) 2015年 Eric. All rights reserved.
//


#import <UIKit/UIKit.h>
@class UnlockView;

@protocol UnlockViewDelegate <NSObject>

@optional
// 绘图手势之得到密码
- (void)UnlockView:(UnlockView *)lockView didFinishPath:(NSString *)path;
@end

@interface UnlockView : UIView
@property(nonatomic, weak) IBOutlet id <UnlockViewDelegate>   delegate;

// 验证失败重绘提示
- (void)didFailPath;

// 清空
- (void)clearAll;
@end
