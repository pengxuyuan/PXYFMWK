//
//  UIView+PXYChainProgramming.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2018/9/20.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import "UIView+PXYChainProgramming.h"

@implementation UIView (PXYChainProgramming)

/**
 快捷创建 UIView
 */
+ (UIView *)makeView:(void (^)(UIView *view))makeView {
    UIView *view = [UIView new];
    if (makeView) {
        makeView(view);
    }
    return view;
}

#pragma mark - 设置 Frame
- (UIView *(^)(CGFloat, CGFloat, CGFloat, CGFloat))setFrame {
    UIView *(^block)(CGFloat, CGFloat, CGFloat, CGFloat) = ^(CGFloat x, CGFloat y, CGFloat w, CGFloat h) {
        self.frame = CGRectMake(x, y, w, h);
        return self;
    };
    
    return block;
}

- (void)setSetFrame:(UIView *(^)(CGFloat, CGFloat, CGFloat, CGFloat))setFrame {
    
}

#pragma mark - 设置 Background Color
//- (UIView *(^)(UIColor *))setBackgroundColor {
//    UIView *(^block)(UIColor *) = ^(UIColor *color) {
//        self.backgroundColor = color;
//        return self;
//    };
//    return block;
//}

- (SetBackgroundColorBlock)setBackgroundColor {
    SetBackgroundColorBlock block = ^(UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
    return block;
}

- (void)setSetBackgroundColor:(UIView *(^)(UIColor *))setBackgroundColor {
    
}



@end
