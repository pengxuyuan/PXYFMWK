//
//  UIView+PXYChainProgramming.h
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2018/9/20.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIViewBlock)(UIView *view);
typedef UIView *(^SetFrameBlock)(CGFloat x, CGFloat y, CGFloat w, CGFloat h);
typedef UIView *(^SetBackgroundColorBlock)(UIColor *color);

/**
 为 UIView 增加链式编程的语法
 */
@interface UIView (PXYChainProgramming)

/**
 快捷创建 UIView
 */
+ (UIView *)makeView:(void (^)(UIView *view))makeView;

/**
 设置 Frame
 */
@property (nonatomic, copy) UIView * (^setFrame)(CGFloat x, CGFloat y, CGFloat w, CGFloat h);

/**
 设置 Background Color
 */
//@property (nonatomic, copy) UIView * (^setBackgroundColor) (UIColor *color);
@property (nonatomic, copy) SetBackgroundColorBlock setBackgroundColor;


@end
