//
//  SPClarifierMessageModel.h
//  SmartPurifieriOS
//
//  Created by windpc on 2016/12/16.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseModel.h"


@interface SPClarifierMessageModel : SPBaseModel

@property (nonatomic,copy) NSString * messageid ;

@property (nonatomic,copy) NSString * title ;

@property (nonatomic,copy) NSString * content ;

@property (nonatomic,copy) NSString * nextparams ;

@property (nonatomic,assign) NSInteger type ; //0代表订单到期,1代表交易,2代表绑定,3代表分享

@property (nonatomic,assign) NSInteger isread ;

@property (nonatomic,copy) NSString * message_time ;


@end


