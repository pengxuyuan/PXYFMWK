//
//  PXYMainThreadMonitorHelper.h
//  FPSDemo
//
//  Created by Pengxuyuan on 2017/6/28.
//  Copyright © 2017年 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PXYMainThreadMonitorHelper;
@protocol MainThreadMonitorDelegate <NSObject>

@optional
- (void)mainThreadMonitor:(PXYMainThreadMonitorHelper *)mainThreadMonitorHelper catonInformation:(NSString *)catonInformation;

@end


struct MainThreadMonitorDelegateFlag{
    unsigned int catonInformation : 1;
};

/**
 主线程监测帮助类
 monitor main thread
 */
@interface PXYMainThreadMonitorHelper : NSObject

/**
 单例
 Singleton
 */
+ (instancetype)shareInstance;

@property (nonatomic, weak) id<MainThreadMonitorDelegate> delegate;

/**
 开始监测主线程
 star monitor mian thread
 */
- (void)starMonitoringMainThread;

/**
 取消监测主线程
 cancel monitor main thread
 */
- (void)endMonitoringMainThread;


@end
