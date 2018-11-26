//
//  PXYFPSHelper.h
//  FPSDemo
//
//  Created by Pengxuyuan on 2017/6/27.
//  Copyright © 2017年 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FPSValueBlock)(float fps);

/**
 FPS 帮助类
 FPS Helper
 */
@interface PXYFPSHelper : NSObject

/**
 单例
 Singleton
 */
+ (instancetype)shareInstance;

/**
 获取FPS
 get the FPS Value
 */
- (void)getFPSValueWithBlock:(FPSValueBlock)block;

/**
 开始监测FPS
 start FPS Monitoring, Do not need to manually open, is turned on by default
 */
- (void)startFPSMonitoring;

/**
 停止、取消监测FPS
 stop & cancel FPS Monitoring
 */
- (void)endFPSMonitoring;


@end
