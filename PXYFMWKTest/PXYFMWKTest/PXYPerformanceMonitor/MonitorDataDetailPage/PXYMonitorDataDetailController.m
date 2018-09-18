//
//  PXYMonitorDataDetailController.m
//  FPSDemo
//
//  Created by Pengxuyuan on 2017/7/14.
//  Copyright © 2017年 Pengxuyuan. All rights reserved.
//

#import "PXYMonitorDataDetailController.h"
#import <WebKit/WKWebView.h>

@interface PXYMonitorDataDetailController ()<WKNavigationDelegate>

//@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, copy) NSString *catonInformationStr;

@end

@implementation PXYMonitorDataDetailController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildUI];
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - Public methods
- (void)setMonitorDataWithCatonInformation:(NSString *)catonInformation {
    _catonInformationStr = catonInformation;
    
//    UIFont *font = [UIFont systemFontOfSize:14];
//    NSString* htmlString = [NSString stringWithFormat:@"<span style=\"font-family: %@!important; font-size: %i; color: %@\">%@</span>",
//                            font.fontName,
//                            (int) font.pointSize,
//                            @"#555555",
//                            @"AAAA"];
//    [self.webView loadHTMLString:htmlString baseURL:nil];
}

#pragma mark - Private methods
- (void)buildUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
}

- (void)loadData {
    UIFont *font = [UIFont systemFontOfSize:15];
    NSString* htmlString = [NSString stringWithFormat:@"<span style=\"font-family: %@!important; font-size: %i; color: %@\">%@</span>",
                            font.fontName,
                            (int) font.pointSize,
                            @"#555555",
                            self.catonInformationStr];
    [self.webView loadHTMLString:htmlString baseURL:nil];
}

#pragma mark - ListNotificationInter

#pragma mark - Request

#pragma mark - Setter & getter

#pragma mark - Lazzy load
//- (WKWebView *)webView {
//    if (_webView == nil) {
//        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
//        _webView.navigationDelegate = self;
//        
//    }
//    return _webView;
//}

- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//        _webView.scalesPageToFit = YES;
    }
    return _webView;
}

@end
