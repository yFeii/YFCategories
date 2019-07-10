//
//  NSString+DateHelper.m
//  HGOrderingMerchant
//
//  Created by ShiGY on 2017/11/8.
//  Copyright © 2017年 Tianbiao Wang. All rights reserved.
//

#import "NSString+DateHelper.h"
#import "NSDate+HGHelper.h"

@implementation NSString (DateHelper)

- (NSDate *)dateFromStringWithYearAndMinute {
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    return [outputFormatter dateFromString:self];
}

- (NSDate *)dateFromStringWithPointDate{
  
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy.MM.dd"];
    return [outputFormatter dateFromString:self];
}

- (NSString *)yearMonthDayHourMinuteFormattedString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSDate *date = [self dateFromString];
    
    NSDateFormatter *formatterStr = [[NSDateFormatter alloc] init] ;
    [formatterStr setDateFormat:@"YYYY-MM-dd HH:mm"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSString *res = [formatterStr stringFromDate:date];
    return res;
}

- (NSDate *)dateFromString {
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [outputFormatter dateFromString:self];
}



- (NSString *)todayAndYesterdayString{
    
    float today = 12 *60 *60;

    NSDate *nowDate = [NSDate date];
    NSString *nowStr = [nowDate stringOfDatePartWithSlash];
    nowStr = [NSString stringWithFormat:@"%@ 00:00", nowStr];
    NSDate *zeroDate = [nowStr dateFromStringWithYearAndMinute];
    //当天0点
    
    NSDate *targetDate = [NSDate dateWithTimeIntervalSince1970:self.doubleValue];
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
@end
