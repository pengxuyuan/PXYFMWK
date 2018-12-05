//
//  PXYMainThreadMonitorHelper.m
//  FPSDemo
//
//  Created by Pengxuyuan on 2017/6/28.
//  Copyright © 2017年 Pengxuyuan. All rights reserved.
//

#import "PXYMainThreadMonitorHelper.h"
//#import <CrashReporter/CrashReporter.h>
#import "PXYDeviceCpuHelper.h"
#import "PXYDataMonitorManager.h"
#import "BSBacktraceLogger.h"

@interface PXYMainThreadMonitorHelper ()

@property (nonatomic, assign) CFRunLoopObserverRef observer;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@property (nonatomic, assign) CFRunLoopActivity activity;
@property (nonatomic, assign) NSUInteger timeoutCount;

@property (nonatomic, assign) struct MainThreadMonitorDelegateFlag mainThreadMonitorDelegateFlag;


@end

@implementation PXYMainThreadMonitorHelper

#pragma mark - Life Cycle
/**
 单例
 Singleton
 */
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static PXYMainThreadMonitorHelper *instance;
    dispatch_once(&onceToken, ^{
        instance = [PXYMainThreadMonitorHelper new];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _timeoutCount = 0;
    }
    return self;
}

#pragma mark - Public Methods
/**
 开始监测主线程
 star monitor mian thread
 */
- (void)starMonitoringMainThread {
    if (_observer) return;
    
    self.delegate = (id<MainThreadMonitorDelegate>)[PXYDataMonitorManager shareInstance];
    [self addMainThreadObserver];
}

/**
 取消监测主线程
 cancel monitor main thread
 */
- (void)endMonitoringMainThread {
    if (_observer == nil) return;
    
    CFRunLoopRef runLoopRef = CFRunLoopGetMain();
    
    if (CFRunLoopContainsObserver(runLoopRef, _observer, kCFRunLoopCommonModes)){
        CFRunLoopRemoveObserver(runLoopRef, _observer, kCFRunLoopCommonModes);
        CFRelease(_observer);
        _observer = NULL;
    }
}

#pragma mark - Private Methods
- (void)addMainThreadObserver {
    CFRunLoopRef runLoopRef = CFRunLoopGetMain();
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)(self),
        &CFRetain,
        &CFRelease,
        NULL,
    };
    
    _observer= CFRunLoopObserverCreate(NULL,
                                      kCFRunLoopAllActivities,
                                      YES,
                                      NSIntegerMax - 999,
                                      &mainThreadObserverCallback,
                                      &context);
    CFRunLoopAddObserver(runLoopRef, _observer, kCFRunLoopCommonModes);

    //创建信号
    _semaphore = dispatch_semaphore_create(0);
    
    [self handleMainThreadTimeout];
    
}

static void mainThreadObserverCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    PXYMainThreadMonitorHelper *helper = (__bridge PXYMainThreadMonitorHelper  *)info;
    helper.activity = activity;
    
    //发送信号
    dispatch_semaphore_signal(helper.semaphore);
}

- (void)handleMainThreadTimeout {
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (YES) {
            // 假定连续5次超时50ms认为卡顿(当然也包含了单次超时250ms)
            long st = dispatch_semaphore_wait(weakSelf.semaphore, dispatch_time(DISPATCH_TIME_NOW, 50*NSEC_PER_MSEC));
            
            if (st != 0) {
                if (weakSelf.observer == nil) {
                    weakSelf.timeoutCount = 0;
                    weakSelf.semaphore = 0;
                    weakSelf.activity = 0;
                    return ;
                }
                
                if (weakSelf.activity == kCFRunLoopBeforeSources ||
                    weakSelf.activity == kCFRunLoopAfterWaiting) {
                    
                    if (++ weakSelf.timeoutCount < 5) continue;

//                    if ([PXYDeviceCpuHelper fetchCpuUsage] > 90) {
//                        PLCrashReporterConfig *config = [[PLCrashReporterConfig alloc] initWithSignalHandlerType:PLCrashReporterSignalHandlerTypeBSD
//                                                                                           symbolicationStrategy:PLCrashReporterSymbolicationStrategyNone];
//                        PLCrashReporter *crashReporter = [[PLCrashReporter alloc] initWithConfiguration:config];
//                        
//                        NSData *data = [crashReporter generateLiveReport];
//                        PLCrashReport *reporter = [[PLCrashReport alloc] initWithData:data error:NULL];
//                        NSString *report = [PLCrashReportTextFormatter stringValueForCrashReport:reporter
//                                                                                  withTextFormat:PLCrashReportTextFormatiOS];
                        
                        NSString *mainThreadStr =[BSBacktraceLogger bs_backtraceOfMainThread];
                        
                        if (weakSelf.mainThreadMonitorDelegateFlag.catonInformation) {
                            [weakSelf.delegate mainThreadMonitor:weakSelf catonInformation:mainThreadStr];
                        }
//                        NSLog(@"PLCrashReporter 开始===========================");
//                        NSLog(@"------------\n%@\n------------", report);
//                        NSLog(@"PLCrashReporter 结束===========================");
//                    }
                    

                }
            }
            weakSelf.timeoutCount = 0;
        }
    });
}

#pragma mark - Setter & Getter
- (void)setDelegate:(id<MainThreadMonitorDelegate>)delegate {
    PXYDataMonitorManager *manager = [PXYDataMonitorManager shareInstance];
    if (![delegate isMemberOfClass:[PXYDataMonitorManager class]]) {
        manager.realDelegate = delegate;
    }
    
    _delegate = (id<MainThreadMonitorDelegate>)manager;
    
    if ([manager respondsToSelector:@selector(mainThreadMonitor:catonInformation:)]) {
        _mainThreadMonitorDelegateFlag.catonInformation = 1;
    }
}


@end
