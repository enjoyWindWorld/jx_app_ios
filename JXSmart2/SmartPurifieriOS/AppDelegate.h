//
//  AppDelegate.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/14.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPTabbarViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, assign) BOOL allowRotation;

@property (nonatomic,strong) SPTabbarViewController * tabbar;

@property (nonatomic,retain) NSString *configStatus;


-(void)setTabbarWithRootViewC;

-(void)setLoginVCWithRootViewC;

+(void)jx_privateMethod_FullScreenView;

@end

