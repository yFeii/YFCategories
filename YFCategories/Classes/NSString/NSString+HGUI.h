//
//  NSString+HGUI.h
//  HGOrderingMerchant
//
//  Created by Tianbiao Wang on 17/8/30.
//  Copyright © 2017年 Tianbiao Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HGUI)

+ (NSString *)createUUID;

+ (NSString *)base64EncodedStringFromString:(NSString *)string;

+ (NSString *)base64EncodedString:(NSString *)string;

+ (NSString *)NowDateTimestamp;

- (id)MD5;

- (NSString *)mobileSecurity;
@end
