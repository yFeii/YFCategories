//
//  NSString+PriceHelper.m
//  HGOrderingMerchant
//
//  Created by ShiGY on 2017/10/24.
//  Copyright © 2017年 Tianbiao Wang. All rights reserved.
//

#import "NSString+PriceHelper.h"

@implementation NSString (PriceHelper)


- (NSNumber *)numberFromPriceMultiply100{
    
    NSDecimalNumber *number;
    if ([XHTools isStringEmpty:self]) {

       number = [NSDecimalNumber decimalNumberWithString:@"0"];
    }else{
        
        number = [NSDecimalNumber decimalNumberWithString:self];
    }
    
    number = [number decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
    return number;
}

- (NSString *)securityCardString {
    
    NSString *temp = self;
    
    NSInteger securityCount = 3;
    NSInteger currentSecurityCount = 0;
    
    NSString *finalStr = @"";
    
    while (temp.length>4 && currentSecurityCount<securityCount) {
        
        temp = [temp substringFromIndex:4];
        finalStr = [finalStr stringByAppendingString:@"****   "];
        currentSecurityCount++;
    }
    
    finalStr = [finalStr stringByAppendingString:temp];
    return finalStr;
}


- (NSString *)subtractPrice:(NSString *)priceString{
    
    NSNumber *t_self;
    if ([XHTools isStringEmpty:self]) {
        
        t_self = [NSDecimalNumber decimalNumberWithString:@"0"];
    }else{
        
        t_self = [NSDecimalNumber decimalNumberWithString:self];
    }
    
    NSNumber *t_num;
    if ([XHTools isStringEmpty:priceString]) {
        
        t_num = [NSDecimalNumber decimalNumberWithString:@"0"];
    }else{
        
        t_num = [NSDecimalNumber decimalNumberWithString:priceString];
    }

    NSDecimalNumber *tempNum = [NSDecimalNumber decimalNumberWithDecimal:[t_self decimalValue]];
    NSDecimalNumber *targetNum = [NSDecimalNumber decimalNumberWithDecimal:[t_num decimalValue]];
    NSDecimalNumber *result = [tempNum decimalNumberBySubtracting:targetNum];//相减
    return [NSString stringWithFormat:@"%@", result];
}

- (NSString *)addingPrice:(NSString *)priceString{
    
    NSNumber *t_self;
    if ([XHTools isStringEmpty:self]) {
        
        t_self = [NSDecimalNumber decimalNumberWithString:@"0"];
    }else{
        
        t_self = [NSDecimalNumber decimalNumberWithString:self];
    }
    
    NSNumber *t_num;
    if ([XHTools isStringEmpty:priceString]) {
        
        t_num = [NSDecimalNumber decimalNumberWithString:@"0"];
    }else{
        
        t_num = [NSDecimalNumber decimalNumberWithString:priceString];
    }
    NSDecimalNumber *tempNum = [NSDecimalNumber decimalNumberWithDecimal:[t_self decimalValue]];
    NSDecimalNumber *targetNum = [NSDecimalNumber decimalNumberWithDecimal:[t_num decimalValue]];
    NSDecimalNumber *result = [tempNum decimalNumberByAdding:targetNum];
    return [NSString stringWithFormat:@"%@", result];
}

- (NSString *)multiplyingPrice:(NSString *)priceString needFix2:(BOOL)isFixed {
    
    NSNumber *t_self;
    if ([XHTools isStringEmpty:self]) {
        
        t_self = [NSDecimalNumber decimalNumberWithString:@"0"];
    }else{
        
        t_self = [NSDecimalNumber decimalNumberWithString:self];
    }
    
    NSNumber *t_num;
    if ([XHTools isStringEmpty:priceString]) {
        
        t_num = [NSDecimalNumber decimalNumberWithString:@"0"];
    }else{
        
        t_num = [NSDecimalNumber decimalNumberWithString:priceString];
    }
    NSDecimalNumber *tempNum = [NSDecimalNumber decimalNumberWithDecimal:[t_self decimalValue]];
    NSDecimalNumber *targetNum = [NSDecimalNumber decimalNumberWithDecimal:[t_num decimalValue]];
    NSDecimalNumber *result = [tempNum decimalNumberByMultiplyingBy:targetNum];
    if (isFixed) {
        return [NSString stringWithFormat:@"%.2f", [result doubleValue]];
    }
    return [NSString stringWithFormat:@"%@", result];
}

- (NSString *)multiplyingPriceAbandon2afterPoint:(NSString *)priceString  {
    
    NSNumber *t_self;
    if ([XHTools isStringEmpty:self]) {
        
        t_self = [NSDecimalNumber decimalNumberWithString:@"0"];
    }else{
        
        t_self = [NSDecimalNumber decimalNumberWithString:self];
    }
    
    NSNumber *t_num;
    if ([XHTools isStringEmpty:priceString]) {
        
        t_num = [NSDecimalNumber decimalNumberWithString:@"0"];
    }else{
        
        t_num = [NSDecimalNumber decimalNumberWithString:priceString];
    }
    NSDecimalNumber *tempNum = [NSDecimalNumber decimalNumberWithDecimal:[t_self decimalValue]];
    NSDecimalNumber *targetNum = [NSDecimalNumber decimalNumberWithDecimal:[t_num decimalValue]];

    //舍弃后两位
    NSDecimalNumberHandler *handel = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];

    NSDecimalNumber *result = [tempNum decimalNumberByMultiplyingBy:targetNum withBehavior:handel];
    return [NSString stringWithFormat:@"%.2f", result.doubleValue];

}
@end
