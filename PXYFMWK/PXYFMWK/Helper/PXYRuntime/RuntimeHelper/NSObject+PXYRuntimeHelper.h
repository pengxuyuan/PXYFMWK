//
//  NSObject+PXYRuntimeHelper.h
//  ImageCorner
//
//  Created by Pengxuyuan on 2018/8/9.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>

/**
 利用 Runtime 打印
 */
@interface NSObject (PXYRuntimeHelper)

/**
 交换方法，替换本类中的实例方法
 可以在本类的分类中调用
 */
+ (void)pxy_swizzleMethodWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

/**
 交换方法，将 originalClass 中的 originalSelector 替换成 swizzledClass 类中的 swizzledSelector 方法
 isInstanceMethod 选择判断时候是实例方法
 */
+ (void)pxy_swizzleMethodWithOriginalClass:(Class)originalClass originalSelector:(SEL)originalSelector swizzledClass:(Class)swizzledClass swizzledSelector:(SEL)swizzledSelector isInstanceMethod:(BOOL)isInstanceMethod;

/**
 获取类中的所有属性
 */
- (void)pxy_printPropertyList;

/**
 获取类中的所有成员变量
 */
- (void)pxy_printIvaList;

/**
 获取类中的所有方法
 */
- (void)pxy_printMethodList;

/**
 获取协议列表
 */
- (void)pxy_printProtocolList;

@end
