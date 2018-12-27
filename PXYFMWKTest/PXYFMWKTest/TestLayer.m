//
//  TestLayer.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2018/12/5.
//  Copyright © 2018 Pengxuyuan. All rights reserved.
//

#import "TestLayer.h"

@implementation TestLayer

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"%s",__func__);
//        self.backgroundC7olor = [UIColor redColor].CGColor;
    }
    return self;
}

//- (CGRect)frame {
//    NSLog(@"%s",__func__);
//    return [super frame];
//}

- (void)setFrame:(CGRect)frame {
    NSLog(@"%s",__func__);
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds {
    NSLog(@"%s",__func__);
    [super setBounds:bounds];
}

- (void)setPosition:(CGPoint)position {
    NSLog(@"%s",__func__);
    [super setPosition:position];
}

- (void)setAnchorPoint:(CGPoint)anchorPoint {
    NSLog(@"%s",__func__);
    [super setAnchorPoint:anchorPoint];
}

- (void)setTransform:(CATransform3D)transform {
    NSLog(@"%s",__func__);
    [super setTransform:transform];
}

- (void)display {
    NSLog(@"%s",__func__);
    [super display];
}


- (void)addAnimation:(CAAnimation *)anim forKey:(NSString *)key {
    NSLog(@"%s addAnimation:%@",__func__,[anim debugDescription]);
    [super addAnimation:anim forKey:key];
}

- (void)setMasksToBounds:(BOOL)masksToBounds {
    NSLog(@"%s",__func__);
    return [super setMasksToBounds:masksToBounds];
}



@end
