//
//  JXSubPartnerModel.m
//  JXPartner
//
//  Created by windpc on 2017/8/17.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXSubPartnerModel.h"

@implementation JXPartnerModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{

    return @{@"par_id":@"id"};
}

@end

@implementation JXSubPartnerModel

+(NSDictionary *)mj_objectClassInArray{

    return @{@"date":[JXPartnerModel class]};
}

@end
