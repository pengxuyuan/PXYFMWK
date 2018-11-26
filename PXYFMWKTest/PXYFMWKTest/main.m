//
//  main.m
//  ImageCorner
//
//  Created by Pengxuyuan on 2018/8/2.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <PXYFMWKDYLIB/PXYFMWKDYLIB.h>

int main(int argc, char * argv[]) {
    [[PXYStartupTimeMonitor shareInstance] appStartRecordingTime];
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
