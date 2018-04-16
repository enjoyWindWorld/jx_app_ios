//
//  SPComServiceModulesBusiness.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/24.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPComServiceModulesBusiness.h"
#import "ServiceModel.h"
#import "PushBtnModel.h"
#import "JXCommunityAdvModel.h"
#import "JXCommunityGoPay.h"

@implementation SPComServiceModulesBusiness

/**
 保洁列表
 
 @param param phoneNum<Y>,password<Y>
 @param successBlock 结果
 @param failer 提示
 */
-(void)cleanDeital:(NSDictionary*)param
           success:(BusinessSuccessBlock)successBlock
            failer:(BusinessFailureBlock)failer{
    
//    [SPBaseNetWorkRequst startNetRequestWithisPostMethod:YES didParam:param didUrl:cleanDeitalURL didSuccess:^(id response) {
//        
//        
//    } didFailed:^(NSString *errorMsg) {
//        
//    }];
    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:cleanDeitalURL didSuccess:^(id response) {
        
        
    } didFailed:^(NSString *errorMsg) {
        
        
    }];
    
    
}

//广告
-(void)communityGetAdv:(NSDictionary*)param
               success:(BusinessSuccessBlock)successBlock
                failer:(BusinessFailureBlock)failer{
    

    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:communityGetAdvURL didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSArray * adv_arr = [JXCommunityAdvModel mj_objectArrayWithKeyValuesArray:response];
            
            if (successBlock) {
                
                successBlock(adv_arr);
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

//社区按钮列表
-(void)pushtotalDetails:(NSDictionary*)param
                       success:(BusinessSuccessBlock)successBlock
                        failer:(BusinessFailureBlock)failer{
    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:pushtotalURL didSuccess:^(id response) {
        if ([response isKindOfClass:[NSArray class]]) {
          
             NSMutableArray* listModel  = [PushBtnModel mj_objectArrayWithKeyValuesArray:response];
            
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

//填写发布
-(void)communityPublish:(NSDictionary*)param
               success:(BusinessSuccessBlock)successBlock
                failer:(BusinessFailureBlock)failer{
    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:publishURL didSuccess:^(id response) {
        if (successBlock) {
            successBlock(response);
        }
        
    } didFailed:^(NSString *errorMsg) {
        
        if (failer) {
            failer(errorMsg);
        }
    }];
    
}

//服务列表
-(void)communityserviceList:(NSDictionary*)param
              success:(BusinessSuccessBlock)successBlock
               failer:(BusinessFailureBlock)failer{
 
    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:serviceListURL didSuccess:^(id response) {
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

//服务详情
-(void)communitydoultonDetails:(NSDictionary*)param
                success:(BusinessSuccessBlock)successBlock
                 failer:(BusinessFailureBlock)failer{
    
        
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:doultonDetailsURL didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSArray * listModel  = [ServiceModel mj_objectArrayWithKeyValuesArray:response];
            
            if (successBlock) {
                
                successBlock ([listModel firstObject]);
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

//水机用户数量
-(void)communityUserCount:(NSDictionary*)param
                  success:(BusinessSuccessBlock)successBlock
                   failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:communityUserCount didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSDictionary * dic = [response firstObject];
            
            if (successBlock && ![[dic objectForKey:@"user_number"] isEqual:[NSNull null]]) {
           
                NSString * user_number = [dic objectForKey:@"user_number"];
                
                successBlock(user_number);
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

-(void)insertCommunityPublish:(NSMutableDictionary*)param
                     imageArr:(NSMutableArray*)imageArr
                      success:(BusinessSuccessBlock)successBlock
                       failer:(BusinessFailureBlock)failer{

    //@"imgUrl":@"http://data.jx-inteligent.tech:15010/jx/f/4/020913411473141_20170209134114.jpg",
    
    __block  NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:param];
    
    if (imageArr.count == 0) {
        
        [dic setObject:@"" forKey:@"imgUrl"];
        
        [self privateRequestInsertPublish:dic success:successBlock failer:failer];
                
    }else{
        __block  NSMutableArray * imageListArr = @[].mutableCopy;
        
        [self uploadImageList:imageArr withCompression:0.2 success:^(id result) {
            
            if ([result isKindOfClass:[NSArray class]]) {
                
                NSString * imgurl = @"";
                
                for (NSDictionary * dic in result) {
                    
                    imgurl = [dic objectForKey:@"imgUrl"];
                    
                    [imageListArr addObject:imgurl];
                }
                
                if (imageListArr.count == imageArr.count) {
                    
                    __block NSMutableString * mutabstring = @"".mutableCopy;
                    
                    for (NSString* imagestring in imageListArr) {
                        
                        [mutabstring appendFormat:@"%@,",imagestring];
                    }
                    
                    NSString * imgurl = mutabstring.length>1?[mutabstring substringToIndex:mutabstring.length-1]:mutabstring;
                    
                    NSLog(@"图片上传 组 %@",imgurl);
                    
                    [dic setObject:imgurl forKey:@"imgUrl"];
                    
                    [self privateRequestInsertPublish:dic success:successBlock failer:failer];
                    
                }
                
                
            }else{
                
                failer(BUSINESSDATAERR);
            }
            
        } failere:^(id error) {
            
            failer(error);
            
        }];
    }
}

-(void)privateRequestInsertPublish:(NSMutableDictionary*)param
             success:(BusinessSuccessBlock)successBlock
              failer:(BusinessFailureBlock)failer{
   
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:COMMUNITYPUBLISH didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            JXCommunityGoPay * model = [JXCommunityGoPay mj_objectWithKeyValues:[response firstObject]];
            
            if (successBlock) {
                
                successBlock(model);
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

#pragma MARK - 社区发布  阿里支付
-(void)fetchCommunityAliPAY:(NSDictionary*)param
                    success:(BusinessSuccessBlock)successBlock
                     failer:(BusinessFailureBlock)failer{
    
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:communityPublishAliPAY didSuccess:^(id response) {
        
        if (successBlock) {
            
            successBlock (response);
        }
    
    } didFailed:^(id error) {
       
        if (failer) {
            failer(error);
        }
        
    }];

    
}

#pragma MARK - 社区发布  微信支付
-(void)fetchCommunityWeChatPay:(NSDictionary*)param
                       success:(BusinessSuccessBlock)successBlock
                        failer:(BusinessFailureBlock)failer{
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:communityPublishWeChatPay didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSDictionary * arr =[response firstObject];
            
            if (![arr isEqual:[NSNull null]] && arr) {
                
                if (successBlock) {
                    
                    successBlock (arr);
                }
                
            }else{
                if (failer) {
                    
                    failer (@"交易失败");
                }
                
            }
            
        }else{
        
            failer (BUSINESSDATAERR);
            
        }

        
    } didFailed:^(id error) {
        
        if (failer) {
            failer(error);
        }
    }];
    
}

#pragma MARK - 社区发布  银联支付
-(void)fetchCommunityUnionPay:(NSDictionary*)param
                      success:(BusinessSuccessBlock)successBlock
                       failer:(BusinessFailureBlock)failer{
    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:communityPublishUnionPay didSuccess:^(id response) {
        
        NSDictionary * responseDic = [response firstObject];
        
        if (![responseDic isEqual:[NSNull null]]) {
            
            NSString * tn  = [responseDic objectForKey:@"tn"];
            
            if (tn.length>0&&successBlock) {
                
                successBlock(tn);
            }else{
                
                if (failer) {
                    
                    failer (@"交易失败");
                }
                
            }
            
        }else{
            
            if (failer) {
                
                failer (@"交易失败");
            }
        }

        
    } didFailed:^(id error) {
        if (failer) {
            failer(error);
        }
        
    }];
    
}


/**
 更新咨询量接口
 
 @param param
 @param successBlock
 @param failer
 */
-(void)updateCommunityConsulting:(NSDictionary*)param
                         success:(BusinessSuccessBlock)successBlock
                          failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:CommunityConsultingUrl didSuccess:^(id response) {
        
    } didFailed:^(id error) {
        if (failer) {
            failer(error);
        }
        
    }];
    
}

/**
 举报商家
 
 @param param id
 @param successBlock chengg
 @param failer shib
 */
-(void)reportCommunityBusiness:(NSDictionary*)param
                       success:(BusinessSuccessBlock)successBlock
                        failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:YES didParam:param didUrl:CommunityReportService didSuccess:^(id response) {
        
        if (successBlock) {
            successBlock(nil);
        }
        
    } didFailed:^(id error) {
    
        if (failer) {
            failer(error);
        }
        
    }];
    
}


@end
