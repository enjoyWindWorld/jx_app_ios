//
//  SPHomePageViewController.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/15.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPHomePageViewController.h"
#import "SPHomeDetailViewController.h"
#import "SPHomePageListModel.h"
#import "SPHomePageBusiness.h"
#import "DESEncrypt.h"
#import "QSHCache.h"


#import "JXMainPageProductCell.h"
#import "JXMainHeaderReusableView.h"
#import "JXMainPageCommunityCell.h"
#import "JXMainEmptyTradingCell.h"
#import "JXMainTodayTradingCell.h"
#import "JXMainPageNewsCell.h"
#import "Masonry.h"
#import "JXMainPageModel.h"
#import "SDCycleScrollView.h"
#import "JXNewsModel.h"
#import "RxWebViewController.h"
#import "SPCommunityServiceElectricityEntrance.h"
#import "JXWaterQualityReportModel.h"
#import "JFAreaDataManager.h"
#import "AppDelegate.h"


#define MAINPRODUCTDESC @"产品选购"
#define MAINCOMMUNITYDESC @"社区服务排行榜"
#define MAINEMPTYTRAFFICDESC @"  您目前还没有绑定可用的智能设备\n只需轻松俩步,快速开启新的智能生活"
#define MAINCOLORPRODUCT [UIColor colorWithRGB:17 G:140 B:227]
#define MAINCOLORCOMMUNITY [UIColor colorWithRGB:243 G:132 B:15]

#define CellMiniItemSpace 0
#define CellMiniLineSpace 0
#define CellMiniNumber 3
#define SXHEADLINEHEIGHT 40

@interface SPHomePageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate>

@property(nonatomic,strong) NSMutableArray * itemDataSource ;

@property (nonatomic,strong) SPHomePageBusiness * bussess ;

@property (nonatomic,strong) JXMainPageModel * mainModel ;

@property (nonatomic,strong) UICollectionView * collectionView;

@property (nonatomic,strong) UIView* mainBanner ;

@property (strong, nonatomic) SDCycleScrollView *mainBannerView;

@property (nonatomic,strong) NSArray * newsArr ;

@property (nonatomic,strong) JXWaterQualityReportModel * waterModel ;

@end

@implementation SPHomePageViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"净喜智能";
    
    self.navigationController.delegate = self;

    [self.view addSubview:self.collectionView];
    
    [AppDelegate jx_privateMethod_FullScreenView];
    
    __weak typeof(self) weakself = self ;
    [self.collectionView addJX_NormalHeaderRefreshBlock:^{
        
        [weakself requestHomelist];
        
        [weakself requestProductList];
        
        [weakself requestPurifierWaterData];
        
        [weakself requestNewsList];
    }];

    [self requestProductList];
   
    [self requestHomelist];
    
//
    [self requestPurifierWaterData];
    
    [self requestNewsList];
    
    [self.collectionView addJXEmptyView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    long sdImageSize = [[SDImageCache sharedImageCache]getSize];
    
    if (sdImageSize > 9900000) {
        [QSHCache qsh_RemoveAllCache];
        
        [[SDImageCache sharedImageCache]clearMemory];
        
        [[SDImageCache sharedImageCache] cleanDisk];
    }
}

#pragma mark - 添加刷新


#pragma mark - 请求产品列表
-(void)requestHomelist{

    __weak typeof(self) weakself = self ;
    
    [self.bussess getHomeFileListImage:@{@"page":[NSNumber numberWithInteger:1]} success:^(id result) {
        
        NSArray * resultArr = result ;
        
        [weakself.itemDataSource  removeAllObjects];
        
        [weakself.itemDataSource addObjectsFromArray:resultArr];
        
        [weakself.collectionView JXendRefreshing];
        
        [weakself.collectionView reloadData];
        
    } failere:^(NSString *error) {
        
        [weakself.collectionView JXendRefreshing];
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
        
    } isGetCache:NO];
}

#pragma mark - 请求首页广告数据
-(void)requestProductList{
    
    __weak typeof(self) weakself = self ;
    
    [self.bussess getHomePageData:@{@"type":[NSNumber numberWithInteger:-2]} succcess:^(id result) {
        
        weakself.mainModel = result ;
        
        [weakself.collectionView JXendRefreshing];
        
        [weakself.collectionView reloadData];
        
    } failere:^(NSString *error) {
        
        [weakself.collectionView JXendRefreshing];
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
    }];

}

#pragma mark - 请求饮水量
-(void)requestPurifierWaterData{

    __weak typeof(self) weakself = self ;
    
    [self.bussess getPurifierWaterData:@{@"cityCode":[self fetchCurrentCity]} succcess:^(id result) {
        
        weakself.waterModel = result;
        
        [weakself.collectionView reloadData];
        
         [weakself.collectionView JXendRefreshing];
  
    } failere:^(id error) {
        
        if ([error isKindOfClass:[NSDictionary class]]) {
            
            weakself.waterModel = nil;
            
            [weakself.collectionView reloadData];
        }
        
        [weakself.collectionView JXendRefreshing];
   
    }];
    
}

-(NSString*)fetchCurrentCity{
    
     NSString * cityNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"cityNumber"];
    
    __block  NSString * city = @"";
    
    [[JFAreaDataManager shareManager] currentCity:cityNumber communityCityForTDS:^(NSString *name) {
       
        city = name;

    }];

    return city ;
}


/**
 请求新闻内容
 */
-(void)requestNewsList{

    __weak typeof(self) weakself = self ;
    
    [self.bussess fetchHomePageNewsList:@{@"type":@"0"} succcess:^(id result) {
        
        weakself.newsArr = result ;
        
        [weakself.collectionView reloadData];
        
    } failere:^(id error) {
        
        [weakself.collectionView JXendRefreshing];
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
        
    }];
   
    
}


#pragma mark-  UITableViewDelegate


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    if (self.itemDataSource.count == 0) {
        
        return 0;
    }
 
    return 4 ;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

   
    
    if (section== 0||section==3)  return 1;
    
    if (section == 1) {
        
      return self.itemDataSource.count;
    }
    
    if (section == 2) {
        
        return self.mainModel.ranking_list.count;
    }
    
    return 3;
    
}

- (NSMutableArray *)getData {
    
    NSMutableArray * adsArray = @[].mutableCopy;
    
    for (int i = 0; i < self.newsArr.count; i++) {
        
        JXNewsModel * newmodel = self.newsArr[i];
        
        ADRollModel *model = [[ADRollModel alloc] init];
        
        model.noticeType = newmodel.news_type_name;
        
        model.noticeTitle =newmodel.news_content;
        
        model.urlString = newmodel.news_url;
       
        [adsArray addObject:model];
    }
    
    return adsArray;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0) {
        
        JXMainPageNewsCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JXMainPageNewsCell" forIndexPath:indexPath];
        
        cell.news = self.mainModel;
        
        if ([self getData].count>0) {
            
            [cell.newsContent  setVerticalShowDataArr:[self getData]];
            
            [cell.newsContent start];
            
            cell.newsContent.clickBlock = ^(NSInteger index) {
                
                if (self.newsArr.count>index) {
                    
                    JXNewsModel * newmodel = self.newsArr[index];
                    
                    RxWebViewController * web = [[RxWebViewController alloc] initWithUrl:[NSURL URLWithString:newmodel.news_url]];
                    
                    [self.navigationController pushViewController:web animated:YES];
                    
                }
                
            };
        }
        
        
        return cell;
    }
    
    
 if (indexPath.section==1){
     
     
     JXMainPageProductCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JXMainPageProductCell" forIndexPath:indexPath];
    
     if (self.itemDataSource.count>indexPath.item) {
         
         SPHomePageListModel * model  = self.itemDataSource[indexPath.item];
         
         [SPSDWebImage SPImageView:cell.imgeProduct imageWithURL:model.pic_url placeholderImage:[UIImage imageNamed:SPPRODUCTICOPLACEHOLDERImage]];
         
         cell.nameLabel.text = model.name;
     }
    
     return cell ;
     
    }else if (indexPath.section==2){
        
        
        JXMainPageCommunityCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JXMainPageCommunityCell" forIndexPath:indexPath];
       
        if (self.mainModel.ranking_list.count>indexPath.item) {
            
                NSLog(@"响应了");
            
            cell.pageModel = self.mainModel.ranking_list[indexPath.item];

        }
        return cell;
    }else{
        
        if (self.waterModel) {
            
            JXMainTodayTradingCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JXMainTodayTradingCell" forIndexPath:indexPath];
            
            cell.model = self.waterModel;
    
            return cell;
            
        }else{
        
            JXMainEmptyTradingCell * cell  =[collectionView dequeueReusableCellWithReuseIdentifier:@"JXMainEmptyTradingCell" forIndexPath:indexPath];
            
            cell.descLabel.text = MAINEMPTYTRAFFICDESC;
            
            return cell;
        }

    }

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    UICollectionReusableView *reusableview = nil;

    if (kind == UICollectionElementKindSectionHeader) {
        
        JXMainHeaderReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"JXMainHeaderReusableView" forIndexPath:indexPath];
        
        header.descLabel.text = indexPath.section==1?MAINPRODUCTDESC:MAINCOMMUNITYDESC;
        
        header.colorView.backgroundColor =indexPath.section==1?MAINCOLORPRODUCT:MAINCOLORCOMMUNITY;
        
        return header;
    }
    
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0)
        
        return CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT*0.4);
    
    if (indexPath.section==3)

        return CGSizeMake(SCREEN_WIDTH,110);
    

    CGFloat height  = indexPath.section==1?SCREEN_WIDTH/3:50;

    return CGSizeMake(SCREEN_WIDTH/3, height);
}

-(void)updateBannerGroupUrl:(JXMainPageModel *)news{
    
    __block NSMutableArray * arr = [NSMutableArray arrayWithCapacity:0];
    
    [news.home_page enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        JXMainAdvModel * model = obj;
        
        [arr addObject:model.adv_imgurl ];
        
    }];

    self.mainBannerView.imageURLStringsGroup =arr;

}



//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//
//
//    return 10.f;
//}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 0;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section==0||section==3)  return CGSizeZero;

    return CGSizeMake(SCREEN_WIDTH, 30);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section==0)
       
        return UIEdgeInsetsMake(0, 0, 10, 0);
    
    return UIEdgeInsetsZero;
}



#pragma mark - didSelectItemAtIndexPath
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==1) {
        
        if (self.itemDataSource.count>indexPath.item) {
            
            id model  = self.itemDataSource[indexPath.item];
            
            [self performSegueWithIdentifier:@"SPHomeDetailViewController" sender:model];
            
        }
    }
    
    if (indexPath.section == 2) {
        
        if (self.mainModel.ranking_list.count>indexPath.item) {
  
            JXMainAdvModel * model = self.mainModel.ranking_list[indexPath.item];
  
            UIViewController * vc  = [SPCommunityServiceElectricityEntrance  fetchCommunityDetailViewController:model.pub_id];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    
}


#pragma mark - willShowViewController
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];

    [self.navigationController setNavigationBarHidden:isShowHomePage animated:animated];
}

#pragma mark - prepareForSegue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"SPHomeDetailViewController"]) {
        
        SPHomeDetailViewController * VC = segue.destinationViewController ;
    
        VC.listModel = sender ;
    }
    
}




#pragma mark - getter setter
//
-(NSMutableArray *)itemDataSource{

    if (_itemDataSource == nil) {
        
        _itemDataSource = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return _itemDataSource ;
}

-(SPHomePageBusiness *)bussess{

    if (_bussess == nil) {
        
        _bussess  = [[SPHomePageBusiness alloc] init ];
    }
    
    return _bussess;
}

-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        //同一行相邻两个cell的最小间距
        layout.minimumInteritemSpacing = CellMiniItemSpace;
        //最小两行之间的间距
        layout.minimumLineSpacing = CellMiniLineSpace;
        
        CGRect  frame = self.view.bounds;
        
        frame.size.height -= StatusBar_H + 20.f;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        
        _collectionView.alwaysBounceVertical = YES;
        
        _collectionView.backgroundColor=[UIColor whiteColor];
        
        [self compatibleAvailable_ios11:_collectionView];
        
        _collectionView.delegate=self;
        
        _collectionView.dataSource=self;
        
        [self.view addSubview:_collectionView];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"JXMainPageProductCell" bundle:nil] forCellWithReuseIdentifier:@"JXMainPageProductCell"];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"JXMainPageCommunityCell" bundle:nil] forCellWithReuseIdentifier:@"JXMainPageCommunityCell"];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"JXMainEmptyTradingCell" bundle:nil] forCellWithReuseIdentifier:@"JXMainEmptyTradingCell"];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"JXMainTodayTradingCell" bundle:nil] forCellWithReuseIdentifier:@"JXMainTodayTradingCell"];
        
        [_collectionView  registerNib:[UINib nibWithNibName:@"JXMainHeaderReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"JXMainHeaderReusableView"];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"JXMainPageNewsCell" bundle:nil] forCellWithReuseIdentifier:@"JXMainPageNewsCell"];
        
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
    }
    return _collectionView;
}

//-(UIView *)mainBanner{
//    
//    if (_mainBanner == nil) {
//        
//        _mainBanner = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.4)];
//        
//        _mainBannerView = [[SDCycleScrollView alloc]init];
//        
//        [_mainBanner addSubview:_mainBannerView];
//        
//        [_mainBannerView mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.left.top.right.mas_equalTo(0);
//            
//            make.height.mas_equalTo(_mainBanner.mas_height).offset(-SXHEADLINEHEIGHT);
//        }];
//        
//        UIView * backlINE = [[UIView alloc] init];
//        
//        backlINE.backgroundColor = [UIColor groupTableViewBackgroundColor];
//        
//        [_mainBanner addSubview:backlINE];
//        
//        [backlINE mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.left.right.mas_equalTo(0);
//            
//            make.top.equalTo(_mainBannerView.mas_bottom);
//            
//            make.height.mas_equalTo(1);
//            
//        }];
//        
//        UIImageView * image = [[UIImageView alloc] init];
//        
//        image.image = [UIImage imageNamed:@"horn"];
//        
//        [_mainBanner addSubview:image];
//        
//        [image mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.left.mas_offset(15);
//            make.size.mas_equalTo(CGSizeMake(14, 14));
//            make.top.mas_equalTo(backlINE.mas_bottom).offset(13);
//        }];
//        
//        _newsType = [[SXHeadLine alloc] initWithFrame:CGRectMake(0, 0, 120, SXHEADLINEHEIGHT)];
//        
//        _newsContent = [[SXHeadLine alloc] initWithFrame:CGRectMake(0, 0, 120, SXHEADLINEHEIGHT)];
//        
//        [_mainBanner addSubview:_newsType];
//        [_mainBanner addSubview:_newsContent];
//        
//        [_newsType mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.left.mas_equalTo(image.mas_right);
//            
//            make.top.mas_equalTo(backlINE.mas_bottom);
//            
//            make.width.mas_equalTo(120);
//            
//            make.height.mas_equalTo(SXHEADLINEHEIGHT);
//        }];
//        
//        UIView * backlINE2 = [[UIView alloc] init];
//        
//        backlINE2.backgroundColor = [UIColor groupTableViewBackgroundColor];
//        
//        [_mainBanner addSubview:backlINE2];
//        
//        [backlINE2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.left.mas_equalTo(_newsType.mas_right);
//            
//            make.top.mas_equalTo(backlINE.mas_bottom);
//            
//            make.height.mas_equalTo(SXHEADLINEHEIGHT);
//            
//            make.width.mas_equalTo(1);
//            
//        }];
//        
//        [_newsContent mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.left.mas_equalTo(backlINE2.mas_right);
//            
//            make.top.mas_equalTo(backlINE.mas_bottom);
//            
//            make.height.mas_equalTo(SXHEADLINEHEIGHT);
//            
//            make.right.mas_equalTo(backlINE.mas_right);
//            
//        }];
//        
//        _mainBanner.backgroundColor = [UIColor whiteColor];
//        
//    }
//    
//    return _mainBanner;
//}


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
