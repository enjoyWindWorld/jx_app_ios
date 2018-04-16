//
//  SPGoPayTypeModel.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/21.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseModel.h"

@interface SPGoPayTypeModel : SPBaseModel

@property(nonatomic,copy) NSString * icoName;

@property(nonatomic,copy) NSString* titleName ;

@property (nonatomic,assign) BOOL isSelect ;

@property(nonatomic,assign) SP_AppPay_Type type;


-(instancetype)initWithIcoName:(NSString*)iconame
                     titlename:(NSString*)titlename
                      isselect:(BOOL)isselect
                          type:(SP_AppPay_Type)type;

@end
