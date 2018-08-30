//
//  NSObject+PXYKVO.h
//  ImageCorner
//
//  Created by Pengxuyuan on 2018/8/7.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PXYKVOCompleteBlock)(id observer, NSString *keyPath, id oldValue, id newValue);

@interface NSObject (PXYKVO)

/**
 添加 KVO Block
 */
- (void)pxy_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath completeBlock:(PXYKVOCompleteBlock)completeBlock;

/**
 移除 KVO Block
 */
- (void)pxy_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

@end
