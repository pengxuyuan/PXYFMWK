//
//  PXYHashHelper.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2018/10/16.
//  Copyright © 2018 Pengxuyuan. All rights reserved.
//

#import "PXYHashHelper.h"
#import <CommonCrypto/CommonDigest.h>


@implementation PXYHashHelper

/**
 字符串 MD5摘要算法
 */
+ (NSString *)MD5EncryptWithString:(NSString *)originString {
    if (originString == nil) return @"";
    NSData *stringData = [originString dataUsingEncoding:NSUTF8StringEncoding];
    return [self MD5EncryptWithData:stringData];
}

/**
 Data MD5摘要算法
 */
+ (NSString *)MD5EncryptWithData:(NSData *)originData {
    if (originData == nil) return @"";
    char *bytes = (char *)[originData bytes];
    uint32_t lenght = (uint32_t)originData.length;
    return [self MD5EncryptWithBytes:bytes length:lenght];
}

/**
 字符串 MD5摘要算法 16位
 */
+ (NSString *)MD516ByteEncryptWithString:(NSString *)originString {
    if (originString == nil) return @"";
    NSData *stringData = [originString dataUsingEncoding:NSUTF8StringEncoding];
    return [self MD516ByteEncryptWithData:stringData];
}

/**
 Data MD5摘要算法  16位
 */
+ (NSString *)MD516ByteEncryptWithData:(NSData *)originData {
    if (originData == nil) return @"";
    char *bytes = (char *)[originData bytes];
    uint32_t lenght = (uint32_t)originData.length;
    NSString *md532Str = [self MD5EncryptWithBytes:bytes length:lenght];
    if (md532Str.length == 32) {
        return [md532Str substringWithRange:NSMakeRange(8, 16)];
    } else {
        return @"";
    }
}

#pragma mark - Private Methods
+ (NSString *)MD5EncryptWithBytes:(char *)bytes length:(uint32_t)length {
    const char *originStr = bytes;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(originStr, length, buffer);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", buffer[i]];
    }
    
//    return [hash lowercaseString];
    return hash;
}



/*
 1. X 表示以十六进制形式输出
 %02X 表示不足两位，前面补0输出；如果超过两位，则实际输出
 而如果直接写为 %2X，数据不足两位时，实际输出，即不额外补0输出； 如果超过两位，则实际输出。
 
 2. MD5 16 位就是取 32 中间的 16 位，去掉前8后8
 
 3. CCHmac 用来计算 HMAC 加密，#import <CommonCrypto/CommonHMAC.h>，解决固定盐的问题
 
 */

@end
