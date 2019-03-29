//
//  Target_HomePageModule.h
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/3/3.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//这里是对外提供的功能，但是是通过 Target-Action 来调用
@interface Target_HomePageModule : NSObject

//获取 HomeModule 模块的 HomeViewController
- (UIViewController *)Action_nativeFetchHomePageViewController:(NSDictionary *)params;

// 设置 HomePageModule 模块 HomePage 页面信息
- (void)Action_nativeSettingHomePageViewController:(NSDictionary *)params;

@end
