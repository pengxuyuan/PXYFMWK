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

#import "UIResponder+PXYRouter.h"
#import "AImageView.h"
#import "NSData+PXYFileType.h"

#import "NSData+ImageContentType.h"
#import "Father.h"
#import "Son.h"


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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
    [_imageView addGestureRecognizer:tap];
    [self.view addSubview:_imageView];
    _imageView.userInteractionEnabled = YES;
    [_imageView settingCornerWithCornerRadius:100];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    Father *f = [Father new];
    Son *s = [Son new];
    
    NSLog(@"%@",NSStringFromClass([f class]));
    NSLog(@"%@",NSStringFromClass([s class]));
    NSLog(@"%@",NSStringFromClass([s superclass]));
}


@end

