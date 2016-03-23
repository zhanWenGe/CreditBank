//
//  ListModel.m
//  CreditBank
//
//  Created by Eric on 15/5/19.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "ListModel.h"
#import "MJExtension.h"

@implementation ListModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self replacedKeyFromPropertyName];
    }
    return self;
}

- (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"templateName" : @"template"
             };
}


@end


