//
//  NSObject+PXYRuntimeHelper.m
//  ImageCorner
//
//  Created by Pengxuyuan on 2018/8/9.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import "NSObject+PXYRuntimeHelper.h"
#import <objc/message.h>

@implementation NSObject (PXYRuntimeHelper)

#pragma mark - Plubic Methods
/**
 交换方法
 */
+ (void)pxy_swizzleMethodWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
    Class class = [self class];
    
    SEL originalSeletor = originalSelector;
    SEL swizzledSeletor = swizzledSelector;
    
    Method originMethod = class_getInstanceMethod(class, originalSeletor);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSeletor);
    
    //先尝试給源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况
    BOOL didAddMethod = class_addMethod(class, originalSeletor, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        //添加成功：说明源SEL没有实现IMP，将源SEL的IMP替换到交换SEL的IMP
        class_replaceMethod(class, swizzledSeletor, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        //添加失败：说明源SEL已经有IMP，直接将两个SEL的IMP交换即可
        method_exchangeImplementations(originMethod, swizzledMethod);
    }
}

/**
 获取类中的所有属性
 */
- (void)pxy_printPropertyList {
    
    Class class = [self class];
    NSLog(@"");
    NSLog(@"----- Class: %@ PropertyList Start -----",NSStringFromClass(class));
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(class, &count);
    for (int i = 0; i < count; i ++) {
        objc_property_t property = properties[i];
        NSLog(@"%s ---- %s",property_getName(property),property_getAttributes(property));
    }
    free(properties);
    NSLog(@"----- Class: %@ PropertyList End   -----",NSStringFromClass(class));
    NSLog(@"");
}

/**
 获取类中的所有成员变量
 */
- (void)pxy_printIvaList {
    Class class = [self class];
    NSLog(@"");
    NSLog(@"----- Class: %@ IvaList Start -----",NSStringFromClass(class));
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(class, &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        NSLog(@"%s ---- %s",ivar_getName(ivar),ivar_getTypeEncoding(ivar));
    }
    free(ivars);
    NSLog(@"----- Class: %@ IvaList End   -----",NSStringFromClass(class));
    NSLog(@"");
}

/**
 获取类中的所有方法
 */
- (void)pxy_printMethodList {
    Class class = [self class];
    NSLog(@"");
    NSLog(@"----- Class: %@ MethodList Start -----",NSStringFromClass(class));
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(class, &count);
    for (int i = 0; i < count; i ++) {
        Method method = methodList[i];
        NSLog(@"Method: ---- %@",NSStringFromSelector(method_getName(method)));
    }
    
    NSLog(@"----- Class: %@ MethodList End   -----",NSStringFromClass(class));
    NSLog(@"");   
}

/**
 获取协议列表
 */
- (void)pxy_printProtocolList {
    Class class = [self class];
    NSLog(@"");
    NSLog(@"----- Class: %@ ProtocolList Start -----",NSStringFromClass(class));
    
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(class, &count);
    for (int i = 0; i < count; i ++) {
        Protocol *protocol = protocolList[i];
        const char *protocolName = protocol_getName(protocol);
        NSLog(@"Protocol: ---- %s",protocolName);
    }
    
    NSLog(@"----- Class: %@ ProtocolList End   -----",NSStringFromClass(class));
    NSLog(@"");
}

@end
