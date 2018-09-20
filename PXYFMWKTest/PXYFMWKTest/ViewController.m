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
#import "NSObject+DLIntrospection.h"



@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _imageView.backgroundColor = [UIColor redColor];
    _imageView.center = self.view.center;
    _imageView.image = [UIImage imageNamed:@"icon.jpeg"];
    [self.view addSubview:_imageView];
    [_imageView settingCornerWithCornerRadius:100];

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
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

