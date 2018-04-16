//
//  SPSDWebImage.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/14.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPSDWebImage.h"
#import <UIImageView+WebCache.h>

@implementation SPSDWebImage

+ (void)SPImageView:(UIImageView *)imageView imageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage
{
    
    //100天
    [SDWebImageManager sharedManager].imageCache.maxCacheAge = INT32_MAX;
 
    [SDWebImageManager sharedManager].imageCache.maxCacheSize = INT64_MAX;
    
    if ([url rangeOfString:@"http://data.jx-inteligent.tech:15010/jx"].location!=NSNotFound ||
        [url rangeOfString:@"http://113.106.93.195:15010/jx"].location!=NSNotFound) {

        url = [url stringByReplacingOccurrencesOfString:@"http://data.jx-inteligent.tech:15010/jx" withString:@"http://www.szjxzn.tech:8080/old_jx"];
        
        url = [url stringByReplacingOccurrencesOfString:@"http://113.106.93.195:15010/jx" withString:@"http://www.szjxzn.tech:8080/old_jx"];
    }
    

    NSURL * Imageurl = [NSURL URLWithString:url];
    
    [imageView sd_setImageWithURL:Imageurl placeholderImage:placeholderImage options:SDWebImageAllowInvalidSSLCertificates];
}

+ (void)clearDiskImages
{
    [[SDImageCache sharedImageCache]clearMemory];
    
    [[SDImageCache sharedImageCache] cleanDisk];
}

+ (NSInteger)getImagesSize
{
    return [[SDImageCache sharedImageCache]getSize];
}


@end
