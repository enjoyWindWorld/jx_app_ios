//
//  JXMovieHappyBusiness.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/29.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseBusiness.h"


@interface JXMovieHappyBusiness : SPBaseBusiness

-(void)fetchMovieHapplyList:(NSDictionary*)param
                    success:(BusinessSuccessBlock)successBlock
                     failer:(BusinessFailureBlock)failer;


@end
