//
//  PXYHashHelper.h
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2018/10/16.
//  Copyright © 2018 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 哈希算法帮助类
 */
@interface PXYHashHelper : NSObject

/**
 字符串 MD5摘要算法 32位
 */
+ (NSString *)MD5EncryptWithString:(NSString *)originString;


/**
 Data MD5摘要算法  32位
 */
+ (NSString *)MD5EncryptWithData:(NSData *)originData;


/**
 字符串 MD5摘要算法 16位
 */
+ (NSString *)MD516ByteEncryptWithString:(NSString *)originString;

/**
 Data MD5摘要算法  16位
 */
+ (NSString *)MD516ByteEncryptWithData:(NSData *)originData;


@end
