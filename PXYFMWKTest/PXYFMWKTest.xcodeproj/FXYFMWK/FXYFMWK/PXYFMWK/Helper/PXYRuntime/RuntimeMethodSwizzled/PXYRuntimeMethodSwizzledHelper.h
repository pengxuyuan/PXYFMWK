//
//  PXYRuntimeMethodSwizzledHelper.h
//  ImageCorner
//
//  Created by Pengxuyuan on 2018/8/10.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PXYRuntimeMethodSwizzledHelper : NSObject

void PXY_SwizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector);

@end
