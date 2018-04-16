//
//  ServiceModel.h
//  SmartPurifieriOS
//
//  Created by yuan on 2016/12/6.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPBaseModel.h"

@interface ServiceModel : SPBaseModel
@property (nonatomic,copy) NSString *address;       //地址
@property (nonatomic,copy) NSString *content;       //内容
@property (nonatomic,copy) NSString *invildtime;    //无效时间
@property (nonatomic,copy) NSString *distance;      //距离
@property (nonatomic,copy) NSString *traffic;       // 访问量
@property (nonatomic,copy) NSString *url;           //图片地址
@property (nonatomic,copy) NSString *vaildtime;     // 开始时间
@property (nonatomic,copy) NSString *inquiries;     //咨询量
@property (nonatomic,copy) NSString *phoneNum;      //电话
@property (nonatomic,copy) NSString *name;          //商家名称
@property (nonatomic,copy) NSString *pub_addtime;
@property (nonatomic,copy) NSString * pubName ;

@property (nonatomic,copy) NSString * merchantlong ;
@property (nonatomic,copy) NSString * merchantlat ;

@property (nonatomic,copy) NSString *pubId;
@property (nonatomic,copy) NSString *seller;
@property (nonatomic,copy) NSString * pubid ;
@property (nonatomic,copy) NSString *typenamestr;



@end
