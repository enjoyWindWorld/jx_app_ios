//
//  PushBtnModel.m
//  SmartPurifieriOS
//
//  Created by yuan on 2016/12/6.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "PushBtnModel.h"

@implementation PushBtnModel


+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"dataIdentifier":@"id"};
    
}
/** 保存 */
-(BOOL)savePushBtnModel{
    
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self];
    
    if (data) {
        
        NSUserDefaults * defa = [NSUserDefaults standardUserDefaults];
        
        [defa setObject:data forKey:@"communityPushBtnModel"];
        
        return [defa synchronize];
    }
    return NO;
}

/** 删除 */
+(BOOL)delUserLoginModel{
    
    [[NSUserDefaults  standardUserDefaults] removeObjectForKey:@"communityPushBtnModel"];
    
    return [[NSUserDefaults standardUserDefaults]synchronize];
    
}
/** 获取 */
+(PushBtnModel*)getPushBtnModel{
    
    NSData * community = [[NSUserDefaults standardUserDefaults] objectForKey:@"communityPushBtnModel"];
    
    if (community) {
        
        PushBtnModel * model = [NSKeyedUnarchiver unarchiveObjectWithData:community];
        
        return model;
    }
    return nil;
}


@end
