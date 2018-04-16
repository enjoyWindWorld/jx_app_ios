//
//  SPBaseBusiness.m
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/24.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseBusiness.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "SPMainModulesMacro.h"
//NSString * const fileUpLoad = @"smvc/file/fileupload";

@implementation SPBaseBusiness

-(void) uploadImageList:(NSMutableArray *)imageList
        withCompression:(CGFloat)compression
                success:(BusinessSuccessBlock)success
                failere:(BusinessFailureBlock)failere
{
    NSString *key = @"file";
 
    for (NSObject *object in imageList) {
        
        if ([object isKindOfClass:[ALAsset class]]) {
            
            ALAsset *asset = (ALAsset *)object;
            
            ALAssetRepresentation *representation = [asset defaultRepresentation];
            
            UIImage *image = [UIImage imageWithCGImage:representation.fullResolutionImage scale:1 orientation:(UIImageOrientation)representation.orientation];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

                [SPBaseNetWorkRequst uploadWithImage:image url:fileUpLoad filename:nil name:nil params:nil progress:nil didSuccess:success didFail:failere ];
                
            });
            
        }
        else if ([object isKindOfClass:[NSURL class]]) {
            
            NSURL *url = (NSURL *)object;
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
           
            [library assetForURL:url resultBlock:^(ALAsset *asset) {
                
                ALAssetRepresentation *assetRepresentation = [asset defaultRepresentation];
              
                UIImage *image = [UIImage imageWithCGImage:assetRepresentation.fullResolutionImage scale:1 orientation:UIImageOrientationUp];
                
              
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                 
                     [SPBaseNetWorkRequst uploadWithImage:image url:fileUpLoad filename:nil name:nil params:nil progress:nil didSuccess:success didFail:failere ];
                });
                
            } failureBlock:^(NSError *error) {
                
                

            }];
            
        }else if ([object isKindOfClass:[UIImage class]]){
        
            UIImage * iamge = object ;

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [SPBaseNetWorkRequst uploadWithImage:iamge url:fileUpLoad filename:nil name:nil params:nil progress:nil didSuccess:success didFail:failere ];
            });
            
        }else if ([object isKindOfClass:[PHAsset class]]){
        
            PHAsset * assest = object ;
            
            PHImageManager *imageManager = [PHImageManager defaultManager];
            
            PHImageRequestOptions *options = [PHImageRequestOptions new];
            options.networkAccessAllowed = YES;
            options.resizeMode = PHImageRequestOptionsResizeModeFast;
            options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
            options.synchronous = false;
            
            [imageManager requestImageForAsset:assest targetSize:CGSizeMake(assest.pixelWidth, assest.pixelHeight) contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage *result, NSDictionary *info) {
    
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    [SPBaseNetWorkRequst uploadWithImage:result url:fileUpLoad filename:nil name:nil params:nil progress:nil didSuccess:success didFail:failere ];
                });
            }];
    
        }
    }
}




@end
