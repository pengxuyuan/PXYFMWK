//
//  PXYMonitorDataCacheHelper.h
//  FPSDemo
//
//  Created by Pengxuyuan on 2017/7/6.
//  Copyright © 2017年 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 缓存监测数据类
 Monitor Data Cache
 */
@interface PXYMonitorDataCacheHelper : NSObject

/**
 Singleton
 */
+ (instancetype)shareInstance;

- (void)saveObject:(id)object;

- (void)setObject:(id)object forKey:(id)key;

- (void)removeObjectForKey:(id)key;

- (void)removeAllObjects;

- (id)fetchData;

- (id)fetchDataWithKey:(id)key;

@end
