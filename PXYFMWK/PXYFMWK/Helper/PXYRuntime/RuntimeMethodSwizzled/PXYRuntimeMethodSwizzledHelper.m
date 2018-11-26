//
//  PXYRuntimeMethodSwizzledHelper.m
//  ImageCorner
//
//  Created by Pengxuyuan on 2018/8/10.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import "PXYRuntimeMethodSwizzledHelper.h"
#import <objc/message.h>

@implementation PXYRuntimeMethodSwizzledHelper

void PXY_SwizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
//    Class class = [swizzleClass class];
    
    SEL originalSeletor = originalSelector;
    SEL swizzledSeletor = swizzledSelector;
    
    Method originMethod = class_getInstanceMethod(class, originalSeletor);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSeletor);
    
    BOOL didAddMethod = class_addMethod(class, originalSeletor, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSeletor, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzledMethod);
    }
}

@end
