//
//  UIImageView+ImageCorner.m
//  ImageCorner
//
//  Created by Pengxuyuan on 2018/8/2.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import "UIImageView+ImageCorner.h"

@implementation UIImageView (ImageCorner)

- (void)settingCornerWithCornerRadius:(CGFloat)cornerRadius {
    UIImage *cornerImage = self.image;
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CGContextAddPath(contextRef,path.CGPath);
    CGContextClip(contextRef);
    [cornerImage drawInRect:rect];
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    cornerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = cornerImage;
}

@end
