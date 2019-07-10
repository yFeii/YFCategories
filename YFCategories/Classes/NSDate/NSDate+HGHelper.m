//
//  NSDate+HGHelper.m
//  HGOrderingMerchant
//
//  Created by ShiGY on 2017/10/10.
//  Copyright © 2017年 Tianbiao Wang. All rights reserved.
//

#import "NSDate+HGHelper.h"
#import "NSString+DateHelper.h"

@implementation NSDate (HGHelper)

- (NSDate *)zeroOfDate {
   
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    
    // components.nanosecond = 0 not available in iOS
    NSTimeInterval ts = (double)(int)[[calendar dateFromComponents:components] timeIntervalSince1970];
    return [NSDate dateWithTimeIntervalSince1970:ts];
}

- (NSDate *)maxOfDate {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSString *overDateString = [NSString stringWithFormat:@"%@ 23:59:59",[formatter stringFromDate:self]];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [formatter dateFromString:overDateString];
}

- (NSString*)stringOfDatePart{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM月dd日";
    return [formatter stringFromDate:self];
}

- (NSString*)stringOfDateLineAndPoint{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM.dd";
    return [formatter stringFromDate:self];
}

- (NSString*)stringOfDatePartNumFormat{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM.dd HH:mm";
    return [formatter stringFromDate:self];
}


- (NSString*)stringOfDatePartMonthAndHourMinute{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM月dd日 HH:mm";
    return [formatter stringFromDate:self];
}

- (NSString*)stringOfDatePartYearMonthAndHour{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy.MM.dd HH:mm";
    return [formatter stringFromDate:self];
}

- (NSString*)stringOfDatePartWithSlash{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy/MM/dd";
    return [formatter stringFromDate:self];
}

- (NSString*)stringOfDate{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月dd日";
    return [formatter stringFromDate:self];
}

- (NSString*)stringOfHengDateMonthAndHour{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    return [formatter stringFromDate:self];
}

- (NSString*)stringOfPointDate{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy.MM.dd";
    return [formatter stringFromDate:self];
}

- (NSString*)stringOfLineDate{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    return [formatter stringFromDate:self];
}

- (NSString*) stringOfDatePartWIthHourAndminute{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    return [formatter stringFromDate:self];
}



#pragma mark <picker>

static const NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;

+ (NSDate *)setYear:(NSUInteger)year {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *components = [calendar components:unitFlags fromDate:currentDate];
    [components setYear:year];
    [components setMonth:1];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    NSDate *date = [calendar dateFromComponents:components];
    return date;
}

+ (NSDate *)setYear:(NSUInteger)year month:(NSUInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *components = [calendar components:unitFlags fromDate:currentDate];
    [components setYear:year];
    [components setMonth:month];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    NSDate *date = [calendar dateFromComponents:components];
    return date;
}

+ (NSDate *)setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *components = [calendar components:unitFlags fromDate:currentDate];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    NSDate *date = [calendar dateFromComponents:components];
    return date;
}

+ (NSDate *)setMonth:(NSUInteger)month day:(NSUInteger)day hour:(NSInteger)hour minute:(NSInteger)minute {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *components = [calendar components:unitFlags fromDate:currentDate];
    [components setMonth:month];
    [components setDay:day];
    [components setHour:hour];
    [components setMinute:minute];
    NSDate *date = [calendar dateFromComponents:components];
    return date;
}

+ (NSDate *)setHour:(NSInteger)hour minute:(NSInteger)minute {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *components = [calendar components:unitFlags fromDate:currentDate];
    [components setHour:hour];
    [components setMinute:minute];
    NSDate *date = [calendar dateFromComponents:components];
    return date;
}
+ (NSDate *)timeToDateWithFormat:(NSString *)format fromTimeStr:(NSString *)timeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:timeStr];
}
- (NSUInteger)howManyDaysWithMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    NSUInteger day = range.length;
    return day;
}


- (NSString *)todayAndYesterdayString{
    
    float today = 12 *60 *60;
    
    NSDate *nowDate = [NSDate date];
    NSString *nowStr = [nowDate stringOfDatePartWithSlash];
    nowStr = [NSString stringWithFormat:@"%@ 00:00", nowStr];
    NSDate *zeroDate = [nowStr dateFromStringWithYearAndMinute];
    //当天0点
    
    NSDate *targetDate = self;
    NSDate *lastDate =[NSDate dateWithTimeIntervalSince1970:zeroDate.timeIntervalSince1970 - today];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
    NSDateComponents *lastDayCmp = [calendar components:unitFlags fromDate:lastDate];
    NSDateComponents *todayCmp = [calendar components:unitFlags fromDate:nowDate];
    NSDateComponents *targetCmp = [calendar components:unitFlags fromDate:targetDate];
    NSString *finalStr;
    
    if ([targetCmp day] == [todayCmp day] && [targetCmp year] == [todayCmp year] && [targetCmp month] == [todayCmp month]) {
        
        finalStr = [targetDate stringOfDatePartWIthHourAndminute];
        finalStr = [NSString stringWithFormat:@"%@ %@", @"今天",finalStr];
        return finalStr;
    }
    
    if ([targetCmp day] == [lastDayCmp day] && [targetCmp year] == [lastDayCmp year] && [targetCmp month] == [lastDayCmp month]) {
        
        finalStr = [targetDate stringOfDatePartWIthHourAndminute];
        finalStr = [NSString stringWithFormat:@"%@ %@", @"昨天",finalStr];
        return finalStr;
    }
    finalStr = [targetDate stringOfDatePartMonthAndHourMinute];
    return finalStr;
}

- (NSString *)todayAndYesterdayFormatterString{
    
    float today = 12 *60 *60;
    
    NSDate *nowDate = [NSDate date];
    NSString *nowStr = [nowDate stringOfDatePartWithSlash];
    nowStr = [NSString stringWithFormat:@"%@ 00:00", nowStr];
    NSDate *zeroDate = [nowStr dateFromStringWithYearAndMinute];
    //当天0点
    
    NSDate *targetDate = self;
    NSDate *lastDate =[NSDate dateWithTimeIntervalSince1970:zeroDate.timeIntervalSince1970 - today];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
    NSDateComponents *lastDayCmp = [calendar components:unitFlags fromDate:lastDate];
    NSDateComponents *todayCmp = [calendar components:unitFlags fromDate:nowDate];
    NSDateComponents *targetCmp = [calendar components:unitFlags fromDate:targetDate];
    NSString *finalStr;
    
    if ([targetCmp day] == [todayCmp day] && [targetCmp year] == [todayCmp year] && [targetCmp month] == [todayCmp month]) {
        
        finalStr = [targetDate stringOfDatePartWIthHourAndminute];
        finalStr = [NSString stringWithFormat:@"%@ %@", @"今天",finalStr];
        return finalStr;
    }
    
    if ([targetCmp day] == [lastDayCmp day] && [targetCmp year] == [lastDayCmp year] && [targetCmp month] == [lastDayCmp month]) {
        
        finalStr = [targetDate stringOfDatePartWIthHourAndminute];
        finalStr = [NSString stringWithFormat:@"%@ %@", @"昨天",finalStr];
        return finalStr;
    }
    finalStr = [targetDate stringOfHengDateMonthAndHour];
    return finalStr;
}
@end
