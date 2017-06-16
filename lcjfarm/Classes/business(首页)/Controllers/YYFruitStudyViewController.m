//
//  YYFruitStudyViewController.m
//  lcjfarm
//
//  Created by wyy on 16/7/22.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYFruitStudyViewController.h"

@interface YYFruitStudyViewController ()
@property (nonatomic, weak) UIWebView *webView;

@property (nonatomic, strong) NSString *urlStr;
@end

@implementation YYFruitStudyViewController
- (instancetype)initWithUrlStr:(NSString *)urlStr{
    if (self = [super init]) {
        self.urlStr = urlStr;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"水果课堂";
    //增加web View
    [self addWebView];
}
#pragma mark 增加web View
/**
 *  增加web View
 */
- (void)addWebView{
    UIWebView *webView = [[UIWebView alloc] init];
    [self.view addSubview:webView];
    self.webView = webView;
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
    
    NSURL *url = [NSURL URLWithString:self.urlStr];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
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
