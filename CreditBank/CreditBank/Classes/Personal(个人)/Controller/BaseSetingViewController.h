//
//  BaseSetingViewController.h
//  001-caipiao
//
//  Created by Eric on 15/3/24.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseSetingViewController : UITableViewController
- (void)setUpData;
@property(nonatomic, strong) NSMutableArray *data;
@end
