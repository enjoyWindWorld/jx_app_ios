//
//  JXMovieHappylyViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/13.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXMovieHappylyViewController.h"
#import "JXMovieHappyBusiness.h"
#import "ZFPlayer.h"
#import "JXPlayerCollectionViewCell.h"
#import "JXMovieListModel.h"
#import "JXPlayerItemCollectionViewCell.h"
#import "JXPlayerImageReusableView.h"
#import "JXPlayerLabelReusableView.h"
#import "JXMovieItemCollectionViewController.h"

#define MOVIEWHAPPY_ITEM_SPACE 0
#define MOVIEWHAPPY_LINE_SPACE 10
#define MOVIEWHAPPY_NNUMBER 1

#define PLAYERIMAGEKEY @"PLAYERIMAGEKEY"
#define PLAYERTITLEKEY @"PLAYERTITLEKEY"

@interface JXMovieHappylyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate>

@property (nonatomic,strong) UICollectionView * collectionView;

@property (nonatomic,strong) JXMovieHappyBusiness * business ;

@property (nonatomic,strong) NSMutableArray * datas ;

@property (nonatomic, strong) ZFPlayerView        *playerView;

@property (nonatomic, strong) ZFPlayerControlView *controlView;

@property (nonatomic,assign) NSInteger currentPage ;

@property (nonatomic,strong) NSArray * staticHeadArr ;

@end

@implementation JXMovieHappylyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"视频娱乐";
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.navigationController.delegate = self;
    
    [self.view addSubview:[self collectionView]];
    
     __weak typeof(self) weakself = self ;
  
    [self.collectionView addJX_NormalHeaderRefreshBlock:^{
        
         [weakself requestMoviehappyList:1];
        
    }];
    
    [self.collectionView addJX_NormalFooterRefreshBlock:^{
        
        [weakself requestMoviehappyList:_currentPage+1];
    }];
    
    _datas = [NSMutableArray arrayWithCapacity:0];
    
    [self.collectionView addJXEmptyView];
    
    [self requestMoviehappyList:1];
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
//    [self.navigationController setNavigationBarHidden:YES animated:animated];

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

    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    
    if (section == 0) {
        
//        return self.staticHeadArr.count;
        return 0;
    }
    
    return self.datas.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        JXPlayerItemCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JXPlayerItemCollectionViewCell" forIndexPath:indexPath];
        
        cell.ico.image = [UIImage imageNamed: [self.staticHeadArr[indexPath.row] objectForKey:PLAYERIMAGEKEY]];
        
        cell.title.text =  [self.staticHeadArr[indexPath.row] objectForKey:PLAYERTITLEKEY];
        
        return cell;
    }
    
    
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
    
    if (indexPath.section == 0) {
        
        CGFloat margin = 0;
        
        CGFloat itemWidth = SCREEN_WIDTH/4 - 4*margin;
    
        return CGSizeMake(itemWidth, itemWidth*0.8);
    }
    

    CGFloat margin = 5;
    
    CGFloat itemWidth = SCREEN_WIDTH/MOVIEWHAPPY_NNUMBER - MOVIEWHAPPY_NNUMBER*margin;
    
    CGFloat itemHeight = itemWidth*9/16;
    
    return CGSizeMake(itemWidth, itemHeight);

}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        JXPlayerImageReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"JXPlayerImageReusableView" forIndexPath:indexPath];
        
        
        
        return header ;
    }else if (indexPath.section == 1){
    
        JXPlayerLabelReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"JXPlayerLabelReusableView" forIndexPath:indexPath];
        
        return header;
    }
    
    return nil ;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        JXMovieItemCollectionViewController * table = [[JXMovieItemCollectionViewController alloc] init];
        
        table.currentPage = indexPath.item;
        
        [self.navigationController pushViewController:table animated:YES];
        
    }
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    if (section == 0 ) {
        
        return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/2.35);
    }else if (section ==1){
    
        return CGSizeMake(SCREEN_WIDTH, 45.f);
    }
    
    return CGSizeZero;
}


#pragma mark - GETTER SETTER
-(UICollectionView *)collectionView {
    
    if (!_collectionView) {
     
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        flowLayout.minimumLineSpacing = 10;
        
        flowLayout.minimumInteritemSpacing = 0;
        
        CGRect frame = self.view.bounds ;
        
        frame.size.height -= NaviBar_H + StatusBar_H + 40.f;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,frame.size.height) collectionViewLayout:flowLayout] ;
        
        _collectionView.delegate = self;
        
        _collectionView.dataSource = self;
        
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"JXPlayerCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"JXPlayerCollectionViewCell"];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"JXPlayerItemCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"JXPlayerItemCollectionViewCell"];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"JXPlayerImageReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"JXPlayerImageReusableView"];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"JXPlayerLabelReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"JXPlayerLabelReusableView"];
    }
    return _collectionView;
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
        
//        _playerView.delegate = self;
  
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

-(NSArray *)staticHeadArr{

    if (!_staticHeadArr) {
        
        _staticHeadArr = @[@{PLAYERIMAGEKEY:@"player_hot",PLAYERTITLEKEY:@"最热"},@{PLAYERIMAGEKEY:@"player_new",PLAYERTITLEKEY:@"最新"},@{PLAYERIMAGEKEY:@"player_zhibo",PLAYERTITLEKEY:@"互动"},@{PLAYERIMAGEKEY:@"player_category",PLAYERTITLEKEY:@"分类"}];
        
    }
    
    return _staticHeadArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
