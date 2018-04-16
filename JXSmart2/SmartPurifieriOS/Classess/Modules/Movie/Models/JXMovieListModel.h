//
//  JXMovieListModel.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/29.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseModel.h"

@interface JXMovieListModel : SPBaseModel

@property (nonatomic,copy) NSString * title;

@property (nonatomic,copy) NSString * img ; //有可能是gif

@property (nonatomic,copy) NSString * video ;

@end
