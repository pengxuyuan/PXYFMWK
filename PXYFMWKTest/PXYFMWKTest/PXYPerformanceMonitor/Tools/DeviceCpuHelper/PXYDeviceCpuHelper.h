//
//  PXYDeviceCpuHelper.h
//  FPSDemo
//
//  Created by Pengxuyuan on 2017/6/29.
//  Copyright © 2017年 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 获取设备CPU 帮助类
 Device CPU Helper Class
 */
@interface PXYDeviceCpuHelper : NSObject

/**
 获取CPU 使用率
 get cpu usage
 */
+ (float)fetchCpuUsage;

/**
 获取所有线程，将 cpu_usafge 累加，可以得到当前 App 所在进程的的 CPU 使用率
 戴銘老师的 Demo
 @return float
 */
+ (float)fetchCPUsage;

@end
