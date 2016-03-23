//
//  ProfileControllerView.m
//  CreditBank
//
//  Created by Eric on 15/3/30.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "ProfileControllerView.h"
#import "settingGroup.h"
#import "SettingArrowItem.h"
#import "StatementViewController.h"
#import "NickNameController.h"
#import "SetPasswordViewController.h"
#import "PayPasswordViewController.h"
#import "PrefixHeader.pch"
#import "MBProgressHUD+MJ.h"
#import "UserInfoView.h"
#import "BindingAccountController.h"



@interface ProfileControllerView ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSDictionary *profileDic;
@property (nonatomic, weak) UIImageView *imageView;

/**
 *  头像
 */
@property (nonatomic, strong) SettingItem *avatar;
/**
 *  昵称
 */
@property (nonatomic, strong) SettingItem *nickName;
/**
 *  京东账户
 */
@property (nonatomic, strong) SettingItem *JD;
/**
 *  新浪微博
 */
@property (nonatomic, strong) SettingItem *sinaWeibo;
/**
 *  QQ账户
 */
@property (nonatomic, strong) SettingItem *QQ;
/**
 *  天猫账户
 */
@property (nonatomic, strong) SettingItem *Tmall;

/**
 *  电话号码
 */
@property (nonatomic, copy) NSString *phoneNumber;
/**
 *  京东商城的id
 */
@property (nonatomic, copy) NSString *idJD;
/**
 *  天猫商城的id
 */
@property (nonatomic, copy) NSString *idTM;



@end

@implementation ProfileControllerView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";

}

- (void)setUpData {
    [self getPrefileDate];
    [self setUpGroup1];
    [self setUpGroup2];
    [self setUpGroup3];
}

- (void)setUpGroup3 {
    
    settingGroup *group = [[settingGroup alloc] init];
    __weak typeof(self) profile = self;
    
    
    SettingItem *jd = [SettingArrowItem arrowItemWithTitle:@"京东账户" pushController:nil];
    jd.option = ^(SettingItem *item){
        BindingAccountController *bindingVC = [[BindingAccountController alloc] init];
        bindingVC.title = @"京东账户绑定";
        bindingVC.shopId = self.idJD;

        [bindingVC changeSubTitleWithBlock:^(NSString *subTitle, UIColor *titleColor) {
            self.JD.subTitle = subTitle;
            self.JD.subTitleColor = titleColor;
        }];
        
        if ([self.JD.subTitle isEqualToString:@"未绑定"]) {
            [profile.navigationController pushViewController:bindingVC animated:YES];
        }
        
    };
    self.JD = jd;
    
    SettingItem *mall = [SettingArrowItem arrowItemWithTitle:@"天猫账户" pushController:nil];
    mall.option = ^(SettingItem *item){
        BindingAccountController *bindingVC = [[BindingAccountController alloc] init];
        bindingVC.title = @"天猫账户绑定";
        bindingVC.shopId = self.idTM;

        [bindingVC changeSubTitleWithBlock:^(NSString *subTitle, UIColor *titleColor) {
            self.Tmall.subTitle = subTitle;
            self.Tmall.subTitleColor = titleColor;
        }];
        
        if ([self.Tmall.subTitle isEqualToString:@"未绑定"]) {
            
            [profile.navigationController pushViewController:bindingVC animated:YES];
        }
    };
    self.Tmall = mall;
    
    SettingItem *sinaWeibo = [SettingArrowItem arrowItemWithTitle:@"新浪微博" pushController:nil];
    sinaWeibo.option = ^(SettingItem *item){
        BindingAccountController *bindingVC = [[BindingAccountController alloc] init];
        bindingVC.title = @"新浪微博绑定";
//        [profile.navigationController pushViewController:bindingVC animated:YES];
    };
    self.sinaWeibo = sinaWeibo;
    
    
    SettingItem *qq = [SettingArrowItem arrowItemWithTitle:@"QQ账户" pushController:nil];
    qq.option = ^(SettingItem *item){
        BindingAccountController *bindingVC = [[BindingAccountController alloc] init];
        bindingVC.title = @"QQ账户绑定";
//        [profile.navigationController pushViewController:bindingVC animated:YES];
    };
    self.QQ = qq;

    
    
    group.items = @[jd, mall, sinaWeibo, qq];
    [self.data addObject:group];
}

- (void)setUpGroup2 {
    
    // 创建密码分组
    settingGroup *group = [[settingGroup alloc] init];
    
    // 账户密码
    SettingItem *accessPasswd = [SettingArrowItem arrowItemWithTitle:@"账户密码" pushController:nil];
    __weak typeof(self) profile = self;
    accessPasswd.option = ^(SettingItem *item){
        SetPasswordViewController *setPasswordVC = [[SetPasswordViewController alloc] init];
        setPasswordVC.token = profile.token;
        [profile.navigationController pushViewController:setPasswordVC animated:YES];
    };
    
//    // 支付密码
//    SettingItem *payPasswd = [SettingArrowItem arrowItemWithTitle:@"支付密码" pushController:nil];
//    payPasswd.option = ^(SettingItem *item){
//        PayPasswordViewController *payPasswordVC = [[PayPasswordViewController alloc] init];
//        payPasswordVC.token = profile.token;
//        payPasswordVC.phoneNumber = profile.phoneNumber;
//        [profile.navigationController pushViewController:payPasswordVC animated:YES];
//    };
    group.items = @[accessPasswd];
    [self.data addObject:group];
}

- (void)setUpGroup1 {
    
    settingGroup *group = [[settingGroup alloc] init];
    SettingItem *avatar = [SettingArrowItem arrowItemWithTitle:@"头像" pushController:nil];
    __weak typeof(self) icon = self;
    avatar.option = ^(SettingItem *item){
        
        //选择图片的获取方式
        [icon iconChangeClick];
    };
  
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame  = CGRectMake(0, 0, 50, 50);

    self.imageView = imageView;
    avatar.rightImageView = imageView;
    
    
    avatar.height = 70;
    self.avatar = avatar;
    
    SettingItem *nickName = [SettingArrowItem arrowItemWithTitle:@"昵称" pushController:nil];
    
    __weak typeof(self) profile = self;
    nickName.option = ^(SettingItem *item){
        NickNameController *nickNameController = [[NickNameController alloc] init];
        nickNameController.token = self.token;
        nickNameController.nickName = self.nickName.subTitle;
        [profile.navigationController pushViewController:nickNameController animated:YES];
    };
    
    self.nickName = nickName;
//    nickName.subTitle = @"北纬45°";
//    SettingItem *address = [SettingArrowItem arrowItemWithTitle:@"收货地址" pushController:[StatementViewController class]];
    
    
    group.items = @[avatar, nickName];
    [self.data addObject:group];
    
}

- (void)getPrefileDate
{
    
    NSString *time = [NSDate getTime];
    NSArray *arr = @[self.token, time];
    NSString *md5 = [Common paramsSign:arr];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.token, @"token",
                                time, @"time",
                                md5, @"sign",
                                PLATFORMID, @"app_id", nil];
    
    AnRequest *anReq = [[AnRequest alloc] init];
    NSString *netStr = @"?anu=api/1/user/get_user_info";
    [anReq get:netStr params:dictionary successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ANLog(@"bangdin:%@", responseObject);
        // 头像赋值
        self.profileDic = [NSDictionary dictionaryWithDictionary:responseObject];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.profileDic[@"small_avatar"]] placeholderImage:[UIImage imageNamed:@"avatar"]];
        
        // 昵称赋值
        self.nickName.subTitle = self.profileDic[@"nick_name"];
        // 保存昵称
        [[NSUserDefaults standardUserDefaults] setObject:self.profileDic[@"nick_name"] forKey:@"nickName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        self.idJD = self.profileDic[@"jd"][@"shop_id"];
        self.idTM = self.profileDic[@"tmall"][@"shop_id"];
        
        
        // 京东账户
        NSInteger jdBinding = [self.profileDic[@"jd"][@"mall_id"] integerValue];
        if (jdBinding == 0) {
            self.JD.subTitle = @"未绑定";
            self.JD.subTitleColor = [UIColor redColor];
        } else {
            self.JD.subTitle = @"已绑定";
            self.JD.subTitleColor = HDColor(128, 128, 128);
        }
        
        // 天猫账户
        NSInteger tmallBinding = [self.profileDic[@"tmall"][@"mall_id"] integerValue];
        if (tmallBinding == 0) {
            self.Tmall.subTitle = @"未绑定";
            self.Tmall.subTitleColor = [UIColor redColor];
        } else {
            self.Tmall.subTitle = @"已绑定";
            self.Tmall.subTitleColor = HDColor(128, 128, 128);
        }
        
        
        // QQ账户绑定
        if ([self.profileDic[@"qq"] isEqualToNumber:@0]) {
            self.QQ.subTitle = @"未绑定";
            self.QQ.subTitleColor = [UIColor redColor];
        } else if ([self.profileDic[@"qq"] isEqualToNumber:@1]) {
            self.QQ.subTitle = @"已绑定";
            self.QQ.subTitleColor = HDColor(128, 128, 128);
        } else {
        }
        
        // 新浪微博绑定
        if ([self.profileDic[@"weibo"] isEqualToNumber:@0]) {
            self.sinaWeibo.subTitle = @"未绑定";
            self.sinaWeibo.subTitleColor = [UIColor redColor];
        } else if ([self.profileDic[@"weibo"] isEqualToNumber:@1]) {
            self.sinaWeibo.subTitle = @"已绑定";
            self.sinaWeibo.subTitleColor = HDColor(128, 128, 128);
        } else {
        }
        
        // 电话号码
        self.phoneNumber = self.profileDic[@"mobile"];
        
        [self.tableView reloadData];
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        ANLog(@"filed responseObject : %@", responseObject);
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        ANLog(@"error : %@", error);
    }];
    
}
/**
 *  在试图将要出现的时候改变昵称
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.nickName.subTitle = [[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"];
    [self.tableView reloadData]; 
}

/**
 *  弹出选择器
 */
- (void)iconChangeClick
{
    
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                              delegate:self
                                                     cancelButtonTitle:@"取消"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"拍照", @"从手机相册选择", nil];
    
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 0://相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 1://相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            case 2:
                return;
                
        }
    }
    else {
        if (buttonIndex == 1) {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        } else {
            return;
        }
    }
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:^{}];
    
    
}
#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    // 将编辑后的图片写入本地
//    UIImageWriteToSavedPhotosAlbum(info[UIImagePickerControllerEditedImage], nil, nil, nil);
    self.imageView.image = info[UIImagePickerControllerEditedImage];
    
    [self sendWithImage:self.imageView.image compression:0.3];
    
    self.changImageBlock(info[UIImagePickerControllerEditedImage]);
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)changeImageWithBlock:(ChangeImageBlock)image
{
    self.changImageBlock = image;
}

/**
 *  上传头像
 */
- (void)sendWithImage:(UIImage *)image compression:(CGFloat)compression
{
    // 2.封装请求参数
    NSString *time = [NSDate getTime];
    NSArray *arr = @[self.token, time];
    NSString *md5 = [Common paramsSign:arr];
    NSString *encodeResult = [UIImageJPEGRepresentation(image, compression) base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.token, @"token",
                                encodeResult, @"avatar",
                                time, @"time",
                                md5, @"sign",
                                PLATFORMID, @"app_id", nil];
    
    // 3.发送请求
    AnRequest *anRequest = [[AnRequest alloc] init];
    NSString *netStr = @"?anu=api/1/user/save_avatar";
    [anRequest post:netStr params:dictionary image:image compression:compression successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD showSuccess:@"发送成功"];
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [MBProgressHUD showError:@"发送失败"];
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}




@end
