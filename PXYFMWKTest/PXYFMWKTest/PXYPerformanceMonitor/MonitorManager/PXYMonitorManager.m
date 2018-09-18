//
//  PXYMonitorManager.m
//  FPSDemo
//
//  Created by Pengxuyuan on 2017/6/27.
//  Copyright © 2017年 Pengxuyuan. All rights reserved.
//

#import "PXYMonitorManager.h"
#import "PXYStatusBarView.h"
#import "PXYMainThreadMonitorHelper.h"
#import "PXYFPSHelper.h"
#import "PXYMonitorDataListController.h"

@interface PXYMonitorManager ()<StatusBarViewDelegate>

@property (nonatomic, strong) PXYStatusBarView *statusBarView;
@property (nonatomic, assign, getter=isMonitoring) BOOL monitoring;

@end

@implementation PXYMonitorManager
#pragma mark - Life Cycle
/**
 单例
 Singleton
 */
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static PXYMonitorManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [PXYMonitorManager new];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _monitoring = NO;
    }
    return self;
}


#pragma mark - Public Methods
/**
 开始监测
 start Monitor
 */
- (void)startMonitoring {
    if(_monitoring == YES) return;
    
    
    [[PXYMainThreadMonitorHelper shareInstance] starMonitoringMainThread];
    
    _monitoring = YES;
}

/**
 停止、取消监测
 stop Monitor
 */
- (void)endMonitoring {
    if (_monitoring != YES) return;
    
    [[PXYMainThreadMonitorHelper shareInstance] endMonitoringMainThread];
    _monitoring = NO;
}

/**
 展示状态栏监测
 show the monitor ssview on Status Bar
 */
- (void)showStatusBarMonitorView {
#if defined(DEBUG) || defined(_DEBUG)
    [self.statusBarView showStatusBarViewWithAnimation:YES];
#endif
}

/**
 隐藏状态栏监测
 hide the monitor view on Status Bar
 */
- (void)hideStatusBarMonitorView {
    [self.statusBarView hideStatusBarViewWithAnimation:YES];
}

#pragma mark - Private Methods

#pragma mark - StatusBarViewDelegate
- (void)statusBarView:(PXYStatusBarView *)statusBarView longPressGuesture:(UIGestureRecognizer *)recongnizer {
    PXYMonitorDataListController *dataListVC = [PXYMonitorDataListController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dataListVC];
//    [nav.navigationBar setBackgroundColor:[UIColor colorWithRed:1/255.0 green:112/255.0 blue:200/255.0 alpha:1]];
//    [nav.navigationBar setBarTintColor:[UIColor colorWithRed:1/255.0 green:112/255.0 blue:200/255.0 alpha:1]];
    
    UIViewController *currentVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([currentVC presentedViewController]) {
        [dataListVC dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [currentVC presentViewController:nav animated:YES completion:nil];
}

#pragma mark - Lazzy load
- (PXYStatusBarView *)statusBarView {
    if (_statusBarView == nil) {
        UIView *statusBar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
        CGFloat statusBarW = statusBar.frame.size.width;
        CGFloat statusBarH = statusBar.frame.size.height;
        
        _statusBarView = [[PXYStatusBarView alloc] initWithFrame:CGRectMake(0, -statusBarH, statusBarW, statusBarH)];
        _statusBarView.delegate = self;
        [statusBar addSubview:self.statusBarView];
    }
    return _statusBarView;
}




@end
