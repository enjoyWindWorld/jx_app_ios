//
//  SPPurifierModel.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/18.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPPurifierModel.h"

@implementation SPProducePayTypePriceModel

-(NSString*)fetchPayTypeName{

    return self.paytype==0?@"包年购买":@"流量购买";
}

@end

@implementation SPProduceColorModel



@end

@implementation SPPurifierModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{

    return @{@"dataIdentifier":@"id",@"dataTypename":@"typename"};

}




@end
