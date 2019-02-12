//
//  TestView.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2018/12/5.
//  Copyright © 2018 Pengxuyuan. All rights reserved.
//

#import "TestView.h"
#import "TestLayer.h"

@implementation TestView

+ (Class)layerClass {
    NSLog(@"%s",__func__);
    return [TestLayer class];
}

- (void)setFrame:(CGRect)frame {
    NSLog(@"%s",__func__);
    [super setFrame:frame];
}

- (void)setCenter:(CGPoint)center {
    NSLog(@"%s",__func__);
    [super setCenter:center];
}

- (void)setBounds:(CGRect)bounds {
    NSLog(@"%s",__func__);
    [super setBounds:bounds];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s",__func__);
//    [super touchesBegan:touches withEvent:event];
}

//- (void)displayLayer:(CALayer *)layer {
//    NSLog(@"%s",__func__);
//}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    NSLog(@"%s",__func__);
    
//    layer.contents
    
//    [super drawLayer:layer inContext:ctx];
}


- (void)drawRect:(CGRect)rect {
    NSLog(@"%s",__func__);
    [super drawRect:rect];
}



- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
    NSLog(@"%s",__func__);
    return [super actionForLayer:layer forKey:event];
}



- (void)setClipsToBounds:(BOOL)clipsToBounds {
    NSLog(@"%s",__func__);
    [super setClipsToBounds:clipsToBounds];
}

@end
