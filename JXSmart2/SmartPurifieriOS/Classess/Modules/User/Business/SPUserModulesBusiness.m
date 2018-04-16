//
//  SPUserModulesBusiness.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/24.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPUserModulesBusiness.h"
#import "UserPurifierDetailModel.h"
#import "UserPurifierListModel.h"
#import "spuserAddressListModel.h"
#import "OrderLitModel.h"
#import "OrderDetailModel.h"
#import "ServiceModel.h"
#import "SPClarifierTrafficModel.h"
#import "NSDate+NSDateExtra.h"
#import "SPClarifierMessageModel.h"
#import "SPAddOrderModel.h"
#import "JXShoppingCarModel.h"
#import "JXAfterProductModel.h"
#import "JXFitlerModel.h"
#import "JXAfterListModel.h"
#import "JXNewAfterSalesModel.h"
#import "JXEvaluateModel.h"

@implementation SPUserModulesBusiness

//上传头像
-(void)uploadUserICO:(NSDictionary*)param
                     success:(BusinessSuccessBlock)successBlock
                      failer:(BusinessFailureBlock)failer{
    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:userChangeHeadIcoURL didSuccess:^(id response) {
        
        if (successBlock) {
            successBlock(response);
        }
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
        
    }];
    
}


/**
 个人 - 我的净水器列表
 
 @param param phoneNum<Y>,
 @param successBlock 净水器模型数组
 @param failer 提示语
 */
-(void)getUserPurifierList:(NSDictionary*)param
                   success:(BusinessSuccessBlock)successBlock
                    failer:(BusinessFailureBlock)failer{
   
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:userPurifierList didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSArray * listModel  = [UserPurifierListModel mj_objectArrayWithKeyValuesArray:response];
            
            if (successBlock) {
                
                successBlock (listModel);
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
 个人 - 我的净水器详情
 
 @param param phoneNum<Y>,pro_id<Y>
 @param successBlock 净水器数据
 @param failer 提示语
 */
-(void)getUserPurifierDetail:(NSDictionary*)param
                     success:(BusinessSuccessBlock)successBlock
                      failer:(BusinessFailureBlock)failer{
   
    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:userPurifierDetail didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]&&[response firstObject]) {
         
            //UserPurifierDetailModel * puModel  = [UserPurifierDetailModel mj_objectWithKeyValues:[response firstObject]];
            
            if (successBlock) {
                
                successBlock(response);
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

//我的订单列表
-(void)getUserMyOrder:(NSDictionary*)param
                   success:(BusinessSuccessBlock)successBlock
                    failer:(BusinessFailureBlock)failer{

    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:userMyOrder didSuccess:^(id response) {
        
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
        
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];
    
    
}

//我的订单详情
-(void)getUserMyOrderDetail:(NSDictionary*)param
                     success:(BusinessSuccessBlock)successBlock
                      failer:(BusinessFailureBlock)failer{
    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:userMyOrderDetail didSuccess:^(id response) {
        
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

//我的订单删除
-(void)getUserOrderDel:(NSDictionary*)param
                    success:(BusinessSuccessBlock)successBlock
                     failer:(BusinessFailureBlock)failer{
    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:userOrderDel didSuccess:^(id response) {
        if (successBlock) {
            successBlock(response);
        }
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];
    
    
}


//用户中心
-(void)getUserInfo:(NSDictionary*)param
                     success:(BusinessSuccessBlock)successBlock
                      failer:(BusinessFailureBlock)failer{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *str = [defaults objectForKey:@"userInfo"];
    
    NSString *url;
    BOOL type;
    if ([str isEqualToString:@"昵称"]) {
        url = userNickName;
        type = YES;
    }else if ([str isEqualToString:@"签名"]) {
        url = userSign;
        type = YES;
    }else if ([str isEqualToString:@"性别"]) {
        url = userSex;
        type = YES;
    }else if ([str isEqualToString:@"地址"]) {
        url = userHomeAddressList;
        type = YES;
    }else if ([str isEqualToString:@"意见反馈"]) {
        url = userOption;
        type = NO;
    }
    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:YES isNeedUserIdentifier:type didParam:param didUrl:url didSuccess:^(id response) {
        
            if (successBlock) {
                successBlock(response);
            }

    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
        
    }];
    
}


/**
 获得用户家庭地址接口
 
 @param param
 @param successBlock
 @param failer
 */
-(void)getUserHomeList:(NSDictionary*)param
               success:(BusinessSuccessBlock)successBlock
                failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:userHomeAddressList didSuccess:^(id response) {
       
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSArray * arr = [spuserAddressListModel mj_objectArrayWithKeyValuesArray:response];
            
            if (successBlock) {
                
                successBlock (arr);
            }
            
        }else{
        
            if (failer) {
               
                failer (BUSINESSDATAERR);
            }
        }

    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
           
            failer(errorMsg);
        }
    }];

    
}

/**
 新增或者修改地址
 
 @param param id为地址id,为空表示新增,非空表示修改,userid:用户ID,name:收货人姓名,phone:收货人手机号,area:区域,detail:街道门牌,code:邮政编码,isdefault=0表示默认地址
 @param successBlock 成功
 @param failer 失败
 */
-(void)getModifyHomeAddress:(NSDictionary*)param
                    success:(BusinessSuccessBlock)successBlock
                     failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:userHomeAddressModify didSuccess:^(id response) {
        
        if (successBlock) {
            successBlock(response);
        }
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];
    
}


/**
 删除某条地址
 
 @param param 地址id
 @param successBlock 成功
 @param failer 失败
 */
-(void)getDeleteHomeAddress:(NSDictionary*)param
                    success:(BusinessSuccessBlock)successBlock
                     failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:userDeleteMessage didSuccess:^(id response) {
        
        if (successBlock) {
            successBlock(response);
        }
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];


}

-(void)getMerchantRelease:(NSDictionary*)param
                    success:(BusinessSuccessBlock)successBlock
                     failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:userMerchantRelease didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSArray * listModel  = [ServiceModel mj_objectArrayWithKeyValuesArray:response];
            
            if (successBlock) {
                
                successBlock (listModel);
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

//分享绑定
-(void)getSharePhoneNum:(NSDictionary*)param
                    success:(BusinessSuccessBlock)successBlock
                     failer:(BusinessFailureBlock)failer{
    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:userSharePhoneNum didSuccess:^(id response) {
        
        if (successBlock) {
            successBlock(response);
        }
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];
    
    
}

//社会化分享
-(void)getUserShare:(NSDictionary*)param
                success:(BusinessSuccessBlock)successBlock
                 failer:(BusinessFailureBlock)failer{
    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:nil didUrl:userhShareURL didSuccess:^(id response) {
        
        if (successBlock) {
            successBlock(response);
        }
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];
    
    
}

/**
 获取消息列表
 
 @param param 参数
 @param successBlock 成功
 @param failer 失败
 */
-(void)getMessageList:(NSDictionary *)param
              success:(BusinessSuccessBlock)successBlock
               failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:userMessageList didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSArray * arrMessage = [SPClarifierMessageModel mj_objectArrayWithKeyValuesArray:response];

            if (successBlock) {
               
                successBlock(arrMessage);
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
 获得余量查询
 
 @param param 参数
 @param successBlock 成功
 @param failer 失败
 */
-(void)getClarifierDetailCost:(NSDictionary *)param
                      success:(BusinessSuccessBlock)successBlock
                       failer:(BusinessFailureBlock)failer{
    

    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:userClarifierDetailCost didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            SPClarifierTrafficModel * model = [SPClarifierTrafficModel mj_objectWithKeyValues:[response firstObject]];
            
        
            model.fetch_Time = [NSDate getTimeStringWithDate:[NSDate date]];
            
            if (model && successBlock) {
                
                
                    
                successBlock(model);
                
                
            }else{
            
                if (failer) {
                    failer(BUSINESSDATAERR);
                }
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

//更换手机号
-(void)getModifyPhoneNum:(NSDictionary*)param
               success:(BusinessSuccessBlock)successBlock
                failer:(BusinessFailureBlock)failer{
    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:userModifyPhoneNum didSuccess:^(id response) {
       
        if (successBlock) {
            successBlock(response);
        }
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];
    
}


/**
 获得续费下单
 
 @param param 参数
 @param successBlock 成功
 @param failer 失败
 */
-(void)getClarifierAddOrderCost:(NSDictionary *)param
                        success:(BusinessSuccessBlock)successBlock
                         failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:UserClarifierCostPay didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            SPAddOrderModel * model = [SPAddOrderModel mj_objectWithKeyValues:[response firstObject]];
            
            model.type = SPAddorder_Type_Renewal;
            
            if (model && successBlock) {
                
                successBlock (model);
            }else{
                
                if (failer) {
                    failer(BUSINESSDATAERR);
                }
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
 更改某条消息为已读
 
 @param param 参数
 @param successBlock 成功
 @param failer 失败
 */
-(void)getChangeMessageWithRead:(NSDictionary *)param
                        success:(BusinessSuccessBlock)successBlock
                         failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:userChangeMessageWithRead didSuccess:^(id response) {
        
        
        if (successBlock) {
            successBlock(response);
        }
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];
    
}

/**
 删除某条消息
 
 @param param 消息id
 @param successBlock chengg
 @param failer dhib
 */
-(void)getDeleteOneOfMessage:(NSDictionary *)param
                     success:(BusinessSuccessBlock)successBlock
                      failer:(BusinessFailureBlock)failer{
    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:userDeleteMessage didSuccess:^(id response) {
        
        
        if (successBlock) {
            successBlock(response);
        }
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];
    
}

/**
 获得未读消息数
 
 @param param userid
 @param successBlock chengg
 @param failer shib
 */
-(void)getNotReadMessageCount:(NSDictionary *)param
                      success:(BusinessSuccessBlock)successBlock
                       failer:(BusinessFailureBlock)failer{
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:userNotReadMessageCount didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSDictionary *numberDic  = [response firstObject];
            
            if (successBlock&&numberDic) {
                
                successBlock([numberDic objectForKey:@"number"]);
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
 获取续费订单详情
 
 @param param
 @param successBlock
 @param failer
 */
-(void)getUserOrderRenewalDetail:(NSDictionary *)param
                         success:(BusinessSuccessBlock)successBlock
                          failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:userOrderRenewalDetail didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            OrderDetailModel * model = nil;
            
            for (NSDictionary * responseDic  in response) {
                
                NSArray * sppuifierArr = [OrderDetailModel mj_objectArrayWithKeyValuesArray:responseDic[@"orderdetail"]];
                
                model = [sppuifierArr firstObject];
                
                NSArray * colorArr = [SPOrderDetailPriceModel mj_objectArrayWithKeyValuesArray:responseDic[@"paytype"]];
                
                model.priceArr = colorArr;
            
            }

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
 查询用户购物车所有商品
 
 @param param
 @param successBlock
 @param failer
 */
-(void)fetchMyShoppingCarAllList:(NSDictionary *)param
                         success:(BusinessSuccessBlock)successBlock
                          failer:(BusinessFailureBlock)failer{
    
    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:ShoppingCartShowAllCars didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSArray * listArr = [JXShoppingCarMainModel mj_objectArrayWithKeyValuesArray:response];
            
            
            
//            NSMutableArray * listArr = @[].mutableCopy;
//            
//            for (int i = 0; i<3; i++) {
//                
//                JXShoppingCarMainModel * model = [[JXShoppingCarMainModel alloc] init];
//                
//                 NSMutableArray * listArrModel = @[].mutableCopy;
//                
//                for (int j = 0; j<3; j++) {
//                    
//                    JXShoppingCarModel * model = [[JXShoppingCarModel alloc] init];
//                    
//                    [listArrModel addObject:model];
//                }
//                model.list = listArrModel;
//                
//                [listArr addObject:model];
//            }
            
            if (successBlock) {
                successBlock(listArr);
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
 删除用户购物车商品
 
 @param param
 @param successBlock
 @param failer
 */
-(void)deleteMyShoppingCar:(NSDictionary *)param
                   success:(BusinessSuccessBlock)successBlock
                    failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:ShoppingCartDeleCarts didSuccess:^(id response) {
        
        if (successBlock) {
            
            successBlock(response);
        }
        
    } didFailed:^(id error) {
        
        if (failer) {
            failer(error);
        }
        
    }];

}


/**
 更新用户购物车商品
 
 @param param
 @param successBlock
 @param failer
 */
-(void)updateMyShoppingCar:(NSDictionary *)param
                   success:(BusinessSuccessBlock)successBlock
                    failer:(BusinessFailureBlock)failer{
    
    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:ShoppingCartUpdateCarts didSuccess:^(id response) {
       
        if (successBlock) {
            
            successBlock(response);
        }
        
    } didFailed:^(id error) {
        
        if (failer) {
            failer(error);
        }
        
    }];

}


/**
 获取我的推广
 
 @param param userid
 @param successBlock
 @param failer
 */
-(void)fetchMyPromoter:(NSDictionary *)param
               success:(BusinessSuccessBlock)successBlock
                failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:userAllPromoter didSuccess:^(id response) {
        
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSArray * list = [ServiceModel mj_objectArrayWithKeyValuesArray:response];
            
            if (successBlock) {
                
                successBlock(list);
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

#pragma mark - 售后模块
-(void)fetch_AfterSalesList:(NSDictionary *)param
                    success:(BusinessSuccessBlock)successBlock
                     failer:(BusinessFailureBlock)failer{
    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:fetch_user_afterLists didSuccess:^(id response) {

        if ([response isKindOfClass:[NSArray class]]) {

            NSArray * arr = [JXAfterListModel mj_objectArrayWithKeyValuesArray:response];

            successBlock(arr);

        }else{

            failer(BUSINESSDATAERR);

        }

    } didFailed:^(id error) {
        
        if (failer) {
            failer(error);
        }
    }];
    
}

//获取购买设备列表
-(void)fetch_productList:(NSDictionary *)param
                 success:(BusinessSuccessBlock)successBlock
                  failer:(BusinessFailureBlock)failer{
    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:fetch_chooseProductlist didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSArray * arr = [JXAfterProductModel mj_objectArrayWithKeyValuesArray:response
                             ];
            
            successBlock(arr);
            
        }else{
         
            failer(BUSINESSDATAERR);
            
        }
    } didFailed:^(id error) {
        
        
    }];
}

//获取设备对应的滤芯
-(void)fetch_trafficList:(NSDictionary *)param
                 success:(BusinessSuccessBlock)successBlock
                  failer:(BusinessFailureBlock)failer{
    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:fetch_chooseTrafficlist didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSArray * arr = [JXFitlerModel mj_objectArrayWithKeyValuesArray:response];
            
            successBlock(arr);
            
        }else{
            
            failer(BUSINESSDATAERR);
        }
        
    } didFailed:^(id error) {
        
        if (failer) {
            failer(error);
        }
    }];
}

//获取故障现象
-(void)fetch_faultErrTipList:(NSDictionary *)param
                     success:(BusinessSuccessBlock)successBlock
                      failer:(BusinessFailureBlock)failer{
    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:fetch_faultErrList didSuccess:^(id response) {

        if ([response isKindOfClass:[NSArray class]]) {

            NSMutableArray * arr = [NSMutableArray arrayWithCapacity:0];

            for (NSDictionary * dic in response) {

                [arr addObject:dic[@"fault_cause"]];
            }
//            NSArray * arr = [JXFitlerModel mj_objectArrayWithKeyValuesArray:response];

            successBlock(arr);

        }else{

            failer(BUSINESSDATAERR);
        }
        
    } didFailed:^(id error) {
        
        if (failer) {
            failer(error);
        }
    }];
}

//发布一个新的
-(void)fetch_updateNewAfterSales:(NSDictionary *)param
                          images:(NSMutableArray*)images
                         success:(BusinessSuccessBlock)successBlock
                          failer:(BusinessFailureBlock)failer{

  __block  NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:param];

    if (images.count == 0) {

        [dic setObject:@"" forKey:@"fautl_url"];

        [self privateRequestInsertAfterSales:dic success:successBlock failer:failer];

    }else{

         __block  NSMutableArray * imageListArr = @[].mutableCopy;

        [self uploadImageList:images withCompression:0.2 success:^(id result) {

            if ([result isKindOfClass:[NSArray class]]) {

                NSString * imgurl = @"";

                for (NSDictionary * dic in result) {

                    imgurl = [dic objectForKey:@"imgUrl"];

                    [imageListArr addObject:imgurl];
                }

                if (imageListArr.count == images.count) {

                    __block NSMutableString * mutabstring = @"".mutableCopy;

                    for (NSString* imagestring in imageListArr) {

                        [mutabstring appendFormat:@"%@,",imagestring];
                    }

                    NSString * imgurl = mutabstring.length>1?[mutabstring substringToIndex:mutabstring.length-1]:mutabstring;

                    NSLog(@"图片上传 组 %@",imgurl);

                    [dic setObject:imgurl forKey:@"fautl_url"];

                    [self privateRequestInsertAfterSales:dic success:successBlock failer:failer];

                }


            }else{

                failer(BUSINESSDATAERR);
            }

        } failere:^(id error) {

            failer(error);

        }];

    }

}

-(void)privateRequestInsertAfterSales:(NSMutableDictionary*)param
                           success:(BusinessSuccessBlock)successBlock
                            failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:fetch_afterSalesNew didSuccess:^(id response) {

        if (successBlock) {

            successBlock(@"成功");
        }

    } didFailed:^(id error) {

        if (failer) {
            failer(error);
        }
    }];

}


//查看详情数据
-(void)fetch_AfterSalesDetails:(NSDictionary *)param
                       success:(BusinessSuccessBlock)successBlock
                        failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:fetch_afterSalesDetails didSuccess:^(id response) {

        if ([response isKindOfClass:[NSArray class]]) {

            JXNewAfterSalesModel * model = [JXNewAfterSalesModel mj_objectWithKeyValues:[response firstObject]];

            successBlock(model);

        }else{

            failer(BUSINESSDATAERR);
        }

    } didFailed:^(id error) {

        if (failer) {
            failer(error);
        }
    }];

}

//新增评价
-(void)fetch_InsertPingJiaData:(NSDictionary *)param
                        images:(NSMutableArray*)images
                       success:(BusinessSuccessBlock)successBlock
                        failer:(BusinessFailureBlock)failer{

    __block  NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:param];

    if (images.count == 0) {

        [dic setObject:@"" forKey:@"appraise_url"];

        [self privateRequestInsertPingJiaData:dic success:successBlock failer:failer];

    }else{

        __block  NSMutableArray * imageListArr = @[].mutableCopy;

        [self uploadImageList:images withCompression:0.2 success:^(id result) {

            if ([result isKindOfClass:[NSArray class]]) {

                NSString * imgurl = @"";

                for (NSDictionary * dic in result) {

                    imgurl = [dic objectForKey:@"imgUrl"];

                    [imageListArr addObject:imgurl];
                }

                if (imageListArr.count == images.count) {

                    __block NSMutableString * mutabstring = @"".mutableCopy;

                    for (NSString* imagestring in imageListArr) {

                        [mutabstring appendFormat:@"%@,",imagestring];
                    }

                    NSString * imgurl = mutabstring.length>1?[mutabstring substringToIndex:mutabstring.length-1]:mutabstring;

                    NSLog(@"图片上传 组 %@",imgurl);

                    [dic setObject:imgurl forKey:@"appraise_url"];

                    [self privateRequestInsertPingJiaData:dic success:successBlock failer:failer];

                }


            }else{

                failer(BUSINESSDATAERR);
            }

        } failere:^(id error) {

            failer(error);

        }];

    }


}

-(void)privateRequestInsertPingJiaData:(NSMutableDictionary*)param
                              success:(BusinessSuccessBlock)successBlock
                               failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:fetch_insertPingJiaData didSuccess:^(id response) {

        successBlock(@"成功");

    } didFailed:^(id error) {

        if (failer) {
            failer(error);
        }
    }];

}

//查看评价
-(void)fetch_getPingJiaDetail:(NSDictionary *)param
                      success:(BusinessSuccessBlock)successBlock
                       failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:fetch_pingJiaDetail didSuccess:^(id response) {

        if ([response isKindOfClass:[NSArray class]]) {

            JXEvaluateModel* model = [JXEvaluateModel  mj_objectWithKeyValues:[response firstObject]];

            successBlock(model);

        }else{

            failer(BUSINESSDATAERR);
        }

    } didFailed:^(id error) {

        if (failer) {
            failer(error);
        }
    }];
}

@end
