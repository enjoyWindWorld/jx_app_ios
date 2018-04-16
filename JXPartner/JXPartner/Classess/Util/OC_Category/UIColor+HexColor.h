//
//  UIColor+HexColor.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/15.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)


/**
 16进制色吗

 @param hexString <#hexString description#>

 @return <#return value description#>
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;


+ (UIColor *)colorWithRGB:(CGFloat)R G:(CGFloat)G B:(CGFloat)B;

+ (UIColor *)colorWithRGB:(CGFloat)R G:(CGFloat)G B:(CGFloat)B alpha:(CGFloat)alpha;

@end
