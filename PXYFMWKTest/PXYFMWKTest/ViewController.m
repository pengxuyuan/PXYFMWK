//
//  ViewController.m
//  ImageCorner
//
//  Created by Pengxuyuan on 2018/8/2.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+ImageCorner.h"
#import <PXYFMWKDYLIB/PXYFMWKDYLIB.h>
#import "AImageView.h"
#import "TestViewController.h"

#import <objc/runtime.h>
#import <objc/message.h>
#import <libkern/OSAtomic.h>
#import <pthread.h>

#import "UIImageView+CornerRadius.h"

#import "Person.h"
#import "Son.h"

#import "RSSwizzle.h"
#import "TestView.h"

@interface ViewController ()

@property (nonatomic, strong) AImageView *imageView;

@property (nonatomic, strong) Person *person;
@property (nonatomic, strong) Son *son;

@property (nonatomic, strong) TestView *testView;
@property (nonatomic, strong) CALayer *layer1;


@end


@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController.navigationBar setHidden:YES];
//    self.navigationController.navigationBar.translucent = NO;
//    _imageView = [[AImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
//    _imageView.backgroundColor = [UIColor redColor];
//    _imageView.center = self.view.center;
//    [self.view addSubview:_imageView];
//    _imageView.image = [UIImage imageNamed:@"icon.jpeg"];
    
    //    1.layer 直接设置圆角
//     _imageView.layer.cornerRadius = 100;
//     _imageView.layer.masksToBounds = YES;

    //    2.画布的方式增加圆角
//     [_imageView settingCornerWithCornerRadius:100];
//    _imageView.image = [UIImage imageNamed:@"222.png"];


    //    3.第三方库设置圆角
//     [_imageView zy_cornerRadiusRoundingRect];


//     //测试性能
//     for (int i = 0; i < 1000; i++) {
//         [self func1WithOrigialImage:[UIImage imageNamed:@"icon.jpeg"]];
////         [_imageView settingCornerWithCornerRadius:100];
////         [_imageView zy_cornerRadiusRoundingRect];
////         [_imageView zy_cornerRadiusWithImage:_imageView.image cornerRadius:100 rectCornerType:UIRectEdgeAll];
//     }
    
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
    btn1.center = self.view.center;
    [btn1 setTitle:@"UIView&CALayer" forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor redColor]];
    [btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    [btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    [btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(btn1.frame.origin.x, CGRectGetMaxY(btn1.frame) + 30, 200, 80)];
    [btn2 setTitle:@"Graver" forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor redColor]];
    [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    

    
}

- (void)btn1Click {
    NSLog(@"%s",__func__);
    return;
    
    TestViewController *testVC = [TestViewController new];
    testVC.type = TestViewType1;
    [self.navigationController pushViewController:testVC animated:YES];
}

- (void)btn2Click {
    TestViewController *testVC = [TestViewController new];
    testVC.type = TestViewType2;
    [self.navigationController pushViewController:testVC animated:YES];
}


/*
 性能方案测试： CPU 内存 线程 耗时
 1、第三方框架 zy_cornerRadiusWithImage：CPU持续上涨、内存持续上涨，卡住主线程
 2、settingCornerWithCornerRadius:CPU 持续上涨、内存稳定、不卡主线程
 
 
 3、UIKit：UIGraphicsBeginImageContextWithOptions：CPU 持续上涨、内存持续上涨，卡主主线程
 4、CoreGraphics
 
 
 
 */

//测试圆角图片的性能
/*
 绘图几种方式：
 1.UIKit：UIGraphicsBeginImageContextWithOptions
 2.CoreGraphics：CGBitmapContextCreate & CGContextDrawImage
 3.ImageIO：CGImageSourceCreateThumbnailAtIndex
 4.CoreImage：CIContext
 */

//UIKit：UIGraphicsBeginImageContextWithOptions
- (UIImage *)func1WithOrigialImage:(UIImage *)originalImage {
    UIImage *cornerImage = originalImage;
    CGSize canvasSize = originalImage.size;
    CGFloat cornerRadius = canvasSize.width/2;
    
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
    
    return cornerImage;
}

//2.CoreGraphics：CGBitmapContextCreate & CGContextDrawImage
- (void)func2WithOrigialImage:(UIImage *)originalImage {
    
    
    
    
}

@end
