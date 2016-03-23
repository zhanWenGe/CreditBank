//
//  BarkImportController.m
//  CreditBank
//
//  Created by Eric on 15/5/6.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "BarkImportController.h"
#import "PrefixHeader.pch"
#import "LineButton.h"

#import "settingGroup.h"
#import "SettingItem.h"
#import "BlueButtonView.h"
#import "TimeOutHander.h"
#import "Common.h"
#import "IntegralImportController.h"
#import "BankInfoModel.h"

#define CELLHIGH 47
bool agreeSelect = YES;
@interface BarkImportController ()<LineButtonDelegate, BlueButtonViewDelegate>

@property(nonatomic, weak) UITextField *idCardTextField;
@property(nonatomic, weak) UITextField *passwdTextField;
@property(nonatomic, weak) UITextField *verificationCodeTextField;
@property(nonatomic, weak) UIButton *remberBtn;

@property (nonatomic, retain) UILabel *checkCodeNumberLabel;
@property (nonatomic, copy) NSString *code;

@property (nonatomic, strong) UIImageView *verificationImage;

@property (nonatomic, weak) TimeOutHander *timeOut;

@property (nonatomic, strong) UILabel *timeLabel;






@end

@implementation BarkImportController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTopLineButton];
}


- (void)setTopLineButton
{
    self.view.backgroundColor = DEFALT_BG;
    // 顶部的按钮
    LineButton *lineButton = [LineButton lineButtonTableView:nil leftButton:@"信用卡" middleBtton:@"储蓄卡" rightButton:@"一网通"];
    lineButton.backgroundColor = [UIColor whiteColor];
    lineButton.delegate = self;
    lineButton.frame = CGRectMake(0, 0, WIDTH, 35);
    [self.tableView addSubview:lineButton];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 55;
    } else {
        return 10;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return 20;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELLHIGH;
}

#pragma mark - lineButtonDelegate
- (void)lineButtonClicked:(LineButton *)view button:(UIButton *)btn index:(NSInteger)index
{
    //    ANLog(@"%@, %ld", btn, index);
}

#pragma mark -- TableView Mehod
- (void)setUpData {
    [self setUpGroup];
}


- (void)setUpGroup {
    
    // 身份证组
    settingGroup *idCardGroup = [[settingGroup alloc] init];
    
    // 身份证
    SettingItem *idCardItem = [SettingItem itemWithIcon:nil title:@"身份证"];
    
    UIButton *passwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [passwdBtn setImage:[UIImage imageNamed:@"warning"] forState:UIControlStateNormal];
    [passwdBtn setTitle:@"字母区分大小写" forState:UIControlStateNormal];
    
    [passwdBtn setTitleColor:HDColor(246, 94, 89) forState:UIControlStateNormal];
    passwdBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    passwdBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    
    CGFloat passwdBtnX = WIDTH - 120;
    CGFloat passwdBtnY = 0;
    CGFloat passwdBtnW = 110;
    CGFloat passwdBtnH = CELLHIGH;
    passwdBtn.frame = CGRectMake(passwdBtnX, passwdBtnY, passwdBtnW, passwdBtnH);
    idCardItem.customView = passwdBtn;
    
    // 身份证号码
    SettingItem *idCardNumberItem = [SettingItem itemWithIcon:nil title:nil];
    
    UITextField *idCardTextField = [[UITextField alloc] init];
    idCardTextField.placeholder = @"输入身份证号码";
    CGFloat idCardTextFieldX = 20;
    CGFloat idCardTextFieldY = 0;
    CGFloat idCardTextFieldH = CELLHIGH;
    CGFloat idCardTextFieldW = WIDTH - 40;
    idCardTextField.frame = CGRectMake(idCardTextFieldX, idCardTextFieldY, idCardTextFieldW, idCardTextFieldH);
    self.idCardTextField = idCardTextField;
    [self.idCardTextField becomeFirstResponder];
    idCardNumberItem.customView = self.idCardTextField;
    
    idCardGroup.items = @[idCardItem, idCardNumberItem];
    
    // 密码组
    settingGroup *passwdGroup = [[settingGroup alloc] init];
    // 查询密码
    SettingItem *passwdItem = [SettingItem itemWithIcon:nil title:@"查询密码"];
    
    UIButton *verificationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [verificationBtn setImage:[UIImage imageNamed:@"warning"] forState:UIControlStateNormal];
    [verificationBtn setTitle:@"请输入6位查询密码" forState:UIControlStateNormal];
    [verificationBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
    [verificationBtn setTitleColor:HDColor(246, 94, 89) forState:UIControlStateNormal];
    verificationBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    verificationBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    verificationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    CGFloat verificationBtnX = WIDTH - 255;
    CGFloat verificationBtnY = 0;
    CGFloat verificationBtnW = 245;
    CGFloat verificationBtnH = CELLHIGH;
    verificationBtn.frame = CGRectMake(verificationBtnX, verificationBtnY, verificationBtnW, verificationBtnH);
    passwdItem.customView = verificationBtn;
    
    
    // 密码输入框
    SettingItem *passwdTextItem = [SettingItem itemWithIcon:nil title:nil];
    
    UITextField *passwdTextField = [[UITextField alloc] init];
    passwdTextField.placeholder = @"输入查询密码";
    passwdTextField.secureTextEntry = YES;
    passwdTextField.frame = CGRectMake(idCardTextFieldX, idCardTextFieldY, idCardTextFieldW, idCardTextFieldH);
    self.passwdTextField = passwdTextField;
    passwdTextItem.customView = self.passwdTextField;
    
    passwdGroup.items = @[passwdItem, passwdTextItem];
    
    // 验证码组
    settingGroup *verificationCodeGroup = [[settingGroup alloc] init];
    // 验证码
    SettingItem *verificationCodeItem = [SettingItem itemWithIcon:nil title:@"验证码"];
    // 验证码显示图片
    CGFloat verificationImageW = 100;
    CGFloat verificationImageX = WIDTH - 100 - 20;
    CGFloat verificationImageY = 5;
    CGFloat verificationImageH = idCardTextFieldH - 10;
    self.verificationImage = [[UIImageView alloc] initWithFrame:CGRectMake(verificationImageX, verificationImageY, verificationImageW, verificationImageH)];
    verificationCodeItem.customView = self.verificationImage;
    [self onTapToGenerateCode:nil];
    // 添加点击手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapToGenerateCode:)];
    self.verificationImage.userInteractionEnabled = YES;
    [self.verificationImage addGestureRecognizer:tapGesture];
    
    
    // 验证码输入框
    SettingItem *verificationCodeTextItem = [SettingItem itemWithIcon:nil title:nil];
    
    UITextField *verificationCodeTextField = [[UITextField alloc] init];
    verificationCodeTextField.placeholder = @"输入验证码";
    
    verificationCodeTextField.frame = CGRectMake(idCardTextFieldX, idCardTextFieldY, idCardTextFieldW + 10, idCardTextFieldH);
    self.verificationCodeTextField  = verificationCodeTextField;
    verificationCodeTextItem.customView = self.verificationCodeTextField;
    
    //剩余时间
    [self setTimeOutAddReset];
    verificationCodeGroup.items = @[verificationCodeItem, verificationCodeTextItem];
    
    
    // 同意<用户使用协议>
    settingGroup *agreeWithGroup = [[settingGroup alloc] init];
    SettingItem *agreeWithItem = [SettingItem itemWithLabel:nil title:nil];
    
    
    UIButton *rememberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rememberBtn addTarget:self action:@selector(rememberBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [rememberBtn setImage:[UIImage imageNamed:@"remberme"] forState:UIControlStateNormal];
    [rememberBtn setImage:[UIImage imageNamed:@"rembermeSelected"] forState:UIControlStateSelected];
    [rememberBtn setTitle:@"同意《用户使用协议》" forState:UIControlStateNormal];
    
    [rememberBtn setTitleColor:HDColor(3, 3, 3) forState:UIControlStateNormal];
    rememberBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    rememberBtn.frame = CGRectMake(idCardTextFieldX - 5, idCardTextFieldY, 170, idCardTextFieldH);
    rememberBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 7, 0, 0);
    agreeWithItem.customView = rememberBtn;
    self.remberBtn = rememberBtn;
    
    agreeWithGroup.items = @[agreeWithItem];
    
    
    
    [self.data addObject:idCardGroup];
    [self.data addObject:passwdGroup];
    [self.data addObject:verificationCodeGroup];
    [self.data addObject:agreeWithGroup];
    
    
    // 导入按钮
    BlueButtonView *loginBtn = [[BlueButtonView alloc] initWithBtnTitle:@"导入"];
    loginBtn.delegate = self;
    
    CGFloat loginBtnY = 0;
    CGFloat loginBtnW = WIDTH;
    CGFloat loginBtnH = 46;
    CGFloat loginBtnX = 0;
    
    loginBtn.frame = CGRectMake(loginBtnX, loginBtnY, loginBtnW, loginBtnH);
    self.tableView.tableFooterView = loginBtn;
    
}

/**
 *  同意用户协议按钮
 */
- (void)rememberBtnClick:(UIButton *)button {
    
    if (agreeSelect == YES) {
        button.selected = YES;
        agreeSelect = NO;
    }else{
        button.selected = NO;
        agreeSelect = YES;
    }
}

- (void)btnClick:(id)view btn:(UIButton *)btn
{
    int checkResult = [self.verificationCodeTextField.text compare:self.code options:NSCaseInsensitiveSearch];
 
    if (agreeSelect == YES) {
        
        [self setAlertViewWithMessage:@"未同意《用户使用协议》不可导入,若需导入请选择同意"];
        
    } else {
        if (self.idCardTextField.text.length == 0) {
            [self setAlertViewWithMessage:@"身份证号码为空"];
        } else if (self.passwdTextField.text == nil || self.passwdTextField.text.length != 6) {
            [self setAlertViewWithMessage:@"请输入6位查询密码"];
        } else  if (checkResult == -1) {
            [self setAlertViewWithMessage:@"请输入正确的验证码"];
        } else{
            
            [self postLoginInformation];
        }
        
        
    }
    
    ANLog(@"agree   Select = %d", agreeSelect);
}

/**
 *  提交登陆信息
 */
- (void)postLoginInformation
{
    [self postImportInfomation:@"?anu=api/1/card/bind_bank_card"];
}

/**
 *  填出提示框
 *
 *  @param message 提示信息
 */
- (void)setAlertViewWithMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles:nil, nil];
    [alertView show];
    
}


/**
 *  提交数据
 */
- (void)postImportInfomation:(NSString *)netString
{
    NSString *token = [Common token];
    NSString *bankId = self.bankId;
    NSString *type = self.type;
    NSString *idCardNumber = self.idCardTextField.text;
    NSString *password = self.passwdTextField.text;
    NSString *verificatCode = self.verificationCodeTextField.text;
    NSString *time = [NSDate getTime];
    NSArray *arr = @[token, idCardNumber, verificatCode, password, time];
    NSString *md5 = [Common paramsSign:arr];
    
    NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                 token, @"token",
                                 bankId, @"bank_id",
                                 type, @"type",
                                 idCardNumber, @"identity_id",
                                 verificatCode, @"check_code",
                                 password, @"query_code",
                                 time, @"time",
                                 md5, @"sign",
                                 PLATFORMID, @"app_id", nil];
    
    AnRequest *anReq = [[AnRequest alloc] init];
    [anReq post:netString params:dictionary successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        ANLog(@"--?>success: %@", responseObject[@"bank_info"]);
        
        BankInfoModel *bankInfM = [BankInfoModel objectWithKeyValues:responseObject];
        
        IntegralImportController *integralImport = [[IntegralImportController alloc] init];
        integralImport.title = self.title;
        integralImport.bankInfoM = bankInfM;
        [self.navigationController pushViewController:integralImport animated:YES];
        
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        ANLog(@"error: %@", operation);
        [self setAlertViewWithMessage:responseObject[@"error_info"]];
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        ANLog(@"fail: %@", error);
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < -10) {
        
        [self.idCardTextField resignFirstResponder];
        [self.passwdTextField resignFirstResponder];
        [self.verificationCodeTextField resignFirstResponder];
    }
    
    
}

- (void)onTapToGenerateCode:(UITapGestureRecognizer *)tap {
    
    [self.verificationImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/security_code?token=%@&random=%u", HOSTURL, [Common token], (arc4random() % 10000)]]];
    [self.timeLabel removeFromSuperview];
    

    [self setTimeOutAddReset];
    
    ANLog(@"%@", [NSString stringWithFormat:@"%@/security_code?token=%@&random=%u", HOSTURL, [Common token], (arc4random() % 10000)]);
    
    return;
}

- (void)setTimeOutAddReset
{
    CGFloat timeLabelW = 150;
    CGFloat timeLabelX = CGRectGetMaxX(self.verificationCodeTextField.frame) - 150 - 20;
    CGFloat timeLabelY = 0;
    CGFloat timeLabelH = 15;
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH)];
    self.timeLabel.font = [UIFont systemFontOfSize:15];
    self.timeLabel.center = CGPointMake(self.timeLabel.center.x, self.verificationCodeTextField.center.y);
    [self.verificationCodeTextField addSubview:self.timeLabel];
    self.timeLabel.textColor = HDColor(183, 183, 183);
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeOut = [TimeOutHander timeOut:200 overTime:@"已过期" ingTime:@"秒过期"];
    self.timeOut.timeLabel = self.timeLabel;
}


@end
