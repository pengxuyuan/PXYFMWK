//
//  TKModuleManager.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/3/4.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import "TKModuleManager.h"
#import <UIKit/UIKit.h>
#import "PXYViewControllerHelper.h"

@interface TKModuleManager ()

//模块配置
@property (nonatomic, strong) NSMutableDictionary <NSString *,id <TKModuleProtocol> >*moduleDict;
@property (nonatomic, strong) NSMutableDictionary <NSString *, NSString *> *moduleConfigDict;

@end

@implementation TKModuleManager

+(instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static TKModuleManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [TKModuleManager new];
    });
    return instance;
}

- (void)initModuleConfig {
    //初始化模块间消息配置
    NSMutableArray *cofigArray = [NSMutableArray array];
    [cofigArray addObject:@{@"name":@"sso",@"value":@"TKSSOViewController"}];
    [cofigArray addObject:@{@"name":@"trade",@"value":@"TKTradeViewController"}];
    
    _moduleDict = [NSMutableDictionary dictionary];
    _moduleConfigDict = [NSMutableDictionary dictionary];
    for (NSDictionary *dict in cofigArray) {
        NSString *name = dict[@"name"];
        NSString *value = dict[@"value"];
        
        Class class = NSClassFromString(value);
        if (class) {
            
            id<TKModuleProtocol> module = [[class alloc] init];
            if (module && [module isKindOfClass:[UIViewController class]])
            {
//                ((UIViewController *)module).name = name;
            }
            [_moduleDict setObject:module forKey:name];
            [_moduleConfigDict setObject:value forKey:name];
        } else {
            NSLog(@"模块[%@]对应的类%@不存在!",name,value);
        }
    }
}

- (void)sendModuleMessageWithSourceModule:(NSString *)sourceModule
                             targetModule:(NSString *)targetModule
                                   funcNo:(NSString *)funcNo
                                   params:(NSMutableDictionary *)params
                    moduleMessageCallback:(ModuleMessageCallback)callback {
    
    TKModuleModel *model = [TKModuleModel new];
    model.sourceModule = sourceModule;
    model.targetModule = targetModule;
    model.funcNo = funcNo;
    model.params = params;
    model.moduleMessageCallback = callback;
    
    id sourceModuleObj = _moduleDict[sourceModule];
    if (sourceModuleObj) {
        model.sourceModuleObject = sourceModuleObj;
    }
    
    id targetModuleObj = _moduleDict[targetModule];
    if (targetModuleObj) {
        model.targetModuleObject = targetModuleObj;
    }
    
    id <TKModuleProtocol> module = (id<TKModuleProtocol>)self.moduleDict[targetModule];
    if (module && [module isKindOfClass:[UIViewController class]])
    {
        //是控制器的话，需要用缓存
        UIViewController *viewController = [[PXYViewControllerHelper sharedInstance] fetchViewControllerWithName:targetModule];
        if (viewController) {
            module = (id <TKModuleProtocol>)viewController;
        }
    }
    
    if ([module respondsToSelector:@selector(dealModuleMessage:)])
    {
        [module dealModuleMessage:model];
    }
}


@end
