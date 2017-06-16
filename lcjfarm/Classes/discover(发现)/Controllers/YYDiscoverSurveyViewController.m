//
//  YYDiscoverSurveyViewController.m
//  lcjfarm
//
//  Created by wyy on 16/8/19.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYDiscoverSurveyViewController.h"

@interface YYDiscoverSurveyViewController ()

@property (nonatomic, copy) NSString *urlStr;
@end

@implementation YYDiscoverSurveyViewController
- (instancetype)initWithUrlStr:(NSString *)urlStr{
    if (self = [super init]) {
        self.title = @"问卷调查";
        self.urlStr = urlStr;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
   
    NSURL *url = [NSURL URLWithString:self.urlStr];
    
    UIWebView *webView = [[UIWebView alloc] init];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(self.view);
    }];
    [webView loadRequest:[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0]];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
