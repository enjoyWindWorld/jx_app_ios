//
//  UIImageView+PartWeb.h
//  JXPartner
//
//  Created by windpc on 2017/8/16.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

@interface UIImageView (PartWeb)



-(void)imageWithURL:(NSString *)url placeholderImage:(NSString *)placeholderImage;

+(void)cleanImage;


@end
