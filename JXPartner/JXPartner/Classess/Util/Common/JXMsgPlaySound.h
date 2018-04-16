//
//  JXMsgPlaySound.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/30.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
@interface JXMsgPlaySound : NSObject

+ (void)initSystemShake;//系统 震动

+ (void)initSystemSoundWithName:(NSString *)soundName SoundType:(NSString *)soundType;//初始化系统声音

+ (void)initSystemShakeSoundWithName:(NSString *)soundName SoundType:(NSString *)soundType;

@end
