//
//  SPSDWebImage.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/14.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIButton+WebCache.h>
@interface SPSDWebImage : NSObject

/**
 *  加载网络图片
 *
 *  @param imageView        要显示图片的UIImageView控件
 *  @param url              图片的URl 地址字符串
 *  @param placeholderImage 占位符图片
 */
+ (void)SPImageView:(UIImageView *)imageView imageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage;

/**
 *  清空SD卡里的图片缓存
 */
+ (void)clearDiskImages;

/**
 *  获取SD卡里图片缓存的总大小
 *
 *  @return 返回文件总大小
 */
+ (NSInteger)getImagesSize;


@end
