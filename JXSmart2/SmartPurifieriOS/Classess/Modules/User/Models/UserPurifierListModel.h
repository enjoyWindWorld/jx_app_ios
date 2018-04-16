//
//  UserPurifierListModel.h
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/29.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseModel.h"

@interface UserPurifierListModel : SPBaseModel

 /** 净水机颜色 */
@property (nonatomic,copy) NSString * color ;
 /** 净水机类 */
@property (nonatomic,copy) NSString * name ;
 /** 净水机id（访问滤芯状态需用到） */
@property (nonatomic,copy) NSString * pro_no ;

@property (nonatomic,assign) NSInteger  ord_protypeid ;

@property (nonatomic,copy) NSString * url ;

// 净水器类型 - 我的净水器 还分享而来
@property (nonatomic,assign) NSInteger  type ;

//净水汽的别名
@property (nonatomic,copy) NSString * pro_alias ;


@end
