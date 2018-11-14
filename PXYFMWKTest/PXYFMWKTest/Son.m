//
//  Son.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2018/9/10.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import "Son.h"

@implementation Son

- (void)sonMethod {
    NSLog(@"--------------------");
    NSLog(@"%s",__func__);
    NSLog(@"%@",NSStringFromClass([self class]));
    NSLog(@"%@",NSStringFromClass([super class]));
    NSLog(@"%@",NSStringFromClass([self superclass]));
    NSLog(@"--------------------");
}

@end
