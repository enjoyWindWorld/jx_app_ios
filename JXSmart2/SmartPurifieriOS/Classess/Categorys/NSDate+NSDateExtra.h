//
//  NSDate+NSDateExtra.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/15.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NSDateExtra)

//日期字符串转NSDate
+(NSDate *)getDateWithDateString:(NSString *)time;


//时间戳转时间
+(NSString *)getConfromWithDateString:(NSString *)time;
+(NSString *)getConfromWithDateString:(NSString *)time withDateFormat:(NSString *)dateFormat;
//timestring返回14/09/12 09:24
+(NSString *)getTimeStringWithDateString:(NSString *)time;
//NSDtate 转YY/MM/dd HH:mm
+(NSString *)getTimeStringWithDate:(NSDate *)time;
//NSDtate 转YY/MM/dd
+(NSString *)getTimeYYMMDDStringWithDate:(NSDate *)time;
+(NSString *)getTimeHHmmssStringWithDate:(NSDate *)time;


//时间转换成多少小时之前，或者今天几小时，或者昨天等
+(NSString*)getComponeWithDateString:(NSString *)time;





+(NSString *)getDataTimeStringWithDate:(NSDate *)time dateFormat:(NSString *)dateFormat;
+(NSDate *)getDateWithTimeString:(NSString *)time dateFormat:(NSString *)dateFormat;
+(NSString *)getDateStringWithDateString:(NSString *)time
                        currenDateFormat:(NSString *)currenDateFormat
                              dateFormat:(NSString *)dateFormat;
/*
 *  根据Date获取当前时间的月份
 */
+(NSInteger)getMonth:(NSDate *)date;
/*
 *  根据Date获取当前时间年份
 */
+(NSInteger)getYear:(NSDate *)date;
/*
 *  根据Date获取当前时间的天
 */
+(NSInteger)getDay:(NSDate *)date;

/*
 *  根据Date获取x分钟前/x小时前/昨天/x天前
 *  已经注释这两个显示(x个月前/x年前)
 */
+ (NSString *)timeInfoWithDateString:(NSDate *)date;

+ (NSString *)timeDayInfoWithDateString:(NSDate *)date;
/*
 *  根据Date获取当前时间的月的天数
 */
+ (NSInteger)numberDaysInMonthOfDate:(NSDate *)date_;

@end
