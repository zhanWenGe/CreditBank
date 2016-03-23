//
//  SafeViewController.m
//  CreditBank
//
//  Created by Eric on 15/4/28.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "SafeViewController.h"

@interface SafeViewController ()

@end

@implementation SafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.url = @"/news/detail?id=289";
    [super loadRequest];
}



@end
