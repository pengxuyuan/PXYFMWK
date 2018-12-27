//
//  TestViewController.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2018/11/14.
//  Copyright © 2018 Pengxuyuan. All rights reserved.
//

#import "TestViewController.h"
#import "TestView.h"

@interface TestViewController ()

@property (nonatomic, strong) TestView *testView;



@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.type == TestViewType1) {
        self.navigationItem.title = @"UIView & CALayer";
    } else if (self.type == TestViewType2) {
        self.navigationItem.title = @"Graver";
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.type == TestViewType1) {
        
        self.testView = [[TestView alloc] initWithFrame:self.view.bounds];
        self.testView.backgroundColor = [UIColor redColor];
        self.testView.clipsToBounds = YES;
        [self.view addSubview:self.testView];
    
    } else if (self.type == TestViewType2) {
        
    }
    
}


- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
