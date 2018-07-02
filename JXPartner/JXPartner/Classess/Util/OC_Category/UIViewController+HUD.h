//
//  UIViewController+HUD.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/2/23.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SVProgressHUD.h>
#import <Toast/UIView+Toast.h>

typedef NS_ENUM(NSInteger,STATETYPE){

    STATETYPE_SUCCESS,  //成功
    
    STATETYPE_FAILERE,  //失败
};

@interface UIViewController (HUD)

- (void)show;
- (void)showWithStatus:(NSString*)status;
- (void)showProgress:(float)progress;
- (void)showProgress:(float)progress status:(NSString*)status;
- (void)showSuccessWithStatus:(NSString*)status;
- (void)showErrorWithStatus:(NSString*)status;
- (void)showDefaultWithStatus:(NSString*)status;

-(void)makeToast:(NSString *)message
        duration:(NSTimeInterval)duration
        position:(id)position;

-(void)makeToast:(NSString *)message ;

-(void)makeToast:(NSString *)message
        duration:(NSTimeInterval)duration;

#pragma mark - Common

+(void)dismiss;



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
//+(void)updateStyleWithJD:(JDPrepareStyleBlock)prepareBlock;


@end
