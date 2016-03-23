//
//  AddressBookController.m
//  AddressBook
//
//  Created by 王德康 on 15/5/14.
//  Copyright (c) 2015年 王德康. All rights reserved.
//

#import "AddressBookController.h"
#import <AddressBook/AddressBook.h>
#import "AddressBookM.h"

@interface AddressBookController ()
@property(nonatomic, strong) NSArray *data;
@property(nonatomic, assign) int selectIndexRow;
@end

@implementation AddressBookController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"通讯录";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClick:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(enterClick:)];
    
    // 调用数据
    [self requestAddressBook];
}

/**
 *  确认按钮
 *
 *  @param btn <#btn description#>
 */
- (void)enterClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(AddressBook:EventBtn:phone:)]) {
        AddressBookM *m = (AddressBookM *)self.data[self.selectIndexRow];
        if (m) {
            [self.delegate AddressBook:self EventBtn:btn phone:m.tel];
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancelClick:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"AddressBookRecord";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    AddressBookM *m = self.data[indexPath.row];
    
    // 普通标题
    cell.textLabel.text = m.name;
    
    // 副标题
    cell.detailTextLabel.text = m.tel;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectIndexRow = (int)indexPath.row;
}

/**
 *  请求加载通讯录数据
 *
 */
- (void)requestAddressBook  {
    
    // 通讯录实例
    ABAddressBookRef book = ABAddressBookCreateWithOptions(NULL, NULL);
    
    // 请求通讯录的权限
    ABAddressBookRequestAccessWithCompletion(book, ^(bool granted, CFErrorRef error) {
        // 是否允许
        if (granted) {
            [self accessAddressBookOC];
        } else {
            //退出当前窗口
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    });
    
    // C语言要创建的对象，要自主释放，凡是包含 create copy retain new 创建的对象都需要手工释放
    CFRelease(book);
}

/**
 *  返回所有通讯录
 */
- (void)accessAddressBookOC {
    
    NSMutableArray *data = [NSMutableArray array];
    
    // 用户拒绝访问通讯录
    if (ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized ) {
        return;
    }
    
    // 通讯录实例
    ABAddressBookRef book = ABAddressBookCreateWithOptions(NULL, NULL);
    
    // 拷贝所有通讯录到BOOK, CFArrayRef 转 NSArray
    NSArray *allPeople = (__bridge NSArray *)(ABAddressBookCopyArrayOfAllPeople(book));
    
    for (int i = 0; i < allPeople.count; i++) {
        
        // 获取这个位置的联系人, Id 对象转 ABRecordRef
        ABRecordRef people = (__bridge ABRecordRef)(allPeople[i]);
        
        // 获取联系人信息 CFStringRef 转 NSString *
        NSString  *firstName  = (__bridge NSString *)(ABRecordCopyValue(people, kABPersonFirstNameProperty));
        NSString  *lastName   = (__bridge NSString *)(ABRecordCopyValue(people, kABPersonLastNameProperty));
        
        
        
        // 电话有多个记录
        ABMultiValueRef phone  = ABRecordCopyValue(people, kABPersonPhoneProperty);
        NSArray *phoneArray = (__bridge NSArray *)(ABMultiValueCopyArrayOfAllValues(phone));
        
        // 获取所有电话记录
        
        for (int n = 0; n < phoneArray.count; n++) {
            NSString *name;
            
            NSString  *phoneNum = (__bridge NSString *)(__bridge CFStringRef)(phoneArray[n]);
            
            if (firstName) {
                
                if (lastName) {
                    // 组合 姓 + 名
                    name = [NSString stringWithFormat:@"%@%@", lastName, firstName];
                } else {
                    name = [NSString stringWithFormat:@"%@", firstName];
                }
                
            }
            
            if (name) {
                AddressBookM *m = [[AddressBookM alloc] init];
                m.name = name;
                m.tel  = phoneNum;
                
                [data addObject:m];
            }
            
        }
        
        CFRelease(phone);
    }
    
    // 释放通讯录实例
    CFRelease(book);

    // 保存数据
    self.data = data;
    
    [self.tableView reloadData];
}

//- (void)accessAddressBookC {
//
//    // 用户拒绝访问通讯录
//    if (ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized ) {
//        return;
//    }
//
//    // 通讯录实例
//    ABAddressBookRef book = ABAddressBookCreateWithOptions(NULL, NULL);
//
//    // 拷贝所有通讯录到BOOK
//    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(book);
//
//    CFIndex count = CFArrayGetCount(allPeople);
//
//    for (int i = 0; i < count; i++) {
//
//        // 获取这个位置的联系人
//        ABRecordRef people = CFArrayGetValueAtIndex(allPeople, i);
//
//        // 获取联系人信息
//        CFStringRef firstName  = ABRecordCopyValue(people, kABPersonFirstNameProperty);
//        CFStringRef lastName  = ABRecordCopyValue(people, kABPersonLastNameProperty);
//
//        // 电话有多个记录
//        ABMultiValueRef phone  = ABRecordCopyValue(people, kABPersonPhoneProperty);
//
//        // 获取所有电话记录
//        if (phone) {
//            CFIndex phoneCount = ABMultiValueGetCount(phone);
//            for (int n = 0; n < phoneCount; n++) {
//                NSString *name;
//
//                CFStringRef phoneNum = ABMultiValueCopyValueAtIndex(phone, n);
//                if (firstName) {
//
//                    if (lastName) {
//                        name = [NSString stringWithFormat:@"%@%@", lastName, firstName];
//                    }
//
//                    name = [NSString stringWithFormat:@"%@", firstName];
//                }
//                if (name) {
//                    NSLog(@"%@, %@, %@",name, phoneNum);
//                }
//
//                // 释放内存
//                if (phoneNum) CFRelease(phoneNum);
//            }
//        }
//
//        if (firstName) CFRelease(firstName);
//        if (lastName) CFRelease(lastName);
//        if (phone) CFRelease(phone);
//    }
//
//
//    CFRelease(allPeople);
//
//    // 释放通讯录实例
//    CFRelease(book);
//}
@end
