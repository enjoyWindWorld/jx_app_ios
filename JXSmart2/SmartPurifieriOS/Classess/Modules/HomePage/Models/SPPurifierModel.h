//
//  SPPurifierModel.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/18.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseModel.h"


@interface SPProducePayTypePriceModel : SPBaseModel

@property (nonatomic,assign)NSInteger paytype ;

@property (nonatomic,copy) NSString * price ;

@property (nonatomic,copy) NSString * pay_pledge ; //押金

@property (nonatomic,assign) BOOL isSelect ;

-(NSString*)fetchPayTypeName;


@end

@interface SPProduceColorModel : SPBaseModel

@property (nonatomic,copy) NSString * url ;

@property (nonatomic,copy) NSString * pic_color ;

@property (nonatomic,copy) NSString * tone ;

@property (nonatomic,assign) BOOL isSelect ;

@end

/**
 净水器数据模型
 */
@interface SPPurifierModel : SPBaseModel

 /** 产品标示 */
@property (nonatomic, copy) NSString* dataIdentifier;

/**  产品毛重 */
@property (nonatomic,copy) NSString* PROD_WX ;

/**  型号 */
@property (nonatomic,copy) NSString* dataTypename;

/**  净水流量 */
@property (nonatomic,copy) NSString* PROD_HL ;

/**  环境温度 */
@property (nonatomic,copy) NSString* PROD_C ;

/**  过滤方式 */
@property (nonatomic,copy) NSString* PROD_FL ;

/**  出水水质 */
@property (nonatomic,copy) NSString* PROD_IW ;

/**  产品尺寸 */
@property (nonatomic,copy) NSString* PROD_SZ;

/**  进水压力 */
@property (nonatomic,copy) NSString* PROD_MPA ;

/**  适用水范围 */
@property (nonatomic,copy) NSString* PROD_WT ;

/**  包装尺寸 */
@property (nonatomic,copy) NSString* PROD_SZI ;

/**  额定电压/频率 */
@property (nonatomic,copy) NSString* PROD_HZ ;

/**  金额 */
//@property (nonatomic,copy) NSString * yearfee;

/**  加热功率 */
@property (nonatomic,copy) NSString* PROD_W ;

/**  产品净重 */
@property (nonatomic,copy) NSString* PROD_WD ;

/**  净水器名称 */
@property (nonatomic,copy) NSString* name;

@property (nonatomic,strong) NSArray * colorArr;

@property (nonatomic,strong) NSArray * PricceArr;

@property (nonatomic,assign) ClarifierCostType  costType;





@end
