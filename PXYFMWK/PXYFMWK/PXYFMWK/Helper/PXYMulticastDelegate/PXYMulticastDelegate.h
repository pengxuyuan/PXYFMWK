//
//  PXYMulticaseDelegate.h
//  PXYMulticaseDelegate
//
//  Created by Pengxuyuan on 2017/7/18.
//  Copyright © 2017年 Pengxuyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Multicast Delegate 多播委托
 */
@interface PXYMulticastDelegate : NSProxy

/**
 初始化
 */
- (instancetype)init;

/**
 增加一个观察者
 */
- (void)addDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;

/**
 增加一个观察者
 */
- (void)removeDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;

/**
 移除一个观察者
 */
- (void)removeDelegate:(id)delegate;

/**
 移除所有的观察者
 */
- (void)removeAllDelegate;

@end

