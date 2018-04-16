//
//  SPToastHUD.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/14.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIView+Toast.h>

@interface SPToastHUD : NSObject

+ (void)makeToast:(NSString *)message makeView:(UIView *)view;

+(void)makeToast:(NSString *)message
        duration:(NSTimeInterval)duration
        position:(id)position
        makeView:(UIView *)view;



@end
