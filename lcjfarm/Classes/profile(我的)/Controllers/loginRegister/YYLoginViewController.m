//
//  YYLoginViewController.m
//  lcjfarm
//
//  Created by wyy on 16/7/28.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYLoginViewController.h"

#import "YYRegisterCodeViewController.h"
#import "YYUserTool.h"

@interface YYLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIView *phoneLine;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *passwordLine;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation YYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    //设置子控件的属性
    [self setViews];
}
#pragma mark 设置子控件的属性
/**
 *  设置子控件的属性
 */
- (void)setViews{
    //设置线条的颜色
    self.phoneLine.backgroundColor = kGrayLineColor;
    self.passwordLine.backgroundColor = kGrayLineColor;
    
    [self.registerBtn setTitleColor:kNavColor forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  登录按钮被点击
 */
- (IBAction)loginBtnClick:(id)sender {
    NSString *phone = self.phoneTextField.text;
    NSString *password = self.passwordTextField.text;
    if (phone.length == 0) {
        [MBProgressHUD showError:@"请输入手机号"];
        return;
    }
    else if (password.length == 0){
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }

    [self loginWithPhone:phone andPassword:password];
}
#pragma mark 去登录用户
/**
 *  去登录用户
 */
- (void)loginWithPhone:(NSString *)phone andPassword:(NSString *)password{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"username"] = phone;
    parameters[@"password"] = password;
//    YYLog(@"登录phone:%@\npassword:%@", phone, password);
    
    [NSObject POST:@"http://app.guonongda.com:8080/user/loginByName.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(NSDictionary *responseObject, NSError *error) {
        YYLog(@"正确:%@\n 错误:%@",responseObject, error);
        
        NSString *returnCode = responseObject[@"status"];
        if ([returnCode isEqualToString:@"404"]) {
            [MBProgressHUD showError:@"用户名或密码错误"];
            return;
            
        }
        else if ([returnCode isEqualToString:@"200"]){
            NSDictionary *dic = responseObject[@"data"];
            
            [MBProgressHUD showSuccess:@"登录成功"];
            YYUserModel *userModel = [YYUserTool userModel];
            if (userModel == nil) {
                userModel = [[YYUserModel alloc] init];
            }
            NSString *afterPhone = [phone substringFromIndex:phone.length - 4];
            userModel.name = [NSString stringWithFormat:@"果农达#%@",afterPhone];
            userModel.userID = dic[@"id"];
            [YYUserTool saveUserModel:userModel];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else{
            [MBProgressHUD showError:@"用户登录失败"];
        }
    }];

}
- (IBAction)registerBtnClick:(id)sender {
    YYRegisterCodeViewController *registerController = [[YYRegisterCodeViewController alloc] init];
    [self.navigationController pushViewController:registerController animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
