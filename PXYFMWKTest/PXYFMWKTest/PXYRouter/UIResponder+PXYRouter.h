//
//  UIResponder+PXYRouter.h
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2018/10/17.
//  Copyright © 2018 Pengxuyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 进行事件转发
 */
@interface UIResponder (PXYRouter)

/**
 发送一个路由器消息, 对eventName感兴趣的 UIResponsder 可以对消息进行处理

 @param eventName 发生的事件名称
 @param userInfo 传递消息时, 携带的数据, 数据传递过程中, 会有新的数据添加
 */
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSObject *)userInfo;


@end
