//
//  CTMediator+HomePageModuleActions.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/3/3.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import "CTMediator+HomePageModuleActions.h"

//Taget
NSString * const kCTMediatorHomePageModuleTarget = @"HomePageModule";

//Action
NSString * const kCTMediatorActionNativeFetchHomePageViewController = @"nativeFetchHomePageViewController";
NSString * const kCTMediatorActionNativeSettingHomePageViewController = @"nativeSettingHomePageViewController";



@implementation CTMediator (HomePageModuleActions)

//获取 HomePageModule 模块的主控制器
- (UIViewController *)mediator_fetchHomePageModuleViewController {
    UIViewController *viewController = [self performTarget:kCTMediatorHomePageModuleTarget
                                                    action:kCTMediatorActionNativeFetchHomePageViewController params:@{@"title":@"传参"}
                                         shouldCacheTarget:YES];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        return viewController;
    } else {
        NSLog(@"mediator_fetchHomePageModuleViewController 异常");
        return nil;
    }
}

// 设置 HomePageModule 模块 HomePage 页面信息
- (void)mediator_settingHomePageModuleViewControllerWithParams:(NSDictionary *)params {
    [self performTarget:kCTMediatorHomePageModuleTarget
                 action:kCTMediatorActionNativeSettingHomePageViewController params:params
      shouldCacheTarget:YES];
}


@end
