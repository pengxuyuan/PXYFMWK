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

- (IBAction)push:(id)sender {
    TKSSOViewController *sso = [TKSSOViewController new];
    [self.navigationController pushViewController:sso animated:YES];
}
    
- (IBAction)present:(id)sender {
    TKSSOViewController *sso = [TKSSOViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:sso];
    [self presentViewController:nav animated:YES completion:nil];
}
    
- (IBAction)pop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
    
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
    
- (IBAction)goHome:(id)sender {
    
    UIViewController *root = [self findRootVCWith:self];
    if (root.presentedViewController) {
        [root dismissViewControllerAnimated:NO completion:^{
            [root.navigationController popToRootViewControllerAnimated:YES];
        }];
    } else {
        [root.navigationController popToRootViewControllerAnimated:YES];
    }
}

    
- (UIViewController *)findRootVCWith:(UIViewController *)currentVC{
    
    if (currentVC == nil) return nil;
    
    UIViewController *dealVC = currentVC;
    if (dealVC.presentingViewController == nil) {
        if ([dealVC isKindOfClass:[UINavigationController class]]) {
            dealVC = (UINavigationController *)[dealVC.childViewControllers firstObject];
        }
        
        if (dealVC.navigationController.childViewControllers.count > 0) {
            if (dealVC == [dealVC.navigationController.childViewControllers firstObject]) {
                return dealVC;
            }
        } else {
            return dealVC;
        }
    }
    
    if (dealVC.presentingViewController) {
        dealVC = dealVC.presentingViewController;
    } else if (dealVC.navigationController.childViewControllers.count > 0) {
        dealVC = [dealVC.navigationController.childViewControllers firstObject];
    }
    
    return [self findRootVCWith:dealVC];
    
}
   
    
@end
