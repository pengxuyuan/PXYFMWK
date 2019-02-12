//
//  TestViewController.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2018/11/14.
//  Copyright © 2018 Pengxuyuan. All rights reserved.
//

#import "TestViewController.h"
#import "TestView.h"

#import "WMGCanvasView.h"
#import "WMGCanvasControl.h"

#import <objc/runtime.h>

@interface TestViewController ()

@property (nonatomic, strong) TestView *testView;



@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.type == TestViewType1) {
        self.navigationItem.title = @"UIView & CALayer";
    } else if (self.type == TestViewType2) {
        self.navigationItem.title = @"Graver";
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.type == TestViewType1) {

        self.testView = [[TestView alloc] initWithFrame:self.view.bounds];
        self.testView.backgroundColor = [UIColor redColor];
        self.testView.clipsToBounds = YES;
        [self.view addSubview:self.testView];

    } else if (self.type == TestViewType2) {
        WMGCanvasView *canvasView = [[WMGCanvasView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        canvasView.center = self.view.center;
        canvasView.backgroundImage = [UIImage imageNamed:@"icon.jpeg"];
        canvasView.cornerRadius = 20;
        [self.view addSubview:canvasView];

//        WMGCanvasControl *control = [[WMGCanvasControl alloc] initWithFrame:self.view.bounds];
//        control.backgroundColor = [UIColor yellowColor];
//        [control addTarget:self action:@selector(controlClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:control];
    }
    
//    //验证动画问题
//    NSLog(@"block outside:%@",[self.testView actionForLayer:self.testView.layer forKey:@"position"]);
//    [UIView animateWithDuration:0.2 animations:^{
//        self.testView.frame = CGRectMake(self.testView.frame.origin.x, self.testView.frame.origin.y + 100, self.testView.frame.size.width, self.testView.frame.size.height);
//
//        NSLog(@"block inside:%@",[self.testView actionForLayer:self.testView.layer forKey:@"position"]);
//    }];
//
//
//    //1.验证 Label 不同占用的内存问题
//    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
//    label.text = @"我😀😀我我问我我我";
//    label.text = @"我我我问我我我";
//    [self.view addSubview:label];
    
  
}

- (void)controlClick:(WMGCanvasControl *)control {
    NSLog(@"%s",__func__);
}


- (void)dealloc {
    NSLog(@"%s",__func__);
}

//扩展话题
//1. Block 输出结果
//    __block NSString *key = @"AAA";
//    objc_setAssociatedObject(self, &key, @1, OBJC_ASSOCIATION_ASSIGN);
//    id a = objc_getAssociatedObject(self, &key);
//
//    void (^block)(void) = ^ {
//        objc_setAssociatedObject(self, &key, @2, OBJC_ASSOCIATION_ASSIGN);
//    };
//
//    id m = objc_getAssociatedObject(self, &key);
//    block();
//    id n = objc_getAssociatedObject(self, &key);
//    objc_setAssociatedObject(self, &key, @3, OBJC_ASSOCIATION_ASSIGN);
//    id p = objc_getAssociatedObject(self, &key);
//    NSLog(@"%@ --- %@ --- %@ --- %@",a,m,n,p);

//2. __block 在 ARC 和 MRC 环境的区别()


//3. isEqual 和 hash 方法
//    重写 isEqual 方法，hash 方法没重写
//    这个时候会出现 isEqual 判断两个对象相同，但是 hash 值不同，但是这两个对象在 Set 集合中可以同时存在，这个在业务逻辑上是不合理的。

@end
