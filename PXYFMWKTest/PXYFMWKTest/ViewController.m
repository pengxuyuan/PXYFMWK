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

@interface ViewController ()

@end

@implementation ViewController

- (id)getBlockArray {
    int val = 10;
    return [[NSArray alloc] initWithObjects:^{NSLog(@"%d",val);}, ^{NSLog(@"%d",val);},nil];
//    return [[NSArray alloc] initWithObjects:[^{NSLog(@"%d",val);} copy], [^{NSLog(@"%d",val);} copy],nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self test];
    
//    id obj = [self getBlockArray];
//    typedef void (^blk_t)(void);
//    blk_t blk = [obj objectAtIndex:0];
//    blk();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageView.backgroundColor = [UIColor redColor];
    imageView.center = self.view.center;
    imageView.image = [UIImage imageNamed:@"icon.jpeg"];
    [self.view addSubview:imageView];
    [imageView settingCornerWithCornerRadius:100];
}

- (void)test {
    __block NSString *key = @"AAA";
//    NSString *key = @"AAA";
//    static NSString *key = @"AAA";
    
    objc_setAssociatedObject(self, &key, @1, OBJC_ASSOCIATION_ASSIGN);
    id a = objc_getAssociatedObject(self, &key);
    
    void (^block)(void) = ^ {
        objc_setAssociatedObject(self, &key, @2, OBJC_ASSOCIATION_ASSIGN);
    };
    
    id m = objc_getAssociatedObject(self, &key);
    block();
    id n = objc_getAssociatedObject(self, &key);
    objc_setAssociatedObject(self, &key, @3, OBJC_ASSOCIATION_ASSIGN);
    id p = objc_getAssociatedObject(self, &key);
    NSLog(@"%@ --- %@ --- %@ --- %@",a,m,n,p);
}



@end

