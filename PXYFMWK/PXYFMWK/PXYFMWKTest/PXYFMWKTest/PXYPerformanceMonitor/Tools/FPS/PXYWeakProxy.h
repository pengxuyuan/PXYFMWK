//
//  PXYWeakProxy.h
//  FPSDemo
//
//  Created by Pengxuyuan on 2017/7/5.
//  Copyright © 2017年 Pengxuyuan. All rights reserved.
//

//learning from https://github.com/ibireme/YYKit
//http://www.tanhao.me/code/160702.html/

#import <Foundation/Foundation.h>

/**
 打破循环引用的，主要用于NSTimer、CADisplayLink
 跳板模式
 
 A object used to hold a weak object. Used Message forwarding mechanism to solve retain cycles
 such as the targer in NSTimer or CADisplayLink
 */
@interface PXYWeakProxy : NSProxy

@property (nonatomic, weak, readonly) id target;

+ (instancetype)objectWithTarget:(id)target;

@end
