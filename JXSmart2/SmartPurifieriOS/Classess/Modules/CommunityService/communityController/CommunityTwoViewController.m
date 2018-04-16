//
//  CommunityTwoViewController.m
//  EBaby
//
//  Created by Mray-mac on 16/11/15.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "CommunityTwoViewController.h"
#import "CommunityTableViewCell.h"
#import "CleanDetailViewController.h"
#import "ReleaseViewController.h"
#import "ClassDeitalViewController.h"
#import <MJExtension.h>
#import "SPComServiceModulesBusiness.h"
#import "ServiceModel.h"
#import "PushBtnModel.h"
#import "ClassDeitalModel.h"
#import "SPUserModel.h"
#import "SPSDWebImage.h"
#import "AppDelegate.h"

#import "JXCommunityTopItemView.h"
#import "RDVTabBarController.h"
#import "JXCommunityAdvModel.h"

#define BANNERPLACEHOLDERIMAGE [UIImage imageNamed:@"CommunityNoPicture@2x"]

@interface CommunityTwoViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,SDWebImageManagerDelegate>

{
    UITableView * _tableV;

    NSInteger _page;
    
    BOOL _isScreen;
    
    UIButton * _titleBtn;
    
    UIImageView * _titleImg;
    
}

@property (nonatomic,strong) JXCommunityTopItemView * topItemView ;

@property (nonatomic,strong) SPComServiceModulesBusiness * bussiness ;

@property (nonatomic,strong) NSMutableArray * datas ;

@property (nonatomic,strong) UIImageView * topBannerImageView;

@end

@implementation CommunityTwoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _page = 1;
    
    _isScreen = NO;
    
    [self initWithUI];
    
    [self initAdvertNetWork];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self initNetWork];
}



//视图创建
-(void)initWithUI
{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(20, 20, 120, 40)];
    
    _titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _titleBtn.frame=CGRectMake(0, 0, 120, 40);
  
    [_titleBtn setTitle:[NSString stringWithFormat:@"%@",_optionStr] forState:UIControlStateNormal];
    
    [_titleBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    
    [_titleBtn addTarget:self action:@selector(showAllQuestions) forControlEvents:UIControlEventTouchUpInside];
    
    [_titleBtn.titleLabel setNumberOfLines:0];
    
    [_titleBtn setTitleColor:HEXCOLOR(@"525252") forState:UIControlStateNormal];
    
    CGSize size = CGSizeMake(SCREEN_WIDTH,2000);
    
    NSString *titleText = _titleBtn.titleLabel.text;
    
    CGSize labelsize = [titleText sizeWithFont:_titleBtn.titleLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    
    _titleImg = [[UIImageView alloc]initWithFrame:CGRectMake(labelsize.width/2+64, 17, 0.048*SCREEN_WIDTH, 9)];
    
    _titleImg.image = [UIImage imageNamed:@"nav_back_down"];
    
    
    [titleView addSubview:_titleBtn];
    
    [titleView addSubview:_titleImg];
    
    self.navigationItem.titleView = titleView;
    
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NaviBar_H-StatusBar_H) style:UITableViewStylePlain];
    
    [self compatibleAvailable_ios11:_tableV];
    
    _tableV.backgroundColor = SPViewBackColor;
    
    _tableV.delegate = self;
   
    _tableV.dataSource = self;
   
    _tableV.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
   
    [self.view addSubview:_tableV];
    
    [_tableV setTableFooterView:[UIView new]];
    
    [_tableV registerNib:[UINib nibWithNibName:NSStringFromClass([CommunityTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"CommunityTableViewCell"];
    
    __weak __typeof (self)weakself = self;
    
   [_tableV addJX_NormalHeaderRefreshBlock:^{
       
       [weakself headerRefresh];
       
   }];
    
    [_tableV addJX_NormalFooterRefreshBlock:^{
        
        [weakself footRefresh];
        
    }];
    
    [_tableV addJXEmptyView];
    
    _tableV.tableHeaderView = self.topBannerImageView;
    
    //发布按钮
    float releaseWidth = SCREEN_WIDTH*0.226;
    
    UIButton *releaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    releaseBtn.frame = CGRectMake(SCREEN_WIDTH-releaseWidth-10, SCREEN_HEIGHT-releaseWidth-14-64, releaseWidth, releaseWidth);
    
    [releaseBtn setImage:[UIImage imageNamed:@"releaseImg"] forState:UIControlStateNormal];
    
    [releaseBtn addTarget:self action:@selector(releaseClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:releaseBtn];
    
}


#pragma mark - 拿到数据
-(void)initNetWork
{
    
     __weak typeof(self) weakself = self ;
    
    NSString *pagestr = [NSString stringWithFormat:@"%ld",(long)_page];
    
    NSString * city = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentCity"];
    
    NSRange range = [city rangeOfString:@"-"];
    
    if (range.location!=NSNotFound) {
        
        city = [city substringToIndex:range.location];
    }
    
    NSDictionary * dic = @{@"id":_communityID,
                           @"page":pagestr,
                           @"address":city,
                           };
    
    [self.bussiness communityserviceList:dic success:^(id result) {
        
        [_tableV JXendRefreshing];
        
        NSArray * resultArr = result;
        
        if (_page == 1) {
            
            [weakself.datas removeAllObjects];
            
        }
    
        [weakself.datas addObjectsFromArray:resultArr];
        
        [_tableV reloadData];

    } failer:^(NSString *error) {
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
      
        [_tableV JXendRefreshing];
        
    }];
    
}

#pragma mark- 获取广告
-(void)initAdvertNetWork
{
  
    NSDictionary * dic = @{@"type":_communityID};
    
    __weak typeof(self) weakself = self ;
 
    [self.bussiness communityGetAdv:dic success:^(id result) {
        
        NSArray *dicArr = result;
        
        JXCommunityAdvModel * model = [dicArr firstObject];
        
        if (model) {
            
            [SPSDWebImage SPImageView:weakself.topBannerImageView imageWithURL:model.adv_imgurl placeholderImage:BANNERPLACEHOLDERIMAGE];
            
            
        }else{
            
            weakself.topBannerImageView .image = BANNERPLACEHOLDERIMAGE;
            
        }
    
    } failer:^(NSString *error) {
        
    
    }];
    
}

#pragma mark - 显示分类视图
//标题栏按钮点击事件
-(void)showAllQuestions{

    if (!_isScreen) {
        
        __weak typeof(self) weaksel = self ;
        
        [self.topItemView showComunityView:_communityID animated:YES completion:^(PushBtnModel *Model) {
            
            if (Model) {
                
                _communityID = Model.dataIdentifier;
                
                _optionStr = Model.menu_name;
                
                [_titleBtn setTitle:[NSString stringWithFormat:@"%@",_optionStr] forState:UIControlStateNormal];
                
                [weaksel initAdvertNetWork];
                
                [weaksel headerRefresh];
                
            }
            [weaksel.topItemView dissMissWithAnimated:YES];
            
             self.topItemView = nil ;
            
            [weaksel titleAnimatstartWith:_isScreen];
        }];
        
    }else{
        
        [self.topItemView dissMissWithAnimated:YES];
        
        self.topItemView = nil ;
        
    }
    
    [self titleAnimatstartWith:_isScreen];
}

#pragma mark - 旋转标题小图片
-(void)titleAnimatstartWith:(BOOL)isShow{
    
    
    CGAffineTransform trafm = isShow ==NO?CGAffineTransformMakeRotation(M_PI):CGAffineTransformIdentity;
    
    [UIView animateWithDuration:0.35 animations:^{
        
        _titleImg.transform = trafm;
        
    } completion:^(BOOL finished) {
        
        _isScreen = !isShow ;
    }];
    
}

//发布按钮点击事件
-(void)releaseClick{
    
    ReleaseViewController *vc = [[ReleaseViewController alloc]init];
  
//    vc.categoryid = _communityID;
    
    __weak typeof(self) weakself = self ;
   
//    vc.block = ^(BOOL isRefresh){
//    
//        
//        [weakself headerRefresh];
//        
//         [SPToastHUD makeToast:@"发布成功" duration:3 position:nil makeView:weakself.view];
//    };
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)headerRefresh
{
    _page = 1;
    
    [self initNetWork];
    
}

- (void)footRefresh
{
    _page ++;
   
    [self initNetWork];
}





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.datas.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //cell创建视图
    CommunityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunityTableViewCell"];

    if (self.datas.count>indexPath.row) {
        
        ServiceModel * m = self.datas[indexPath.row];
        
        cell.deitallabel.text = m.content;
        //cell.deitallabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.deitallabel.numberOfLines = 0;
        
        cell.titlelabel.text = m.seller;
        
        [cell.titlelabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
        
        cell.addressLabel.width = cell.addressLabel.width+cell.typeName.width;
        
        cell.addressLabel.text = m.address;
        
        NSString *timestr = [m.pub_addtime substringWithRange:NSMakeRange(0,10)];
        
        cell.timeLabel.text = timestr;
        
        NSString * first = [[m.url componentsSeparatedByString:@","]firstObject];
        
        [SPSDWebImage SPImageView:cell.cellImg imageWithURL:first placeholderImage:[UIImage imageNamed:@"暂无图片1@2x"]];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleDefault;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell高度代理
    return 0.15*SCREEN_HEIGHT;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //cell点击事件
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (self.datas.count>indexPath.row) {
        
        CleanDetailViewController *vc = [[CleanDetailViewController alloc]init];
        
        ServiceModel *m = self.datas[indexPath.row];
        
        vc.pubId = m.pubId;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - GETTER SETTER
-(JXCommunityTopItemView *)topItemView{
    
    if (_topItemView==nil) {
        
        NSData * model  = [[NSUserDefaults standardUserDefaults] objectForKey:COMMUNITYPUSHBTNKEY];
       
        if (model) {
            
           NSArray * listArr  = [NSKeyedUnarchiver unarchiveObjectWithData:model];
            
           
            _topItemView = [[JXCommunityTopItemView alloc ]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT * 0.6) andData:listArr];
        }
        
    }
    [self.view addSubview:_topItemView];
    
    return _topItemView;
}

-(SPComServiceModulesBusiness *)bussiness{
    
    if (_bussiness==nil) {
        
        _bussiness = [[SPComServiceModulesBusiness alloc] init];
    }
    return _bussiness;
}

-(NSMutableArray *)datas{
    
    if (_datas == nil) {
        
        _datas = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _datas;
}


-(UIImageView *)topBannerImageView{

    if (!_topBannerImageView) {
        
        _topBannerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.248)];
        
        _topBannerImageView.backgroundColor = [UIColor colorWithRGB:244/255.0 G:244/255.0 B:244/255.0 alpha:1.0];
        
        _topBannerImageView.image = BANNERPLACEHOLDERIMAGE;
        
    }
    
    return _topBannerImageView;
}

-(void)dealloc{

    [_datas  removeAllObjects];
    _datas = nil;
}



@end
