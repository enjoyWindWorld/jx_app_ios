//
//  SPCityModel.h
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/22.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseModel.h"

@interface SPCityModel : SPBaseModel


/*
 *  城市ID
 */
@property (nonatomic, strong) NSString *cityID;

/*
 *  城市名称
 */
@property (nonatomic, strong) NSString *cityName;

/*
 *  短名称
 */
@property (nonatomic, strong) NSString *shortName;

/*
 *  城市名称-拼音
 */
@property (nonatomic, strong) NSString *pinyin;

/*
 *  城市名称-拼音首字母
 */
@property (nonatomic, strong) NSString *initials;



/**
 获取定位的城市

 @return SPCityModel
 */
+(SPCityModel *)getLocationCityModel;


/**
 删除本地存储的数据

 @return YES
 */
-(BOOL)delLocationCityModel;


/**
 保存定位后的城市

 @return yes
 */
-(BOOL)saveLocationCityModel;


@end

#pragma mark - GYZCityGroup
@interface SPCityGroup : SPBaseModel

/*
 *  分组标题
 */
@property (nonatomic, strong) NSString *groupName;

/*
 *  城市数组
 */
@property (nonatomic, strong) NSMutableArray *arrayCitys;


@end
