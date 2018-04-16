//
//  JXPartnerViewElectricityEntrance.h
//  JXPartner
//
//  Created by windpc on 2017/8/16.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXPartnerViewElectricityEntrance : NSObject


+(UIViewController*)fetchPartnerViewController;

+(UIViewController*)fetchNewIncomeViewController:(id)model ordno:(NSString*)ordno;

+(UIViewController*)fetchPlanFilterViewControllerWithCurrentSearch:(BOOL)currentSearch;

+(UIViewController*)fetchAfterSalesListWithAfterState:(NSInteger)state;

@end
