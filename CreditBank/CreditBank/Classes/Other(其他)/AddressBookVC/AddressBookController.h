//
//  AddressBookController.h
//  AddressBook
//
//  Created by 王德康 on 15/5/14.
//  Copyright (c) 2015年 王德康. All rights reserved.
//


#import <UIKit/UIKit.h>
@class AddressBookController;

@protocol AddressBookDelegate <NSObject>
@optional
- (void)AddressBook:(AddressBookController *)controller EventBtn:(UIButton *)btn phone:(NSString *)phone;
@end

@interface AddressBookController : UITableViewController
@property(nonatomic, weak) id <AddressBookDelegate> delegate;
@end
