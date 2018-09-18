//
//  PXYDataMonitorManager.h
//  FPSDemo
//
//  Created by Pengxuyuan on 2017/7/6.
//  Copyright © 2017年 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXYMainThreadMonitorHelper.h"

/**
 监测数据管理类
 Handle Monitor Data,Save Cache & Disk
 */
@interface PXYDataMonitorManager : NSObject

/**
 单例
 Singleton
 */
+ (instancetype)shareInstance;

@property (nonatomic, weak) id<MainThreadMonitorDelegate> realDelegate;

@end
