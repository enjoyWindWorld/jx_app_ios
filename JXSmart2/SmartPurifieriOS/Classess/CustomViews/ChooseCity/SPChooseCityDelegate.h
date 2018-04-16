//
//  SPChooseCityDelegate.h
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/22.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SPChooseCityViewController;
@class SPCityModel ;

@protocol SPChooseCityDelegate <NSObject>

- (void) cityPickerController:(SPChooseCityViewController *)chooseCityController
                didSelectCity:(SPCityModel *)city;

- (void) cityPickerControllerDidCancel:(SPChooseCityViewController *)chooseCityController;

@end


@protocol SPCityGroupCellDelegate <NSObject>

- (void) cityGroupCellDidSelectCity:(SPCityModel *)city;

@end
