//
//  SPComServiceModulesBusiness.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/24.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseBusiness.h"

@interface SPComServiceModulesBusiness : SPBaseBusiness
/**
 用户注册
 
 @param param phoneNum<Y>,password<Y>
 @param successBlock 结果
 @param failer 提示
 */

-(void)cleanDeital:(NSDictionary*)param
           success:(BusinessSuccessBlock)successBlock
            failer:(BusinessFailureBlock)failer;

//广告
-(void)communityGetAdv:(NSDictionary*)param
               success:(BusinessSuccessBlock)successBlock
                failer:(BusinessFailureBlock)failer;


//社区首页按钮列表
-(void)pushtotalDetails:(NSDictionary*)param
                       success:(BusinessSuccessBlock)successBlock
                        failer:(BusinessFailureBlock)failer;

//填写发布
-(void)communityPublish:(NSDictionary*)param
               success:(BusinessSuccessBlock)successBlock
                failer:(BusinessFailureBlock)failer;

//服务列表
-(void)communityserviceList:(NSDictionary*)param
                success:(BusinessSuccessBlock)successBlock
                 failer:(BusinessFailureBlock)failer;

//服务详情
-(void)communitydoultonDetails:(NSDictionary*)param
                    success:(BusinessSuccessBlock)successBlock
                     failer:(BusinessFailureBlock)failer;

//水机用户数量
-(void)communityUserCount:(NSDictionary*)param
                       success:(BusinessSuccessBlock)successBlock
                        failer:(BusinessFailureBlock)failer;

#pragma mark - 新的社区发布
-(void)insertCommunityPublish:(NSMutableDictionary*)param
                     imageArr:(NSMutableArray*)imageArr
                      success:(BusinessSuccessBlock)successBlock
                       failer:(BusinessFailureBlock)failer;


/**
 更新咨询量接口

 @param param
 @param successBlock
 @param failer
 */
-(void)updateCommunityConsulting:(NSDictionary*)param
                         success:(BusinessSuccessBlock)successBlock
                          failer:(BusinessFailureBlock)failer;


/**
 举报商家

 @param param id
 @param successBlock chengg
 @param failer shib
 */
-(void)reportCommunityBusiness:(NSDictionary*)param
                       success:(BusinessSuccessBlock)successBlock
                        failer:(BusinessFailureBlock)failer;


#pragma MARK - 社区发布  阿里支付
-(void)fetchCommunityAliPAY:(NSDictionary*)param
                      success:(BusinessSuccessBlock)successBlock
                       failer:(BusinessFailureBlock)failer;

#pragma MARK - 社区发布  微信支付
-(void)fetchCommunityWeChatPay:(NSDictionary*)param
                    success:(BusinessSuccessBlock)successBlock
                     failer:(BusinessFailureBlock)failer;

#pragma MARK - 社区发布  银联支付
-(void)fetchCommunityUnionPay:(NSDictionary*)param
                    success:(BusinessSuccessBlock)successBlock
                     failer:(BusinessFailureBlock)failer;


@end
