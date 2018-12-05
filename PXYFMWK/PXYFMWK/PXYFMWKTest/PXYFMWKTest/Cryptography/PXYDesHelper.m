//
//  PXYDesHelper.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2018/10/11.
//  Copyright © 2018 Pengxuyuan. All rights reserved.
//

#import "PXYDesHelper.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation PXYDesHelper

/**
 *  Des加密
 *
 *  @param string 字符串
 *  @param key    秘钥
 *
 *  @return 加密后的数据
 */
+(NSData *)dataWithDesEncryptString:(NSString *)string withKey:(NSString *)key {
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self dataWithDesEncryptData:data withKey:key];
    return [NSData data];
}

/**
 *  Des加密
 *
 *  @param data 数据
 *  @param key    秘钥
 *
 *  @return 加密后的数据
 */
+(NSData *)dataWithDesEncryptData:(NSData *)data withKey:(NSString *)key {
    
    size_t dataSize = [data length];
    
    const void *vKey = (const void *)[key UTF8String];
    const void *dataByte = [data bytes];
    
    
    void *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = dataSize + kCCBlockSizeDES;
    bufferPtr = malloc(bufferPtrSize);
    
    CCCryptorStatus ccStatus = CCCrypt(kCCEncrypt,
            kCCAlgorithmDES,
            kCCOptionPKCS7Padding,
            vKey,
            kCCKeySizeDES,
            NULL,
            dataByte,
            dataSize,
            bufferPtr,
            bufferPtrSize,
            &movedBytes);
    if (ccStatus == kCCSuccess) {
        NSData *outData = [NSData dataWithBytes:bufferPtr length:movedBytes];
        return outData;
    }
    
    return [NSData data];
}

/**
 *  Des加密,先加密，再做base64编码
 *
 *  @param string 字符串
 *  @param key    秘钥
 *
 *  @return 加密后的字符串
 */
+(NSString *)stringWithDesEncryptString:(NSString *)string withKey:(NSString *)key {
    NSData *data = [self dataWithDesEncryptString:string withKey:key];
    NSData *base64Data = [data base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *outDataStr = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
    return outDataStr;
}

@end
