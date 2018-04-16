//
//  SPLoginElectricityEntrance.m
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/22.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPLoginElectricityEntrance.h"


@implementation SPLoginElectricityEntrance


+(UIViewController*)getLoginViewController {

    UIStoryboard * story = [UIStoryboard storyboardWithName:@"MainPage" bundle:nil];
    
    return story.instantiateInitialViewController;

}

@end
