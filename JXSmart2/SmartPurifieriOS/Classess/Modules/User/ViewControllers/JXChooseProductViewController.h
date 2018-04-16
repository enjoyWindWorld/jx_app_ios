//
//  JXChooseProductViewController.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/11/6.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseViewController.h"

typedef void(^touchActionBlock)(id model);

@interface JXChooseProductViewController : SPBaseViewController

@property (nonatomic,copy) touchActionBlock  touchBlock ;

@end
