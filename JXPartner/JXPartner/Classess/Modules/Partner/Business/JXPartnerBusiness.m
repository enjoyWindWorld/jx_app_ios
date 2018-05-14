//
//  JXPartnerBusiness.m
//  JXPartner
//
//  Created by windpc on 2017/8/14.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXPartnerBusiness.h"
#import "OrderLitModel.h"
#import "OrderDetailModel.h"
#import "JXSubPartnerModel.h"
#import "JXBindingAliStateModel.h"
#import "JXMessageModel.h"
#import "SPUserModel.h"
#import "JXCurrentIncomeDetailModel.h"
#import "JXIncomeHistoryModel.h"
#import "JXPlanFilterLifeModel.h"
#import "JXAfterListModel.h"
#import "JXNewAfterSalesModel.h"
#import "JXEvaluateModel.h"
#import "JXNewsModel.h"

@implementation JXPartnerBusiness

/**
 获取登录信息
 
 @param param
 @param successBlock
 @param failer
 */
-(void)fetchPartnerInformation:(NSDictionary*)param
                       success:(BusinessSuccessBlock)successBlock
                        failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_FetchPartnerInformation didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSArray * modelArr = [SPUserModel mj_objectArrayWithKeyValuesArray:response];
            
            if (modelArr.count>0) {
                
                SPUserModel * user = modelArr[0] ;
                
                if (successBlock) {
                    
                    successBlock(user);
                }
            }
        }else{
            
            if (failer) {
                failer(@"数据错误");
            }
        }
        
    } didFailed:^(NSString *errorMsg) {
        if (failer) {
            failer(errorMsg);
        }
        
    }];

}

-(void)fetchHomePageNewsList:(NSDictionary*)param
                    succcess:(BusinessSuccessBlock)success
                     failere:(BusinessFailureBlock)failere{
    
    NSString * url =[NSString stringWithFormat:@"%@:%@/%@/%@",SmartPurifierHostURL,@"8080",@"jx_smart",HomePageNewsList];
    
    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:url didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSArray * conentArr  = [JXNewsModel mj_objectArrayWithKeyValuesArray:response];
            
            if (success) {
                
                success(conentArr);
            }
        }else{
            
            failere(BUSINESSDATAERR);
        }
    } didFailed:^(id error) {
        
        if (failere) {
            failere(error);
        }
    }];
    
    
}


/**
 获取订单列表
 
 @param param 参数
 @param successBlock 成功
 @param failer 失败
 */
-(void)fetchPartnerOrderList:(NSDictionary*)param
                     success:(BusinessSuccessBlock)successBlock
                      failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_FETCHPARTNERORDERLIST didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSArray * listModel  = [OrderLitModel mj_objectArrayWithKeyValuesArray:response];
            
            if (successBlock) {
                
                successBlock (listModel);
            }
            
        }else{
            
            if (failer) {
                failer(BUSINESSDATAERR);
            }
        }
    } didFailed:^(id error) {
        
        if (failer) {
          
            failer(error);
        }
        
    }];
    
    
}


/**
 获取订单详情
 
 @param param 参数
 @param successBlock 成功
 @param failer 失败
 */
-(void)fetchPartnerOrderDetail:(NSDictionary*)param
                       success:(BusinessSuccessBlock)successBlock
                        failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:URL_FETCHPARTNERORDERDETAIL didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]] || response !=nil) {
            NSArray * listModel  = [OrderDetailModel mj_objectArrayWithKeyValuesArray:response];
            
            if (successBlock) {
                successBlock(listModel);
            }
            
        }else{
            
            if (failer) {
                failer(BUSINESSDATAERR);
            }
            
        }
        
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];

}


/**
 获取我的下属
 
 @param param 参数
 @param successBlock 成功
 @param failer 失败
 */
-(void)fetchPartnerSublist:(NSDictionary*)param
                   success:(BusinessSuccessBlock)successBlock
                    failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_FETCHPARNERSUBLIST didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSArray * dataArr = response ;
            
            NSDictionary * dic = [dataArr firstObject];
            
            JXSubPartnerModel * model = [JXSubPartnerModel mj_objectWithKeyValues:dic];
            
            if (successBlock) {
                
                successBlock(model);
            }
            
        }else{
            
            if (failer) {
                failer(BUSINESSDATAERR);
            }
            
        }
        
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];
    
}

/**
 我的下属订单列表
 
 @param param
 @param successBlock
 @param failer
 */
-(void)fetchPartnerSubOrderlist:(NSDictionary*)param
                        success:(BusinessSuccessBlock)successBlock
                         failer:(BusinessFailureBlock)failer{
   
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_FetchParnerSubOrderList didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSArray * listModel  = [OrderLitModel mj_objectArrayWithKeyValuesArray:response];
            
            if (successBlock) {
                
                successBlock(listModel);
            }
            
        }else{
            
            if (failer) {
                failer(BUSINESSDATAERR);
            }
            
        }
        
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];
    
}


/**
 获取支付宝信息接口
 
 @param param 参数
 @param successBlock 成功
 @param failer 失败
 */
-(void)fetchBindingAliInformation:(NSDictionary*)param
                       success:(BusinessSuccessBlock)successBlock
                        failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_FetchAliInfo didSuccess:^(id response) {
        
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            JXBindingAliStateModel * model = [JXBindingAliStateModel mj_objectWithKeyValues:[response firstObject]];
  
            if (successBlock) {
                
                successBlock(model);
            }
            
        }else{
            
            if (failer) {
                failer(BUSINESSDATAERR);
            }
            
        }
        
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];
    
    
}


/**
 绑定支付宝
 
 @param param 参数
 @param successBlock 成功
 @param failer 失败
 */
-(void)bindingAliInformation:(NSDictionary*)param
             success:(BusinessSuccessBlock)successBlock
              failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_BindingAliAct didSuccess:^(id response) {
        
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            JXBindingAliStateModel * model = [JXBindingAliStateModel mj_objectWithKeyValues:[response firstObject]];
            
            if (successBlock) {
                
                successBlock(model);
            }
            
        }else{
            
            if (failer) {
                failer(BUSINESSDATAERR);
            }
            
        }
        
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];
    
}


/**
 解绑支付宝信息
 
 @param param 参数
 @param successBlock 成功
 @param failer 失败
 */
-(void)unbundlingAliInformation:(NSDictionary*)param
                   success:(BusinessSuccessBlock)successBlock
                    failer:(BusinessFailureBlock)failer{


    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_UnBoodingAliAct didSuccess:^(id response) {
        
        
        if (successBlock) {
            
            successBlock(response);
        }
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];
}

/** 查找消息列表 */
-(void)fetchPartnerMessageList:(NSDictionary*)param
                       success:(BusinessSuccessBlock)successBlock
                        failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_FetchPartnerMessageList didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSArray * message = [JXMessageModel mj_objectArrayWithKeyValuesArray:response];
            
            if (successBlock) {
                
                successBlock(message);
            }
            
            
        }else{
        
            failer(BUSINESSDATAERR);
            
        }
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];
}

/** 删除消息 */
-(void)fetchPartnerMessageDelete:(NSDictionary*)param
                         success:(BusinessSuccessBlock)successBlock
                          failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_FetchPartnerMessageDelete didSuccess:^(id response) {
        
        
        if (successBlock) {
            
            successBlock(response);
        }
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];
}
/** 设置已读 */
-(void)fetchPartnerMessageSetReaded:(NSDictionary*)param
                            success:(BusinessSuccessBlock)successBlock
                             failer:(BusinessFailureBlock)failer{
    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_FetchPartnerMessageSetReaded didSuccess:^(id response) {
        
        
        if (successBlock) {
            
            successBlock(response);
        }
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];
    
}
/** 统计未读数量 */
-(void)fetchPartnerMessageListCount:(NSDictionary*)param
                            success:(BusinessSuccessBlock)successBlock
                             failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_FetchPartnerMessageListCount didSuccess:^(id response) {
        
        if (successBlock) {
            
            successBlock([response firstObject][@"number"]);
        }
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];
    
}

/** 提现记录 */
-(void)fetchTiXianHistory:(NSDictionary*)param
                  success:(BusinessSuccessBlock)successBlock
                   failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_FetchTiXianHistory didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSArray * hisArr = [JXIncomeHistoryModel mj_objectArrayWithKeyValuesArray:response];
            
            if (successBlock) {
                
                successBlock(hisArr);
            }
            
        }else{
        
            failer(BUSINESSDATAERR);
            
        }
        
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];
}

/** 提现发起 */
-(void)fetchTiXianRequestAdd:(NSDictionary*)param
                     success:(BusinessSuccessBlock)successBlock
                      failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_FetchTiXianRequestAdd didSuccess:^(id response) {
        
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            if (successBlock) {
                
                successBlock(response);
            }

            
        }else{
        
            failer(BUSINESSDATAERR);
        }
        
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];
}

/** 提现项 */
-(void)fetchTiXianSaleItem:(NSDictionary*)param
                   success:(BusinessSuccessBlock)successBlock
                    failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_FetchTiXianItem didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            JXCurrentIncomeDetailModel * model = [JXCurrentIncomeDetailModel mj_objectWithKeyValues:[response firstObject]];
            
            if (successBlock) {
                
                successBlock(model);
            }
    
        }else{
            
            failer(BUSINESSDATAERR);
        }
        

    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];
}


-(void)fetchTiXianSalesAllMoney:(NSDictionary*)param
                        success:(BusinessSuccessBlock)successBlock
                         failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_FetchTiXianMoney didSuccess:^(id response) {
        
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            if (successBlock) {
                
                successBlock([response firstObject]);
            }
            
        }else{
            
            failer(BUSINESSDATAERR);
        }
    } didFailed:^(id error) {
        
        if (failer) {
         
            failer(error);
        }
    }];
    
}


/** 获取提现比例 */
-(void)fetchSubPermissions:(NSDictionary*)param
                   success:(BusinessSuccessBlock)successBlock
                    failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_FetchParnerPermissions didSuccess:^(id response) {
        
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            if (successBlock) {
                
                successBlock([response firstObject]);
            }
            
        }else{
            
            failer(BUSINESSDATAERR);
        }
    } didFailed:^(id error) {
        
        if (failer) {
            
            failer(error);
        }
    }];
}

/** 更新提现比例 */
-(void)updateSubPermissions:(NSDictionary*)param
                    success:(BusinessSuccessBlock)successBlock
                     failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_UpdatePartnerPermissions didSuccess:^(id response) {
        
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            if (successBlock) {
                
                successBlock([response firstObject]);
            }
            
        }else{
            
            failer(BUSINESSDATAERR);
        }
    } didFailed:^(id error) {
        
        if (failer) {
            
            failer(error);
        }
    }];
    
}

/** 下级提现项 */
-(void)fetchSubTiXianSale:(NSDictionary*)param
                  success:(BusinessSuccessBlock)successBlock
                   failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_FetchSubTiXianDetail didSuccess:^(id response) {
        
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            JXCurrentIncomeDetailModel * model = [JXCurrentIncomeDetailModel mj_objectWithKeyValues:[response firstObject]];
            
            if (successBlock) {
                
                successBlock(model);
            }
            
        }else{
            
            failer(BUSINESSDATAERR);
        }
        
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];
    
}

/** 上级审核下级体现单 */
-(void)updateSubTiXianState:(NSDictionary*)param
                    success:(BusinessSuccessBlock)successBlock
                     failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_UpdateSubTiXianState didSuccess:^(id response) {
        
        if (successBlock) {
            
            successBlock(response);
        }

    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];
}


/** 获得套餐寿命及滤芯寿命 */
-(void)fetchPlanFilterLifeList:(NSDictionary*)param
                       success:(BusinessSuccessBlock)successBlock
                        failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_FetchPlanFilterLifeList didSuccess:^(id response) {

        if ([response isKindOfClass:[NSArray class]]) {

            NSArray * arr = [JXPlanFilterLifeModel mj_objectArrayWithKeyValuesArray:response];

            successBlock(arr);
        }

    } didFailed:^(NSString *errorMsg) {

        if (failer) {
            failer(errorMsg);
        }
    }];

}

/** 搜索方法 */
-(void)fetchPlanFilterSearchKeyWorld:(NSDictionary*)param
                             success:(BusinessSuccessBlock)successBlock
                              failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_FetchPlanFilterSearchKeyWorld didSuccess:^(id response) {

        if ([response isKindOfClass:[NSArray class]]) {

            NSArray * arr = [JXPlanFilterLifeModel mj_objectArrayWithKeyValuesArray:response];

            successBlock(arr);
        }

    } didFailed:^(NSString *errorMsg) {

        if (failer) {
            failer(errorMsg);
        }
    }];

}

/** 获取滤芯警告 */
-(void)fetchFilterWarningList:(NSDictionary*)param
                      success:(BusinessSuccessBlock)successBlock
                       failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_FetchFilterWarningList didSuccess:^(id response) {

        if ([response isKindOfClass:[NSArray class]]) {

            NSArray * arr = [JXPlanFilterLifeModel mj_objectArrayWithKeyValuesArray:response];

            successBlock(arr);
        }

    } didFailed:^(NSString *errorMsg) {

        if (failer) {
            failer(errorMsg);
        }
    }];

}

/** 获取维修记录接口 */
-(void)fetchProductRepairList:(NSDictionary*)param
                      success:(BusinessSuccessBlock)successBlock
                       failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_FetchProductRepairList didSuccess:^(id response) {

        if ([response isKindOfClass:[NSArray class]]) {

            NSArray * arr = [JXAfterListModel mj_objectArrayWithKeyValuesArray:response];

            successBlock(arr);
        }else{

            failer(BUSINESSDATAERR);
        }

    } didFailed:^(NSString *errorMsg) {

        if (failer) {
            failer(errorMsg);
        }
    }];

}

/** 查看当前任务列表 */
-(void)fetchAfterSalesList:(NSDictionary*)param
                   success:(BusinessSuccessBlock)successBlock
                    failer:(BusinessFailureBlock)failer{


    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_FetchAfterSalesList didSuccess:^(id response) {

        if ([response isKindOfClass:[NSArray class]]) {

            NSArray * arr = [JXAfterListModel mj_objectArrayWithKeyValuesArray:response];

            successBlock(arr);
        }else{

            failer(BUSINESSDATAERR);
        }

    } didFailed:^(NSString *errorMsg) {

        if (failer) {
            failer(errorMsg);
        }
    }];
}

/** 查看任务详情 */
-(void)fetchAfterSalesDetails:(NSDictionary*)param
                      success:(BusinessSuccessBlock)successBlock
                       failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_FetchAfterSalesDetails didSuccess:^(id response) {

        if ([response isKindOfClass:[NSArray class]]) {

            JXNewAfterSalesModel * model =[JXNewAfterSalesModel mj_objectWithKeyValues:[response firstObject]];

            if (successBlock) {

                successBlock(model);
            }
        }else{

            failer(BUSINESSDATAERR);
        }

    } didFailed:^(NSString *errorMsg) {

        if (failer) {
            failer(errorMsg);
        }
    }];

}

/** 查看评价数据详情 */
-(void)fetchAfterSalesPingJia:(NSDictionary*)param
                      success:(BusinessSuccessBlock)successBlock
                       failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:URL_FetchAfterSalesPingJiaData didSuccess:^(id response) {

        if ([response isKindOfClass:[NSArray class]]) {


            JXEvaluateModel * model = [JXEvaluateModel mj_objectWithKeyValues:[response firstObject]];

            successBlock(model);

        }else{

            failer(BUSINESSDATAERR);
        }

    } didFailed:^(NSString *errorMsg) {

        if (failer) {
            failer(errorMsg);
        }
    }];

}

@end
