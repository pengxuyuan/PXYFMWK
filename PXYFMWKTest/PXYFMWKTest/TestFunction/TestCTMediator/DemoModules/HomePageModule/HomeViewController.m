//
//  HomeViewController.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2019/3/3.
//  Copyright © 2019 Pengxuyuan. All rights reserved.
//

#import "HomeViewController.h"
#import "UIViewController+PXYBaseViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s",__func__);
    self.name = @"home";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"CTMediaor 首页";
}


@end
