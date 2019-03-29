//
//  CTMediator+HomePageModuleActions.h
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/3/3.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import "CTMediator.h"

// 对外界暴露 HomePageModule 模块的功能方法
@interface CTMediator (HomePageModuleActions)

//获取 HomePageModule 模块的主控制器
- (UIViewController *)mediator_fetchHomePageModuleViewController;

// 设置 HomePageModule 模块 HomePage 页面信息
- (void)mediator_settingHomePageModuleViewControllerWithParams:(NSDictionary *)params;

@end
