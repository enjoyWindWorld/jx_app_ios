//
//  JXChooseReasonViewController.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/11/10.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseViewController.h"

typedef void(^touchActionBlock)(id model);

@interface JXChooseReasonViewController : SPBaseViewController

@property (nonatomic,copy) touchActionBlock  touchBlock ;

@end
