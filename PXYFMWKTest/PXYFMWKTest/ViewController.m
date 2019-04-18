//
//  ViewController.m
//  ImageCorner
//
//  Created by Pengxuyuan on 2018/8/2.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import "ViewController.h"
#import <PXYFMWKDYLIB/PXYFMWKDYLIB.h>
#import "UIViewController+PXYBaseViewController.h"

#import "CTMediator+HomePageModuleActions.h"

#import "TKModuleManager.h"

#import "TKFXBlurView.h"

#import "WMGImage.h"
#import "WMGTextAttachment.h"
#import "WMGMixedView.h"

#import "Person.h"

@interface ViewController ()


@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__func__);
    self.name = @"view";
    self.view.backgroundColor = [UIColor whiteColor];
//    [[TKModuleManager sharedInstance] initModuleConfig];
    
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    imageView.image = [UIImage imageNamed:@"1111.png"];
//    [self.view addSubview:imageView];
//
//    TKFXBlurView *blur = [[TKFXBlurView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
//    blur.tintColor = [UIColor blackColor]; //前景颜色
//    blur.blurRadius = 200; //模糊半径
//    blur.dynamic = YES;      //动态改变模糊效果
//
//    [imageView addSubview:blur];
    
    WMGImage *image = [WMGImage new];
    image.downloadUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544007471380&di=b2100fe21076aec03f8cfced82099dd7&imgtype=0&src=http%3A%2F%2Fimage.xinmin.cn%2F2016%2F08%2F06%2F20160806172159913425.jpeg";
    image.size = CGSizeMake(100, 100);
    WMGTextAttachment *attac = [WMGTextAttachment textAttachmentWithContents:image type:WMGAttachmentTypeStaticImage size:CGSizeMake(100, 100)];
    
    WMMutableAttributedItem *item = [WMMutableAttributedItem itemWithText:@"初始值"];
    [item appendImageWithUrl:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544007471380&di=b2100fe21076aec03f8cfced82099dd7&imgtype=0&src=http%3A%2F%2Fimage.xinmin.cn%2F2016%2F08%2F06%2F20160806172159913425.jpeg" size:CGSizeMake(100, 100)];
    
    
    WMGMixedView *view = [[WMGMixedView alloc] initWithFrame:CGRectMake(10, 100, 200, 200)];
    view.attributedItem = item;
    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"主界面";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[TKModuleManager sharedInstance] initModuleConfig];
    
    self.tabBarItem.title = @"11111";
    
    NSDictionary *dictHome1 = [NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    NSDictionary *dictHome2 = [NSDictionary dictionaryWithObject:[UIColor yellowColor] forKey:NSForegroundColorAttributeName];
//    [self.tabBarItem setTitleTextAttributes:dictHome1 forState:UIControlStateNormal];
//    [self.tabBarItem setTitleTextAttributes:dictHome2 forState:UIControlStateSelected];
    
    [[UITabBarItem appearance] setTitleTextAttributes:dictHome1 forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:dictHome2 forState:UIControlStateSelected];
    
    [self.view setNeedsDisplay];
    [self.tabBarController.view setNeedsDisplay];
    
    return;
    
    
    UIColor *color = [UIColor redColor];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"color"] = color;
    
    //CTMediator 实践
//    UIViewController *vc = [[CTMediator sharedInstance] mediator_fetchHomePageModuleViewController];
//    [self.navigationController pushViewController:vc animated:YES];
    [[CTMediator sharedInstance] mediator_settingHomePageModuleViewControllerWithParams:[params copy]];
    

    [[TKModuleManager sharedInstance] sendModuleMessageWithSourceModule:@"view" targetModule:@"sso" funcNo:@"10000" params:params moduleMessageCallback:^(TKModuleModel *moduleModel) {
        NSLog(@"moduleMessageCallback");
        
//        UIViewController *targetObject = moduleModel.targetModuleObject;
//        [self.navigationController pushViewController:targetObject animated:YES];
        
    }];
    
    [[TKModuleManager sharedInstance] sendModuleMessageWithSourceModule:@"view" targetModule:@"trade" funcNo:@"10000" params:params moduleMessageCallback:^(TKModuleModel *moduleModel) {
        NSLog(@"moduleMessageCallback");
    }];
}



@end
