//
//  YYLoginViewController.m
//  lcjfarm
//
//  Created by wyy on 16/7/14.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYRegisterCodeViewController.h"
#import "YYRegisterViewController.h"
#import "YYUserTool.h"


 #import <SMS_SDK/SMSSDK.h>

@interface YYRegisterCodeViewController ()
/**
 *  用户手机号输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
/**
 *  用户手机号右边的竖线
 */
@property (weak, nonatomic) IBOutlet UIView *phoneRightLineView;
/**
 *  用户手机号底下的竖线
 */
@property (weak, nonatomic) IBOutlet UIView *phoneBottomLineView;
/**
 *  发送验证码按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *sendCodeBtn;
/**
 *  验证码输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
/**
 *  验证码输入框底部的线条
 */
@property (weak, nonatomic) IBOutlet UIView *codeBottomLineView;
/**
 *  点击登录，表示同意label
 */
@property (weak, nonatomic) IBOutlet UILabel *loginTextLabel;
/**
 *  用户协议按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *userBtn;
/**
 *  登录按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

/**
 *  定时器
 */
@property (nonatomic, strong) NSTimer *timer;

/**
 *  计时
 */
@property (nonatomic, assign) int i;

@end

@implementation YYRegisterCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    
    //设置子控件的属性
    [self setViews];
    
    //为按钮添加动作
    [self addBtnsActions];
    
}
#pragma mark 设置子控件的属性
/**
 *  设置子控件的属性
 */
- (void)setViews{
    //设置线条的颜色
    self.phoneRightLineView.backgroundColor = kGrayLineColor;
    self.phoneBottomLineView.backgroundColor = kGrayLineColor;
    self.codeBottomLineView.backgroundColor = kGrayLineColor;
    
    //设置发送验证码按钮的颜色
    [self.sendCodeBtn setTitleColor:kGrayTextColor forState:UIControlStateNormal];
    
    //设置label颜色
    self.loginTextLabel.textColor = kGrayTextColor;
    
    //用户协议按钮设置
    [self.userBtn setTitleColor:kNavColor forState:UIControlStateNormal];
}
#pragma mark 为按钮添加动作
/**
 *  为按钮添加动作
 */
- (void)addBtnsActions{
    //用户协议按钮被点击
    [self.userBtn bk_addEventHandler:^(id sender) {
        YYLog(@"用户协议按钮被点击");
    } forControlEvents:UIControlEventTouchUpInside];
    
    //验证按钮被点击
    [self.loginBtn bk_addEventHandler:^(id sender) {
        YYLog(@"验证按钮被点击");
        [self loginBtnClcik];
    } forControlEvents:UIControlEventTouchUpInside];
    
    //发送验证码按钮被点击
    [self.sendCodeBtn bk_addEventHandler:^(id sender) {
        [self sendCodeBtnClick];
        
    } forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark 发送验证码按钮被点击
/**
 *  发送验证码按钮被点击
 */
- (void)sendCodeBtnClick{

    if (self.phoneTextField.text.length == 0) {
        [MBProgressHUD showError:@"请输入手机号"];
        return;
    }
    [MBProgressHUD showMessage:@"正在发送验证码"];
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneTextField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        [MBProgressHUD hideHUD];
        
        
        if (!error) {
            self.sendCodeBtn.enabled = NO;
            //            YYLog(@"获取验证码成功");
            [MBProgressHUD showSuccess:@"验证码已发送"];
            
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
            self.timer = timer;
            
            [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
            self.i = 60;
            
            [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"%d秒",self.i] forState:UIControlStateDisabled];
        }
        else{
            [MBProgressHUD showError:@"验证码发送失败"];
        }
    }];
}
#pragma mark 验证按钮被点击
/**
 *  验证按钮被点击
 */
- (void)loginBtnClcik{
    
    NSString *phone = self.phoneTextField.text;
    NSString *code = self.codeTextField.text;
    if (phone.length == 0) {
        [MBProgressHUD showError:@"请输入手机号"];
        return;
    }
    else if (code.length == 0){
        [MBProgressHUD showError:@"请输入验证码"];
        return;
    }
    
    self.sendCodeBtn.enabled = YES;
    [MBProgressHUD showMessage:@"正在验证"];
    /**
     *  提交验证码
     *
     */
    [SMSSDK commitVerificationCode:code phoneNumber:phone zone:@"86" result:^(NSError *error) {
        [MBProgressHUD hideHUD];
        if (!error) {//没有错误
//            YYLog(@"验证码正确");
            
            [MBProgressHUD showSuccess:@"验证码正确"];
            
            YYRegisterViewController *registerController = [[YYRegisterViewController alloc] initWithPhone:self.phoneTextField.text];
            [self.navigationController pushViewController:registerController animated:YES];
        }
        else
        {
            [MBProgressHUD showError:@"验证码验证失败"];
            YYLog(@"错误信息:%@",error);
        }
    }];

}
#pragma mark 定时器动作
- (void)timerAction{
    self.i--;
    
    if (self.i == 0) {
        [self.timer invalidate];
        self.sendCodeBtn.enabled = YES;
    }
    [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"%d秒",self.i] forState:UIControlStateDisabled];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
