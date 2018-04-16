//
//  SPBaseNetWorkRequstDefine.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/2/16.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#ifndef SPBaseNetWorkRequstDefine_h
#define SPBaseNetWorkRequstDefine_h

typedef NS_ENUM(NSInteger,RequestMethod) {
    
    RequestMethod_GET,  //get
    
    RequestMethod_POST, //post
};

/**
 *  网络请求超时的时间
 */
#define RequestAFN_API_TIME_OUT 20


#if NS_BLOCKS_AVAILABLE

typedef void (^RequestSuccessBlock)(id response);

typedef void (^RequestFailureBlock) (id error);


#endif

#endif /* SPBaseNetWorkRequstDefine_h */
