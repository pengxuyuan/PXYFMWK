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

@interface ViewController ()

@property (nonatomic, strong) AImageView *imageView;

@property (nonatomic, strong) Person *person;
@property (nonatomic, strong) Son *son;

@end


@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    _imageView = [[AImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _imageView.backgroundColor = [UIColor redColor];
    _imageView.center = self.view.center;
    [self.view addSubview:_imageView];
    _imageView.image = [UIImage imageNamed:@"icon.jpeg"];
     
     
     
     //1.layer 直接设置圆角
//     _imageView.layer.cornerRadius = 100;
//     _imageView.layer.masksToBounds = YES;
    
     //2.画布的方式增加圆角
//     [_imageView settingCornerWithCornerRadius:100];
//    _imageView.image = [UIImage imageNamed:@"icon.jpeg"];
    
     
     //3.第三方库设置圆角
//     [_imageView zy_cornerRadiusRoundingRect];
    
     
     //测试性能
     for (int i = 0; i < 1000; i++) {
         [self func1WithOrigialImage:[UIImage imageNamed:@"icon.jpeg"]];
//         [_imageView settingCornerWithCornerRadius:100];
//         [_imageView zy_cornerRadiusRoundingRect];
//         [_imageView zy_cornerRadiusWithImage:_imageView.image cornerRadius:100 rectCornerType:UIRectEdgeAll];
     }
}

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



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.view.backgroundColor = [UIColor redColor];
    
//    TestViewController *textVC = [TestViewController new];
//    [self.navigationController pushViewController:textVC animated:YES];

    
    _imageView.image = [UIImage imageNamed:@"222.png"];

}








@end

//1.pthread
//    pthread_t pthread;
//    pthread_create(&pthread, NULL, run, NULL);

//2.NSThread
//    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(nsthread) object:nil];
//    [thread1 start];

//    [NSThread detachNewThreadSelector:<#(nonnull SEL)#> toTarget:<#(nonnull id)#> withObject:<#(nullable id)#>]
//    [NSObject performSelectorInBackground:<#(nonnull SEL)#> withObject:<#(nullable id)#>]

//3.GCD
//4.NSOperation & NSOperationQueue
//    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperation) object:nil];
//    [operation start];
//    NSBlockOperation
//void *run(void *data) {
//
//    for (int i = 0; i < 10; i++) {
//        NSLog(@"%@",[NSThread currentThread]);
//        NSLog(@"%d",i);
//        sleep(1);
//    }
//
//    return NULL;
//}

//- (void)nsthread {
//    for (int i = 0; i < 10; i++) {
//        NSLog(@"%@",[NSThread currentThread]);
//        NSLog(@"%d",i);
//        sleep(1);
//    }
//}

//- (void)invocationOperation {
//    for (int i = 0; i < 10; i++) {
//        NSLog(@"%@",[NSThread currentThread]);
//        NSLog(@"%d",i);
//        sleep(1);
//    }
//}

// 串行队列 + 同步任务
//- (void)serialSyn {
//    dispatch_queue_t queue = dispatch_queue_create("com.serialSyn", DISPATCH_QUEUE_SERIAL);
//
//    dispatch_sync(queue, ^{
//        for (int i =0; i <3; i ++) {
//            NSLog(@"1---%@", [NSThread currentThread]);
//        }
//    });
//
//    dispatch_sync(queue, ^{
//        for (int i =0; i <3; i ++) {
//            NSLog(@"2---%@", [NSThread currentThread]);
//        }
//    });
//
//    dispatch_sync(queue, ^{
//        for (int i =0; i <3; i ++) {
//            NSLog(@"3---%@", [NSThread currentThread]);
//        }
//    });
//}
//
//// 串行队列 + 异步任务
//- (void)serialAsyn {
//    dispatch_queue_t queue = dispatch_queue_create("com.serialAsyn", DISPATCH_QUEUE_SERIAL);
//
//    dispatch_async(queue, ^{
//        for (int i =0; i <3; i ++) {
//            NSLog(@"1---%@", [NSThread currentThread]);
//        }
//    });
//
//    dispatch_async(queue, ^{
//        for (int i =0; i <3; i ++) {
//            NSLog(@"2---%@", [NSThread currentThread]);
//        }
//    });
//
//    dispatch_async(queue, ^{
//        for (int i =0; i <3; i ++) {
//            NSLog(@"3---%@", [NSThread currentThread]);
//        }
//    });
//}
//
//// 并行队列 + 同步任务
//- (void)concurrenSyn {
//    dispatch_queue_t queue = dispatch_queue_create("com.concurrenSyn", DISPATCH_QUEUE_CONCURRENT);
//
//    dispatch_sync(queue, ^{
//        for (int i =0; i <3; i ++) {
//            NSLog(@"1---%@", [NSThread currentThread]);
//        }
//    });
//
//    dispatch_sync(queue, ^{
//        for (int i =0; i <3; i ++) {
//            NSLog(@"2---%@", [NSThread currentThread]);
//        }
//    });
//
//    dispatch_sync(queue, ^{
//        for (int i =0; i <3; i ++) {
//            NSLog(@"3---%@", [NSThread currentThread]);
//        }
//    });
//}
//
//
//// 并行队列 + 异步任务
//- (void)concurrenASyn {
//    dispatch_queue_t queue = dispatch_queue_create("com.concurrenASyn", DISPATCH_QUEUE_CONCURRENT);
//
//    dispatch_async(queue, ^{
//        for (int i =0; i <3; i ++) {
//            NSLog(@"1---%@", [NSThread currentThread]);
//        }
//    });
//
//    dispatch_async(queue, ^{
//        for (int i =0; i <3; i ++) {
//            NSLog(@"2---%@", [NSThread currentThread]);
//        }
//    });
//
//    dispatch_async(queue, ^{
//        for (int i =0; i <3; i ++) {
//            NSLog(@"3---%@", [NSThread currentThread]);
//        }
//    });
//}


//后台销毁对象
//    self.father = [Father new];
//    Father *temp = self.father;
//    self.father = nil;
