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
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(btn1.frame.origin.x, CGRectGetMaxY(btn1.frame) + 30, 200, 80)];
    [btn2 setTitle:@"Graver" forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor redColor]];
    [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    

    
}

- (void)btn1Click {
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


//self.testView = [[TestView alloc] initWithFrame:self.view.bounds];
//self.testView.backgroundColor = [UIColor redColor];
////    self.testView.layer.backgroundColor = [UIColor yellowColor].CGColor;
//[self.view addSubview:self.testView];
//
//    NSLog(@"self.testView fram:%@ --- self.testView.layer.contentsScale: %f", NSStringFromCGRect(self.testView.frame),self.testView.layer.contentsScale);

//    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    view1.backgroundColor = [UIColor yellowColor];
//    [self.testView addSubview:view1];

//    self.layer1 = [[CALayer alloc] init];
//    self.layer1.frame = CGRectMake(0, 0, 100, 100);
//    self.layer1.backgroundColor = [UIColor yellowColor].CGColor;
//    [self.testView.layer addSublayer:self.layer1];


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    //    self.view.backgroundColor = [UIColor redColor];
//
//    //    TestViewController *textVC = [TestViewController new];
//    //    [self.navigationController pushViewController:textVC animated:YES];
//
////    NSLog(@"%s",__func__);
////    _imageView.image = [UIImage imageNamed:@"222.png"];
//
////    self.testView.frame = CGRectMake(self.testView.frame.origin.x, self.testView.frame.origin.y + 100, self.testView.frame.size.width, self.testView.frame.size.height);
////    self.testView.layer.frame = CGRectMake(self.testView.layer.frame.origin.x, self.testView.layer.frame.origin.y + 100, self.testView.layer.frame.size.width, self.testView.layer.frame.size.height);
////    self.layer1.frame = CGRectMake(self.layer1.frame.origin.x, self.layer1.frame.origin.y + 100, self.layer1.frame.size.width, self.layer1.frame.size.height);
//
//
////    NSLog(@"block outside:%@",[self.testView actionForLayer:self.testView.layer forKey:@"position"]);
////
////    [UIView animateWithDuration:0.2 animations:^{
////        self.testView.frame = CGRectMake(self.testView.frame.origin.x, self.testView.frame.origin.y + 100, self.testView.frame.size.width, self.testView.frame.size.height);
////
////        NSLog(@"block inside:%@",[self.testView actionForLayer:self.testView.layer forKey:@"position"]);
////    }];
////
////
//////    self.layer1 addAnimation:<#(nonnull CAAnimation *)#> forKey:<#(nullable NSString *)#>
////
//
//
////    self.testView = [[TestView alloc] initWithFrame:self.view.bounds];
////    //    self.testView.frame = CGRectMake(0, 0, 300, 300);
////    self.testView.backgroundColor = [UIColor redColor];
////    //    self.testView.layer.backgroundColor = [UIColor yellowColor].CGColor;
////    [self.view addSubview:self.testView];
////
////    CGFloat memoryCost = self.testView.frame.size.width * self.testView.frame.size.height * self.testView.layer.contentsScale * 4 / 1024 / 1024;
////    NSLog(@"self.testView fram:%@ --- self.testView.layer.contentsScale: %f memory:%f", NSStringFromCGRect(self.testView.frame),self.testView.layer.contentsScale,memoryCost);
//
//    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
//    label.text = @"我😀😀我我问我我我";
////    label.textColor = [UIColor yellowColor];
//    [self.view addSubview:label];
//
//
//
//
//    //1. Block 输出结果
////    __block NSString *key = @"AAA";
////    objc_setAssociatedObject(self, &key, @1, OBJC_ASSOCIATION_ASSIGN);
////    id a = objc_getAssociatedObject(self, &key);
////
////    void (^block)(void) = ^ {
////        objc_setAssociatedObject(self, &key, @2, OBJC_ASSOCIATION_ASSIGN);
////    };
////
////    id m = objc_getAssociatedObject(self, &key);
////    block();
////    id n = objc_getAssociatedObject(self, &key);
////    objc_setAssociatedObject(self, &key, @3, OBJC_ASSOCIATION_ASSIGN);
////    id p = objc_getAssociatedObject(self, &key);
////    NSLog(@"%@ --- %@ --- %@ --- %@",a,m,n,p);
//
//
//    //2. __Block 在 ARC 和 MRC 环境的区别
//    //3. isEqual 和 hash 方法
//}


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
