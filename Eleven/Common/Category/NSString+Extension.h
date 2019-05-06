//
//  NSString+Extension.h
//  新浪微博
//
//  Created by apple on 15/10/10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font andMaxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;
- (NSString *)MD5String;
+ (NSString *)changeISO88591StringToUnicodeString:(NSString *)iso88591String;
+ (NSString *)subStringWithAddress:(NSString *)address subWithProvince:(NSString *)province andsubWithCity:(NSString *)city;
+ (NSMutableAttributedString *)getAttributedStringWithColor:(UIColor *)color withFlagString:(NSString *)flagString withOriginString:(NSString *)originString;
+ (NSString *)subStringwithOrigionString:(NSString *)origionString fromSearchString:(NSString *)searchString toReplaceString:(NSString *)replaceString;
+ (NSMutableAttributedString *)stringGetHighlightString:(NSString *)highLightString fromOrigionString:(NSString *)origionString;
+ (NSString *)stringWithAccurateTimeChangeToBlurryTime:(NSString *)time dateFormat:(NSString *)dateFormat;
+ (NSString *)stringgenerateTradeNO;
+ (UIColor *)stringWithColorSring:(NSString *)colorString;
+ (BOOL)stringIsEmpty:(NSString *)aString shouldCleanWhiteSpace:(BOOL)cleanWhiteSpace;
//获取日期字符串
+ (NSString *)stringWithDate:(NSDate *)date isNeedWeek:(BOOL)isNeedWeek;
- (NSString *)replaceFirstOccurance:(NSString *)occurance withReplacement:(NSString *)replacement;

@end
