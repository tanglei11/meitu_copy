//
//  NSDate+Extension.m
//  新浪微博
//
//  Created by apple on 15/10/10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
//判断某个时间是否为今年
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //获得某个时间的年月日时分秒
    NSDateComponents *createDateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowDateCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return createDateCmps.year == nowDateCmps.year;
}
//判断某个时间是否为昨天
- (BOOL)isYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    NSDate *date = [fmt dateFromString:dateStr];
    NSDate *now = [fmt dateFromString:nowStr];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}
//判断某个时间是否为前天
- (BOOL)isTheDayBeforeYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    NSDate *date = [fmt dateFromString:dateStr];
    NSDate *now = [fmt dateFromString:nowStr];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 2;
}
//判断某个时间是否今天
- (BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    return [dateStr isEqualToString:nowStr];
}

+ (NSDate *)getCurrentAreaDate
{
    NSDate *date = [NSDate date];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: date];
    
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    return localeDate;
}

+ (NSCalendar *) currentCalendar
{
    static dispatch_once_t pred;
    static __strong NSCalendar *sharedCalendar = nil;
    
    dispatch_once(&pred, ^{
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    });
    
    return sharedCalendar;
}

#pragma mark - Decomposing Dates

- (NSInteger) nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitHour fromDate:newDate];
    return components.hour;
}

- (NSInteger) hour
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.hour;
}

- (NSInteger) minute
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.minute;
}

- (NSInteger) seconds
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.second;
}

- (NSInteger) day
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.day;
}

- (NSInteger) month
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.month;
}

- (NSInteger) week
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekOfYear;
}

- (NSInteger) weekday
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekday;
}

- (NSInteger) nthWeekday // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekdayOrdinal;
}

- (NSInteger) year
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.year;
}

// duration
+ (NSString *)durationBetweenDate1:(NSDate *)date1 andDate2:(NSDate *)date2
{
    NSInteger hours = 0;
    NSInteger minutes = 0;
    if ([date1 isLaterThanDate:date2]) {
        minutes = [date1 minutesAfterDate:date2];
    }
    else {
        minutes = [date2 minutesAfterDate:date1];
    }
    
    hours = minutes / 60;
    minutes = minutes % 60;
    
    NSLog(@"%ld-------%ld",hours,minutes);
    
    NSString *duration;
    if (hours == 0) {
        duration = [NSString stringWithFormat:@"%d%@", (int)minutes, NSLocalizedString(@"SHORT_MINUTE", nil)];
    }
    else {
        if (minutes == 0) {
            duration = [NSString stringWithFormat:@"%d%@", (int)hours, NSLocalizedString(@"SHORT_HOUR", nil)];
        }
        else {
            duration = [NSString stringWithFormat:@"%d%@%d%@", (int)hours, NSLocalizedString(@"SHORT_HOUR", nil), (int)minutes, NSLocalizedString(@"SHORT_MINUTE", nil)];
        }
    }
    
    return duration;
}

+ (NSInteger)durationTimeBetweenDate1:(NSDate *)date1 andDate2:(NSDate *)date2
{
    NSInteger hours = 0;
    NSInteger minutes = 0;
    if ([date1 isLaterThanDate:date2]) {
        minutes = [date1 minutesAfterDate:date2];
    }
    else {
        minutes = [date2 minutesAfterDate:date1];
    }
    
    hours = minutes / 60;
    minutes = minutes % 60;
    
    NSLog(@"%ld-------%ld",hours,minutes);
    
    NSInteger duration = hours * 60 + minutes;
    
    return duration;
}

- (NSInteger) minutesAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_MINUTE);
}

- (BOOL)isLaterThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}

@end
