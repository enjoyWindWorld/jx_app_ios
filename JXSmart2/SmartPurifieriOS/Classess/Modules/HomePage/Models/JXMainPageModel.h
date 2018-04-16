//
//  JXMainPageModel.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/25.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseModel.h"


@interface JXMainAdvModel : SPBaseModel

@property (nonatomic, copy) NSString * adv_imgurl;
@property (nonatomic, copy) NSString * adv_name;
@property (nonatomic,copy)  NSString * pub_id ;

@end



@interface JXMainPageModel : SPBaseModel

@property (nonatomic, strong) NSArray * home_page;
@property (nonatomic, strong) NSArray * ranking_list;

@end


