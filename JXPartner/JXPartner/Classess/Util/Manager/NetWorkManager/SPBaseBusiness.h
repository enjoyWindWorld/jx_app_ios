//
//  SPBaseBusiness.h
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/24.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPBaseNetWorkRequst.h"
#import <MJExtension.h>
#import "NSString+Verification.h"
#define  BUSINESSDATAERR @"数据错误"

typedef void (^BusinessSuccessBlock) (id result);
typedef void (^BusinessFailureBlock)  (id error);

@interface SPBaseBusiness : NSObject



-(void) uploadImageList:(NSMutableArray *)imageList
        withCompression:(CGFloat)compression
                success:(BusinessSuccessBlock)success
                failere:(BusinessFailureBlock)failere;






@end
