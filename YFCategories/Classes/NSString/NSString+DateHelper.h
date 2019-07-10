//
//  NSString+DateHelper.h
//  HGOrderingMerchant
//
//  Created by ShiGY on 2017/11/8.
//  Copyright © 2017年 Tianbiao Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DateHelper)

- (NSDate *)dateFromStringWithYearAndMinute;
- (NSDate *)dateFromStringWithPointDate;

- (NSString *)yearMonthDayHourMinuteFormattedString;
- (NSString *)todayAndYesterdayString;
@end
