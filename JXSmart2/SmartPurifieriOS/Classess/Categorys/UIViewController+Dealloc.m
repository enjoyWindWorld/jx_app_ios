//
//  UIViewController+Dealloc.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/2/21.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "UIViewController+Dealloc.h"
#import <objc/runtime.h>
@implementation UIViewController (Dealloc)
+ (void)load
{
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method method2 = class_getInstanceMethod([self class], @selector(deallocSwizzle));
    method_exchangeImplementations(method1, method2);
}

- (void)deallocSwizzle
{
     NSLog(@"%@被销毁了", [self class]);
    
    [self deallocSwizzle];
}

static char MethodKey;
- (void)setMethod:(NSString *)method
{
    objc_setAssociatedObject(self, &MethodKey, method, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)method
{
    return objc_getAssociatedObject(self, &MethodKey);
}
@end

@implementation UIView (Dealloc)
//+ (void)load
//{
//    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
//    Method method2 = class_getInstanceMethod([self class], @selector(deallocSwizzle));
//    method_exchangeImplementations(method1, method2);
//}
//
//- (void)deallocSwizzle
//{
//    NSLog(@"%@被销毁了", [self class]);
//    
//    [self deallocSwizzle];
//}
//
//static char MethodKey;
//- (void)setMethod:(NSString *)method
//{
//    objc_setAssociatedObject(self, &MethodKey, method, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//- (NSString *)method
//{
//    return objc_getAssociatedObject(self, &MethodKey);
//}
@end
