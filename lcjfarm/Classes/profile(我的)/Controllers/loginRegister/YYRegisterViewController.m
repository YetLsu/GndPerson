//
//  YYRegisterViewController.m
//  lcjfarm
//
//  Created by wyy on 16/7/28.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYRegisterViewController.h"
#import "YYUserTool.h"

@interface YYRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *firstPasswordLine;
@property (weak, nonatomic) IBOutlet UITextField *firstPasswordTextField;

@property (weak, nonatomic) IBOutlet UIView *secondPasswordLine;
@property (weak, nonatomic) IBOutlet UITextField *secondPasswordTextField;
/**
 手机号
 */
@property (nonatomic, copy) NSString *phone;
@end

@implementation YYRegisterViewController
/**
 *  创建控制器的方法
 */
- (instancetype)initWithPhone:(NSString *)phone{
    if (self = [super init]) {
        self.phone = phone;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    //设置子控件的属性
    [self setViews];
}
#pragma mark 设置子控件的属性
/**
 *  设置子控件的属性
 */
- (void)setViews{
    //设置线条的颜色
    self.firstPasswordLine.backgroundColor = kGrayLineColor;
    self.secondPasswordLine.backgroundColor = kGrayLineColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  注册按钮被点击
 */
- (IBAction)registerBtnClick:(id)sender {
    NSString *firstPassWord = self.firstPasswordTextField.text;
    NSString *secondPassWord = self.secondPasswordTextField.text;
    
    if (firstPassWord.length == 0) {
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }
    else if (secondPassWord.length == 0){
        [MBProgressHUD showError:@"请再次输入密码"];
        return;
    }
    else if (![firstPassWord isEqualToString:secondPassWord]){
        [MBProgressHUD showError:@"两次输入的密码不一致"];
        return;
    }
    
    //去注册用户
    [self registerUserWithPassword:firstPassWord];
}
#pragma mark 去注册用户
/**
 *  去注册用户
 *
 */
- (void)registerUserWithPassword:(NSString *)password{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"username"] = self.phone;
    parameters[@"password"] = password;
//     YYLog(@"注册phone:%@\npassword:%@", self.phone, password);
    [NSObject POST:@"http://app.guonongda.com:8080/user/registerByName.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(NSDictionary *responseObject, NSError *error) {
        YYLog(@"正确:%@\n 错误:%@",responseObject, error);
        
        NSString *returnCode = responseObject[@"status"];
        if ([returnCode isEqualToString:@"404"]) {
            [MBProgressHUD showError:@"该用户已存在"];
            return;
            
        }
        else if ([returnCode isEqualToString:@"200"]){
            NSDictionary *dic = responseObject[@"data"];
            [MBProgressHUD showSuccess:@"成功注册"];
            YYUserModel *userModel = [YYUserTool userModel];
            NSString *afterPhone = [self.phone substringFromIndex:self.phone.length - 4];
            userModel.name = [NSString stringWithFormat:@"果农达#%@",afterPhone];
            userModel.userID = dic[@"id"];
            [YYUserTool saveUserModel:userModel];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else{
            [MBProgressHUD showError:@"用户注册失败"];
        }
    }];

}
@end
