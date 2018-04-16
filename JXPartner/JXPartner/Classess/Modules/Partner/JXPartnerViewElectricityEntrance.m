//
//  JXPartnerViewElectricityEntrance.m
//  JXPartner
//
//  Created by windpc on 2017/8/16.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXPartnerViewElectricityEntrance.h"
#import "JXNewIncomeTableViewController.h"
#import "JXPlanFilterLifeViewController.h"
#import "JXAfterSalesViewController.h"

@implementation JXPartnerViewElectricityEntrance

+(UIViewController*)fetchPartnerViewController{

    UIStoryboard * story = [UIStoryboard storyboardWithName:@"JXPartner" bundle:nil];
    
    return story.instantiateInitialViewController;
}


+(UIViewController*)fetchNewIncomeViewController:(id)model ordno:(NSString*)ordno{
    
    UIStoryboard * story = [UIStoryboard storyboardWithName:@"JXPartner" bundle:nil];
    
    JXNewIncomeTableViewController * vc = [story instantiateViewControllerWithIdentifier:@"JXNewIncomeTableViewControllerXBID"];
    
    vc.subModel = model ;
    
    vc.walletOrdersn = ordno ;
    
    return vc;
}


+(UIViewController*)fetchPlanFilterViewControllerWithCurrentSearch:(BOOL)currentSearch{

    UIStoryboard * story = [UIStoryboard storyboardWithName:@"JXPartner" bundle:nil];

    JXPlanFilterLifeViewController * vc = [story instantiateViewControllerWithIdentifier:@"JXPlanFilterLifeViewControllerXBID"];

    vc.currentSearch = currentSearch;

    return vc;

}

+(UIViewController*)fetchAfterSalesListWithAfterState:(NSInteger)index{

    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"JXPartner" bundle:nil];

    JXAfterSalesViewController * vc  =  [sb instantiateViewControllerWithIdentifier:@"JXAfterSalesViewControllerXBID"];

    vc.after_State = index == 0 ? 1 : 200 ;

    return vc;

}

@end
