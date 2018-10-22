//
//  Father.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2018/9/10.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import "Father.h"

@implementation Father

//+ (void)load {
//    NSLog(@"%s",__func__);
//}

- (void)testDemo {
    
}

- (NSUInteger)hash {
    
    NSUInteger hash = [super hash];
    NSLog(@"hash:%ld",hash);
    return 1000;
    return hash;
}

- (BOOL)isEqual:(id)object {
    NSLog(@"isEqual");
    //1. == 判断地址
    if (self == object) return YES;
    
    //2.isKindOfClass 判断对象类型
    if (![object isKindOfClass:[self class]]) return NO;
    
    //3. 进行业务逻辑判断
    return [self isEqualToFather:(Father *)object];
}

- (BOOL)isEqualToFather:(Father *)object {
    //业务逻辑
    if ([self.name isEqualToString:object.name]) {
        return YES;
    }else {
        return NO;
    }
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
