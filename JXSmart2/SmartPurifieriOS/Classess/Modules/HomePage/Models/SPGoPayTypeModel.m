//
//  SPGoPayTypeModel.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/21.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPGoPayTypeModel.h"

@implementation SPGoPayTypeModel

-(instancetype)initWithIcoName:(NSString*)iconame
                     titlename:(NSString*)titlename
                      isselect:(BOOL)isselect
                          type:(SP_AppPay_Type)type{

    SPGoPayTypeModel * model = [[SPGoPayTypeModel alloc] init];

    model.icoName = iconame ;
    
    model.titleName = titlename;
    
    model.isSelect = isselect;
    
    model.type = type ;
    
    return model;
    
}

@end
