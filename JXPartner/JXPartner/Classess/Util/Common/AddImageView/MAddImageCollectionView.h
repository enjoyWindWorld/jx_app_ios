//
//  MAddImageCell.h
//  newElementHospital
//
//  Created by Wind on 2015/11/21.
//  Copyright © 2016年 szxys.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTAssetsPickerController.h"

#define KaddImageViewHeight 90

#define KaddImageViewWitdh 170

#define KLINECOUNT 4  //每行的总个数

@class MAddImageCollectionView;

@protocol MAddImageCollectionViewDelegate <NSObject>

@optional
-(void)updataAddImageViewHeight:(MAddImageCollectionView*)addConllectionView
                     imageCount:(NSInteger)imageCount;

-(void)updateIcon:(NSInteger)_iconIndex addiMageView:(MAddImageCollectionView *)addConllectionView;

@end

@interface MAddImageCollectionView : UIView <UICollectionViewDataSource,UICollectionViewDelegate,
UIActionSheetDelegate,CTAssetsPickerControllerDelegate,
UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UICollectionView *mCollectionView;
    NSMutableArray *images;
    
}
@property(nonatomic,assign)NSInteger maxImageCount;//默认为8

@property (nonatomic, strong) UIImage *addImage;

@property(nonatomic,assign)NSInteger iconIndex;

@property (nonatomic,assign) BOOL isShowEdit; //是否展示可编译的

@property(nonatomic,strong)NSLayoutConstraint *addImageViewHeight;

@property(nonatomic,assign)id<MAddImageCollectionViewDelegate> delegate;

-(id)initWithFrame:(CGRect)frame
            images:(NSArray *)mImages
          delegate:(id<MAddImageCollectionViewDelegate>)mDelegate;

-(void)setSelfSize:(CGSize)size;
-(NSMutableArray *)getImages;
-(void)setImages:(NSArray *)mImages;
//-(NSInteger)getIconIndex;

@end
