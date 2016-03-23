//
//  LockButton.m
//  滑动解锁-001
//
//  Created by Eric on 15/4/3.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "LockButton.h"

@implementation LockButton
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.layer.borderWidth = 1;
    self.userInteractionEnabled = NO;
    
    [self setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
    [self setBordeColorDefault];
    
    [self setBackgroundColor:[UIColor colorWithRed:36/255.0 green:39/255.0 blue:54/255.0 alpha:1.0]];
    
    self.layer.cornerRadius = 35;
    self.layer.masksToBounds = YES;
}


- (void)setBordeColorError {
    self.layer.borderColor =[UIColor redColor].CGColor;
}

- (void)setBordeColorDefault {
    self.layer.borderColor =[UIColor colorWithRed:51/255.0 green:154/255.0 blue:221/255.0 alpha:1.0].CGColor;
}
@end
