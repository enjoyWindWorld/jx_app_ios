
//
//  CommunityViewController.m
//  EBaby
//
//  Created by Mray-mac on 16/11/15.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "CommunityViewController.h"
#import "CommunityTwoViewController.h"
#import "SPComServiceModulesBusiness.h"
#import "UIImageView+WebCache.h"
#import "SDCycleScrollView.h"
#import "SPBaseNavViewController.h"
#import "PushBtnModel.h"
#import <UIButton+WebCache.h>
#import "AppDelegate.h"
#import "SPUserModel.h"
#import "JFLocation.h"
#import "JFAreaDataManager.h"
#import "JFCityViewController.h"
#import "LXFButton.h"


#import "JXMainCommunityCollectionViewCell.h"
#import "JXCommunityAdvModel.h"
#import "JXCommunityBannerCell.h"


#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]


#define MainCommunityCellMiniItemSpace 0
#define MainCommunityCellMiniLineSpace 0
#define MainCommunityCellMiniNumber 3

@interface CommunityViewController ()<UIScrollViewDelegate,SDCycleScrollViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UINavigationControllerDelegate,JFLocationDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    UIButton * _cityBtn;
 
}
@property (nonatomic,retain)SDCycleScrollView *cycleScrollerView;

/** 城市定位管理器*/
@property (nonatomic, strong) JFLocation *locationManager;
/** 城市数据管理器*/
@property (nonatomic, strong) JFAreaDataManager *manager;

@property (nonatomic,strong) UICollectionView * collectionView;

@property (nonatomic,strong) SPComServiceModulesBusiness * business ;

@property (nonatomic,strong) NSMutableArray * myItemArrData ;

@property (nonatomic,strong) NSArray * advListArr;

@end

@implementation CommunityViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    
    [self initUI];
    
    self.locationManager = [[JFLocation alloc] init];
    
    _locationManager.delegate = self;
    
    [self initAdvertNetWork];
    
    [self initPushBtnNetWork];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    //控制器即将进入的时候调用
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    
    
}

#pragma 网络请求代理

-(void)initAdvertNetWork
{
    NSDictionary * dic = @{@"type":@"0"};
    
     __weak typeof(self) weakself = self ;
   
    [self.business communityGetAdv:dic success:^(id result) {
        
        [weakself.collectionView JXendRefreshing];
        
        weakself.advListArr = result;
    
        [weakself.collectionView reloadData];
    
    } failer:^(NSString *error) {
        
         [weakself.collectionView JXendRefreshing];
      
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
        
    }];
    
}

#pragma mark - 获取分类
-(void)initPushBtnNetWork
{

    __weak typeof(self) weakself = self ;
    
    [self.business pushtotalDetails:nil success:^(id result) {
        
        NSUserDefaults * userdefault  = [NSUserDefaults standardUserDefaults];
        
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:result];
        
        [userdefault setObject:data forKey:COMMUNITYPUSHBTNKEY];
        
        [userdefault synchronize];
        
        [weakself.collectionView JXendRefreshing];
        
        [weakself.myItemArrData removeAllObjects];
        
        [weakself.myItemArrData addObjectsFromArray:result];
        
        [weakself.collectionView reloadData];
        
    } failer:^(NSString *error) {
        
         [weakself.collectionView JXendRefreshing];

        [SPMJRefresh endRefreshing:weakself.collectionView];
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
        
    }];
}

-(void)jx_getLocoationCityUserCount{

    
     NSString * city = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentCity"];

    NSRange range = [city rangeOfString:@"-"];
    
    if (range.location!=NSNotFound) {
        
        city = [city substringToIndex:range.location];
    }
    
    [self.business communityUserCount:@{@"city":city} success:^(id result) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSString * title = _cityBtn.currentTitle;
            
            title = [title stringByAppendingFormat:@"\n%@",result];
            
            [_cityBtn setTitle:title forState:UIControlStateNormal];
            
            [_cityBtn sizeToFit];
            
        });
        
        
    } failer:^(NSString *error) {
        
        
    }];
        
}

#pragma mark - 初始化 UI
-(void)initUI{
    
    
    _cityBtn = [LXFButton buttonWithType:UIButtonTypeCustom];
   
    _cityBtn.frame = CGRectMake(15, 30, 75, 24);
    
    _cityBtn.layer.cornerRadius = _cityBtn.frame.size.height/2;
    
    _cityBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    _cityBtn.titleLabel.numberOfLines = 2;
    
    NSString * city = [KCURRENTCITYINFODEFAULTS objectForKey:@"currentCity"];
    
    if (city.length > 0) {
       
        [_cityBtn setTitle:[NSString stringWithFormat:@"%@ ⌵",city] forState:UIControlStateNormal];
    }else{
        
        [_cityBtn setTitle:@"城市 ⌵" forState:UIControlStateNormal];
    }
    
    [_cityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   
    _cityBtn.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.3];
    
    [_cityBtn addTarget:self action:@selector(cityClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_cityBtn sizeToFit];
    
    [_cycleScrollerView addSubview:_cityBtn];
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView addSubview:_cityBtn];
    
    __weak typeof(self) weakslef = self;
    
    [_collectionView addJX_NormalHeaderRefreshBlock:^{
        
        [weakslef initAdvertNetWork];
        
        [weakslef initPushBtnNetWork];
        
    }];
    
    [_collectionView addJXEmptyView];
    
}



#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
   
    if (_advListArr.count==0||_myItemArrData.count==0) {
        
        return 0;
    }
    
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section==0) {
        
        return 1;
    }
    
    return self.myItemArrData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        JXCommunityBannerCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JXCommunityBannerCell" forIndexPath:indexPath];
        
        cell.bannerView.delegate = self;
        
        cell.advModelList = _advListArr;
        
        return cell;
    }
   
    JXMainCommunityCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"JXMainCommunityCollectionViewCell" forIndexPath:indexPath];
    
    if (self.myItemArrData.count>indexPath.item) {
        
        PushBtnModel *m = self.myItemArrData[indexPath.item];
        
        [SPSDWebImage SPImageView:cell.itemImage imageWithURL:m.menu_icourl placeholderImage:[UIImage imageNamed:@"暂位图@2x"]];
        
        cell.itemLabel.text = m.menu_name;
        
        cell.itemLabel.adjustsFontSizeToFitWidth= YES;
        
        cell.itemLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters ;
    }
    
    
    return cell;
}

#pragma mark -UICollectionViewLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        
        return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*0.4);
    }
    
    CGFloat miniWidth = (SCREEN_WIDTH-MainCommunityCellMiniItemSpace*(MainCommunityCellMiniNumber-1))/MainCommunityCellMiniNumber ;
 
    return CGSizeMake(miniWidth, miniWidth);
}

#pragma mark - collectionViewdidSelect
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
    if (self.myItemArrData.count>indexPath.item) {
        
        NSString * city = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentCity"];
        
        if ([city isEqual:[NSNull null]] || !city) {
            
            [SPToastHUD makeToast:@"请选择相应的城市地区" duration:3 position:nil makeView:self.view];
            
            return;
        }
        
        PushBtnModel *m = self.myItemArrData[indexPath.item];
        
        CommunityTwoViewController *vc = [[CommunityTwoViewController alloc]init];
                
        vc.optionStr = m.menu_name;
        
        vc.communityID = m.dataIdentifier;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}


#pragma mark - getter setter 
-(SPComServiceModulesBusiness *)business{

    if (!_business) {
        
        _business = [[SPComServiceModulesBusiness alloc] init];
    }
    
    return _business;
}

-(NSMutableArray *)myItemArrData{

    if (!_myItemArrData) {
        
        _myItemArrData  = [NSMutableArray arrayWithCapacity:0];
    }
    return _myItemArrData;
}

-(UICollectionView *)collectionView{

    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        //同一行相邻两个cell的最小间距
        layout.minimumInteritemSpacing = MainCommunityCellMiniItemSpace;
        //最小两行之间的间距
        layout.minimumLineSpacing = MainCommunityCellMiniLineSpace;
        
        CGRect  frame = self.view.bounds;
        
        frame.size.height -= StatusBar_H + 20.f;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        
        [self  compatibleAvailable_ios11:_collectionView];
        
        _collectionView.alwaysBounceVertical=YES;
        
        _collectionView.backgroundColor=[UIColor whiteColor];
        
        _collectionView.delegate=self;
        
        _collectionView.dataSource=self;
                
        [self.view addSubview:_collectionView];
        
        UINib *nib = [UINib nibWithNibName:@"JXMainCommunityCollectionViewCell" bundle:nil];
        
        [_collectionView registerNib:nib forCellWithReuseIdentifier:@"JXMainCommunityCollectionViewCell"];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"JXCommunityBannerCell" bundle:nil] forCellWithReuseIdentifier:@"JXCommunityBannerCell"];
        
    }
    return _collectionView;
}


#pragma mark - 定位
-(void)cityClick
{
    
    JFCityViewController *cityViewController = [[JFCityViewController alloc] init];
    cityViewController.title = @"选择城市";
    
    __weak typeof(self) weakself = self ;
    [cityViewController  choseCityBlock:^(NSString *cityName) {
        
        if (cityName.length > 0) {
            
            [_cityBtn setTitle:[NSString stringWithFormat:@"%@ ⌵",cityName] forState:UIControlStateNormal];
            
            [_cityBtn sizeToFit];
            
            [weakself jx_getLocoationCityUserCount];
        }
        
    }];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:cityViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
    
}
- (JFAreaDataManager *)manager {
    if (!_manager) {
        _manager = [JFAreaDataManager shareManager];
        [_manager areaSqliteDBData];
    }
    return _manager;
}


#pragma mark --- 定位
//定位中...
- (void)locating {
    NSLog(@"定位中...");
}

//定位成功
- (void)currentLocation:(NSDictionary *)locationDictionary {
    NSString *city = [locationDictionary objectForKey:@"City"];
    
    NSString * alocationCity = [NSString stringWithFormat:@"%@ ⌵",city];
    
    [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"locationCity"];
   
    if (![_cityBtn.currentTitle isEqualToString:alocationCity]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"您定位到%@，确定切换城市吗？",city] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        
            [self jx_getLocoationCityUserCount];
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [_cityBtn setTitle:alocationCity forState:UIControlStateNormal];
            
            [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"currentCity"];
            
            [_cityBtn sizeToFit];
            
            [self jx_getLocoationCityUserCount];
            
            [self.manager cityNumberWithCity:city cityNumber:^(NSString *cityNumber) {
                
                [KCURRENTCITYINFODEFAULTS setObject:cityNumber forKey:@"cityNumber"];
            }];
            
            [KCURRENTCITYINFODEFAULTS synchronize];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
    
        [self jx_getLocoationCityUserCount];
    }
    
}

/// 拒绝定位
- (void)refuseToUsePositioningSystem:(NSString *)message {
    NSLog(@"%@",message);
}

/// 定位失败
- (void)locateFailure:(NSString *)message {
    NSLog(@"%@",message);
}

#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
{
    if (self.advListArr.count>index) {
        
        JXCommunityAdvModel * model = self.advListArr[index];
        
        NSURL * url = [NSURL URLWithString:model.adv_url];
        
        [[UIApplication sharedApplication] openURL:url];
    }
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)inde{
    
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}





@end
