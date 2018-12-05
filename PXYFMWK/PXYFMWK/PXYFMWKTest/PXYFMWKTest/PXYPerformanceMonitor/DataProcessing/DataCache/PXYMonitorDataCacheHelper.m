//
//  PXYMonitorDataCacheHelper.m
//  FPSDemo
//
//  Created by Pengxuyuan on 2017/7/6.
//  Copyright © 2017年 Pengxuyuan. All rights reserved.
//

#import "PXYMonitorDataCacheHelper.h"
#import "YYCache.h"

static NSString *const kThreadMonitorCacheKey = @"kThreadMonitorCacheKey";

@interface PXYMonitorDataCacheHelper ()

@property (nonatomic, strong) YYMemoryCache *cache;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PXYMonitorDataCacheHelper
#pragma mark - Life Cycle
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static PXYMonitorDataCacheHelper *instance;
    dispatch_once(&onceToken, ^{
        instance = [PXYMonitorDataCacheHelper new];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Public Methods
- (void)saveObject:(id)object {
    [_dataArray addObject:object];
    
    [self setObject:_dataArray forKey:kThreadMonitorCacheKey];
    
//    [_dataArray removeAllObjects];
}

- (void)setObject:(id)object forKey:(id)key {
    [self.cache setObject:object forKey:key];
}

- (void)removeObjectForKey:(id)key {
    [self.cache removeObjectForKey:key];
}

- (void)removeAllObjects {
    [self.cache removeAllObjects];
}

- (id)fetchData {
    return [self fetchDataWithKey:kThreadMonitorCacheKey];
}

- (id)fetchDataWithKey:(id)key {
    return [self.cache objectForKey:key];
}


#pragma mark - Lazzy load
- (YYMemoryCache *)cache {
    if (_cache == nil) {
        _cache = [YYMemoryCache new];
        _cache.releaseOnMainThread = YES;
    }
    return _cache;
}


@end
