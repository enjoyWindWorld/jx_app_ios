//
//  SPUserModel.m
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/28.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPUserModel.h"

#define SPUserInfmation @"SPUserInfmationKey"

@implementation SPUserModel

-(NSString *)nickname{

    if (_nickname.length==0) {
        
        return @"未设置昵称";
    }

    return _nickname ;
}

-(NSString *)sign{

    if (_sign.length==0) {
        
        return @"未设置签名";
    }
    
    return _sign ;
}

-(NSString *)sexstring{

    if (_sex==0) {
        
        return @"女";
   
    }else if (_sex==1) {
        
        return @"男";
    }else{
    
        return @"保密";
    }

}

/** 保存 */
-(BOOL)saveUserLoginModel{

    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self];
    
    if (data) {
        
        NSUserDefaults * defa = [NSUserDefaults standardUserDefaults];
        
        [defa setObject:data forKey:SPUserInfmation];
        
        return [defa synchronize];
    }
    return NO;
}
/** 删除 */
-(BOOL)delUserLoginModel{

    [[NSUserDefaults  standardUserDefaults] removeObjectForKey:SPUserInfmation];
    
    return [[NSUserDefaults standardUserDefaults]synchronize];

}
/** 获取 */
+(SPUserModel*)getUserLoginModel{

    NSData * user = [[NSUserDefaults standardUserDefaults] objectForKey:SPUserInfmation];

    if (user) {
        
        SPUserModel * model = [NSKeyedUnarchiver unarchiveObjectWithData:user];
        
        return model;
    }
    return nil;
}

@end
