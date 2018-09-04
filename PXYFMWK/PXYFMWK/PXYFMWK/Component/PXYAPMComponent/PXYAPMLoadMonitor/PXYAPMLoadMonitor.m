//
//  PXYAPMLoadMonitor.m
//  PXYFMWK
//
//  Created by Pengxuyuan on 2018/9/3.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import "PXYAPMLoadMonitor.h"
#import "NSObject+PXYRuntimeHelper.h"

#import <objc/runtime.h>
#import <dlfcn.h>
#import <mach-o/ldsyms.h>
#include <limits.h>
#include <mach-o/dyld.h>
#include <mach-o/nlist.h>
#include <string.h>

#define TIMESTAMP_NUMBER(interval)  [NSNumber numberWithLongLong:interval*1000*1000]

unsigned int count;
const char **classes;

static NSMutableArray *_loadInfoArray;

@interface PXYAPMLoadMonitor ()

@end

@implementation PXYAPMLoadMonitor

+ (void)load {
//    return;
    NSLog(@"%s",__func__);
    _loadInfoArray = [[NSMutableArray alloc] init];
    
    CFAbsoluteTime time1 =CFAbsoluteTimeGetCurrent();
    
    int imageCount = (int)_dyld_image_count();
    
    for(int iImg = 0; iImg < imageCount; iImg++) {
        
        const char* path = _dyld_get_image_name((unsigned)iImg);
        NSString *imagePath = [NSString stringWithUTF8String:path];
        
        NSBundle* mainBundle = [NSBundle mainBundle];
        NSString* bundlePath = [mainBundle bundlePath];
        
        if ([imagePath containsString:bundlePath] && ![imagePath containsString:@".dylib"]) {
            classes = objc_copyClassNamesForImage(path, &count);
            
            for (int i = 0; i < count; i++) {
                NSString *className = [NSString stringWithCString:classes[i] encoding:NSUTF8StringEncoding];
                if (![className isEqualToString:@""] && className) {
                    Class class = object_getClass(NSClassFromString(className));
                    
                    SEL originalSelector = @selector(load);
                    SEL swizzledSelector = @selector(PXYAPM_Load);
                    
                    [self pxy_swizzleMethodWithOriginalClass:class originalSelector:originalSelector swizzledClass:[PXYAPMLoadMonitor class] swizzledSelector:swizzledSelector];
                    
//                    Method originalMethod = class_getClassMethod(class, originalSelector);
//                    Method swizzledMethod = class_getClassMethod([PXYAPMLoadMonitor class], swizzledSelector);
//
//                    BOOL hasMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
//
//                    if (!hasMethod) {
//                        BOOL didAddMethod = class_addMethod(class,
//                                                            swizzledSelector,
//                                                            method_getImplementation(swizzledMethod),
//                                                            method_getTypeEncoding(swizzledMethod));
//
//                        if (didAddMethod) {
//                            swizzledMethod = class_getClassMethod(class, swizzledSelector);
//
//                            method_exchangeImplementations(originalMethod, swizzledMethod);
//                        }
//                    }
                    
                }
            }
        }
    }
    
    CFAbsoluteTime time2 =CFAbsoluteTimeGetCurrent();
    
    NSLog(@"Hook Time---:%.3f 秒",(time2 - time1));
}

+ (void)PXYAPM_Load {
    CFAbsoluteTime start =CFAbsoluteTimeGetCurrent();
    
    [self PXYAPM_Load];
    
    CFAbsoluteTime end =CFAbsoluteTimeGetCurrent();
    
    NSString *spendTStr = [NSString stringWithFormat:@"%.3f 秒",(end - start)];
    // 时间精度 us
    NSDictionary *infoDic = @{@"st":TIMESTAMP_NUMBER(start),
                              @"et":TIMESTAMP_NUMBER(end),
                              @"name":NSStringFromClass([self class]),
                              @"spendTime":spendTStr
                              };
    NSLog(@"-- %@",infoDic);
    [_loadInfoArray addObject:infoDic];
}



@end
