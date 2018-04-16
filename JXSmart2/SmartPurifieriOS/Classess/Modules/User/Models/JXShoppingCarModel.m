//
//  JXShoppingCarModel.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/15.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXShoppingCarModel.h"

@implementation JX_Proid

@end

@implementation JX_Scname



@end

@implementation JXShoppingCarMainModel

+(NSDictionary *)mj_objectClassInArray{

    return @{@"list":[JXShoppingCarModel class],@"name":[JX_Scname class],@"proid":[JX_Proid class]};
}

-(NSString*)fetchShoppingCarName{

    JX_Scname * name  = [self.name firstObject];
    
    return name.name;
}

-(NSString*)fetchShoppingCarProid{

    JX_Proid * name  = [self.proid firstObject];
    
    return name.proid;
}

-(CGFloat)fetchShoppingProductMoney{

    __block CGFloat money =  0 ;
    
    [self.list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        JXShoppingCarModel * model = obj;
        
        if (model.isSelect) {
            
            money += model.totalPrice;
        }
    }];
    
    return money;
}

-(NSInteger)fetchShoppingSelectNumber{

    __block NSInteger count = 0;
    
    [self.list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        JXShoppingCarModel * model = obj;
        
        if (model.isSelect) {
            
            count+=1;
        }
        
    }];
    
    return count;
}


@end

@implementation JXShoppingCarModel


-(NSString*)fetchPayTypeName{
    
    return self.type==0?@"包年购买":@"流量购买";
}

@end
