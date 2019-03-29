//
//  TKModuleManager.h
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/3/4.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKModuleModel.h"
#import "TKModuleProtocol.h"

//模块间消息管理类
@interface TKModuleManager : NSObject

+(instancetype)sharedInstance;

- (void)initModuleConfig;

- (void)sendModuleMessageWithSourceModule:(NSString *)sourceModule
                             targetModule:(NSString *)targetModule
                                   funcNo:(NSString *)funcNo
                                    params:(NSMutableDictionary *)params
                    moduleMessageCallback:(ModuleMessageCallback)callback;

@end
