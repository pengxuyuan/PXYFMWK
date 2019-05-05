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
 获取 App 占用的物理内存 phys_footprint

 @return phys_footprint
 */
+ (uint64_t)fetchAppPhysicalMmory;

/**
 获取 App 占用的驻留内存 虚拟内存

 @return resident_size
 */
+ (uint64_t)fetchAppVirtualMemory;

/**
 Log 内存相关信息
 */
+ (void)printMemoryInfo;



@end
