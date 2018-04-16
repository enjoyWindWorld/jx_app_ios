//
//  JXCurrentIncomeDetailModel.m
//  JXPartner
//
//  Created by windpc on 2017/8/24.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXCurrentIncomeDetailModel.h"

@implementation JXSubCurrentModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{

    return @{@"dataid":@"id"};
}

@end

@implementation JXCurrentIncomeDetailModel

+(NSDictionary *)mj_objectClassInArray{

    return @{@"direct_subordinates":[JXSubCurrentModel class]};
}

@end
