//
//  JXNewsModel.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/30.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseModel.h"

@interface JXNewsModel : SPBaseModel

@property (nonatomic,copy) NSString * news_type_name ;

@property (nonatomic,copy) NSString * news_content ;

@property (nonatomic,copy) NSString * news_url ;

@property (nonatomic,copy) NSString * news_type ;

@end
