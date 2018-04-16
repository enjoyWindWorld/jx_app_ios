//
//  JXIncomeHistoryModel.h
//  JXPartner
//
//  Created by windpc on 2017/8/24.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "SPBaseModel.h"

#define HIS_LEFT_KEY @"HIS_LEFT_KEY"
#define HIS_RIGHT_KEY @"HIS_RIGHT_KEY"


@interface JXIncomeHistoryModel : SPBaseModel

@property (nonatomic,copy) NSString * user_number ;         //个人编号
@property (nonatomic,copy) NSString * w_id ;                //订单id
@property (nonatomic,copy) NSString * last_modtime ;        //最后更新时间
@property (nonatomic,copy) NSString * withdrawal_order ;    //提现订单号
@property (nonatomic,copy) NSString * withdrawal_reason ;   //失败原因
@property (nonatomic,copy) NSString * pay_account ;         //支付宝账号
@property (nonatomic,copy) NSString * arrive_time ;      /** 到账时间 */
@property (nonatomic,copy) NSString * withdrawal_way ;   /** 支付方式 */
@property (nonatomic,assign) CGFloat withdrawal_amount ;    /** 总金额 */
@property (nonatomic,copy) NSString * real_name ;           //姓名
@property (nonatomic,assign) NSInteger withdrawal_state ;    //状态
@property (nonatomic,copy) NSString * audit_time ;          //审核时间
@property (nonatomic,copy) NSString * add_time ;            //提现发起时间
@property (nonatomic,copy) NSString * pay_name ;            //支付宝账号名


@property (nonatomic,strong) NSArray * viewItemArr ;

@end
