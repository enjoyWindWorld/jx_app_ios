//
//  NSDate+NSDateExtra.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/15.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "NSDate+NSDateExtra.h"

@implementation NSDate (NSDateExtra)

+(NSDate *)getDateWithDateString:(NSString *)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];//hh与HH的区别:分别表示12小时制,24小时制
    NSDate *confromTimesp = [dateFormatter dateFromString:time];;
    
    return confromTimesp;
}


//NSDtate 转YYYY-MM-dd
+(NSString *)getTimeYYMMDDStringWithDate:(NSDate *)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];//hh与HH的区别:分别表示12小时制,24小时制
    NSString *confromTimespStr = [dateFormatter stringFromDate:time];
    
    return confromTimespStr;
}
//NSDtate 转HH:mm:ss
+(NSString *)getTimeHHmmssStringWithDate:(NSDate *)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:@"HH:mm:ss"];//hh与HH的区别:分别表示12小时制,24小时制
    NSString *confromTimespStr = [dateFormatter stringFromDate:time];
    
    return confromTimespStr;
}


+(NSString *)getConfromWithDateString:(NSString *)time
{
    return [self getConfromWithDateString:time withDateFormat:@"YYYY-MM-dd HH:mm"];
}
+(NSString *)getConfromWithDateString:(NSString *)time withDateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:dateFormat];//hh与HH的区别:分别表示12小时制,24小时制
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[time doubleValue]];
    NSString *confromTimespStr = [dateFormatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}

+(NSString *)getTimeStringWithDateString:(NSString *)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];//hh与HH的区别:分别表示12小时制,24小时制
    NSDate *confromTimesp = [dateFormatter dateFromString:time];
    [dateFormatter setDateFormat:@"YY/MM/dd HH:mm"];//hh与HH的区别:分别表示12小时制,24小时制
    NSString *confromTimespStr = [dateFormatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}
//NSDtate 转YY/MM/dd HH:mm
+(NSString *)getTimeStringWithDate:(NSDate *)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd HH:mm"];//hh与HH的区别:分别表示12小时制,24小时制
    NSString *confromTimespStr = [dateFormatter stringFromDate:time];
    
    return confromTimespStr;
}

#pragma mark- 日期字符串转NSDate
+(NSDate *)getDateWithTimeString:(NSString *)time dateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:dateFormat];//hh与HH的区别:分别表示12小时制,24小时制
    NSDate *confromTimesp = [dateFormatter dateFromString:time];;
    
    return confromTimesp;
}
#pragma mark- NSDate转日期字符串
+(NSString *)getDataTimeStringWithDate:(NSDate *)time dateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:dateFormat];//hh与HH的区别:分别表示12小时制,24小时制
    NSString *confromTimespStr = [dateFormatter stringFromDate:time];
    
    return confromTimespStr;
}

#pragma mark- 将日期字符串转换成想要的日期字符串
+(NSString *)getDateStringWithDateString:(NSString *)time
                        currenDateFormat:(NSString *)currenDateFormat
                              dateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:currenDateFormat];//hh与HH的区别:分别表示12小时制,24小时制
    NSDate *confromTimesp = [dateFormatter dateFromString:time];
    [dateFormatter setDateFormat:dateFormat];//hh与HH的区别:分别表示12小时制,24小时制
    NSString *confromTimespStr = [dateFormatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}

+(NSInteger)getMonth:(NSDate *)date{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSMonthCalendarUnit;
    NSDateComponents* comp = [calendar components:unitFlags fromDate:date];
    return [comp month];
}
+(NSInteger)getYear:(NSDate *)date{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit;
    NSDateComponents* comp = [calendar components:unitFlags fromDate:date];
    return [comp year];
}
+(NSInteger)getDay:(NSDate *)date{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSDayCalendarUnit;
    NSDateComponents* comp = [calendar components:unitFlags fromDate:date];
    return [comp day];
}

+ (NSString *)timeInfoWithDateString:(NSDate *)date {
    
    NSDate *curDate = [NSDate date];
    NSInteger curinterval = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:curDate];
    NSDate *curDate1 = [curDate  dateByAddingTimeInterval: curinterval];
    NSInteger fromeInterval = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:date];
    NSDate *fromeDate = [date  dateByAddingTimeInterval: fromeInterval];
    
    
    NSTimeInterval time = -[fromeDate timeIntervalSinceDate:curDate1];
    NSTimeInterval houseTime = 60*60;
    NSTimeInterval secondsPerDay = 24 * houseTime;
    //假设这是你要比较的date：NSDate *yourDate = ……
    //日历
    
    int month = (int)([self getMonth:curDate] - [self getMonth:date]);
    int year = (int)([self getYear:curDate] - [self getYear:date]);
    int day = (int)([self getDay:curDate] - [self getDay:date]);
    
    //     NSLog(@"\nfromeDate:%@,\ncurDate:%@,\nfromeDay = %d \ncurDay = %d",fromeDate,curDate,[self getDay:date],[self getDay:curDate]);
    
    int retTime = 1.0;
    if (time < houseTime) { // 小于一小时
        if (time<=0) {
            return @"";
        }
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%d分钟前", retTime];
        
    }else if (abs(year) == 0 && abs(month) == 0 && day == 1) {
        
        return @"昨天";
        
    }else if (time < secondsPerDay) {
        // 小于一天，也就是今天
        retTime = (time-600) / houseTime;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%d小时前", retTime];
        
    }else if ((abs(year) == 0 && abs(month) <= 1)
              || (abs(year) == 1 &&
                  [self getMonth:curDate] == 1
                  && [self getMonth:date] == 12)) {
                  // 第一个条件是同年，且相隔时间在一个月内
                  // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
                  int retDay = 0;
                  if (year == 0) {
                      // 同年
                      if (month == 0) {
                          // 同月
                          retDay = day;
                      }
                  }
                  if (retDay <= 0) {
                      // 获取发布日期中，该月有多少天
                      int totalDays = (int)[self numberDaysInMonthOfDate:date];
                      // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
                      retDay = (int)[self getDay:curDate] + (totalDays - (int)[self getDay:date]);
                  }
                  if (retDay>10) {
                      NSDateFormatter *format=[[NSDateFormatter alloc] init];
                      [format setDateFormat:@"yyyy/MM/dd"];
                      return [NSString stringWithFormat:@"%@",[format stringFromDate:date]];
                  }else{
                      return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
                  }
              }else{
                  NSDateFormatter *format=[[NSDateFormatter alloc] init];
                  [format setDateFormat:@"yyyy/MM/dd"];
                  return [NSString stringWithFormat:@"%@",[format stringFromDate:date]];
                  
                  //        if (abs(year) <= 1) {
                  //            if (year == 0) { // 同年
                  //                return [NSString stringWithFormat:@"%d个月前", abs(month)];
                  //            }
                  //            // 隔年
                  //            int month = (int)[self getMonth:curDate];
                  //            int preMonth = (int)[self getMonth:date];
                  //            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                  //                return @"1年前";
                  //            }
                  //            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
                  //        }
                  //
                  //        return [NSString stringWithFormat:@"%d年前", abs(year)];
              }
    return @"";
}

+ (NSString *)timeDayInfoWithDateString:(NSDate *)date {
    
    NSDate *curDate = [NSDate date];
    NSInteger curinterval = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:curDate];
    NSDate *curDate1 = [curDate  dateByAddingTimeInterval: curinterval];
    NSInteger fromeInterval = [[NSTimeZone systemTimeZone] secondsFromGMTForDate:date];
    NSDate *fromeDate = [date  dateByAddingTimeInterval: fromeInterval];
    
    
    NSTimeInterval time = -[fromeDate timeIntervalSinceDate:curDate1];
    NSTimeInterval houseTime = 60*60;
    NSTimeInterval secondsPerDay = 24 * houseTime;
    //假设这是你要比较的date：NSDate *yourDate = ……
    //日历
    
    int month = (int)([self getMonth:curDate] - [self getMonth:date]);
    int year = (int)([self getYear:curDate] - [self getYear:date]);
    int day = (int)([self getDay:curDate] - [self getDay:date]);
    
    //     NSLog(@"\nfromeDate:%@,\ncurDate:%@,\nfromeDay = %d \ncurDay = %d",fromeDate,curDate,[self getDay:date],[self getDay:curDate]);
    
    int retTime = 1.0;
    if (time < houseTime) { // 小于一小时
        if (time<=0) {
            return @"";
        }
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"今天"];
        
    }else if (abs(year) == 0 && abs(month) == 0 && day == 1) {
        
        return @"昨天";
        
    }else if (time < secondsPerDay) {
        // 小于一天，也就是今天
        retTime = (time-600) / houseTime;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"今天"];
        
    }else if ((abs(year) == 0 && abs(month) <= 1)
              || (abs(year) == 1 &&
                  [self getMonth:curDate] == 1
                  && [self getMonth:date] == 12)) {
                  // 第一个条件是同年，且相隔时间在一个月内
                  // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
                  int retDay = 0;
                  if (year == 0) {
                      // 同年
                      if (month == 0) {
                          // 同月
                          retDay = day;
                      }
                  }
                  if (retDay <= 0) {
                      // 获取发布日期中，该月有多少天
                      int totalDays = (int)[self numberDaysInMonthOfDate:date];
                      // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
                      retDay = (int)[self getDay:curDate] + (totalDays - (int)[self getDay:date]);
                  }
                  //                  if (retDay>10) {
                  NSDateFormatter *format=[[NSDateFormatter alloc] init];
                  [format setDateFormat:@"yyyy/MM/dd"];
                  return [NSString stringWithFormat:@"%@",[format stringFromDate:date]];
                  //                  }else{
                  //                      return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
                  //                  }
              }else{
                  NSDateFormatter *format=[[NSDateFormatter alloc] init];
                  [format setDateFormat:@"yyyy/MM/dd"];
                  return [NSString stringWithFormat:@"%@",[format stringFromDate:date]];
                  
                  //        if (abs(year) <= 1) {
                  //            if (year == 0) { // 同年
                  //                return [NSString stringWithFormat:@"%d个月前", abs(month)];
                  //            }
                  //            // 隔年
                  //            int month = (int)[self getMonth:curDate];
                  //            int preMonth = (int)[self getMonth:date];
                  //            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                  //                return @"1年前";
                  //            }
                  //            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
                  //        }
                  //
                  //        return [NSString stringWithFormat:@"%d年前", abs(year)];
              }
    return @"";
}


+ (NSInteger)numberDaysInMonthOfDate:(NSDate *)date_
{
    //    获取发布日期中，该月有多少天
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    NSRange range = [calender rangeOfUnit:NSDayCalendarUnit
                     
                                   inUnit: NSMonthCalendarUnit
                     
                                  forDate: date_];
    
    
    
    return range.length;
    
}

+(NSString*)getComponeWithDateString:(NSString *)time
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setTimeZone:[NSTimeZone systemTimeZone]];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *fromdate1=[format dateFromString:time];
    //    NSLog(@"\ntime :%@",time);
    
    return [self timeInfoWithDateString:fromdate1];
}

@end
