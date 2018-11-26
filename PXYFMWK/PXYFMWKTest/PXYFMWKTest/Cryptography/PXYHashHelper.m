//
//  PXYHashHelper.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2018/10/16.
//  Copyright © 2018 Pengxuyuan. All rights reserved.
//

#import "PXYHashHelper.h"


@implementation PXYHashHelper

#pragma mark - MD5
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



#pragma mark - SHA 相关
/**
 字符串 SHA1 摘要算法
 */
+ (NSString *)SHA1EncryptWithString:(NSString *)originString {
    if (originString == nil) return @"";
    NSData *stringData = [originString dataUsingEncoding:NSUTF8StringEncoding];
    return [self SHA1EncryptWithData:stringData];
}

/**
 Data SHA1 摘要算法
 */
+ (NSString *)SHA1EncryptWithData:(NSData *)originData {
    if (originData == nil) return @"";
    char *bytes = (char *)[originData bytes];
    uint32_t lenght = (uint32_t)originData.length;
    return [self SHAEncryptWithBytes:bytes length:lenght flag:CC_SHA1_DIGEST_LENGTH];
}


#pragma mark - Private Methods
+ (NSString *)MD5EncryptWithBytes:(char *)bytes length:(uint32_t)length {
    const char *originStr = bytes;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(originStr, length, buffer);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [hash appendFormat:@"%02X", buffer[i]];
    }
    
    //    return [hash lowercaseString];
    return hash;
}

+ (NSString *)SHAEncryptWithBytes:(char *)bytes length:(uint32_t)length flag:(NSInteger)flag{
    const char *originStr = bytes;
    uint8_t buffer[flag];
    switch (flag) {
        case CC_SHA1_DIGEST_LENGTH:
            CC_SHA1(originStr, length, buffer);
            break;
        case CC_SHA224_DIGEST_LENGTH:
            CC_SHA224(originStr, length, buffer);
            break;
        case CC_SHA256_DIGEST_LENGTH:
            CC_SHA256(originStr, length, buffer);
            break;
        case CC_SHA384_DIGEST_LENGTH:
            CC_SHA384(originStr, length, buffer);
            break;
        case CC_SHA512_DIGEST_LENGTH:
            CC_SHA512(originStr, length, buffer);
            break;
        default:
            CC_SHA1(originStr, length, buffer);
            break;
    }
    
    NSMutableString *sha = [NSMutableString string];
    for (int i = 0; i < flag; i++)
    {
        [sha appendFormat:@"%02X", buffer[i]];
    }
    return sha;
}


/*
 1. X 表示以十六进制形式输出
 %02X 表示不足两位，前面补0输出；如果超过两位，则实际输出
 而如果直接写为 %2X，数据不足两位时，实际输出，即不额外补0输出； 如果超过两位，则实际输出。
 
 2. MD5 16 位就是取 32 中间的 16 位，去掉前8后8
 
 3. CCHmac 用来计算 HMAC 加密，#import <CommonCrypto/CommonHMAC.h>，解决固定盐的问题
 
 4. SHA:SHA1 SHA224 SHA256 SHA384 SHA512,传入不用的长度就可以了
 
 */

@end
