//
//  NSString+Extension.m
//  新浪微博
//
//  Created by apple on 15/10/10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NSString+Extension.h"
#import "NSDate+Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font andMaxW:(CGFloat)maxW
{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}
- (CGSize)sizeWithFont:(UIFont *)font
{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = font;
    return [self sizeWithAttributes:attr];
}

- (NSString *)MD5String
{
    if([self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++) {
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return [NSString stringWithString:outputString];
}

+ (NSString *)changeISO88591StringToUnicodeString:(NSString *)iso88591String
{
    
    NSMutableString *srcString = [[NSMutableString alloc]initWithString:iso88591String];
    [srcString replaceOccurrencesOfString:@"&#x" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [srcString length])];
    
    NSMutableString *desString = [[NSMutableString alloc]init];
    
    NSArray *arr = [srcString componentsSeparatedByString:@";"];
    
    for(int i=0;i<[arr count]-1;i++){
        
        NSString *v = [arr objectAtIndex:i];
        char *c = malloc(3);
        unsigned long value = [self changeHexStringToDecimal:v];
        c[1] = value  &0x00FF;
        c[0] = value >>8 &0x00FF;
        c[2] = '\0';
        [desString appendString:[NSString stringWithCString:c encoding:NSUnicodeStringEncoding]];
        free(c);
    }
    
    return desString;
}
+ (unsigned long)changeHexStringToDecimal:(NSString *)hexString{
    NSData *data = [hexString dataUsingEncoding:NSUTF8StringEncoding];
    unsigned long value = 0;
    size_t dataLen = data.length;
    const Byte *bytes = data.bytes;
    for (size_t i = 0; i < dataLen; ++i) {
        Byte ch = bytes[i];
        Byte num;
        if ('0' <= ch && ch <= '9')
            num = ch - '0';
        else if ('a' <= ch && ch <= 'f')
            num = ch - 'a' + 10;
        else if ('A' <= ch && ch <= 'F')
            num = ch - 'A' + 10;
        else ;
        //非法字符;在这里写上你的错误处理代码
        value = value * 16 + num;
    }
    
    return value;
    
}
+ (NSString *)subStringWithAddress:(NSString *)address subWithProvince:(NSString *)province andsubWithCity:(NSString *)city
{
    NSString *prefix = [NSString stringWithFormat:@"%@%@",province,city];
    NSRange range = [address rangeOfString:prefix];
    return [address substringWithRange:NSMakeRange(range.length, address.length - range.length)];
}
+ (NSMutableAttributedString *)getAttributedStringWithColor:(UIColor *)color withFlagString:(NSString *)flagString withOriginString:(NSString *)originString
{
    NSString *content = [NSString stringWithFormat:@"%@%@",flagString,originString];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:content];
    [str addAttribute:NSForegroundColorAttributeName value:color    range:NSMakeRange(0, flagString.length)];
    return str;
}
+ (NSString *)subStringwithOrigionString:(NSString *)origionString fromSearchString:(NSString *)searchString toReplaceString:(NSString *)replaceString
{
    NSRange range = [origionString rangeOfString:searchString];
    if (range.length) {
        origionString = [origionString substringWithRange:NSMakeRange(range.length, origionString.length - range.length)];
    }
    origionString = [NSString stringWithFormat:@"%@%@",replaceString,origionString];
    return origionString;
}
//高亮提示
+ (NSMutableAttributedString *)stringGetHighlightString:(NSString *)highLightString fromOrigionString:(NSString *)origionString
{
    NSRange range = [origionString rangeOfString:highLightString];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:origionString];
    if (range.length) {
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
    }
    return str;
}
+ (NSString *)stringWithAccurateTimeChangeToBlurryTime:(NSString *)time dateFormat:(NSString *)dateFormat
{
    //
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    //真机调试，转换这种欧美时间,需要设置locale
//    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    fmt.locale = [NSLocale currentLocale];
    NSString *string = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];

    if (dateFormat == nil) {
        fmt.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
    }
    else {
        fmt.dateFormat = dateFormat;
    }

    // 微博创建日期
    NSDate *createDate = [fmt dateFromString:time];
    // 将创建时间转换为当前时区的时间
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:createDate];
    NSDate *localeDate = [createDate dateByAddingTimeInterval:interval];
    //当前时间
    NSDate *now = [NSDate date];
    //日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //计算日期之间的差值
    NSDateComponents *cpms = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    NSString *createDateSting = [NSString stringWithFormat:@"%@",localeDate];
    NSRange range = NSMakeRange(11, 5);
    NSString *HHmm;
    if (localeDate == nil) {
        return @"";
    }
    else {
        HHmm = [createDateSting substringWithRange:range];
    }
    if ([createDate isThisYear]) {
        if ([createDate isYesterday]) {
            return [NSString stringWithFormat:@"昨天 %@",HHmm];
        }
        else if ([createDate isTheDayBeforeYesterday]) {
            return [NSString stringWithFormat:@"前天 %@",HHmm];
        }
        else if([createDate isToday]){
            if (cpms.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前",(long)cpms.hour];
            }else if (cpms.minute >= 1){
                return [NSString stringWithFormat:@"%ld分钟前",(long)cpms.minute];
            }else{
                return @"刚刚";
            }
        }
        else{
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    }else{
        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        return [fmt stringFromDate:createDate];
    }
    return time;
}

//生成订单号
+ (NSString *)stringgenerateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}
+ (UIColor *)stringWithColorSring:(NSString *)colorString
{
    UIColor *color = nil;
    if ([colorString isEqualToString:@"orange"]) {
        color = [UIColor colorWithRed:254.0 / 255.0 green:122.0 / 255.0 blue:14.0 / 255.0 alpha:1.0];
    }else if([colorString isEqualToString:@"green"]){
        color = [UIColor colorWithRed:121.0 / 255.0 green:218.0 / 255.0 blue:111.0 / 255.0 alpha:1.0];
    }else if([colorString isEqualToString:@"blue"]){
        color = [UIColor colorWithRed:51.0 / 255.0 green:153.0 / 255.0 blue:255.0 / 255.0 alpha:1.0];
    }else if([colorString isEqualToString:@"yellow"]){
        color = [UIColor colorWithRed:252.0 / 255.0 green:187.0 / 255.0 blue:40.0 / 255.0 alpha:1.0];
    }else if ([colorString isEqualToString:@"violet"]){
        color = [UIColor colorWithRed:67.0 / 255.0 green:33.0 / 255.0 blue:110.0 / 255.0 alpha:1.0];
    }else if([colorString isEqualToString:@"black"]){
        color = [UIColor colorWithRed:0.0 / 255.0 green:0.0 / 255.0 blue:0.0 / 255.0 alpha:1.0];
    }else if ([colorString isEqualToString:@"deep-green"]){
        color = [UIColor colorWithRed:114.0 / 255.0 green:206.0 / 255.0 blue:58.0 / 255.0 alpha:1.0];
    }else if ([colorString isEqualToString:@"dive-green"]){
        color = [UIColor colorWithRed:0.0 / 255.0 green:220.0 / 255.0 blue:119.0 / 255.0 alpha:1.0];
    }else if ([colorString isEqualToString:@"pink"]){
        color = [UIColor colorWithRed:233.0 / 255.0 green:83.0 / 255.0 blue:108.0 / 255.0 alpha:1.0];
    }else if ([colorString isEqualToString:@"red"]){
        color = [UIColor colorWithRed:238.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0];
    }else if ([colorString isEqualToString:@"gray"]){
        color = [UIColor colorWithRed:204.0 / 255.0 green:204.0 / 255.0 blue:204.0 / 255.0 alpha:1.0];
    }else{
        
    }
    return color;
}
+ (BOOL)stringIsEmpty:(NSString *)aString shouldCleanWhiteSpace:(BOOL)cleanWhiteSpace
{
    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }
    
    if (aString == nil) {
        return YES;
    }
    else if ([aString length] == 0) {
        return YES;
    }
    
    if (cleanWhiteSpace) {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }
    return NO;
}

//获取日期字符串
+ (NSString *)stringWithDate:(NSDate *)date isNeedWeek:(BOOL)isNeedWeek
{
    //获取日期
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger week = [comps weekday];
    NSInteger year=[comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSString *dateStr = [NSString string];
    if (isNeedWeek) {
        dateStr = [NSString stringWithFormat:@"%ld-%02ld-%02ld %@",year,month,day,[arrWeek objectAtIndex:week - 1]];
    }else{
        dateStr = [NSString stringWithFormat:@"%ld-%02ld-%02ld",year,month,day];
    }
    return dateStr;
}

- (NSString *)replaceFirstOccurance:(NSString *)occurance withReplacement:(NSString *)replacement
{
    NSRange rOriginal = [self rangeOfString:occurance];
    if (NSNotFound != rOriginal.location) {
        return [self stringByReplacingCharactersInRange:rOriginal withString:replacement];
    }
    return self;
}

@end
