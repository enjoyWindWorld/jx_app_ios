//
//  ShieldEmoji.h
//  SmartPurifieriOS
//
//  Created by yuan on 2016/12/16.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShieldEmoji : NSObject
- (BOOL)isContainsTwoEmoji:(NSString *)string;
- (NSString *)filterEmoji:(NSString *)string;

+ (BOOL)isContainsNewEmoji:(NSString *)string;
+ (NSString *)filterNewEmoji:(NSString *)string;

@end
