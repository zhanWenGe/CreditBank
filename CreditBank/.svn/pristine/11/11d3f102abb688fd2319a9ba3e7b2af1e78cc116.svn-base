//
//  ProfileControllerView.h
//  CreditBank
//
//  Created by Eric on 15/3/30.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "BaseSetingViewController.h"

typedef void (^ChangeImageBlock)(UIImage *);

@interface ProfileControllerView : BaseSetingViewController

@property (nonatomic, copy) ChangeImageBlock changImageBlock;

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *nickNameStr;

/**
 *  改变头像的block
 */
- (void)changeImageWithBlock:(ChangeImageBlock)image;

@end
