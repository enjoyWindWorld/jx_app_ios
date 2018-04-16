//
//  UIViewController+HUD.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/2/23.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "UIViewController+HUD.h"

@implementation UIViewController (HUD)

#pragma mark - Common

+(void)dismiss{

    [JDStatusBarNotification dismiss];
    
    [SVProgressHUD dismiss];
}

#pragma mark - SVProgressHUD Show

+(void)showHUDs:(NSString*)state{

    if ([[self class]jx_privateMethod_isVisible]) {

        
    }
}


#pragma mark - JDStatusBar Show

+ (void)showWithStatus:(NSString *)status
          dismissAfter:(NSTimeInterval)timeInterval
             styleName:(STATETYPE)styleName{
    
    if ([[self class]jx_privateMethod_isVisible]) {
        
        NSString * tyle = styleName==STATETYPE_SUCCESS?JDStatusBarStyleSuccess:JDStatusBarStyleError;
        
        [JDStatusBarNotification showWithStatus:status dismissAfter:timeInterval styleName:tyle];
    }
}


+(void)updateAnimationTypeWithSV:(SVProgressHUDAnimationType)style{

    
}

+(void)updateMaskTypeWithSV:(SVProgressHUDMaskType)maskType{

    
}

+(void)updateHUDStyleWithSV:(SVProgressHUDStyle)style{

    
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


- (BOOL)showHUD:(NSString *)error{

    if ([JDStatusBarNotification isVisible]||[SVProgressHUD isVisible]) {//如果statusBar上面正在显示信息，则不再用hud显示error
        return NO;
    }
    
    [SVProgressHUD showWithStatus:error];
    
    return YES;
}
//
- (void)showHUD{

    [SVProgressHUD show];
    
}
//
- (BOOL)hideHUDOrJDBar{

    [JDStatusBarNotification dismiss];
    
    [SVProgressHUD dismiss];
    
    return YES;
}


- (void)showJDStatusBarSuccessStr:(NSString *)tipStr{

}

- (void)showJDStatusBarErrorStr:(NSString *)errorStr{

}

- (void)setJDStatusBarDefaultStyle:(JDPrepareStyleBlock)prepareBlock{

    
}

//+ (BOOL)showError:( *)error{
//   
//    if ([JDStatusBarNotification isVisible]) {//如果statusBar上面正在显示信息，则不再用hud显示error
//       
//        NSLog(@"如果statusBar上面正在显示信息，则不再用hud显示error");
//        return NO;
//    }
//    [UIViewController showHudTipStr:error];
//    return YES;
//}
//+ (void)showHudTipStr:(NSString *)tipStr{
//    if (tipStr && tipStr.length > 0) {
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
//        hud.mode = MBProgressHUDModeText;
//        hud.detailsLabelFont = [UIFont boldSystemFontOfSize:15.0];
//        hud.detailsLabelText = tipStr;
//        hud.margin = 10.f;
//        hud.removeFromSuperViewOnHide = YES;
//        [hud hide:YES afterDelay:1.0];
//    }
//}
//+ (instancetype)showHUDQueryStr:(NSString *)titleStr{
//    titleStr = titleStr.length > 0? titleStr: @"正在获取数据...";
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
//    hud.tag = kHUDQueryViewTag;
//    hud.labelText = titleStr;
//    hud.labelFont = [UIFont boldSystemFontOfSize:15.0];
//    hud.margin = 10.f;
//    return hud;
//}
//+ (NSUInteger)hideHUDQuery{
//    __block NSUInteger count = 0;
//    NSArray *huds = [MBProgressHUD allHUDsForView:kKeyWindow];
//    [huds enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
//        if (obj.tag == kHUDQueryViewTag) {
//            [obj removeFromSuperview];
//            count++;
//        }
//    }];
//    return count;
//}
//+ (void)showStatusBarQueryStr:(NSString *)tipStr{
//    [JDStatusBarNotification showWithStatus:tipStr styleName:JDStatusBarStyleSuccess];
//    [JDStatusBarNotification showActivityIndicator:YES indicatorStyle:UIActivityIndicatorViewStyleWhite];
//}
//+ (void)showStatusBarSuccessStr:(NSString *)tipStr{
//    if ([JDStatusBarNotification isVisible]) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
//            [JDStatusBarNotification showWithStatus:tipStr dismissAfter:1.5 styleName:JDStatusBarStyleSuccess];
//        });
//    }else{
//        [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
//        [JDStatusBarNotification showWithStatus:tipStr dismissAfter:1.0 styleName:JDStatusBarStyleSuccess];
//    }
//}
//+ (void)showStatusBarErrorStr:(NSString *)errorStr{
//    if ([JDStatusBarNotification isVisible]) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
//            [JDStatusBarNotification showWithStatus:errorStr dismissAfter:1.5 styleName:JDStatusBarStyleError];
//        });
//    }else{
//        [JDStatusBarNotification showActivityIndicator:NO indicatorStyle:UIActivityIndicatorViewStyleWhite];
//        [JDStatusBarNotification showWithStatus:errorStr dismissAfter:1.5 styleName:JDStatusBarStyleError];
//    }
//}
//
//+ (void)showStatusBarError:(NSError *)error{
//    NSString *errorStr = [NSObject tipFromError:error];
//    [NSObject showStatusBarErrorStr:errorStr];
//}

@end
