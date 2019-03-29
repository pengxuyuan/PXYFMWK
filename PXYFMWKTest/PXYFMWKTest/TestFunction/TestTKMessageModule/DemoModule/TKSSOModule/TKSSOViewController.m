//
//  TKSSOViewController.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/3/4.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import "TKSSOViewController.h"
#import "UIViewController+PXYBaseViewController.h"
#import "TKModuleManager.h"

@interface TKSSOViewController () <TKModuleProtocol>

@end

@implementation TKSSOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"sso";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"TKModule SSO";
    self.tabBarController.navigationItem.title = @"TKModule SSO";
}

- (void)dealModuleMessage:(TKModuleModel *)moduleModel {
    NSLog(@"%s",__func__);
    
    ModuleMessageCallback callback = moduleModel.moduleMessageCallback;
    if (callback) {
        callback(moduleModel);
    }
    
    UIColor *color = moduleModel.params[@"color"];
    self.view.backgroundColor = color;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UIColor *color = [UIColor blueColor];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"color"] = color;
    [[TKModuleManager sharedInstance] sendModuleMessageWithSourceModule:@"sso" targetModule:@"trade" funcNo:@"10000" params:params moduleMessageCallback:^(TKModuleModel *moduleModel) {
        NSLog(@"%s",__func__);
    }];
}




@end
