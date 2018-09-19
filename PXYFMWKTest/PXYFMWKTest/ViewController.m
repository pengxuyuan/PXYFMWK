//
//  ViewController.m
//  ImageCorner
//
//  Created by Pengxuyuan on 2018/8/2.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+ImageCorner.h"
#import "Son.h"
#import <PXYFMWKDYLIB/PXYFMWKDYLIB.h>
#import <objc/runtime.h>
#import "NSObject+DLIntrospection.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageView.backgroundColor = [UIColor redColor];
    imageView.center = self.view.center;
    imageView.image = [UIImage imageNamed:@"icon.jpeg"];
    [self.view addSubview:imageView];
    [imageView settingCornerWithCornerRadius:100];
    
    func();
}

void pr(int (^block)(void)) {
    printf("%d\n",block());
}

void func() {
    int (^block[10])(void);
    int i;
    for (i = 0; i < 10; i ++) {
        block[i] = ^{
            return i;
        };
    }
    
    for (int j = 0; j < 10; j ++) {
        pr(block[j]);
    }
}






@end

