//
//  SPHomePageBusiness.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/24.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPHomePageBusiness.h"
#import "SPHomePageListModel.h"
#import "SPPurifierModel.h"
#import "SPAddOrderModel.h"

#import "JXMainPageModel.h"
#import "JXShoppingCarAttributeModel.h"
#import "JXShoppingCarModel.h"
#import "JXNewsModel.h"
#import "JXWaterQualityReportModel.h"
@implementation SPHomePageBusiness


/**
 获取首页列表数据
 
 @param param 字典
 @param success 成功
 @param failere 失败
 */
-(void)getHomeFileListImage:(NSDictionary*)param success:(BusinessSuccessBlock)success failere:(BusinessFailureBlock)failere isGetCache:(BOOL)isCache{

    if (!isCache) {
        
        //homeListFile
        //@"smvc/setup/homepage.v"
        //smvc/setup/waterQuantity.v
        [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:homeListFile didSuccess:^(id response) {

            if ([response isKindOfClass:[NSArray class]]) {
                
                NSMutableArray * listArr = [SPHomePageListModel mj_objectArrayWithKeyValuesArray:response];
                
//                [listArr addObjectsFromArray:[SPHomePageListModel mj_objectArrayWithKeyValuesArray:response]];
                
                
                if (success) {
                    
                    success(listArr);
                }

            
            }else{
                
                if (failere) {
                    
                    failere (BUSINESSDATAERR);
                }
            }
            
        } didFailed:^(NSString *errorMsg) {
            
            if (failere) {
                
                failere (errorMsg);
            }
        }];

    }else{
    
        
    }
    
}

/**
 获得商品详情数据
 
 @param param param
 @param success success
 @param failere 失败
 */
-(void)getProductDetailData:(NSDictionary*)param success:(BusinessSuccessBlock)success failere:(BusinessFailureBlock)failere{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:productDetailDataURL didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
           
            __block   SPPurifierModel * amodel = nil ;
            
            for (NSDictionary * responseDic  in response) {
                
                NSArray * sppuifierArr = [SPPurifierModel mj_objectArrayWithKeyValuesArray:responseDic[@"detail"]];
                
                amodel = [sppuifierArr firstObject];
                
                NSArray * colorArr = [SPProduceColorModel mj_objectArrayWithKeyValuesArray:responseDic[@"color"]];
                
                [colorArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (idx==0) {
                        
                        SPProduceColorModel * model = obj ;
                        
                        model.isSelect = YES ;
                        
                        *stop = YES;
                    }
                    
                }];
            
                amodel .colorArr = colorArr ;
                
                NSArray * priceType = [SPProducePayTypePriceModel mj_objectArrayWithKeyValuesArray:responseDic[@"paytype"]];
                
                [priceType enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (idx==0) {
                    
                        SPProducePayTypePriceModel * model = obj ;
                        
                        amodel.costType = model.paytype;
                        
//                        model.price = @"111";
                        
                        model.isSelect = YES ;
                        
                        *stop = YES;
                    }
                    
                }];
                
                amodel.PricceArr = priceType;
            }
            
            if (amodel) {
                
                success (amodel);
            }else{
            
                failere(BUSINESSDATAERR);
            }
            
            
        }else{
        
            if (failere) {
                
                failere (BUSINESSDATAERR);
            }
        }
 
    } didFailed:^(NSString *errorMsg) {
        
        if (failere) {
            
            failere (errorMsg);
        }
    }];
    

}


/**
 请求商品下单
 
 @param param userid,adrid,proid,managerNo,settime,price
 @param success 成功
 @param failere 失败
 */
-(void)getProductAddOrder:(NSDictionary*)param
                 succcess:(BusinessSuccessBlock)success
                  failere:(BusinessFailureBlock)failere{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:productAddOrderURL didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            SPAddOrderModel * model = [SPAddOrderModel mj_objectWithKeyValues:[response firstObject]];
            
            model.type = SPAddorder_Type_PAY;
            
            if (model && success) {
                
                success (model);
            }else{
            
                if (failere) {
                    failere(BUSINESSDATAERR);
                }
            }
        }else{
        
            if (failere) {
                failere(BUSINESSDATAERR);
            }
            
        }
     
    } didFailed:^(NSString *errorMsg) {
        
        if (failere) {
            
            failere (errorMsg);
        }
        
    }];


}


/**
 获得支付宝支付的请求参数
 
 @param param 参数uname,addr,price 价格,orderNo
 @param success 成功
 @param failere 失败
 */
-(void)getAliPayParamCode:(NSDictionary*)param
                 succcess:(BusinessSuccessBlock)success
                  failere:(BusinessFailureBlock)failere{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:productAliPayParam didSuccess:^(id response) {
        
            if (success) {
                
                success (response);
            }
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failere) {
            
            failere (errorMsg);
        }
        
    }];
}

/**
 获得微信支付的请求参数
 
 @param param param
 @param success 成功
 @param failere 失败
 */
-(void)getWeChatPayParamCode:(NSDictionary*)param
                    succcess:(BusinessSuccessBlock)success
                     failere:(BusinessFailureBlock)failere{
   
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:productWeChatPayParam didSuccess:^(id response) {
        
        NSDictionary * arr =[response firstObject];
        
        if (![arr isEqual:[NSNull null]] && arr) {
            
            if (success) {
                
                success (arr);
            }
            
        }else{
            if (failere) {
                
                failere (@"交易失败");
            }
            
        }
    } didFailed:^(NSString *errorMsg) {
        
        if (failere) {
            
            failere (errorMsg);
        }
        
    }];
    
}



/**
 获得银联支付的请求参数
 
 @param param param
 @param success 成功
 @param failere 失败
 */
-(void)getUnionPayParamCode:(NSDictionary*)param
                   succcess:(BusinessSuccessBlock)success
                    failere:(BusinessFailureBlock)failere{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:productUnionpayParam didSuccess:^(id response) {
        
        NSDictionary * responseDic = [response firstObject];
        
        if (![responseDic isEqual:[NSNull null]]) {
            
           NSString * tn  = [responseDic objectForKey:@"tn"];
            
            if (tn.length>0&&success) {
                
                success(tn);
            }else{
               
                if (failere) {
                    
                    failere (@"交易失败");
                }
                
            }
            
        }else{
        
            if (failere) {
                
                failere (@"交易失败");
            }
        }
        
        
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failere) {
            
            failere (errorMsg);
        }
    }];

    
}


/**
 获取饮水量数据
 
 @param param userid
 @param success 成功
 @param failere 失败
 */
-(void)getPurifierWaterData:(NSDictionary*)param
                   succcess:(BusinessSuccessBlock)success
                    failere:(BusinessFailureBlock)failere{
    
    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:WaterQuantity didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            JXWaterQualityReportModel * listArr = [JXWaterQualityReportModel mj_objectWithKeyValues:[response firstObject]];
            
            if (success) {
                
                success(listArr);
            }
            
        }else{
            
            failere(BUSINESSDATAERR);
        }
        
    } didFailed:^(id error) {
       
        if (failere) {
            
            failere (error);
        }
    }];
    
}

/**
 获取首页数据
 
 @param param userid
 @param success 成功
 @param failere 失败
 */
-(void)getHomePageData:(NSDictionary*)param
              succcess:(BusinessSuccessBlock)success
               failere:(BusinessFailureBlock)failere{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:HomePageData didSuccess:^(id response) {
       
        NSArray * arr = response;
        
        if (![arr isEqual:[NSNull null]]&& arr.count>1) {
            
            JXMainPageModel * model = [[JXMainPageModel alloc] init];
            
            model.home_page = [JXMainAdvModel mj_objectArrayWithKeyValuesArray:[response[0] objectForKey:@"home_page"]];
            
            model.ranking_list = [JXMainAdvModel mj_objectArrayWithKeyValuesArray:[response[1] objectForKey:@"ranking_list"]];
            
            if (success) {
                
                success(model);
            }
        
    }else{
        
        if (failere) {
            
            failere (BUSINESSDATAERR);
        }
    }
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failere) {
            
            failere (errorMsg);
        }
    }];
    
}


#pragma mark - 添加购物车
-(void)insertShoppingCar:(NSDictionary*)param
                 success:(BusinessSuccessBlock)success
                 failere:(BusinessFailureBlock)failere{
    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:ShoppingCartAddCarURl didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            success([[response firstObject] objectForKey:@"sum"]);
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
 获取新闻列表
 
 @param param 参数
 @param success 成功
 @param failere 失败
 */
-(void)fetchHomePageNewsList:(NSDictionary*)param
                    succcess:(BusinessSuccessBlock)success
                     failere:(BusinessFailureBlock)failere{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:HomePageNewsList didSuccess:^(id response) {
        
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

#pragma mark - 商品信息
-(void)fetchShoppingCarProdesc:(NSDictionary*)param
                       success:(BusinessSuccessBlock)success
                       failere:(BusinessFailureBlock)failere{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:ShoppingCartAttribute didSuccess:^(id response) {
       
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSArray * listModel = [JXShoppingCarModel  mj_objectArrayWithKeyValuesArray:response];
            
            if (success) {
                success(listModel);
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


-(void)fetchShoppingCarNum:(NSDictionary *)param
                   success:(BusinessSuccessBlock)success
                   failere:(BusinessFailureBlock)failere{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:ShoppingCartFetchCarNum didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            success([[response firstObject] objectForKey:@"sum"]);
            
        }else{
        
            failere(BUSINESSDATAERR);
            
        }
    
    } didFailed:^(id error) {
        
        if (failere) {
            failere(error);
        }
    }];
    
}


@end
