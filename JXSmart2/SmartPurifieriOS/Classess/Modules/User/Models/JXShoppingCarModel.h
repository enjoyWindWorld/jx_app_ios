//
//  JXShoppingCarModel.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/15.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseModel.h"


@interface JX_Proid : SPBaseModel

@property (nonatomic,copy) NSString * proid ;

@end

@interface JX_Scname : SPBaseModel

@property (nonatomic,copy) NSString * name ;

@end

@interface JXShoppingCarMainModel : SPBaseModel

@property (nonatomic, strong) NSArray * list;
@property (nonatomic, strong) NSArray * name;
@property (nonatomic, strong) NSArray * proid;

@property (nonatomic,assign) BOOL  isSelect ;

-(NSString*)fetchShoppingCarName;

-(NSString*)fetchShoppingCarProid;

-(CGFloat)fetchShoppingProductMoney;

-(NSInteger)fetchShoppingSelectNumber;

@end

/**
 购物车数据模型
 */
@interface JXShoppingCarModel : SPBaseModel

@property (nonatomic, assign)   NSInteger proid;
@property (nonatomic, assign)   NSInteger ppdnum;
@property (nonatomic, copy)     NSString * color;
@property (nonatomic, assign)   NSInteger sc_id;
@property (nonatomic, copy)     NSString * url;
@property (nonatomic, copy)     NSString * name;
@property (nonatomic, assign)   NSInteger number;
@property (nonatomic, assign)   CGFloat price;
@property (nonatomic, assign)   NSInteger type;
@property (nonatomic, copy)     NSString* userid;
@property (nonatomic, copy)     NSString * model ;
@property (nonatomic, copy)     NSString * weight ;
@property (nonatomic,copy)      NSString * yearsorflow ;
@property (nonatomic,assign)     CGFloat  pledge ;
@property (nonatomic,assign)     CGFloat totalPrice ;

@property (nonatomic,assign) BOOL  isSelect ;

-(NSString*)fetchPayTypeName;



@end
