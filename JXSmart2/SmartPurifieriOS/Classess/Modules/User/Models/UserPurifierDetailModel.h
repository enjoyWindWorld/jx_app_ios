//
//  UserPurifierDetail.h
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/29.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseModel.h"

@interface UserPurifierDetailModel : SPBaseModel
//
//PRF_PP：PP滤芯。PRF_ACB：颗粒活性炭滤芯。PRF_ADR：黑金吸附滤芯。PRF_RO：RO膜滤芯。PRF_FFR：活性保鲜滤芯。PRF_WFR：弱碱滤芯。

 /** PP滤芯 */
@property (nonatomic,copy) NSString * pp ;
 /** CTO活性炭 */
@property (nonatomic,copy) NSString * cto ;

 /** RO膜滤芯 */
@property (nonatomic,copy) NSString * ro ;
 /** t33活性炭 */
@property (nonatomic,copy) NSString * t33 ;
 /** 弱碱 */
@property (nonatomic,copy) NSString * wfr ;


@end
