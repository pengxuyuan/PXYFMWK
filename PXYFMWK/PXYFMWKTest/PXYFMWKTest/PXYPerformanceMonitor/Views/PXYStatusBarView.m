//
//  PXYStatusBarView.m
//  FPSDemo
//
//  Created by Pengxuyuan on 2017/6/27.
//  Copyright © 2017年 Pengxuyuan. All rights reserved.
//

#import "PXYStatusBarView.h"
#import "PXYFPSLabel.h"
#import "PXYFPSHelper.h"

//默认的动画时间
static const CGFloat kDefaultAnimDuration = 0.5;

@interface PXYStatusBarView ()

@property (nonatomic, strong) PXYFPSLabel *fpsLabel;

@end

@implementation PXYStatusBarView

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
    }
    return self;
}

#pragma mark - Public Methods
/**
 在状态栏上展示View
 show self with animation
 */
- (void)showStatusBarViewWithAnimation:(BOOL)isAnimation {
    if (self.alpha == 1) {
        return;
    }
    
    if (isAnimation) {
        [UIView animateWithDuration:kDefaultAnimDuration animations:^{
            self.transform = CGAffineTransformMakeTranslation(0, self.frame.size.height);
            self.alpha = 1.0;
        } completion:^(BOOL finished) {
            [[PXYFPSHelper shareInstance] startFPSMonitoring];
        }];
    }else{
        self.transform = CGAffineTransformMakeTranslation(0, self.frame.size.height);
        [[PXYFPSHelper shareInstance] startFPSMonitoring];
    }
}

/**
 在状态栏上面隐藏View
 hide self with animation
 */
- (void)hideStatusBarViewWithAnimation:(BOOL)isAnimation {
    if (isAnimation) {
        [UIView animateWithDuration:kDefaultAnimDuration animations:^{
            self.transform = CGAffineTransformIdentity;
            self.alpha = 0;
        } completion:^(BOOL finished) {
//            [self removeFromSuperview];
            [[PXYFPSHelper shareInstance] endFPSMonitoring];
            
        }];
    }else{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 0;
        [[PXYFPSHelper shareInstance] endFPSMonitoring];
//        [self removeFromSuperview];
    }
}

#pragma mark - Private Methods
- (void)buildUI {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.backgroundColor = [UIColor colorWithRed:1/255.0 green:112/255.0 blue:200/255.0 alpha:1];
    self.alpha = 0.0;
    
    [self addSubview:self.fpsLabel];
    
    UILongPressGestureRecognizer *loog = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGuesture:)];
    [self addGestureRecognizer:loog];
    
}

- (void)longPressGuesture:(UIGestureRecognizer *)recongnizer {
    if ([_delegate respondsToSelector:@selector(statusBarView:longPressGuesture:)]) {
        [_delegate statusBarView:self longPressGuesture:recongnizer];
    }
}

#pragma mark - Setter & Getter
- (void)setBgColor:(UIColor *)bgColor {
    self.backgroundColor = bgColor;
}

#pragma mark - Lazzy load
- (PXYFPSLabel *)fpsLabel {
    if (_fpsLabel == nil) {
        _fpsLabel = [[PXYFPSLabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width, 20)];
    }
    return _fpsLabel;
}

@end
