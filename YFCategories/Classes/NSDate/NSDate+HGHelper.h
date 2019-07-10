//
//  NSDate+HGHelper.h
//  HGOrderingMerchant
//
//  Created by ShiGY on 2017/10/10.
//  Copyright © 2017年 Tianbiao Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HGHelper)

- (NSDate *)zeroOfDate;
- (NSDate *)maxOfDate;
- (NSString*)stringOfDate;
- (NSString*)stringOfDatePart;

- (NSString*)stringOfDateLineAndPoint;
- (NSString*)stringOfDatePartMonthAndHourMinute;
- (NSString*)stringOfDatePartNumFormat;
- (NSString*)stringOfDatePartYearMonthAndHour;
- (NSString*)stringOfDatePartWIthHourAndminute;
- (NSString*)stringOfDatePartWithSlash;
- (NSString*)stringOfPointDate;
- (NSString*)stringOfLineDate;
- (NSString*)stringOfHengDateMonthAndHour;

+ (NSDate *)setYear:(NSUInteger)year;
+ (NSDate *)setYear:(NSUInteger)year month:(NSUInteger)month;
+ (NSDate *)setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
+ (NSDate *)setMonth:(NSUInteger)month day:(NSUInteger)day hour:(NSInteger)hour minute:(NSInteger)minute;
+ (NSDate *)setHour:(NSInteger)hour minute:(NSInteger)minute;
// 传入时间格式dateFormatterStr ep."yyyy-mm-dd" date传入NSDate格式的日期
+ (NSDate *)timeToDateWithFormat:(NSString *)format fromTimeStr:(NSString *)timeStr;
- (NSUInteger)howManyDaysWithMonth;
- (NSString *)todayAndYesterdayString;
- (NSString *)todayAndYesterdayFormatterString;

@end
