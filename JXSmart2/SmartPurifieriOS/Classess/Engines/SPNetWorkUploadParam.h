//
//  SPNetWorkUploadParam.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/2/17.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <Foundation/Foundation.h>
//上传的参数模型
@interface SPNetWorkUploadParam : NSObject

/**
 *  上传的参数名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  上传到服务器的文件名称
 */
@property (nonatomic, copy) NSString *fileName;

/**
 *  上传文件的类型
 */
@property (nonatomic, copy) NSString *mimeType;

@end
