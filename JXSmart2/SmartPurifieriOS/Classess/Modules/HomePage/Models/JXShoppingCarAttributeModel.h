//
//  JXShoppingCarAttributeModel.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/15.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseModel.h"

@interface JXShoppingCarAttributeModel : SPBaseModel

@property (nonatomic, copy)     NSString * color;
@property (nonatomic, copy)     NSString * model;
@property (nonatomic, copy)     NSString * name;
@property (nonatomic, assign)   NSInteger pledge;
@property (nonatomic, copy)     NSString * ppdnum;
@property (nonatomic, assign)   NSInteger price;
@property (nonatomic, assign)   CGFloat totalPrice;
@property (nonatomic, copy)     NSString * url;
@property (nonatomic, copy)     NSString * weight;
@property (nonatomic, copy)     NSString * yearsorflow;

@end
