//
//  TKModuleModel.h
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/3/4.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TKModuleModel;

//调用模块间消息的回调 Block
typedef void(^ModuleMessageCallback)(TKModuleModel *moduleModel);

//作为模块间消息传递
@interface TKModuleModel : NSObject

@property (nonatomic, copy) NSString *funcNo;

@property (nonatomic, copy) NSString *sourceModule;

@property (nonatomic, copy) NSString *targetModule;

@property (nonatomic, copy) NSMutableDictionary *params;

@property (nonatomic, strong) ModuleMessageCallback moduleMessageCallback;

@property (nonatomic, weak) id sourceModuleObject;

@property (nonatomic, weak) id targetModuleObject;

@end
