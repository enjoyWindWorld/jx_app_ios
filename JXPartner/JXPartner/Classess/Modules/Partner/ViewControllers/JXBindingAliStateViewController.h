//
//  JXBindingAliStateViewController.h
//  JXPartner
//
//  Created by windpc on 2017/8/18.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXBaseTableViewController.h"
#import "JXBindingAliStateModel.h"

@interface JXBindingAliStateViewController : JXBaseTableViewController

@property (nonatomic,assign) AliBindingState  aliState ;

@property (nonatomic,strong) JXBindingAliStateModel * stateModel ;

@end
