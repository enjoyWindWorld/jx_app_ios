//
//  WBaseViewController.h
//  MyApp
//
//  Created by Amale on 16/4/27.
//  Copyright © 2016年 Wind. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AlertViewAction)(BOOL editing);

@interface SPBaseViewController : UIViewController

-(void)compatibleAvailable_ios11:(UIScrollView*)scrollView;


@end
