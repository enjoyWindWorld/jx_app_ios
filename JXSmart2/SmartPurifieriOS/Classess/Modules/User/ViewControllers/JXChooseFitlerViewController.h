//
//  JXChooseFitlerViewController.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/11/7.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseViewController.h"

typedef void(^touchActionBlock)(id model);

@interface JXChooseFitlerViewController : SPBaseViewController

@property (nonatomic,copy) touchActionBlock  touchBlock ;

@property (nonatomic,copy) NSString * prono ;

@end
