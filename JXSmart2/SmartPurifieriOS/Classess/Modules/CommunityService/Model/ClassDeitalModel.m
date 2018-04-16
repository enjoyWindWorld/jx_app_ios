//
//  ClassDeitalModel.m
//  SmartPurifieriOS
//
//  Created by yuan on 2016/12/8.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "ClassDeitalModel.h"


@implementation ClassDeitalModel
/** 保存 */
-(BOOL)saveClassDeitalModel{
    
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self];
    
    if (data) {
        
        NSUserDefaults * defa = [NSUserDefaults standardUserDefaults];
        
        [defa setObject:data forKey:@"ClassDeital"];
        
        return [defa synchronize];
    }
    return NO;
}

/** 删除 */
-(BOOL)delClassDeitalModel{
    
    [[NSUserDefaults  standardUserDefaults] removeObjectForKey:@"ClassDeital"];
    
    return [[NSUserDefaults standardUserDefaults]synchronize];
    
}
/** 获取 */
+(ClassDeitalModel*)getClassDeitalModel{
    
    NSData * ClassDeital = [[NSUserDefaults standardUserDefaults] objectForKey:@"ClassDeital"];
    
    if (ClassDeital) {
        
        ClassDeitalModel * model = [NSKeyedUnarchiver unarchiveObjectWithData:ClassDeital];
        
        return model;
    }
    return nil;
}


@end
