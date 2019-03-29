//
//  PXYViewControllerHelper.h
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/3/5.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PXYViewControllerHelper : NSObject

+ (instancetype)sharedInstance;

// 将控制器和name 注册到全局 Map 中
- (void)registerViewController:(UIViewController *)viewController withName:(NSString *)name;

//通过 name 获取控制器
- (UIViewController *)fetchViewControllerWithName:(NSString *)name;

//注销全部注册的控制器
- (void)removeAllRegisterViewController;

@end
