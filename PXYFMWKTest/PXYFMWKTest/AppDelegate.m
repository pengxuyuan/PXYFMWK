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

@interface AppDelegate ()

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
}

@end
