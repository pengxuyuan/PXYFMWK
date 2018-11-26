
//
//  PXYFPSHelper.m
//  FPSDemo
//
//  Created by Pengxuyuan on 2017/6/27.
//  Copyright © 2017年 Pengxuyuan. All rights reserved.
//

#import "PXYFPSHelper.h"
#import <QuartzCore/QuartzCore.h>
#import "PXYWeakProxy.h"

@interface PXYFPSHelper ()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, assign) NSTimeInterval lastTime;
@property (nonatomic, assign) float *fpsValuePoint;

@property (nonatomic, copy) FPSValueBlock currentBlock;

@end

@implementation PXYFPSHelper

#pragma mark - Private Methods
/**
 单例
 Singleton
 */
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static PXYFPSHelper *instance;
    dispatch_once(&onceToken, ^{
        instance = [PXYFPSHelper new];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self displayLink];
    }
    return self;
}

#pragma mark - Public Methods
/**
 获取FPS
 get the FPS Value
 */
- (void)getFPSValueWithBlock:(FPSValueBlock)block {
    _currentBlock = block;
}

/**
 开始监测FPS
 start FPS Monitoring, Do not need to manually open, is turned on by default
 */
- (void)startFPSMonitoring {
    [self displayLink];
}

/**
 停止、取消监测FPS
 stop & cancel FPS Monitoring
 */
- (void)endFPSMonitoring {
    [self.displayLink invalidate];
    self.displayLink = nil;
}


#pragma mark - Private Methods
- (void)displayLickMethod:(CADisplayLink *)link {
    
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;

    _currentBlock(fps);
}


#pragma mark - Lazzy load
- (CADisplayLink *)displayLink {
    if (_displayLink == nil) {
        _displayLink = [CADisplayLink displayLinkWithTarget:[PXYWeakProxy objectWithTarget:self] selector:@selector(displayLickMethod:)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _displayLink;
}

@end
