//
//  PXYDeviceMemoryHelper.h
//  FPSDemo
//
//  Created by Pengxuyuan on 2017/6/30.
//  Copyright © 2017年 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 设备内存帮助类
 Device memory helper classs
 */
@interface PXYDeviceMemoryHelper : NSObject

/**
 获取已使用内存
 */
+ (long)fetchUsedMemory;

/**
 获取可用内存
 */
+ (long)fetchFreeMemory;

/**
 打印内存信息
 */
+ (void)fetchLogMemUsage;


@end
