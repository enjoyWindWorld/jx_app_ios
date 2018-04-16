//
//  UIViewController+HUD.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/2/23.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDStatusBarNotification.h"
#import <SVProgressHUD.h>

typedef NS_ENUM(NSInteger,STATETYPE){

    STATETYPE_SUCCESS,  //成功
    
    STATETYPE_FAILERE,  //失败
};

@interface UIViewController (HUD)

- (BOOL)showHUD:(NSString *)error;

- (void)showHUD;

- (BOOL)hideHUDOrJDBar;

#pragma mark - Common

+(void)dismiss;

#pragma mark - SVProgressHUD Show

+(void)showHUDs:(NSString*)state;


#pragma mark - JDStatusBar Show

+ (void)showWithStatus:(NSString *)status
                      dismissAfter:(NSTimeInterval)timeInterval
                         styleName:(STATETYPE)styleName;


+(void)updateAnimationTypeWithSV:(SVProgressHUDAnimationType)style;

+(void)updateMaskTypeWithSV:(SVProgressHUDMaskType)maskType;

+(void)updateHUDStyleWithSV:(SVProgressHUDStyle)style;
/**
 设置jd的样式

 @param prepareBlock 返回一个style
 */
+(void)updateStyleWithJD:(JDPrepareStyleBlock)prepareBlock;


@end
