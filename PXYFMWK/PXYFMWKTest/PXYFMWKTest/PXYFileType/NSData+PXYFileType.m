//
//  NSData+PXYFileType.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2018/10/19.
//  Copyright © 2018 Pengxuyuan. All rights reserved.
//

#import "NSData+PXYFileType.h"

@implementation NSData (PXYFileType)

+ (void)fileFormatForFileData:(nullable NSData *)data {
    if (data == nil) return;
    
    uint8_t c;
    [data getBytes:&c length:1];
    NSLog(@"%x",c);
    size_t t = sizeof(c);
    
}

@end
