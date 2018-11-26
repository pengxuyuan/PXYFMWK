//
//  PXYMonitorManager.h
//  FPSDemo
//
//  Created by Pengxuyuan on 2017/6/27.
//  Copyright © 2017年 Pengxuyuan. All rights reserved.
//  

#import <Foundation/Foundation.h>

/**
 性能监测管理类
 Performance Monitoring Manager Class
 */
@interface PXYMonitorManager : NSObject

/**
 单例
 Singleton
 */
+ (instancetype)shareInstance;

/**
 开始监测
 start Monitoring
 */
- (void)startMonitoring;

/**
 停止、取消监测
 stop & cancel Monitoring
 */
- (void)endMonitoring;

/**
 展示状态栏监测
 show the monitor view on Status Bar
 */
- (void)showStatusBarMonitorView;

/**
 隐藏状态栏监测
 hide the monitor view on Status Bar
 */
- (void)hideStatusBarMonitorView;


@end
