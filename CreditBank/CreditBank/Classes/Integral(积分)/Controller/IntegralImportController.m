//
//  IntegralmportController.m
//  CreditBank
//
//  Created by Eric on 15/5/7.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "IntegralImportController.h"
#import "PrefixHeader.pch"
#import "AddBankHeadView.h"
#import "BlueButtonView.h"
#import "ImpotSuccessController.h"

@interface IntegralImportController ()<BlueButtonViewDelegate, AddBankHeadViewDelegate, UITextFieldDelegate>

@property (nonatomic, weak) BlueButtonView *impotBtn;
@property (nonatomic, weak) AddBankHeadView *addBankHeadV;


@end

@implementation IntegralImportController

- (void)viewDidLoad {
    [super viewDidLoad];
    ANLog(@"------->>===>>>%@", self.bankInfoM);
    
    self.tableView.backgroundColor = DEFALT_BG;
    AddBankHeadView *addBankHeadV = [AddBankHeadView addBankHeadView];
    addBankHeadV.bankInfoModel = self.bankInfoM;
    addBankHeadV.delegate = self;
    self.tableView.tableHeaderView = addBankHeadV;
    self.addBankHeadV = addBankHeadV;
    
    // 导入按钮
    BlueButtonView *impotBtn = [[BlueButtonView alloc] initWithBtnTitle:@"全部导入"];
    impotBtn.delegate = self;
    CGFloat loginBtnY = 0;
    CGFloat loginBtnW = WIDTH;
    CGFloat loginBtnH = 46;
    CGFloat loginBtnX = 0;
    
    impotBtn.frame = CGRectMake(loginBtnX, loginBtnY, loginBtnW, loginBtnH);
    self.tableView.tableFooterView = impotBtn;
    self.impotBtn = impotBtn;
    
    
}

- (void)AddBankHeadViewClickedAction:(UIView *)view button:(UIButton *)button index:(NSInteger)index
{
    
    if (index == 0) {
        [self.impotBtn setBtnTitle:@"导入" state:UIControlStateNormal];
    } else if (index == 1) {
        [self.impotBtn setBtnTitle:@"全部导入" state:UIControlStateNormal];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    view.backgroundColor = DEFALT_BG;
    return view;
}


- (void)btnClick:(id)view btn:(UIButton *)btn
{
    [self.addBankHeadV.inputTextField resignFirstResponder];
    if ([btn.currentTitle isEqualToString:@"导入"]) {
//        ANLog(@"%@, %@", self.addBankHeadV.inputTextField.text, self.addBankHeadV.exchangedIntegralLabel.text);
        
        
        [self postRestPassWordAndpostRegistInfomation:@"?anu=api/1/credit/bank_credit_delete" creadNumberOf:self.addBankHeadV.inputTextField.text];
        
    } else if ([btn.currentTitle isEqualToString:@"全部导入"]) {
//        ANLog(@"%@, %@", self.addBankHeadV.integralLabel.text, self.addBankHeadV.exchangedIntegralLabel.text);
        
        [self postRestPassWordAndpostRegistInfomation:@"?anu=api/1/credit/bank_credit_delete" creadNumberOf:self.addBankHeadV.integralLabel.text];
        
    }
    
}

/**
 *  提交重置密码信息 && 提交注册信息 && 提交注册绑定手机号信息
 */
- (void)postRestPassWordAndpostRegistInfomation:(NSString *)netString creadNumberOf:(NSString *)creadNumberOf
{
    NSString *bankId = self.bankInfoM.bank_id;
    NSString *idCardNumber = self.bankInfoM.card_no;
    NSString *creadNumber = creadNumberOf;
    NSString *token = [Common token];
    NSString *time = [NSDate getTime];
    
    NSArray *arr = @[idCardNumber, bankId, creadNumber, token, time];
    NSString *md5 = [Common paramsSign:arr];
    
    NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                 bankId, @"bank_id",
                                 idCardNumber, @"card_no",
                                 creadNumber, @"num",
                                 token, @"token",
                                 time, @"time",
                                 md5, @"sign",
                                 PLATFORMID, @"app_id", nil];
    
    AnRequest *anReq = [[AnRequest alloc] init];
    [anReq post:netString params:dictionary successBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
//        ANLog(@"--->>>success: %@", responseObject);

        ImpotSuccessController *impotSuccessController = [[ImpotSuccessController alloc] init];
        impotSuccessController.strUrl  = @"?anu=m/card_exchange/import_ok&source_page=bank_type";
        
        [self.navigationController pushViewController:impotSuccessController animated:YES];
        
    } errorBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        ANLog(@"error: %@", operation);
        [self setAlertViewWithMessage:responseObject[@"error_info"]];
    } failBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        ANLog(@"fail: %@", error);
    }];
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

@end
