//
//  NSString+HGUI.m
//  HGOrderingMerchant
//
//  Created by Tianbiao Wang on 17/8/30.
//  Copyright © 2017年 Tianbiao Wang. All rights reserved.
//

#import "NSString+HGUI.h"
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonDigest.h>


#define MD5_CHAR_TO_STRING_16 [NSString stringWithFormat:               \
@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",    \
result[0], result[1], result[2], result[3],                             \
result[4], result[5], result[6], result[7],                             \
result[8], result[9], result[10], result[11],                           \
result[12], result[13], result[14], result[15]]

@implementation NSString (HGUI)
//32位随机字符串生成
+ (NSString *)createUUID
{
    // Create universally unique identifier (object)
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
    // Get the string representation of CFUUID object.
    CFStringRef uuidString= CFUUIDCreateString(kCFAllocatorDefault, uuidObject);
    CFUUIDGetUUIDBytes(uuidObject);
    CFRelease(uuidObject);
    NSString *uuid = [[(__bridge NSString *)uuidString stringByReplacingOccurrencesOfString:@"-" withString:@""] lowercaseString];
    CFRelease(uuidString);
    return uuid;
}

+ (NSString *)base64EncodedStringFromString:(NSString *)string
{
    NSData *data = [NSData
                    dataWithBytes:[string UTF8String]
                    length:[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger length = [data length];
    NSMutableData *mutableData =
    [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    
    uint8_t *input = (uint8_t *) [data bytes];
    uint8_t *output = (uint8_t *) [mutableData mutableBytes];
    
    for (NSUInteger i = 0; i < length; i += 3) {
        NSUInteger value = 0;
        for (NSUInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        static uint8_t const kAFBase64EncodingTable[] =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        
        NSUInteger idx = (i / 3) * 4;
        output[idx + 0] = kAFBase64EncodingTable[(value >> 18) & 0x3F];
        output[idx + 1] = kAFBase64EncodingTable[(value >> 12) & 0x3F];
        output[idx + 2] = (i + 1) < length
        ? kAFBase64EncodingTable[(value >> 6) & 0x3F]
        : '=';
        output[idx + 3] = (i + 2) < length
        ? kAFBase64EncodingTable[(value >> 0) & 0x3F]
        : '=';
    }
    
    return [[NSString alloc] initWithData:mutableData
                                 encoding:NSASCIIStringEncoding];
}

+ (NSString *)base64EncodedString:(NSString *)string
{
    NSData *encodeData = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [encodeData base64EncodedStringWithOptions:0];
}

+ (NSString *)NowDateTimestamp
{
    NSDate *date = [NSDate date];
    NSTimeInterval time = [date timeIntervalSince1970];
    NSString *str = [NSString stringWithFormat:@"%lld",(long long)time];
    return str;
}

- (id)MD5
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return MD5_CHAR_TO_STRING_16;
}


- (NSString *)mobileSecurity {
    
    NSString *mobile = self;
    NSString *string3;
    if (mobile.length>=7) {
        
        NSString *string1 = [mobile substringToIndex:3];
        NSString *string2 = mobile.length == 7 ? @"" : [mobile substringFromIndex:7];
        string3 = [NSString stringWithFormat:@"%@＊＊＊＊%@",string1,string2];
    }else{
        
        string3 = mobile;
    }
    
    return string3;

}

@end
