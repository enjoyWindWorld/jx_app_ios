//
//  JXCurrentIncomeDetailModel.h
//  JXPartner
//
//  Created by windpc on 2017/8/24.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "SPBaseModel.h"

@interface JXSubCurrentModel : SPBaseModel

@property (nonatomic,copy) NSString * dataid ;
@property (nonatomic,copy) NSString * number ;
@property (nonatomic,copy) NSString * name ;
@property (nonatomic,assign) CGFloat  money ;
@property (nonatomic,assign) CGFloat  rebates ;


@end

@interface JXCurrentIncomeDetailModel : SPBaseModel

@property (nonatomic,copy) NSString * wall ;            //壁挂式
@property (nonatomic,copy) NSString * vertical ;        //立式
@property (nonatomic,copy) NSString * desktop ;         //台式
@property (nonatomic,copy) NSString * wall_renew ;      //壁挂式续费
@property (nonatomic,copy) NSString * vertical_renew ;  //立式续费
@property (nonatomic,copy) NSString * desktop_renew ;   //台式续费
@property (nonatomic,assign) BOOL ispact ;              //是否按照合同
@property (nonatomic,assign) CGFloat  service_fee;//服务费返利
@property (nonatomic,assign) CGFloat  renewal;  //续费返利renewal
@property (nonatomic,assign) CGFloat  installation ;//安装费返利
@property (nonatomic,assign) CGFloat lower_rebate; //下级返利
@property (nonatomic,assign) NSInteger state ;
@property (nonatomic,copy) NSString * withdrawal_order_no ;   //提现单号
@property (nonatomic,assign) CGFloat  withdrawal_total_amount;//提现总金额
@property (nonatomic,strong) NSArray * direct_subordinates ;
@property (nonatomic,copy) NSString * sales_time ; //提现发起时间

@property (nonatomic,copy) NSString * pay_name ;   //支付宝名称
@property (nonatomic,copy) NSString * pay_account ; //支付宝账号
@property (nonatomic,copy) NSString * user_number ; //提现人编号
@property (nonatomic,assign) CGFloat  buy_combined ; //购买型合计(去押金)
@property (nonatomic,assign) CGFloat  renewal_combined ; //续费型合计(去押金)
@property (nonatomic,assign) CGFloat  wdl_fee ; //返利比例
@property (nonatomic,assign) CGFloat  rwl_install ; //安装费比例
@property (nonatomic,assign) CGFloat by_tkr_rebates ; //下级被提现比例
@property (nonatomic,assign) CGFloat total_money ; //去押金下级总金额

@end
