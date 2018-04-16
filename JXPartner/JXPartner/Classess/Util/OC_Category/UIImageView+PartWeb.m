//
//  UIImageView+PartWeb.m
//  JXPartner
//
//  Created by windpc on 2017/8/16.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "UIImageView+PartWeb.h"


@implementation UIImageView (PartWeb)

-(void)imageWithURL:(NSString *)url placeholderImage:(NSString *)placeholderImage{

    [SDWebImageManager sharedManager].imageCache.maxCacheAge = INT32_MAX;
    
    [SDWebImageManager sharedManager].imageCache.maxCacheSize = INT64_MAX;
    
    if ([url rangeOfString:@"http://data.jx-inteligent.tech:15010/jx"].location!=NSNotFound ||
        [url rangeOfString:@"http://113.106.93.195:15010/jx"].location!=NSNotFound) {
        
        url = [url stringByReplacingOccurrencesOfString:@"http://data.jx-inteligent.tech:15010/jx" withString:@"http://www.szjxzn.tech:8080/old_jx"];
        
        url = [url stringByReplacingOccurrencesOfString:@"http://113.106.93.195:15010/jx" withString:@"http://www.szjxzn.tech:8080/old_jx"];
    }
    
    
    NSURL * Imageurl = [NSURL URLWithString:url];
    
    [self sd_setImageWithURL:Imageurl placeholderImage:[UIImage imageNamed:placeholderImage] options:SDWebImageAllowInvalidSSLCertificates];
        
}



+(void)cleanImage{

      [[SDImageCache sharedImageCache]cleanDisk];
}

@end
