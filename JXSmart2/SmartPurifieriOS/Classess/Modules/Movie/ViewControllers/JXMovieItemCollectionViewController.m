//
//  JXMovieItemCollectionViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/8/4.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXMovieItemCollectionViewController.h"
#import "JXMovieHappyBusiness.h"
#import "ZFPlayer.h"
#import "JXPlayerCollectionViewCell.h"
#import "JXMovieListModel.h"
#import "JXPlayerItemCollectionViewCell.h"
#import "JXPlayerImageReusableView.h"
#import "JXPlayerLabelReusableView.h"

@interface JXMovieItemCollectionViewController ()

@property (nonatomic,strong) JXMovieHappyBusiness * business ;

@property (nonatomic,strong) NSMutableArray * datas ;

@property (nonatomic, strong) ZFPlayerView        *playerView;

@property (nonatomic, strong) ZFPlayerControlView *controlView;

@end

@implementation JXMovieItemCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 10, 0);
    
    flowLayout.minimumLineSpacing = 10;
    
    flowLayout.minimumInteritemSpacing = 0;

    return [super initWithCollectionViewLayout:flowLayout];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakself = self ;
    
    [self.collectionView addJX_NormalHeaderRefreshBlock:^{
        
        [weakself requestMoviehappyList:1];
        
    }];
    
    [self.collectionView addJX_NormalFooterRefreshBlock:^{
        
        [weakself requestMoviehappyList:weakself.currentPage+1];
    }];
    
    _datas = [NSMutableArray arrayWithCapacity:0];
    
    [self.collectionView addJXEmptyView];
    
    [self requestMoviehappyList:_currentPage+(arc4random()%5+1)];

    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"JXPlayerCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"JXPlayerCollectionViewCell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"JXPlayerItemCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"JXPlayerItemCollectionViewCell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"JXPlayerImageReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"JXPlayerImageReusableView"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"JXPlayerLabelReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"JXPlayerLabelReusableView"];
    
    // Do any additional setup after loading the view.
}


// 页面消失时候
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.playerView resetPlayer];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    // 这里设置横竖屏不同颜色的statusbar
    if (ZFPlayerShared.isLandscape) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return ZFPlayerShared.isStatusBarHidden;
}

/**
 请求视频列表
 */
-(void)requestMoviehappyList:(NSInteger)page{
    
    __weak typeof(self) weakself = self ;
    
    _currentPage = page;
    
    [self.business fetchMovieHapplyList:@{@"id":@"0",@"page":[NSString stringWithFormat:@"%ld",_currentPage]} success:^(id result) {
        
        [weakself.collectionView JXendRefreshing];
        
        NSArray * resultArr = result ;
        
        if (page==1) {
            
            [weakself.datas removeAllObjects];
        }
        
        [weakself.datas addObjectsFromArray:resultArr];
        
        if (resultArr.count==0) {
            
            [weakself.collectionView JXfooterEndNoMoreData];
            
        }
        
        [weakself.collectionView reloadData];
        
    } failer:^(id error) {
        
        [weakself.collectionView JXendRefreshing];
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
        
    }];
    
    
}


#pragma mark - DELEGATE DATASOURCE

#pragma mark -UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.datas.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    

    JXPlayerCollectionViewCell * cell = [collectionView  dequeueReusableCellWithReuseIdentifier:@"JXPlayerCollectionViewCell" forIndexPath:indexPath];
    
    if (self.datas.count>indexPath.item) {
        
        __block   JXMovieListModel * model = self.datas[indexPath.item];
        
        cell.model = model;
        
        __block NSIndexPath *weakIndexPath = indexPath;
        
        __block JXPlayerCollectionViewCell * weakCell = cell;
        
        __weak typeof(self) weakSelf  = self;
        
        cell.playBlock = ^(UIButton *btn){
            
            ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
            
            playerModel.title            = model.title;
            
            playerModel.videoURL         = [NSURL URLWithString:model.video];
            
            playerModel.placeholderImageURLString = model.img;
            
            playerModel.scrollView       = weakSelf.collectionView;
            
            playerModel.indexPath        = weakIndexPath;
            // 赋值分辨率字典
            playerModel.resolutionDic    = nil;
            // player的父视图tag
            
            playerModel.fatherViewTag    = weakCell.topicImageView.tag;
            
            // 设置播放控制层和model
            [weakSelf.playerView playerControlView:nil playerModel:playerModel];
            // 下载功能
            weakSelf.playerView.hasDownload = NO;
            // 自动播放
            [weakSelf.playerView autoPlayTheVideo];
        };
        
    }
    
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    

    CGFloat margin = 5;
    
    CGFloat itemWidth = SCREEN_WIDTH/1 - 1*margin;
    
    CGFloat itemHeight = itemWidth*9/16;
    
    return CGSizeMake(itemWidth, itemHeight);
    
}


-(JXMovieHappyBusiness *)business{
    
    if (!_business) {
        
        _business = [[JXMovieHappyBusiness alloc] init];
    }
    
    return _business;
}
- (ZFPlayerView *)playerView {
    if (!_playerView) {
        
        _playerView = [ZFPlayerView sharedPlayerView];

        _playerView.cellPlayerOnCenter = NO;
        
    }
    return _playerView;
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [[ZFPlayerControlView alloc] init];
    }
    return _controlView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
