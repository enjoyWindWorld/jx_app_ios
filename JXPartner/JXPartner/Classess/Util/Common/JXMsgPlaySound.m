//
//  JXMsgPlaySound.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/30.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXMsgPlaySound.h"

@implementation JXMsgPlaySound

+ (void)initSystemShake{

     AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//震动
    
//     AudioServicesPlaySystemSound(1109);
}

+ (void)initSystemSoundWithName:(NSString *)soundName SoundType:(NSString *)soundType{

    SystemSoundID sound;
    
    NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",soundName,soundType];

    if (path) {
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&sound);
        
        if (error != kAudioServicesNoError) {//获取的声音的时候，出现错误
            sound = -0;
        }
        
        AudioServicesPlaySystemSound(sound);
    }
}

+ (void)initSystemShakeSoundWithName:(NSString *)soundName SoundType:(NSString *)soundType{

    [[self class] initSystemShake];
    
    [[self class ] initSystemShakeSoundWithName:soundName SoundType:soundType];
    
}



@end
