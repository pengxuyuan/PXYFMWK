//
//  TKModuleProtocol.h
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/3/4.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKModuleModel.h"

//模块调用 protocol
@protocol TKModuleProtocol <NSObject>

//处理模块间消息
- (void)dealModuleMessage:(TKModuleModel *)moduleModel;



@end
