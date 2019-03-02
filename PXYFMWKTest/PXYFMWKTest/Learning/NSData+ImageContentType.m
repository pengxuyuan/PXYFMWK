/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 * (c) Fabrice Aneche
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "NSData+ImageContentType.h"
#if SD_MAC
#import <CoreServices/CoreServices.h>
#else
#import <MobileCoreServices/MobileCoreServices.h>
#endif

// Currently Image/IO does not support WebP
#define kSDUTTypeWebP ((__bridge CFStringRef)@"public.webp")
// AVFileTypeHEIC is defined in AVFoundation via iOS 11, we use this without import AVFoundation
#define kSDUTTypeHEIC ((__bridge CFStringRef)@"public.heic")

#define YY_FOUR_CC(c1,c2,c3,c4) ((uint32_t)(((c4) << 24) | ((c3) << 16) | ((c2) << 8) | (c1)))
#define YY_TWO_CC(c1,c2) ((uint16_t)(((c2) << 8) | (c1)))

@implementation NSData (ImageContentType)

+ (SDImageFormat)sd_imageFormatForImageData:(nullable NSData *)data {
    if (!data) {
        return SDImageFormatUndefined;
    }
    
    // File signatures table: http://www.garykessler.net/library/file_sigs.html
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return SDImageFormatJPEG;
        case 0x89:
            return SDImageFormatPNG;
        case 0x47:
            return SDImageFormatGIF;
        case 0x49:
        case 0x4D:
            return SDImageFormatTIFF;
        case 0x52: {
            if (data.length >= 12) {
                //RIFF....WEBP
                NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
                if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                    return SDImageFormatWebP;
                }
            }
            break;
        }
        case 0x00: {
            if (data.length >= 12) {
                //....ftypheic ....ftypheix ....ftyphevc ....ftyphevx
                NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(4, 8)] encoding:NSASCIIStringEncoding];
                if ([testString isEqualToString:@"ftypheic"]
                    || [testString isEqualToString:@"ftypheix"]
                    || [testString isEqualToString:@"ftyphevc"]
                    || [testString isEqualToString:@"ftyphevx"]) {
                    return SDImageFormatHEIC;
                }
            }
            break;
        }
    }
    return SDImageFormatUndefined;
}

+ (nonnull CFStringRef)sd_UTTypeFromSDImageFormat:(SDImageFormat)format {
    CFStringRef UTType;
    switch (format) {
        case SDImageFormatJPEG:
            UTType = kUTTypeJPEG;
            break;
        case SDImageFormatPNG:
            UTType = kUTTypePNG;
            break;
        case SDImageFormatGIF:
            UTType = kUTTypeGIF;
            break;
        case SDImageFormatTIFF:
            UTType = kUTTypeTIFF;
            break;
        case SDImageFormatWebP:
            UTType = kSDUTTypeWebP;
            break;
        case SDImageFormatHEIC:
            UTType = kSDUTTypeHEIC;
            break;
        default:
            // default is kUTTypePNG
            UTType = kUTTypePNG;
            break;
    }
    return UTType;
}


YYImageType YYImageDetectType(CFDataRef data) {
    if (!data) return YYImageTypeUnknown;
    uint64_t length = CFDataGetLength(data);
    if (length < 16) return YYImageTypeUnknown;
    
    const char *bytes = (char *)CFDataGetBytePtr(data);
    
    uint32_t magic4 = *((uint32_t *)bytes);
    switch (magic4) {
        case YY_FOUR_CC(0x4D, 0x4D, 0x00, 0x2A): { // big endian TIFF
            return YYImageTypeTIFF;
        } break;
            
        case YY_FOUR_CC(0x49, 0x49, 0x2A, 0x00): { // little endian TIFF
            return YYImageTypeTIFF;
        } break;
            
        case YY_FOUR_CC(0x00, 0x00, 0x01, 0x00): { // ICO
            return YYImageTypeICO;
        } break;
            
        case YY_FOUR_CC(0x00, 0x00, 0x02, 0x00): { // CUR
            return YYImageTypeICO;
        } break;
            
        case YY_FOUR_CC('i', 'c', 'n', 's'): { // ICNS
            return YYImageTypeICNS;
        } break;
            
        case YY_FOUR_CC('G', 'I', 'F', '8'): { // GIF
            return YYImageTypeGIF;
        } break;
            
        case YY_FOUR_CC(0x89, 'P', 'N', 'G'): {  // PNG
            uint32_t tmp = *((uint32_t *)(bytes + 4));
            if (tmp == YY_FOUR_CC('\r', '\n', 0x1A, '\n')) {
                return YYImageTypePNG;
            }
        } break;
            
        case YY_FOUR_CC('R', 'I', 'F', 'F'): { // WebP
            uint32_t tmp = *((uint32_t *)(bytes + 8));
            if (tmp == YY_FOUR_CC('W', 'E', 'B', 'P')) {
                return YYImageTypeWebP;
            }
        } break;
            /*
             case YY_FOUR_CC('B', 'P', 'G', 0xFB): { // BPG
             return YYImageTypeBPG;
             } break;
             */
    }
    
    uint16_t magic2 = *((uint16_t *)bytes);
    switch (magic2) {
        case YY_TWO_CC('B', 'A'):
        case YY_TWO_CC('B', 'M'):
        case YY_TWO_CC('I', 'C'):
        case YY_TWO_CC('P', 'I'):
        case YY_TWO_CC('C', 'I'):
        case YY_TWO_CC('C', 'P'): { // BMP
            return YYImageTypeBMP;
        }
        case YY_TWO_CC(0xFF, 0x4F): { // JPEG2000
            return YYImageTypeJPEG2000;
        }
    }
    
    // memcmp()用来比较s1 和s2 所指的内存区间前n 个字符。
    // JPG             FF D8 FF
    if (memcmp(bytes,"\377\330\377",3) == 0) return YYImageTypeJPEG;
    
    // JP2
    if (memcmp(bytes + 4, "\152\120\040\040\015", 5) == 0) return YYImageTypeJPEG2000;
    
    return YYImageTypeUnknown;
}

@end
