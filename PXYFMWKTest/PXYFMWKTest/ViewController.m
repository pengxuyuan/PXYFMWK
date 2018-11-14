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

@interface ViewController ()

@property (nonatomic, strong) AImageView *imageView;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView = [[AImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _imageView.backgroundColor = [UIColor redColor];
    _imageView.center = self.view.center;
    _imageView.image = [UIImage imageNamed:@"icon.jpeg"];
    [self.view addSubview:_imageView];
    _imageView.userInteractionEnabled = YES;
    [_imageView settingCornerWithCornerRadius:100];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    TestViewController *textVC = [TestViewController new];
    [self.navigationController pushViewController:textVC animated:YES];
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
