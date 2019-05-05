//
//  PXYDeviceBatteryHelper.h
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/4/22.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 电池相关帮助类
 */
@interface PXYDeviceBatteryHelper : NSObject

/**
 获取当前电量的信息:百分比 80%

 @return 80.0
 */
+ (double)fetchBatteryLevel;

@end

NS_ASSUME_NONNULL_END
