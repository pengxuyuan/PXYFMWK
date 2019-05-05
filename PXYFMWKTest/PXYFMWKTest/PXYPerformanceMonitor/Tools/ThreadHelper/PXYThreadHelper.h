//
//  PXYThreadHelper.h
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/4/22.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 线程工具类
 */
@interface PXYThreadHelper : NSObject

/**
 轮询检查多个线程 CPU 使用情况
 */
+ (void)checkThreadCPU;


@end

NS_ASSUME_NONNULL_END
