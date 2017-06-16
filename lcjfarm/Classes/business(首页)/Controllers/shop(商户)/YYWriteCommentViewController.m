//
//  YYWriteCommentViewController.m
//  pugongying
//
//  Created by wyy on 16/3/14.
//  Copyright © 2016年 WYY. All rights reserved.
//
/**
 *  设置tag值，0为创建资讯评论控制器，1为创建的课程评论控制器
 */
#import "YYWriteCommentViewController.h"
#import "YYUserTool.h"


#import "YYFruitShopModel.h"

#define YYAddNewsSuccess @"YYAddNewsSuccess"

@interface YYWriteCommentViewController ()

@property (nonatomic, strong) YYFruitShopModel *model;
/**
 *  输入的文字
 */
@property (nonatomic, weak) UITextView *textView;
/**
 *  检测是否是第一次输入文字
 */
@property (nonatomic, assign,getter=isFirstWrite) BOOL firstWrite;
/**
 *  蒙版按钮
 */
@property (nonatomic, strong) UIButton *coverBtn;

@property (nonatomic, copy) NSString *placeholderStr;
@end


@implementation YYWriteCommentViewController

- (instancetype)initWithShopModel:(YYFruitShopModel *)model{
    if (self = [super init]) {
        self.model = model;
        self.placeholderStr = @"请输入对店家的建议！";
    }
    return self;
}
/**
 *  蒙版按钮懒加载
 */
- (UIButton *)coverBtn{
    if (!_coverBtn) {
        CGFloat textViewH = 160;
        CGFloat textViewY = 12 + 64;
        CGFloat tableViewY =textViewY + textViewH;
        CGFloat tableViewH = kHeightScreen -tableViewY;
        _coverBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, tableViewY, kWidthScreen, tableViewH)];
        _coverBtn.backgroundColor = [UIColor clearColor];
        [_coverBtn addTarget:self action:@selector(coverBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _coverBtn;
}
//蒙版按钮被点击
- (void)coverBtnClick{
    [self.coverBtn removeFromSuperview];
    
    [self.textView resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //增加提交按钮
    [self addPostBtn];
    
    //增加输入框
    CGFloat textViewH = 400;
    CGFloat textViewW = kWidthScreen - 2 * 12;
    CGFloat textViewY = 12 + 64;
    [self addTextViewWithFrame:CGRectMake(12, textViewY, textViewW, textViewH)];
    
}
#pragma mark 监听输入框的方法
/**
 *  输入框开始输入
 */
- (void)beginWrite1{
    //    YYLog(@"beginWrite");
    if (self.isFirstWrite) return;
    
    self.textView.text = nil;
    self.textView.textColor = [UIColor blackColor];
    
}
/**
 *  输入框正在输入
 */
- (void)nowWrite1{
    //    YYLog(@"输入框正在输入");
    self.firstWrite = YES;
}
/**
 *  输入框结束输入
 */
- (void)endWrite1{
    //    YYLog(@"结束输入");
    if (self.firstWrite) return;
    
    self.textView.text = self.placeholderStr;
    self.textView.textColor = [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1];
}

#pragma mark 增加取消和下一步按钮
- (void)addPostBtn{
    //增加提交按钮
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn setTitle:@"提交" forState:UIControlStateNormal];
    [nextBtn sizeToFit];
    [nextBtn addTarget:self action:@selector(postBtnClick) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:nextBtn];
}
#pragma mark 增加输入框
- (void)addTextViewWithFrame:(CGRect)textViewFrame{
    
    UITextView *textView = [[UITextView alloc] initWithFrame:textViewFrame];
    [self.view addSubview:textView];
    self.textView = textView;
    self.textView.font = [UIFont systemFontOfSize:16];
    self.textView.text = self.placeholderStr;
    self.textView.textColor = [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1];
    //监听输入框开始输入文字
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginWrite1) name:UITextViewTextDidBeginEditingNotification object:nil];
    //监听输入框正在输入文字
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nowWrite1) name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endWrite1) name:UITextViewTextDidEndEditingNotification object:nil];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.textView.returnKeyType = UIReturnKeyDone;
    //添加遮盖层
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
}
/**
 *  键盘弹出添加遮盖层
 */
- (void)keyboardWillShow{
    [self.view addSubview:self.coverBtn];
}
/**
 *  提交按钮被点击
 */
- (void)postBtnClick{
    
    YYUserModel *userModel = [YYUserTool userModel];
    if (!userModel.userID) {
        //去登录页面
        [self registerLoginBtnClick];
        return;
        
    }
    
    if (!self.isFirstWrite) {
        [MBProgressHUD showError:@"请先填写评论" toView:self.view];
        return;
    }
    //提交评论
    [self postComment];
}
#pragma mark 提交评论
/**
 *  提交评论
 */
- (void)postComment{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    YYUserModel *userModel = [YYUserTool userModel];

    parameters[@"userid"] = userModel.userID;
    parameters[@"username"] = userModel.name;
    parameters[@"shopid"] = self.model.shopid;
    parameters[@"medetails"] = self.textView.text;
    
    [MBProgressHUD showMessage:@"正在提交评论"];
    
    [NSObject POST:@"http://app.guonongda.com:8080/me/save.do" parameters:parameters progress:^(NSProgress *downloadProgress) {
        
    } completionHandler:^(id responseObject, NSError *error) {
        [MBProgressHUD hideHUD];
        if (error) {
            [MBProgressHUD showError:@"提交评论失败"];
            return;
        }
        if ([responseObject isEqual:[NSNull null]]) {
            [MBProgressHUD showError:@"提交评论失败"];
            return;
        }
        NSString *status = responseObject[@"status"];
        if ([status isEqualToString:@"0"]) {
            [MBProgressHUD showSuccess:@"成功提交评论"];
            if (self.YYPostCommentSuccessBlock) {
                self.YYPostCommentSuccessBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [MBProgressHUD showError:@"提交评论失败"];
        }

    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark 登陆注册按钮被点击 触发登录动作
/**
 *  登陆注册按钮被点击 触发登录动作
 */
- (void)registerLoginBtnClick{
    
    [MBProgressHUD showError:@"请先去登录"];
}
@end
