//
//  NSString+Verification.h
//  XHApp
//
//  Created by 肖会军 on 16/3/19.
//  Copyright © 2016年 刘军林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Verification)


/**
 验证手机号

 @return YES NO
 */
-(BOOL)predicateStringWithPhone;



/**
 验证密码

 @return YES NO
 */
-(BOOL)predicateStringWithPassword;


- (NSString*) urlEncodedString ;

- (NSString*) urlDecodedString ;




@end
