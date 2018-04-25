//
//  UIButton+myFont.m
//  JXPartner
//
//  Created by Wind on 2018/4/18.
//  Copyright © 2018年 windpc. All rights reserved.
//

#import "UIButton+myFont.h"
#import <objc/runtime.h>

#define SizeScale (IS_IPHONE_6P ? 1.2 :IS_IPHONE_6 ? 1 : 0.8)

@implementation UIButton (myFont)
+ (void)load{
//    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
//    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
//    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    if (self) {
        //部分不像改变字体的 把tag值设置成333跳过
        if(self.titleLabel.tag != 333){
            CGFloat fontSize = self.titleLabel.font.pointSize;
            self.titleLabel.font = [UIFont systemFontOfSize:fontSize*SizeScale];
        }
    }
    return self;
}

@end

@implementation UILabel (myFont)
+ (void)load{
//    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
//    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
//    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    NSLog(@"SizeScale = %f",SizeScale);
    if (self) {
        //部分不像改变字体的 把tag值设置成333跳过
        if(self.tag != 333){
            CGFloat fontSize = self.font.pointSize;
            self.font = [UIFont systemFontOfSize:fontSize*SizeScale];
        }
    }
    return self;
}



@end


