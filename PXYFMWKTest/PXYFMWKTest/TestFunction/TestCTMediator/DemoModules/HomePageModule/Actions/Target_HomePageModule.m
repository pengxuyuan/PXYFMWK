//
//  Target_HomePageModule.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/3/3.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import "Target_HomePageModule.h"
#import "PXYViewControllerHelper.h"

#import "HomeViewController.h"

@interface Target_HomePageModule()

@property (nonatomic, strong) HomeViewController *homeVC;

@end

@implementation Target_HomePageModule

//获取 HomeModule 模块的 HomeViewController
- (UIViewController *)Action_nativeFetchHomePageViewController:(NSDictionary *)params {
    // 因为action是从属于ModuleA的，所以action直接可以使用ModuleA里的所有声明
    
    self.homeVC.navigationItem.title = params[@"title"];
    return self.homeVC;
}

// 设置 HomePageModule 模块 HomePage 页面信息
- (void)Action_nativeSettingHomePageViewController:(NSDictionary *)params {
    NSLog(@"%s",__func__);
    
    UIColor *color = params[@"color"];
    self.homeVC.view.backgroundColor = color;
}

#pragma mark - Lazzy load
- (HomeViewController *)homeVC {
    if (_homeVC == nil) {
        _homeVC = (HomeViewController *)[[PXYViewControllerHelper sharedInstance] fetchViewControllerWithName:@"home"];
        if (_homeVC == nil) {
            _homeVC = [HomeViewController new];
        }
    }
    return _homeVC;
}

@end
