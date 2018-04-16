//
//  SPUserModel.h
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/28.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseModel.h"

//用户模型
@interface SPUserModel : SPBaseModel

//:[{"userImg":"","sex":0,"nickname":"","imgName":"","address":"","email":""}],"errcode":0,"result":0,"msg":"ok"}

 /** 用户头像 */
@property (nonatomic,copy) NSString * userImg ;

@property (nonatomic,copy) NSString * userid ;

//sex 0女 1男
@property (nonatomic,assign)NSInteger sex ;

@property (nonatomic,copy) NSString * nickname ;

@property (nonatomic,copy) NSString * sign ;

@property (nonatomic,copy) NSString * UserPhone ;

@property (nonatomic,copy) NSString * password ;

@property (nonatomic,copy) NSString * sexstring ;


 /** 查找用户性别 */
-(NSString*)fetchuserSex;


 /** 保存 */
-(BOOL)saveUserLoginModel;
 /** 删除 */
-(BOOL)delUserLoginModel;
 /** 获取 */
+(SPUserModel*)getUserLoginModel;



@end
