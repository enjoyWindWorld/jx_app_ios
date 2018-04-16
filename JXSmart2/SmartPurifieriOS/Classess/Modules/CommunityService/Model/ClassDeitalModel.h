//
//  ClassDeitalModel.h
//  SmartPurifieriOS
//
//  Created by yuan on 2016/12/8.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPBaseModel.h"

@interface ClassDeitalModel : SPBaseModel
@property (nonatomic,copy) NSString *classID;

@property (nonatomic,copy) NSString *content;

@property (nonatomic,copy) NSString *className;

@property (nonatomic,assign) long btnTag;

@property (nonatomic,copy) NSString *imgurl;

-(BOOL)saveClassDeitalModel;
-(BOOL)delClassDeitalModel;
+(ClassDeitalModel*)getClassDeitalModel;


@end
