//
//  AboutHeaderView.m
//  CreditBank
//
//  Created by Eric on 15/4/21.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "AboutHeaderView.h"

@implementation AboutHeaderView
+ (instancetype) aboutWithView {
    return [[[NSBundle mainBundle] loadNibNamed:@"AboutHeaderView" owner:nil options:nil] lastObject];
}
@end
