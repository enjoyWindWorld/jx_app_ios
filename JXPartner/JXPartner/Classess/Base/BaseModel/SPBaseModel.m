//
//  WBaseModel.m
//  MyApp
//
//  Created by Amale on 16/4/27.
//  Copyright © 2016年 Wind. All rights reserved.
//

#import "SPBaseModel.h"


@implementation SPBaseModel

MJCodingImplementation

//MJLogAllIvars

-(id) mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{

    if (property.type.typeClass == [NSString class]) {
        if (oldValue == nil || oldValue == [NSNull null]) {
    
            return @"";
        }else if ([oldValue isKindOfClass:[NSString class]]&& ([oldValue length]<=0 || [oldValue isEqualToString:@"null"])){
            return @"";
        }
    }
    return oldValue;
}



@end
