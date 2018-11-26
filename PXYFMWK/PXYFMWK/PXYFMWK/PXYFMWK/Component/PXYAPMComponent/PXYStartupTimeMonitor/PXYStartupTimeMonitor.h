//
//  PXYStartupTimeMonitor.h
//  ImageCorner
//
//  Created by Pengxuyuan on 2018/8/27.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

/*
 1.NSDate
 2.CFAbsoluteTimeGetCurrent()
 3.gettimeofday
 4.mach_absolute_time()
 5.CACurrentMediaTime()
 6.sysctl
 */

#define PXY_TICK NSDate *startTime = [NSDate date];
#define PXY_TOCK NSLog(@"Time Cost: %.3f 秒", -[startTime timeIntervalSinceNow]);

#import <Foundation/Foundation.h>

@interface PXYStartupTimeMonitor : NSObject

/**
 单例
 */
+ (instancetype)shareInstance;

/**
 App 开始记录时间
 */
- (void)appStartRecordingTime;

/**
 App 打一个点

 @param description 当前点描述
 */
- (void)appMarkTimeWithDescription:(NSString *)description;

/**
 App 结束记录时间，并且 Alert 输出时间消耗
 */
- (void)appEndRecordingTimeAndShowAlert;

@end
