//
//  Father.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2018/9/10.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import "Father.h"


@interface Father ()

@property (nonatomic, strong) NSObject *strongObject;

@end

@implementation Father

- (void)fatherMethod {
    NSLog(@"--------------------");
    NSLog(@"%s",__func__);
    NSLog(@"%@",NSStringFromClass([self class]));
    NSLog(@"%@",NSStringFromClass([super class]));
    NSLog(@"%@",NSStringFromClass([self superclass]));
    NSLog(@"--------------------");
}

- (void)dealloc{
    
    NSLog(@"dealloc %@",[self class]);
    
}

- (void)setStrongObject:(NSObject *)strongObject {
    _strongObject = strongObject;
}


@end
