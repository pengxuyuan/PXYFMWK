//
//  DAppDelegate.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/2/12.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import "DAppDelegate.h"
#import <UIKit/UIKit.h>

#import <PXYFMWKDYLIB/PXYFMWKDYLIB.h>


@implementation DAppDelegate

//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    NSLog(@"%s",__func__);
//    return YES;
//}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"%s",__func__);
    
//    sleep(2);
    
    [[PXYStartupTimeMonitor shareInstance] appMarkTimeWithDescription:@"applicationDidBecomeActive DAppDelegate"];
}


@end
