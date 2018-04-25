//
//  SPUserModel.m
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/28.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPUserModel.h"

#define SPUserInfmation @"JXpartnerModel"

@implementation SPUserModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"operatorInter":@"operator"};
}

-(BOOL)saveCurrentPartnerModel{

    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self];
    
    if (data) {
        
        NSUserDefaults * defa = [NSUserDefaults standardUserDefaults];
        
        [defa setObject:data forKey:SPUserInfmation];
        
        return [defa synchronize];
    }
    return NO;
}

+(BOOL)delCurrentPartnerModel{

    [[NSUserDefaults  standardUserDefaults] removeObjectForKey:SPUserInfmation];
    
    return [[NSUserDefaults standardUserDefaults]synchronize];
}

+(SPUserModel*)fetchPartnerModelDF{

    NSData * user = [[NSUserDefaults standardUserDefaults] objectForKey:SPUserInfmation];
    
    if (user) {
        
        SPUserModel * model = [NSKeyedUnarchiver unarchiveObjectWithData:user];
        
        return model;
    }
    return nil;
}



@end
