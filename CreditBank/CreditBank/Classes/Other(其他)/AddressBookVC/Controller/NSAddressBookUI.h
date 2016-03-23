//
//  NSAddressBookUI.h
//  AddressBook
//
//  Created by 王德康 on 15/5/15.
//  Copyright (c) 2015年 王德康. All rights reserved.
//


#import <Foundation/Foundation.h>
@class NSAddressBookUI;
@class AddressBookM;
@class UIViewController;

@protocol NSAddressBookUIDelegate <NSObject>

@optional
// 点击联系人时候，返回联系人的信息,当电话为多个的时候，自动调用多次
- (void)NSAddressBookUI:(NSAddressBookUI *)addressBook didSelectedPeople:(AddressBookM *)bookModel;
// 点击联系人属性时候，返回联系人信息
- (void)NSAddressBookUI:(NSAddressBookUI *)addressBook didSelectedPeopleProperty:(AddressBookM *)bookModel;
@end

@interface NSAddressBookUI : NSObject
@property(nonatomic, weak) id <NSAddressBookUIDelegate> delegate;

// 调用初始化界面
- (void)callAddressUI:(UIViewController *)controller;
@end
