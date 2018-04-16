//
//  MyCenterViewController.h
//  SmartPurifieriOS
//
//  Created by yuan on 2016/12/21.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBaseViewController.h"

@class SPUserModel ;

@interface MyCenterViewController : SPBaseViewController
@property (nonatomic,strong) SPUserModel * userModel ;
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event;

@end
