//
//  SPNetWorkUploadParamImage.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/2/17.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "SPNetWorkUploadParam.h"

@interface SPNetWorkUploadParamImage : SPNetWorkUploadParam

//ALAsset NSURL UIImage
@property (nonatomic,strong) NSMutableArray *imageList;

@property (nonatomic,assign) CGFloat compression ;

@end
