//
//  ErrorView.m
//  CreditBank
//
//  Created by 王德康 on 15/5/8.
//  Copyright (c) 2015年 Eric. All rights reserved.
//



#import "ErrorView.h"
@interface ErrorView()
@property (weak, nonatomic) IBOutlet UIButton *reloadBtn;
- (IBAction)reload:(id)sender;

@end

@implementation ErrorView
+ (instancetype) errWithView {
    return [[[NSBundle mainBundle] loadNibNamed:@"error" owner:nil options:nil] lastObject];
}

- (IBAction)reload:(id)sender {
    if ([self.delegate respondsToSelector:@selector(errorView:reloadBtn:)]) {
        [self.delegate errorView:self reloadBtn:sender];
    }
}
@end
