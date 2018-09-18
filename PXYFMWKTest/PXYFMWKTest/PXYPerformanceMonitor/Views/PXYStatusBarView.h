//
//  PXYStatusBarView.h
//  FPSDemo
//
//  Created by Pengxuyuan on 2017/6/27.
//  Copyright © 2017年 Pengxuyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PXYStatusBarView;

/**
 状态栏相关的delegate
 */
@protocol StatusBarViewDelegate  <NSObject>
@optional

- (void)statusBarView:(PXYStatusBarView *)statusBarView longPressGuesture:(UIGestureRecognizer *)recongnizer;

@end


/**
 状态栏的View
 the view show on status bar
 */
@interface PXYStatusBarView : UIView

/**
 状态栏背景颜色
 status bar view background color
 */
@property (nonatomic, strong) UIColor *bgColor;

/**
 状态栏相关的delegate
 */
@property (nonatomic, weak) id<StatusBarViewDelegate> delegate;

/**
 在状态栏上展示View
 show self with animation
 */
- (void)showStatusBarViewWithAnimation:(BOOL)isAnimation;

/**
 在状态栏上面隐藏View
 hide self with animation
 */
- (void)hideStatusBarViewWithAnimation:(BOOL)isAnimation;


@end
