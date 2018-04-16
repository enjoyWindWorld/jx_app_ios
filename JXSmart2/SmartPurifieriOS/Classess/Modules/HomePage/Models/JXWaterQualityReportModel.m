//
//  JXWaterQualityReportModel.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/7/6.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXWaterQualityReportModel.h"

@implementation JXWaterQuality

@end

//current_exponent
@implementation JXCurrent_exponent

@end

@implementation JXWaterQualityReportModel

+(NSDictionary *)mj_objectClassInArray{

    return @{@"water_quality":[JXWaterQuality class],@"current_exponent":[JXCurrent_exponent class]};
}

@end
