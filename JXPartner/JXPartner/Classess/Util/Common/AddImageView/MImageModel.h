//
//  MAddImageCell.h
//  newElementHospital
//
//  Created by Wind on 2015/11/21.
//  Copyright © 2016年 szxys.com. All rights reserved.
//

#import "SPBaseModel.h"

@interface MImageModel : SPBaseModel

@property (nonatomic,strong) NSString *_id;
//标题图片
@property (nonatomic,strong) id icon;
//缩略图
@property (nonatomic,strong) NSString *thumb;
//大图
@property (nonatomic,strong) NSString *image;

@end
