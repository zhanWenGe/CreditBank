//
//  SetGraphPasswdViewController.h
//  CreditBank
//
//  Created by Eric on 15/4/5.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

// 手势密码，存储key
#define PASSKYE  @"graphicslock"

#import <UIKit/UIKit.h>

@interface SetGraphPasswdViewController : UIViewController

@property(nonatomic, weak) UITableViewController *top;

+ (NSString *)getPasswd;
+ (NSString *)encodePasswd:(NSString *)path;
+ (void)clearPasswd;

@end
