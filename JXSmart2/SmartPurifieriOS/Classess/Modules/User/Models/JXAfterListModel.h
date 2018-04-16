//
//  JXAfterListModel.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/11/13.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseModel.h"

@interface JXAfterListModel : SPBaseModel

@property (nonatomic,copy) NSString * dataIdentifier ;

@property (nonatomic,assign) NSInteger  fas_state;

@property (nonatomic,assign) NSInteger  fas_type;

@property (nonatomic,copy) NSString * fas_addtime;

@property (nonatomic,copy) NSString * specific_reason ;

@end
