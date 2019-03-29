//
//  ViewController.m
//  ImageCorner
//
//  Created by Pengxuyuan on 2018/8/2.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import "ViewController.h"
#import <PXYFMWKDYLIB/PXYFMWKDYLIB.h>
#import "UIViewController+PXYBaseViewController.h"

#import "CTMediator+HomePageModuleActions.h"

#import "TKModuleManager.h"

@interface ViewController ()


@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__func__);
    self.name = @"view";
    self.view.backgroundColor = [UIColor whiteColor];
//    [[TKModuleManager sharedInstance] initModuleConfig];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"主界面";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[TKModuleManager sharedInstance] initModuleConfig];
    
    self.tabBarItem.title = @"11111";
    
    NSDictionary *dictHome1 = [NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    NSDictionary *dictHome2 = [NSDictionary dictionaryWithObject:[UIColor yellowColor] forKey:NSForegroundColorAttributeName];
//    [self.tabBarItem setTitleTextAttributes:dictHome1 forState:UIControlStateNormal];
//    [self.tabBarItem setTitleTextAttributes:dictHome2 forState:UIControlStateSelected];
    
    [[UITabBarItem appearance] setTitleTextAttributes:dictHome1 forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:dictHome2 forState:UIControlStateSelected];
    
    [self.view setNeedsDisplay];
    [self.tabBarController.view setNeedsDisplay];
    
    return;
    
    
    UIColor *color = [UIColor redColor];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"color"] = color;
    
    //CTMediator 实践
//    UIViewController *vc = [[CTMediator sharedInstance] mediator_fetchHomePageModuleViewController];
//    [self.navigationController pushViewController:vc animated:YES];
    [[CTMediator sharedInstance] mediator_settingHomePageModuleViewControllerWithParams:[params copy]];
    

    [[TKModuleManager sharedInstance] sendModuleMessageWithSourceModule:@"view" targetModule:@"sso" funcNo:@"10000" params:params moduleMessageCallback:^(TKModuleModel *moduleModel) {
        NSLog(@"moduleMessageCallback");
        
//        UIViewController *targetObject = moduleModel.targetModuleObject;
//        [self.navigationController pushViewController:targetObject animated:YES];
        
    }];
    
    [[TKModuleManager sharedInstance] sendModuleMessageWithSourceModule:@"view" targetModule:@"trade" funcNo:@"10000" params:params moduleMessageCallback:^(TKModuleModel *moduleModel) {
        NSLog(@"moduleMessageCallback");
    }];
}



@end
