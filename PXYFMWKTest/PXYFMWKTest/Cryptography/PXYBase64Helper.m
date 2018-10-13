//
//  PXYBase64Helper.m
//  PXYFMWKTest
//
//  Created by Pengxuyuan on 2018/10/12.
//  Copyright © 2018 Pengxuyuan. All rights reserved.
//

#import "PXYBase64Helper.h"

@implementation PXYBase64Helper

/**
 String 进行 Base64 编码，转成 NSString
 */
+ (NSString *)stringEncodeBase64WithString:(NSString *)string {
    if (string == nil) return nil;
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [stringData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

/**
 String 进行 Base64 解码，转成 NSString
 */
+ (NSString *)stringDecodeBase64WithString:(NSString *)string {
    if (string == nil) return nil;
    NSData *stringData = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *encodeStr = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    return encodeStr;
}

/**
 NSData 进行 Base64 编码,转成 NSString
 */
+ (NSString *)stringEncodeBase64WithData:(NSData *)data {
    if (data == nil) return nil;
    
    NSData *encodeData = [data base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *encodeStr = [[NSString alloc] initWithData:encodeData encoding:NSUTF8StringEncoding];
    return encodeStr;
}

/**
 NSData 进行 Base64 解码，转成 NSString
 */
+ (NSString *)stringDecodeBase64WithData:(NSData *)data {
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedData:data options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *encodeStr = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
    return encodeStr;
}

/**
 NSData 进行 Base64 编码，转成 Data
 */
+ (NSData *)dataEncodeBase64WithData:(NSData *)data {
    if (data == nil) return nil;
    NSData *encodeData = [data base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodeData;
}

/**
 NSData 进行 Base64 解码，转成 Data
 */
+ (NSData *)dataDecodeBase64WithData:(NSData *)data {
    if (data == nil) return nil;
    NSData *decodeData = [[NSData alloc] initWithBase64EncodedData:data options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return decodeData;
}



@end
