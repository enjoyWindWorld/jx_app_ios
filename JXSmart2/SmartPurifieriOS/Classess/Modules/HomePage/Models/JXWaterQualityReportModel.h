//
//  JXWaterQualityReportModel.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/7/6.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseModel.h"

@interface JXWaterQuality : SPBaseModel

@property (nonatomic,strong) NSString * water_quality ;

@end

@interface JXCurrent_exponent : SPBaseModel

@property (nonatomic,strong) NSString * current_exponent ;

@end


@interface JXWaterQualityReportModel : SPBaseModel

@property (nonatomic,strong) NSArray * water_quality ;

@property (nonatomic,strong) NSArray * current_exponent ;

@end
