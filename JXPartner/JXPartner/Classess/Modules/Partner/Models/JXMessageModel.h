//
//  JXMessageModel.h
//  JXPartner
//
//  Created by windpc on 2017/8/21.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "SPBaseModel.h"

@interface JXMessageModel : SPBaseModel


@property (nonatomic,copy) NSString * p_name ;
@property (nonatomic,copy) NSString * p_content ;       //内容
@property (nonatomic,copy) NSString * p_title ;         //标题
@property (nonatomic,copy) NSString * message_time ;    //时间
@property (nonatomic,copy) NSString * nextparams ;
@property (nonatomic,copy) NSString * p_id ;            //消息ID
@property (nonatomic,assign)NSInteger p_isread ;        //是否已读  1是已读 0 是未读
@property (nonatomic,assign) NSInteger p_type ;

@property (nonatomic,assign) BOOL selected;

@end
