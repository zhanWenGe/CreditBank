//
//  NSAddressBookUI.m
//  AddressBook
//
//  Created by 王德康 on 15/5/15.
//  Copyright (c) 2015年 王德康. All rights reserved.
//  调用系统通讯录UI


#import "NSAddressBookUI.h"
#import <AddressBookUI/AddressBookUI.h>
#import "AddressBookM.h"

@class UIViewController;

@interface NSAddressBookUI() <ABPeoplePickerNavigationControllerDelegate>

@end


@implementation NSAddressBookUI

- (void)callAddressUI:(UIViewController *)controller {
    
    ABPeoplePickerNavigationController *index = [[ABPeoplePickerNavigationController alloc] init];
    
    // 选择联系人是否立即返回APP， FALSE 进入详情页， TRUE立即返回
    index.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:FALSE];
    
    // 是否调用打电话程序，发邮件程序 TRUE 立即返回APP, FALSE是调用打电话
    index.predicateForSelectionOfProperty = [NSPredicate predicateWithValue:TRUE];
    
    // 是否禁用选择联系人
    index.predicateForEnablingPerson = [NSPredicate predicateWithValue:TRUE];
    
    // 个人信息详情页，有哪些属性可见
    NSMutableArray* properties = [[NSMutableArray alloc]init];
    [properties addObject:[NSNumber numberWithInt:kABPersonFirstNameProperty ]];
    [properties addObject:[NSNumber numberWithInt:kABPersonLastNameProperty ]];
    [properties addObject:[NSNumber numberWithInt:kABPersonPhoneProperty]];
    index.displayedProperties = properties;
    
    // 代理
    index.peoplePickerDelegate = self;
    [controller presentViewController:index animated:YES completion:nil];
}

/**
 *  获取联系人完整的姓名
 *
 *  @param person ABRecordRef
 *
 *  @return NSString
 */
- (NSString *)getPersonAllName:(ABRecordRef)person {
    
    // 获取联系人信息 CFStringRef 转 NSString *
    NSString  *firstName  = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    NSString  *lastName   = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
    
    NSString *name;
    
    if (firstName) {
        
        if (lastName) {
            // 组合 姓 + 名
            name = [NSString stringWithFormat:@"%@%@", lastName, firstName];
        } else {
            name = [NSString stringWithFormat:@"%@", firstName];
        }
        
    }
    
    if (name) {
        return name;
    }
    
    return @"";
}

#pragma mark -- ABPeoplePickerNavigationControllerDelegate

// 选择联系人详情页面的属性时，调用这个代理方法
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
    // 电话列表
    ABMultiValueRef phone  = ABRecordCopyValue(person, kABPersonPhoneProperty);
    if (phone) {
        
        NSArray *phoneArray = (__bridge NSArray *)(ABMultiValueCopyArrayOfAllValues(phone));
        if (phoneArray) {
            
            NSString *phoneNum = (__bridge NSString *)(__bridge CFStringRef)phoneArray[(int)identifier];
            // 去除电话号码中的 "-" 和 "+86"
            phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"-" withString:@""];
            phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"+86 " withString:@""];
            phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"+86" withString:@""];
            AddressBookM *m = [[AddressBookM alloc] init];
            m.name = [self getPersonAllName:person];
            m.tel  = phoneNum;
            
            if ([self.delegate respondsToSelector:@selector(NSAddressBookUI:didSelectedPeopleProperty:)]) {
                [self.delegate NSAddressBookUI:self didSelectedPeopleProperty:m];
            }
        }
    }

    
}


// 选择通讯录用户信息时调用, 如果弹出联系人详情页面，这个代理不会被调用
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person {
    
    // 电话有多个记录
    ABMultiValueRef phone  = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSArray *phoneArray    = (__bridge NSArray *)(ABMultiValueCopyArrayOfAllValues(phone));
    NSString *name         = [self getPersonAllName:person];

    // 获取所有电话记录
    for (int n = 0; n < phoneArray.count; n++) {
        NSString  *phoneNum = (__bridge NSString *)(__bridge CFStringRef)(phoneArray[n]);
        
        AddressBookM *m = [[AddressBookM alloc] init];
        m.name = name;
        m.tel  = phoneNum;
        
        if ([self.delegate respondsToSelector:@selector(NSAddressBookUI:didSelectedPeople:)]) {
            [self.delegate NSAddressBookUI:self didSelectedPeople:m];
        }
    }
}


@end
