//
//  Son.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2018/9/10.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import "Son.h"

@implementation Son

//+ (void)load {
////    [super load];
//    NSLog(@"%s",__func__);
//}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"111%@",NSStringFromClass([self class]));
        NSLog(@"222%@",NSStringFromClass([super class]));
        NSLog(@"333%@",NSStringFromClass([self superclass]));
    }
    return self;
}

@end
