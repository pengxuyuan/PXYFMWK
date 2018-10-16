//
//  PXYHashHelper.h
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2018/10/16.
//  Copyright © 2018 Pengxuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

/**
 哈希算法帮助类
 */
@interface PXYHashHelper : NSObject

#pragma mark - MD5 相关
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

#pragma mark - SHA 相关
/**
 字符串 SHA1 摘要算法
 */
+ (NSString *)SHA1EncryptWithString:(NSString *)originString;

/**
 Data SHA1 摘要算法
 */
+ (NSString *)SHA1EncryptWithData:(NSData *)originData;

/**
 SHA 摘要算法, 这个需要传入不同的 flag 就可以计算不同的 SHA
 SHA1 SHA224 SHA256 SHA384 SHA512
 @param bytes 原始数据字节
 @param length 原始数据长度
 @param flag CC_SHA1_DIGEST_LENGTH | CC_SHA224_DIGEST_LENGTH | CC_SHA256_DIGEST_LENGTH | CC_SHA384_DIGEST_LENGTH | CC_SHA512_DIGEST_LENGTH
 @return 摘要后的字符串
 */
+ (NSString *)SHAEncryptWithBytes:(char *)bytes length:(uint32_t)length flag:(NSInteger)flag;


@end
