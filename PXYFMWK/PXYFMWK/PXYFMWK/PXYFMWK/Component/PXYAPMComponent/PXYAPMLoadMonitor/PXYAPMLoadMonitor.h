//
//  PXYAPMLoadMonitor.h
//  PXYFMWK
//
//  Created by Pengxuyuan on 2018/9/3.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 启动 Load 函数监测
 */
@interface PXYAPMLoadMonitor : NSObject

/**
 打印 Load 函数消耗的时间
 */
+ (void)pxy_printLoadTimeConsuming;

@end
