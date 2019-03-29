//
//  TKTradeViewController.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/3/4.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import "TKTradeViewController.h"
#import "UIViewController+PXYBaseViewController.h"
#import "TKModuleManager.h"

@interface TKTradeViewController ()

@end

@implementation TKTradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"trade";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"TKModule Trade";
}

- (void)dealModuleMessage:(TKModuleModel *)moduleModel {
    NSLog(@"%s",__func__);
    
    UIColor *color = moduleModel.params[@"color"];
    self.view.backgroundColor = color;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UIColor *color = [UIColor yellowColor];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"color"] = color;
    [[TKModuleManager sharedInstance] sendModuleMessageWithSourceModule:@"trade" targetModule:@"sso" funcNo:@"10000" params:params moduleMessageCallback:^(TKModuleModel *moduleModel) {
        NSLog(@"%s",__func__);
    }];
}


@end
