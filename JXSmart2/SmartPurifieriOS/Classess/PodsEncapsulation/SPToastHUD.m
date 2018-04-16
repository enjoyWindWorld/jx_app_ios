//
//  SPToastHUD.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/14.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPToastHUD.h"


@implementation SPToastHUD

+ (void)makeToast:(NSString *)message makeView:(UIView *)view
{
    [view makeToast:message];
}

+(void)makeToast:(NSString *)message
        duration:(NSTimeInterval)duration
        position:(id)position
        makeView:(UIView *)view{

    [view makeToast:message duration:duration position:CSToastPositionCenter];

}



@end
