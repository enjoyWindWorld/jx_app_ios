//
//  PushBtnModel.h
//  SmartPurifieriOS
//
//  Created by yuan on 2016/12/6.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPBaseModel.h"
@interface PushBtnModel :SPBaseModel

@property (nonatomic,copy) NSString *dataIdentifier;
@property (nonatomic,copy) NSString *menu_name;
@property (nonatomic,copy) NSString *menu_icourl;
@property (nonatomic,assign) BOOL  isSelect ;

-(BOOL)savePushBtnModel;
+(BOOL)delPushBtnModel;
+(PushBtnModel*)getPushBtnModel;

@end
