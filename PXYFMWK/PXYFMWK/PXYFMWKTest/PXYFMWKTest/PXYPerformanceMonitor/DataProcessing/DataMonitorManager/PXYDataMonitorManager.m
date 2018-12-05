//
//  PXYDataMonitorManager.m
//  FPSDemo
//
//  Created by Pengxuyuan on 2017/7/6.
//  Copyright © 2017年 Pengxuyuan. All rights reserved.
//

#import "PXYDataMonitorManager.h"
#import "PXYMonitorDataCacheHelper.h"

@interface PXYDataMonitorManager ()

@property (nonatomic, assign) struct MainThreadMonitorDelegateFlag mainThreadMonitorDelegateFlag;

@end

@implementation PXYDataMonitorManager
#pragma mark - Life Cycle
/**
 Singleton
 */
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static PXYDataMonitorManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [PXYDataMonitorManager new];
    });
    return instance;
}


#pragma mark - MainThreadMonitorDelegate
- (void)mainThreadMonitor:(PXYMainThreadMonitorHelper *)mainThreadMonitorHelper catonInformation:(NSString *)catonInformation {
    NSLog(@"PLCrashReporter 开始===========================");
    NSLog(@"------------\n%@\n------------", catonInformation);
    NSLog(@"PLCrashReporter 结束===========================");
    
    [[PXYMonitorDataCacheHelper shareInstance] saveObject:catonInformation];
    
    if (_mainThreadMonitorDelegateFlag.catonInformation) {
        [_realDelegate mainThreadMonitor:mainThreadMonitorHelper catonInformation:catonInformation];
    }
}

#pragma mark - Setter & Getter 
- (void)setRealDelegate:(id<MainThreadMonitorDelegate>)realDelegate {
    _realDelegate = realDelegate;
    
    if ([_realDelegate respondsToSelector:@selector(mainThreadMonitor:catonInformation:)]) {
        _mainThreadMonitorDelegateFlag.catonInformation = 1;
    }
}



@end
