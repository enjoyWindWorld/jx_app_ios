//
//  SPCommunityServiceElectricityEntrance.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/16.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPCommunityServiceElectricityEntrance.h"
#import "CommunityViewController.h"
#import "CleanDetailViewController.h"
@implementation SPCommunityServiceElectricityEntrance

/**
 获取社区服务vc
 
 @return vc
 */


+(UIViewController*)getCommunityServiceViewController{

//    UIStoryboard * story = [UIStoryboard storyboardWithName:@"CommunityService" bundle:nil];
//    
//    return story.instantiateInitialViewController ;
    
    CommunityViewController *vc = [[CommunityViewController alloc]init];
    
    return vc;
    
}


+(UIViewController*)fetchCommunityDetailViewController:(NSString*)pubid{

    CleanDetailViewController * vc = [[CleanDetailViewController alloc] init];
    
    vc.pubId = pubid ;
    
    return vc;
}

@end
