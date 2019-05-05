//
//  AppDelegate.m
//  ImageCorner
//
//  Created by Pengxuyuan on 2018/8/2.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import "AppDelegate.h"
#import "PXYMonitorManager.h"
#import <PXYFMWKDYLIB/PXYFMWKDYLIB.h>
#import <JSPatchPlatform/JSPatch.h>

#import "AppDelegate+AAppDelegate.h"
#import "AppDelegate+BAppDelegate.h"
#import "CAppDelegate.h"
#import "DAppDelegate.h"

#import <objc/runtime.h>

#import "PXYDeviceMemoryHelper.h"

@interface AppDelegate ()

@property (nonatomic, strong) PXYMulticastDelegate<UIApplicationDelegate> *multicastDelegateManager;

@property (nonatomic, assign) __block UIBackgroundTaskIdentifier backgroundTaskIndentifier;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[PXYStartupTimeMonitor shareInstance] appMarkTimeWithDescription:@"didFinishLaunchingWithOptions Start"];

    //AppDelegate 拆分
    [self buildAAppDelegate];
    [self buildBAppDelegate];
    
    CAppDelegate *c = [CAppDelegate new];
    DAppDelegate *d = [DAppDelegate new];
    
    [self.multicastDelegateManager addDelegate:c delegateQueue:nil];
    [self.multicastDelegateManager addDelegate:d delegateQueue:nil];
    
    [self.multicastDelegateManager application:application didFinishLaunchingWithOptions:launchOptions];
    
    
    //APMLoadMonitor
    [PXYAPMLoadMonitor pxy_printLoadTimeConsuming];
    
    return YES;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
////
    [[PXYStartupTimeMonitor shareInstance] appMarkTimeWithDescription:@"applicationDidBecomeActive start"];
//
//    PXY_TICK
//    sleep(1);
//    PXY_TOCK
//
    
    [self.multicastDelegateManager applicationDidBecomeActive:application];
    
    [[PXYStartupTimeMonitor shareInstance] appMarkTimeWithDescription:@"applicationDidBecomeActive End"];
    
//    [[PXYStartupTimeMonitor shareInstance] appEndRecordingTimeAndShowAlert];
//    sleep(1);
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self.multicastDelegateManager applicationDidEnterBackground:application];
    
    __weak typeof(self)weakSelf = self;
    self.backgroundTaskIndentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [weakSelf endBackgroundWork];
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:25 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"%s",__func__);
        if ([UIApplication sharedApplication].backgroundTimeRemaining < 30) {
            //后台线程即将结束，打印当前线程堆栈
            NSLog(@"后台线程即将结束");
            
        }
    }];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    NSLog(@"%s",__func__);
    [PXYDeviceMemoryHelper printMemoryInfo];
}

- (void)endBackgroundWork {
    NSLog(@"%s",__func__);
    if (self.backgroundTaskIndentifier != UIBackgroundTaskInvalid) {
        [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTaskIndentifier];
        self.backgroundTaskIndentifier = UIBackgroundTaskInvalid;
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    [self.multicastDelegateManager applicationWillResignActive:application];
}

#pragma mark - Lazzy load
- (PXYMulticastDelegate *)multicastDelegateManager {
    if (_multicastDelegateManager == nil) {
        _multicastDelegateManager = (PXYMulticastDelegate <UIApplicationDelegate> *)[[PXYMulticastDelegate alloc] init];
    }
    return _multicastDelegateManager;
}







@end
