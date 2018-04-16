//
//  JXMovieHappyBusiness.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/29.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXMovieHappyBusiness.h"
#import "JXMovieListModel.h"

@implementation JXMovieHappyBusiness

-(void)fetchMovieHapplyList:(NSDictionary*)param
                    success:(BusinessSuccessBlock)successBlock
                     failer:(BusinessFailureBlock)failer{

    [SPBaseNetWorkRequst  startNetRequestWithTypeMethod:RequestMethod_POST isNeedUserIdentifier:NO didParam:param didUrl:MovieHappylyList didSuccess:^(id response) {
        
        if ([response isKindOfClass:[NSArray class]]) {
            
            NSArray * modelList = [JXMovieListModel mj_objectArrayWithKeyValuesArray:response];
            
            if (successBlock) {
                
                successBlock(modelList);
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



@end
