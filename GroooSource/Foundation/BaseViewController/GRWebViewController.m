//
//  GRWebViewController.m
//  GroooSource
//
//  Created by 李永光 on 2017/2/9.
//  Copyright © 2017年 Assuner. All rights reserved.
//

#import "GRWebViewController.h"

@interface GRWebViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic , strong) NSString *url;

@property (nonatomic , strong) NSString *titleText;

@end

@implementation GRWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    [self startLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (instancetype)initWithURL:(NSString *)url title:(NSString *)text {
    if (self = [super init]) {
        self.titleText = text;
        self.url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    return self;
}

+ (GRNavigationController *)modalWebviewWithURL:(NSString *)url title:(NSString *)text
{
    return [[GRNavigationController alloc] initWithRootViewController:[[self alloc] initWithURL:url title:text]];
}

- (void)startLoad {
    if ([NSString gr_isInvalid:_url]) {
        [self showMessage:@"地址错误!"];
        return;
    }
    NSURL *URL = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [self.webView loadRequest:request];
}

- (void)closeWebView {
    if (self.presentingViewController) {
         [self dismissViewControllerWithAnimation:GRTransitionTypePageCurl completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma - override

- (void)setupBarItem {
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    flexSpace.width = -2;
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_arrow_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    UIBarButtonItem *closeBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"close_cross_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(closeWebView)];
    
    self.navigationItem.leftBarButtonItems = @[flexSpace, backBtn, closeBtn];
}

- (void)back {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        return;
    }
    [self closeWebView];
}

#pragma UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.title = @"加载中···";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.title = self.titleText;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    self.title = self.titleText;
    [self showMessage:@"加载失败"];
}

@end
