//
//  YYFruitNewsWebViewController.m
//  lcjfarm
//
//  Created by wyy on 16/7/13.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "YYFruitNewsWebViewController.h"
#import "YYFruitNewsModel.h"

@interface YYFruitNewsWebViewController (){
    YYFruitNewsModel *_model;
}
@property (nonatomic, weak) UIWebView *webView;
@end

@implementation YYFruitNewsWebViewController
- (instancetype)initWithModel:(YYFruitNewsModel *)model{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = _model.title;
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
    
    NSURL *url = [NSURL URLWithString:_model.weburl];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
