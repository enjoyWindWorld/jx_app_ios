//
//  NSdateCompare.m
//  SmartPurifieriOS
//
//  Created by yuan on 2016/12/15.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "NSdateCompare.h"

@implementation NSdateCompare

-(void)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay  is in the future");
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"oneDay is in the past");
    }
    //NSLog(@"Both dates are the same");
}

@end
