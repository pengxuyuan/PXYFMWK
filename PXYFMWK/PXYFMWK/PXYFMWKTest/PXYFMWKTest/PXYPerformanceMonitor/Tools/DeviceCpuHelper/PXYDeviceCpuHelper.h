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


@end
