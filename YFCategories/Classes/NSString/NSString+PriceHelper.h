//
//  NSString+PriceHelper.h
//  HGOrderingMerchant
//
//  Created by ShiGY on 2017/10/24.
//  Copyright © 2017年 Tianbiao Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PriceHelper)

- (NSString *)securityCardString;
- (NSNumber *)numberFromPriceMultiply100;

- (NSString *)subtractPrice:(NSString *)priceString;
- (NSString *)addingPrice:(NSString *)priceString;
//- (NSString *)multiplyingPrice:(NSString *)priceString;
- (NSString *)multiplyingPrice:(NSString *)priceString needFix2:(BOOL)isFixed;

//舍弃小数点后两位
- (NSString *)multiplyingPriceAbandon2afterPoint:(NSString *)priceString;
@end
