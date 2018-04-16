//
//  SPCityModel.m
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/22.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPCityModel.h"


/**
 归档的key

 @param SPCityModel
 @return
 */
#define SPLocationCityKey @"SPLocationCityKey"

@implementation SPCityModel



/**
 获取定位的城市
 
 @return SPCityModel
 */
+(SPCityModel *)getLocationCityModel{

    NSData *userData = [[NSUserDefaults standardUserDefaults]objectForKey:SPLocationCityKey];
    
    if (userData) {
        SPCityModel *model =[NSKeyedUnarchiver unarchiveObjectWithData:userData];
        
        return model;
    }
    return nil;
}


/**
 删除本地存储的数据
 
 @return YES
 */
-(BOOL)delLocationCityModel{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SPLocationCityKey];
    
    return [[NSUserDefaults standardUserDefaults] synchronize];
}


/**
 保存定位后的城市
 
 @return yes
 */
-(BOOL)saveLocationCityModel{
    
    NSData *userData  = [NSKeyedArchiver archivedDataWithRootObject:self];
    
    [[NSUserDefaults standardUserDefaults]setObject:userData forKey:SPLocationCityKey];
    
    return [[NSUserDefaults standardUserDefaults] synchronize];}

@end


@implementation SPCityGroup

- (NSMutableArray *) arrayCitys
{
    if (_arrayCitys == nil) {
        _arrayCitys = [[NSMutableArray alloc] init];
    }
    return _arrayCitys;
}

@end
