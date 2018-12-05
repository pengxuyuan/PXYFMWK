//
//  NSObject+PXYRuntimeHelper.m
//  ImageCorner
//
//  Created by Pengxuyuan on 2018/8/9.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import "NSObject+PXYRuntimeHelper.h"


@implementation NSObject (PXYRuntimeHelper)

#pragma mark - Plubic Methods
/**
 交换方法
 */
+ (void)pxy_swizzleMethodWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector {
    Class class = [self class];
    [self pxy_swizzleMethodWithOriginalClass:class originalSelector:originalSelector swizzledClass:class swizzledSelector:swizzledSelector isInstanceMethod:YES];
}

/**
 交换方法，将 originalClass 中的 originalSelector 替换成 swizzledClass 类中的 swizzledSelector 方法
 */
+ (void)pxy_swizzleMethodWithOriginalClass:(Class)originalClass originalSelector:(SEL)originalSelector swizzledClass:(Class)swizzledClass swizzledSelector:(SEL)swizzledSelector isInstanceMethod:(BOOL)isInstanceMethod {
    NSLog(@"即将交换方法：将 %@ 类的 %@ 方法与 %@ 类的 %@ 方法交换",NSStringFromClass(originalClass),NSStringFromSelector(originalSelector),NSStringFromClass(swizzledClass),NSStringFromSelector(swizzledSelector));
    SEL originalSeletor = originalSelector;
    SEL swizzledSeletor = swizzledSelector;
    
    Method originalMethod = class_getInstanceMethod(originalClass, originalSeletor);
    Method swizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSeletor);
    if (!isInstanceMethod) {
        originalMethod = class_getClassMethod(originalClass, originalSeletor);
        swizzledMethod = class_getClassMethod(swizzledClass, swizzledSeletor);
    }
    
    
    //先尝试給源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况
//    BOOL didAddMethod = class_addMethod(originalClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
//    if (didAddMethod) {
//        // class_addMethod 添加成功则说明：originalClass 没有实现 originalSelector 对应的方法，并且将此时已经将 originalSelector 对应实现改成 swizzledMethod 的实现。
//        //添加成功：说明源SEL没有实现IMP，将源SEL的IMP替换到交换SEL的IMP
//        class_replaceMethod(swizzledClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//    } else {
//        // class_addMethod 添加失败则说明：originalClass 已经实现 originalSelector 对应的方法，不能再加了，这里直接交换实现就可以了。
//        //添加失败：说明源SEL已经有IMP，直接将两个SEL的IMP交换即可
//        method_exchangeImplementations(originalMethod, swizzledMethod);
//    }
    
    if (originalClass == swizzledClass) {
        //先尝试給源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况
        BOOL didAddMethod = class_addMethod(originalClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            // class_addMethod 添加成功则说明：originalClass 没有实现 originalSelector 对应的方法，并且将此时已经将 originalSelector 对应实现改成 swizzledMethod 的实现。
            //添加成功：说明源SEL没有实现IMP，将源SEL的IMP替换到交换SEL的IMP
            class_replaceMethod(swizzledClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            // class_addMethod 添加失败则说明：originalClass 已经实现 originalSelector 对应的方法，不能再加了，这里直接交换实现就可以了。
            //添加失败：说明源SEL已经有IMP，直接将两个SEL的IMP交换即可
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    } else {
        //先尝试給源SEL添加IMP，这里是为了避免源SEL没有实现IMP的情况
        BOOL hasMethod = class_addMethod(originalClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (hasMethod) {
            // class_addMethod 添加成功则说明：originalClass 没有实现 originalSelector 对应的方法，并且将此时已经将 originalSelector 对应实现改成 swizzledMethod 的实现。
            //添加成功：说明源SEL没有实现IMP，将源SEL的IMP替换到交换SEL的IMP
            class_replaceMethod(swizzledClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            // class_addMethod 添加失败则说明：originalClass 已经实现 originalSelector 对应的方法，不能再加了，这里直接交换实现就可以了。
            BOOL didAddMethod = class_addMethod(originalClass,
                                                swizzledSelector,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod));

            if (didAddMethod) {
                if (isInstanceMethod) {
                    swizzledMethod = class_getInstanceMethod(originalClass, swizzledSelector);
                } else {
                    swizzledMethod = class_getClassMethod(originalClass, swizzledSelector);
                }
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        }
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
