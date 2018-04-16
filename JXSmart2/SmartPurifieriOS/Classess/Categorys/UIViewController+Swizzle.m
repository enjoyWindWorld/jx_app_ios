//
//  UIViewController+Swizzle.m
//  RopeSkippingiOS
//
//  Created by windpc on 2017/2/24.
//  Copyright © 2017年 Wind. All rights reserved.
//

#import "UIViewController+Swizzle.h"
#import "objc/runtime.h"
#import "RDVTabBarController.h"
#import "SPBaseViewController.h"

@implementation UIViewController (Swizzle)


- (void)customviewWillAppear:(BOOL)animated{
   
    if ([[self.navigationController childViewControllers] count] > 1) {
        
        [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
        
        NSLog(@"setTabBarHidden:YES --- customviewWillAppear : %@", NSStringFromClass([self class]));
    }
    [self customviewWillAppear:animated];
}


- (void)customViewDidAppear:(BOOL)animated{
    

    if ([[self.navigationController childViewControllers] count] == 1) {
        
        [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
        
        NSLog(@"setTabBarHidden:YES --- customviewWillAppear : %@", NSStringFromClass([self class]));
    }
    
    [self customViewDidAppear:animated];
}



+ (void)load{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        
        Method WillAppearMethod = class_getInstanceMethod(class, @selector(viewWillAppear:));
        
        Method ToWillAppearMethod = class_getInstanceMethod(class, @selector(customviewWillAppear:));
        
        Method DidAppearMethod = class_getInstanceMethod(class, @selector(viewDidAppear:));
        
        Method ToDidAppearMethod = class_getInstanceMethod(class, @selector(customViewDidAppear:));
        /**
         *  我们在这里使用class_addMethod()函数对Method Swizzling做了一层验证，如果self没有实现被交换的方法，会导致失败。
         *  而且self没有交换的方法实现，但是父类有这个方法，这样就会调用父类的方法，结果就不是我们想要的结果了。
         *  所以我们在这里通过class_addMethod()的验证，如果self实现了这个方法，class_addMethod()函数将会返回NO，我们就可以对其进行交换了。
         */
        if (!class_addMethod(class, @selector(viewWillAppear:), method_getImplementation(ToWillAppearMethod), method_getTypeEncoding(ToWillAppearMethod))) {
            method_exchangeImplementations(WillAppearMethod, ToWillAppearMethod);
        }
        
        if (!class_addMethod(class, @selector(viewDidAppear:), method_getImplementation(ToDidAppearMethod), method_getTypeEncoding(ToDidAppearMethod))) {
            method_exchangeImplementations(DidAppearMethod, ToDidAppearMethod);
        }
        
        
    });
    
}
@end




