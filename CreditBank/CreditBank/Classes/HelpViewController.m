//
//  HelpViewController.m
//  CreditBank
//
//  Created by Eric on 15/4/27.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.url = @"/news/detail?id=287";
    [super loadRequest];
}

@end
