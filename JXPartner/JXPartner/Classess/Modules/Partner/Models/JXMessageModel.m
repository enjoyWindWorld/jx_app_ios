//
//  JXMessageModel.m
//  JXPartner
//
//  Created by windpc on 2017/8/21.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXMessageModel.h"

@implementation JXMessageModel

-(NSString *)message_time{
    
    NSDateFormatter * dataformater = [[NSDateFormatter alloc] init];
    
    [dataformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate * date = [dataformater dateFromString:_message_time];
    
    [dataformater setDateFormat:@"MM-dd HH:mm"];
    
    return [dataformater stringFromDate:date];
}

@end
