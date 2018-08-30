//
//  PXYNSCodingRuntimeHelper.h
//  ImageCorner
//
//  Created by Pengxuyuan on 2018/8/9.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PXYNSCodingRuntime_EncodeWithCoder(Class) \
unsigned int outCount = 0;\
Ivar *ivars = class_copyIvarList([Class class], &outCount);\
for (int i = 0; i < outCount; i++) {\
    Ivar ivar = ivars[i];\
    NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];\
    [aCoder encodeObject:[self valueForKey:key] forKey:key];\
}\
free(ivars);\
\

#define PXYNSCodingRuntime_InitWithCoder(Class)\
if (self = [super init]) {\
    unsigned int outCount = 0;\
    Ivar *ivars = class_copyIvarList([Class class], &outCount);\
    for (int i = 0; i < outCount; i++) {\
        Ivar ivar = ivars[i];\
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];\
        id value = [aDecoder decodeObjectForKey:key];\
        if (value) {\
            [self setValue:value forKey:key];\
        }\
    }\
    free(ivars);\
}\
return self;\
\

/**
 利用 Runtime 实现自动归档 & 解档
 */
@interface PXYRuntimeNSCodingHelper : NSObject

@end
