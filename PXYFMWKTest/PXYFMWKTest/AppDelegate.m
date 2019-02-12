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


@interface AppDelegate ()

@property (nonatomic, strong) PXYMulticastDelegate<UIApplicationDelegate> *multicastDelegateManager;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [[PXYStartupTimeMonitor shareInstance] appMarkTimeWithDescription:@"didFinishLaunchingWithOptions Start"];
//    
////    PXY_TICK
////    [[PXYMonitorManager shareInstance] startMonitoring];
//    [[PXYMonitorManager shareInstance] showStatusBarMonitorView];
////    PXY_TOCK
//    [[PXYStartupTimeMonitor shareInstance] appMarkTimeWithDescription:@"didFinishLaunchingWithOptions End"];
    
//    [JSPatch startWithAppKey:@"8a7373ceea8edada"];
//    [JSPatch setupRSAPublicKey:@"-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCufJD163unTsEKzMGkCIoN5mop\ngGv8XXxRmXcMUxlPwH4ay9MSeJNsRjpQKv7/npjrEAAflMLiEbECsaIzn5R9Vsyb\n0ZgdQSki1oUojrR7mMU7h/Bs+tR4qSARksG87LvJv59v3eSpN3C6gxByGdSDRo02\n0VhGz3Mc4eHS2xkmywIDAQAB\n-----END PUBLIC KEY-----"];
//    [JSPatch sync];
    
    
    //AppDelegate 拆分
    [self buildAAppDelegate];
    [self buildBAppDelegate];
    
    CAppDelegate *c = [CAppDelegate new];
    DAppDelegate *d = [DAppDelegate new];
    
    [self.multicastDelegateManager addDelegate:c delegateQueue:nil];
    [self.multicastDelegateManager addDelegate:d delegateQueue:nil];
    
    [self.multicastDelegateManager application:application didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
//    [[PXYStartupTimeMonitor shareInstance] appEndRecordingTimeAndShowAlert];
//
//    [[PXYStartupTimeMonitor shareInstance] appMarkTimeWithDescription:@"applicationDidBecomeActive start"];
//
////    PXY_TICK
////    sleep(1);
////    PXY_TOCK
//
//    [[PXYStartupTimeMonitor shareInstance] appMarkTimeWithDescription:@"applicationDidBecomeActive End"];
    
//    [self.timer invalidate];
    
    [self.multicastDelegateManager applicationDidBecomeActive:application];
}

#pragma mark - Lazzy load
- (PXYMulticastDelegate *)multicastDelegateManager {
    if (_multicastDelegateManager == nil) {
        _multicastDelegateManager = [[PXYMulticastDelegate alloc] init];
    }
    return _multicastDelegateManager;
}







@end
