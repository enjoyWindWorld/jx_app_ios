//
//  UIViewController+HUD.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/2/23.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "UIViewController+HUD.h"
#import "JDStatusBarNotification.h"

@implementation UIViewController (HUD)

- (void)show{
    
    [UIViewController updateMaskTypeWithSV:SVProgressHUDMaskTypeClear];

     [self showWithStatus:nil];
}
- (void)showWithStatus:(NSString*)status{
    
    [UIViewController updateMaskTypeWithSV:SVProgressHUDMaskTypeClear];

    [SVProgressHUD showWithStatus:status];
}
- (void)showProgress:(float)progress{
    
    [UIViewController updateMaskTypeWithSV:SVProgressHUDMaskTypeClear];

    [SVProgressHUD showProgress:progress];
}
- (void)showProgress:(float)progress status:(NSString*)status{
    
    [UIViewController updateMaskTypeWithSV:SVProgressHUDMaskTypeClear];

    [SVProgressHUD showProgress:progress status:status];
}
- (void)showSuccessWithStatus:(NSString*)status{
    
    [UIViewController updateMaskTypeWithSV:SVProgressHUDMaskTypeNone];

    [SVProgressHUD showSuccessWithStatus:status];
    
    [SVProgressHUD setMinimumDismissTimeInterval:1];
}
- (void)showErrorWithStatus:(NSString*)status{
    
    [UIViewController updateMaskTypeWithSV:SVProgressHUDMaskTypeNone];

    [SVProgressHUD showErrorWithStatus:status];
    
    [SVProgressHUD setMinimumDismissTimeInterval:1];
}



#pragma mark - Common

+(void)dismiss{

    [JDStatusBarNotification dismiss];
    
    [SVProgressHUD dismiss];
}


-(void)makeToast:(NSString *)message{

    [self makeToast:message duration:3 position:CSToastPositionCenter];
}

-(void)makeToast:(NSString *)message
        duration:(NSTimeInterval)duration{

    [self makeToast:message duration:duration position:CSToastPositionCenter];
}

-(void)makeToast:(NSString *)message
        duration:(NSTimeInterval)duration
        position:(id)position{
    
    [self.view makeToast:message duration:duration position:position ];
}



#pragma mark - JDStatusBar Show

+ (void)showWithStatus:(NSString *)status
          dismissAfter:(NSTimeInterval)timeInterval
             styleName:(STATETYPE)styleName{
    
        
    NSString * tyle = styleName==STATETYPE_SUCCESS?JDStatusBarStyleSuccess:JDStatusBarStyleError;

    [JDStatusBarNotification showWithStatus:status dismissAfter:timeInterval styleName:tyle];
    
}


+(void)updateAnimationTypeWithSV:(SVProgressHUDAnimationType)style{

    [SVProgressHUD setDefaultAnimationType:style];
}

+(void)updateMaskTypeWithSV:(SVProgressHUDMaskType)maskType{

    [SVProgressHUD setDefaultMaskType:maskType];
}

+(void)updateHUDStyleWithSV:(SVProgressHUDStyle)style{

    [SVProgressHUD setDefaultStyle:style];
}
/**
 设置jd的样式
 
 @param prepareBlock 返回一个style
 */
+(void)updateStyleWithJD:(JDPrepareStyleBlock)prepareBlock{

    
}

+(BOOL)jx_privateMethod_isVisible{

    if ([JDStatusBarNotification isVisible]||[SVProgressHUD isVisible]){
        return NO;
    }
    
    return YES;
}


- (void)showJDStatusBarSuccessStr:(NSString *)tipStr{

}

- (void)showJDStatusBarErrorStr:(NSString *)errorStr{

}

//- (void)setJDStatusBarDefaultStyle:(JDPrepareStyleBlock)prepareBlock{
//
//
//}


@end
