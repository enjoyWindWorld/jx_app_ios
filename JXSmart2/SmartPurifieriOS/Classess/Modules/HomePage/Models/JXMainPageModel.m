//
//  JXMainPageModel.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/25.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXMainPageModel.h"


@implementation JXMainAdvModel

@end

@implementation JXMainPageModel

+(NSDictionary *)mj_objectClassInArray{

    return @{@"home_page":[JXMainAdvModel class],@"ranking_list":[JXMainAdvModel class]};
    
}

@end
