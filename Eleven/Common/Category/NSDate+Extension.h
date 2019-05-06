//
//  NSDate+Extension.h
//  新浪微博
//
//  Created by apple on 15/10/10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

static const unsigned componentFlags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSDayCalendarUnit | NSCalendarUnitDay |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);
#define D_MINUTE	60

@interface NSDate (Extension)
//判断某个时间是否为今年
- (BOOL)isThisYear;

//判断某个时间是否为昨天
- (BOOL)isYesterday;

//判断某个时间是否为前天
- (BOOL)isTheDayBeforeYesterday;

//判断某个时间是否今天
- (BOOL)isToday;

+ (NSDate *)getCurrentAreaDate;

// duration
+ (NSString *)durationBetweenDate1:(NSDate *)date1 andDate2:(NSDate *)date2;
+ (NSInteger)durationTimeBetweenDate1:(NSDate *)date1 andDate2:(NSDate *)date2;
- (BOOL)isLaterThanDate: (NSDate *) aDate;

@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

@end
