//
//  MAddImageCell.h
//  newElementHospital
//
//  Created by Wind on 2015/11/21.
//  Copyright © 2016年 szxys.com. All rights reserved.
//
#import "MAddImageCollectionView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "MAddImageCell.h"
#import "MCollectionViewCell.h"
#import "MImageModel.h"

#import "MWPhotoBrowser.h"

@interface MAddImageCollectionView()
<MWPhotoBrowserDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    
}
@property (nonatomic,strong)ALAssetsLibrary *assetsLibrary;

@property (nonatomic,strong)  MWPhotoBrowser *browser  ;

@end

@implementation MAddImageCollectionView

-(id)initWithFrame:(CGRect)frame
            images:(NSArray *)mImages
          delegate:(id<MAddImageCollectionViewDelegate>)mDelegate
{
    self =  [super initWithFrame:frame];
    _delegate = mDelegate;
    
    if (self)
    {
        
        images = [[NSMutableArray alloc]initWithArray:mImages];
        [self creatCollectionView];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        images = [[NSMutableArray alloc]init];
        [self creatCollectionView];
    }
    return self;
}

-(void) setAddImage:(UIImage *)addImage
{
    _addImage = addImage;
    [mCollectionView reloadData];
}

-(void)creatCollectionView
{
    self.assetsLibrary = [[ALAssetsLibrary alloc]init];
    self.addImageViewHeight = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeHeight multiplier:0 constant:self.frame.size.height];
    
    if (self.maxImageCount == 0) {
        self.maxImageCount = 8;
    }
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumInteritemSpacing      = 2.0;
    flowLayout.minimumLineSpacing           = 2.0;
    
    mCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
    mCollectionView.backgroundColor = [UIColor whiteColor];

    mCollectionView.delegate = self;
    mCollectionView.dataSource = self;
    
    [mCollectionView registerNib:[UINib nibWithNibName:@"MCollectionViewCell" bundle:Nil]
     forCellWithReuseIdentifier:@"MCollectionIdentifier"];
    [mCollectionView registerNib:[UINib nibWithNibName:@"MAddImageCell" bundle:Nil]
      forCellWithReuseIdentifier:@"MAddImageCellIdentifier"];
    
    [self addSubview:mCollectionView];
}

#pragma mark -CollectionView datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (images.count<self.maxImageCount){
        return images.count+1;
    }
    return images.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    if (images.count==0 ) {
        
        static NSString *CellIdentifier = @"MAddImageCellIdentifier";
        MAddImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier
                                                                        forIndexPath:indexPath];

        if (_addImage) {
            [cell.addButton setBackgroundImage:_addImage forState:UIControlStateNormal];
            [cell.addButton setBackgroundImage:_addImage forState:UIControlStateHighlighted];
        }
        [cell.addButton addTarget:self  action:@selector(addImageAction) forControlEvents:UIControlEventTouchUpInside];
        cell.messLabel.text = [NSString stringWithFormat:@"添加图片(最多添加%ld张)",(long)self.maxImageCount];
        return cell;
        
    } else{
        static NSString *CellIdentifier = @"MCollectionIdentifier";
        
        MCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (images.count<self.maxImageCount && indexPath.row == images.count) {
            
            cell.iconImage.image = [UIImage imageNamed:SPPRODUCTICOPLACEHOLDERImage];
            if (_addImage) {
                cell.iconImage.image = _addImage;
            }
        }else {
            id object = [images objectAtIndex:indexPath.row];
            
            if ([object isKindOfClass:[PHAsset class]]) {
                
                PHAsset * asset = object;
                
                CGFloat witdhHeith = (collectionView.frame.size.width-(10*(KLINECOUNT+1)))/KLINECOUNT;
                
                [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(witdhHeith, witdhHeith) contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                    // 回调部分

                    [cell.iconImage setImage:result];
                }];
                
                
            }else
            if ([object isKindOfClass:[ALAsset class]]) {
                
                ALAsset *asset = object;
                
                [cell.iconImage setImage:[UIImage imageWithCGImage:asset.thumbnail]];
                
            }else
                if ([object isKindOfClass:[UIImage class]]) {
                
                    cell.iconImage.image = object;
                    
                }else if([object isKindOfClass:[NSURL class]]) {
                
                ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
                
                [library assetForURL:object resultBlock:^(ALAsset *asset) {
                    
                    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
                    CGImageRef imgRef = [assetRep fullResolutionImage];
                    UIImage *img = [UIImage imageWithCGImage:imgRef
                                                       scale:assetRep.scale
                                                 orientation:(UIImageOrientation)assetRep.orientation];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [cell.iconImage setImage:img];
                    });
                    
                } failureBlock:^(NSError *error) {
                    
                }];
            }else if ([object isKindOfClass:[MImageModel class]]) {
                MImageModel *model = object;
                
                [SPSDWebImage SPImageView:cell.iconImage imageWithURL:model.icon placeholderImage:[UIImage imageNamed:SPPRODUCTICOPLACEHOLDERImage]];
            }else if ([object isKindOfClass:[NSString class]]){

                [SPSDWebImage SPImageView:cell.iconImage imageWithURL:object placeholderImage:[UIImage imageNamed:SPPRODUCTICOPLACEHOLDERImage]];
            }
        }
        return cell;
    }
    
    return nil;
}

#pragma mark- UICollectionViewDelegate
//设置元素的的大小框
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (images.count>0){
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }else {
        return UIEdgeInsetsMake(10, 0, 10, 0);
    }
    return UIEdgeInsetsZero;
}
//设置元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (images.count==0){
        return CGSizeMake(collectionView.frame.size.width, KaddImageViewHeight);
    }
    CGFloat witdhHeith = (collectionView.frame.size.width-(10*(KLINECOUNT+1)))/KLINECOUNT;
    
    return CGSizeMake(witdhHeith,witdhHeith);
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (images.count>0)
    {
        if (images.count<self.maxImageCount && indexPath.row == images.count) {
            
            //添加照片
            [self addImageAction];
            
        }else{
            _browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
            _browser.displayActionButton = NO;
            _browser.displayNavArrows = NO;
            _browser.displaySelectionButtons = NO;
            _browser.alwaysShowControls = NO;
            _browser.zoomPhotosToFill = YES;
            _browser.enableGrid = NO;
            _browser.startOnGrid = NO;
            _browser.enableSwipeToDismiss = YES;

            if (!_isShowEdit) {

                UIButton * leftbt = [UIButton buttonWithType:UIButtonTypeCustom];

                leftbt.frame = CGRectMake(0, 0, 40, 25);

                [leftbt addTarget:self action:@selector(requestDleteImage) forControlEvents:UIControlEventTouchUpInside];

                [leftbt setTitle:@"删除" forState:UIControlStateNormal];
                [leftbt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                UIBarButtonItem * btn_Item = [[UIBarButtonItem alloc] initWithCustomView:leftbt];
                UIBarButtonItem * space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
                space.width = -15;
                _browser.navigationItem.rightBarButtonItems = @[btn_Item,space];
            }
//            browser.showDelButtonItem = YES;
            [_browser setCurrentPhotoIndex:indexPath.row];
            [((UIViewController *)_delegate).navigationController pushViewController:_browser animated:YES];
        }
        
    }
}

-(void)requestDleteImage{

    [self deletPhotoBrowser:_browser photoAtIndex:_browser.currentIndex];
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return images.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < images.count)
    {
        id object =  [images objectAtIndex:index];
        if ([object isKindOfClass:[NSURL class]])
        {
            
            return[MWPhoto photoWithURL:object];
            
        }else if ([object isKindOfClass:[ALAsset class]])
        {
            ALAsset *asset = object;
            return [MWPhoto photoWithURL:asset.defaultRepresentation.url];
            
        }else if ([object isKindOfClass:[MImageModel class]])
        {
            MImageModel *model = object;
            return[MWPhoto photoWithURL:[NSURL URLWithString:model.image]];
        }else if ([object isKindOfClass:[PHAsset class]]) {
            
            PHAsset * asset = object;
            
            return [MWPhoto photoWithAsset:asset targetSize:CGSizeMake(asset.pixelWidth, asset.pixelHeight)];
            
        }else if ([object isKindOfClass:[UIImage class]]){
        
            return [MWPhoto photoWithImage:object];
        }else if ([object isKindOfClass:[NSString class]]){

            return [MWPhoto photoWithURL:[NSURL URLWithString:object]];
        }
    }
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser
           thumbPhotoAtIndex:(NSUInteger)index {
    
    if (index < images.count)
    {
        id object =  [images objectAtIndex:index];
        if ([object isKindOfClass:[NSURL class]])
        {
            
            return[MWPhoto photoWithURL:object];
            
        }else if ([object isKindOfClass:[ALAsset class]])
        {
            UIImage *image = [UIImage imageWithCGImage:[(ALAsset *)object thumbnail]];
            return [MWPhoto photoWithImage:image];
            
        }else if ([object isKindOfClass:[MImageModel class]])
        {
            MImageModel *model = object;
            return[MWPhoto photoWithURL:[NSURL URLWithString:model.thumb]];
        }else if ([object isKindOfClass:[PHAsset class]]) {
            
            PHAsset * asset = object;
        
            return [MWPhoto photoWithAsset:asset targetSize:CGSizeMake(asset.pixelWidth, asset.pixelHeight)];
        }else if ([object isKindOfClass:[UIImage class]]){
            
            return [MWPhoto photoWithImage:object];
        }else if ([object isKindOfClass:[NSString class]]){

            return [MWPhoto photoWithURL:[NSURL URLWithString:object]];

        }
    }
    return nil;
}
-(void)deletPhotoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    if (index<images.count) {
        if (self.iconIndex == index) {
            self.iconIndex = 0;
        }
        [images removeObjectAtIndex:index];
        if (images.count>0) {
            [photoBrowser reloadData];
        }else{
            [photoBrowser.navigationController popViewControllerAnimated:YES];
        }
        if (_delegate && [_delegate respondsToSelector:@selector(updataAddImageViewHeight:imageCount:)]){
            [_delegate updataAddImageViewHeight:self imageCount:images.count];
        }
        [mCollectionView reloadData];
    }
}

#pragma mark- 添加图片
-(void)addImageAction {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择添加方式"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [sheet showInView:self.superview];
    
}
#pragma mark - UIActionSheeetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //拍照
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            [picker setAllowsEditing:YES];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [(UIViewController *)_delegate presentViewController:picker
                                                         animated:YES
                                                       completion:^{
                                                           
                                                       }];
            
        }
        
    }else if (buttonIndex == 1)
    {
        CTAssetsPickerController *picker = [[CTAssetsPickerController alloc]init];
        picker.selectedAssets = images;
        
//        picker.maximumNumberOfSelection = self.maxImageCount;
//        picker.assetsFilter = [ALAssetsFilter allPhotos];
        picker.delegate = self;
        
        [(UIViewController *)_delegate presentViewController:picker animated:YES completion:NULL];
    }
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *originImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [self.assetsLibrary writeImageToSavedPhotosAlbum:originImage.CGImage
                                         orientation:(ALAssetOrientation)[originImage imageOrientation]
                                     completionBlock:^(NSURL *assetURL, NSError *error)
     {
         if (!error) {
             [self.assetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                 
                 [images addObject:originImage];
                 if (_delegate && [_delegate respondsToSelector:@selector(updataAddImageViewHeight:imageCount:)]){
                     [_delegate updataAddImageViewHeight:self imageCount:images.count];
                 }
                 [mCollectionView reloadData];
             } failureBlock:^(NSError *error) {
               
                 [SPSVProgressHUD showErrorWithStatus:@"选择图片失败,请重新选择"];
                 
             }];
         }else
         {
             [SPSVProgressHUD showErrorWithStatus:@"选择图片失败,请重新选择"];
         }
         
     }];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark- CTAssetsPickerControllerDelegate
- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{

    [images setArray:assets];
    
    [self updataAddImageViewHeight:self imageCount:images.count];

    [mCollectionView reloadData];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset{

    if (picker.selectedAssets.count >= _maxImageCount) {
        
        UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:@"提示"
                                            message:[NSString stringWithFormat:@"最多添加%ld张", (long)_maxImageCount]
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action =
        [UIAlertAction actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                               handler:nil];
        
        [alert addAction:action];
        
        [picker presentViewController:alert animated:YES completion:nil];
        
        return NO;
    }
    
    return YES ;
}

-(void)assetsPickerController:(CTAssetsPickerController *)picker didDeselectAsset:(PHAsset *)asset{

    [images removeObject:asset];

}


-(void)updataAddImageViewHeight:(MAddImageCollectionView *)addConllectionView
                     imageCount:(NSInteger)imageCount {
    NSInteger count = imageCount;
    if (count>0 &&  count<addConllectionView.maxImageCount){
        count +=1;
    }
    float height = [self getAddImageViewHeight:count];
    self.addImageViewHeight.constant = height;
    [addConllectionView setSelfSize:addConllectionView.size];
    if (_delegate && [self.delegate respondsToSelector:@selector(updataAddImageViewHeight:imageCount:)]) {
        [self.delegate updataAddImageViewHeight:self imageCount:imageCount];
    }
}

-(CGFloat)getAddImageViewHeight:(NSInteger)count {
    //返回添加图片view的总高度
    NSInteger line = count%KLINECOUNT>0?(count/KLINECOUNT+1):count/KLINECOUNT;
    if (count!=0) {
        
        CGFloat witdhHeith = ([UIScreen mainScreen].bounds.size.width-(10*(KLINECOUNT+1)))/KLINECOUNT;
        
        return witdhHeith*line+(line+1)*10;
    }
    return KaddImageViewHeight+(line+2)*10;
}

#pragma mark- 设置mCollectionViewSize
-(void)setSelfSize:(CGSize)size
{
    mCollectionView.size = CGSizeMake(mCollectionView.width, size.height);
}
-(NSMutableArray *)getImages
{
    return images;
}
-(void)setImages:(NSArray *)mImages
{
    if (images == nil){
        images = [[NSMutableArray alloc]init];
    }
    [images setArray:mImages];
    
    [mCollectionView reloadData];
}
@end
