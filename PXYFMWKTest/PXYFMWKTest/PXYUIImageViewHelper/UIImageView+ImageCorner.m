//
//  UIImageView+ImageCorner.m
//  ImageCorner
//
//  Created by Pengxuyuan on 2018/8/2.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import "UIImageView+ImageCorner.h"
#import <objc/runtime.h>

//标示是否处理过的图片
static const char kProcessedImage;

typedef void(^CornerImageCompleteBlock)(UIImage *cornerImage);

@interface UIImageView ()

//是否添加了 image 的观察者
@property (nonatomic, assign) BOOL hadImageChangedOberver;

@end

@implementation UIImageView (ImageCorner)

- (void)settingCornerWithCornerRadius:(CGFloat)cornerRadius {
//    if (!self.hadImageChangedOberver) {
//        [self p_addObserver];
//    }
    
    
    [self p_settingCornerWithImage:self.image canvasSize:self.frame.size cornerRadius:cornerRadius completeBlock:^(UIImage *cornerImage) {
        objc_setAssociatedObject(cornerImage, &kProcessedImage, @(1), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.image = cornerImage;
    }];
}


#pragma mark - Private Methods
// 将图片转成成圆角图片
// 使用 @autoreleasepool 是为了降低内存的峰值
- (void)p_settingCornerWithImage:(UIImage *)image canvasSize:(CGSize)canvasSize cornerRadius:(CGFloat)cornerRadius completeBlock:(CornerImageCompleteBlock)completeBlock {
    
    __block UIImage *cornerImage = image;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {

            NSLog(@"%s thread:%@",__func__,[NSThread currentThread]);
            CGRect rect = CGRectMake(0, 0, canvasSize.width, canvasSize.height);

            UIGraphicsBeginImageContextWithOptions(canvasSize, NO, [UIScreen mainScreen].scale);
            CGContextRef contextRef = UIGraphicsGetCurrentContext();
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
            CGContextAddPath(contextRef,path.CGPath);
            CGContextClip(contextRef);
            [cornerImage drawInRect:rect];
            CGContextDrawPath(contextRef, kCGPathFillStroke);
            cornerImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completeBlock) {
                    completeBlock(cornerImage);
                }
            });
        }
    });
}

// 为 Image 增加 Obsercer
- (void)p_addObserver {
    [self addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
}


#pragma mark -
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"image"]) {
        UIImage *newImage = change[NSKeyValueChangeNewKey];
        if (newImage == nil) return;
        if ([objc_getAssociatedObject(newImage, &kProcessedImage) integerValue] == 1) {
            return;
        }

        [self settingCornerWithCornerRadius:100];
    }
}

#pragma mark - Getter & Setter
- (BOOL)hadImageChangedOberver {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setHadImageChangedOberver:(BOOL)hadImageChangedOberver {
    objc_setAssociatedObject(self, @selector(hadImageChangedOberver), @(hadImageChangedOberver), OBJC_ASSOCIATION_ASSIGN);
}


/*
 绘图几种方式：
 1.UIKit：UIGraphicsBeginImageContextWithOptions
 2.CoreGraphics：CGBitmapContextCreate & CGContextDrawImage
 3.ImageIO：CGImageSourceCreateThumbnailAtIndex
 4.CoreImage：CIContext
 */

@end
