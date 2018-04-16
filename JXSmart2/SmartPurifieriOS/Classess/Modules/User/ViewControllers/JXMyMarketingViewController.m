//
//  JXMyMarketingViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/28.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXMyMarketingViewController.h"
#import "SPUserModulesBusiness.h"
#import "CommunityTableViewCell.h"
#import "ServiceModel.h"
#import "CleanDetailViewController.h"
@interface JXMyMarketingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic,strong) NSMutableArray * datas ;

@property (nonatomic,strong) SPUserModulesBusiness * business ;

@property (nonatomic,assign) NSInteger  currentPage ;

@end

@implementation JXMyMarketingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的推广";
    
    [self fetchMyPromoter:1];
    
    _currentPage = 1 ;
    
    _datas = [NSMutableArray arrayWithCapacity:0];
    
    [_myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommunityTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"CommunityTableViewCell"];
    
    [self.myTableView addJXEmptyView];
    
     __weak typeof(self) weakself = self ;
    
    [self.myTableView addJX_NormalHeaderRefreshBlock:^{
        
        [weakself fetchMyPromoter:1];
    }];
    
    [self.myTableView addJX_NormalFooterRefreshBlock:^{
        
        [weakself fetchMyPromoter:_currentPage+1];
        
    }];
    
    [self  compatibleAvailable_ios11:_myTableView];
    
    self.myTableView.tableFooterView = [UIView new];
    
    // Do any additional setup after loading the view.
}


/**
 获取我的推广
 */
-(void)fetchMyPromoter:(NSInteger)page{

    _currentPage = page;
    
     __weak typeof(self) weakself = self ;

    [self.business fetchMyPromoter:@{@"page":[NSString stringWithFormat:@"%ld",_currentPage]} success:^(id result) {
        
        [weakself.myTableView JXendRefreshing];
        
         NSArray * resultArr = result;
        
        if (page == 1) {
            
            [weakself.datas removeAllObjects];;
        }
        
        [weakself.datas addObjectsFromArray:resultArr];
        
        if(resultArr.count==0){
            
            [SPMJRefresh footerEndNoMoreData:weakself.myTableView];
            
        }
        
        [weakself.myTableView reloadData];
        
    } failer:^(id error) {
        
        [weakself.myTableView JXendRefreshing];
        
         [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
    }];
    
}


//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//
//    return self.datas.count;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return  self.datas.count;;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CommunityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CommunityTableViewCell" forIndexPath:indexPath];
    
    if (self.datas.count > indexPath.row) {
        
        ServiceModel * m = self.datas[indexPath.row];
        
        cell.deitallabel.text = m.content;
        
        cell.deitallabel.numberOfLines = 0;
        
        cell.titlelabel.text = m.seller;
        
        [cell.titlelabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
        
        cell.addressLabel.width = cell.addressLabel.width+cell.typeName.width;
        
        cell.addressLabel.text = m.address;
        
        if (m.pub_addtime.length >10) {
            
            NSString *timestr = [m.pub_addtime substringWithRange:NSMakeRange(0,10)];
            
            cell.timeLabel.text = timestr;
            
        }
        
        NSString * first = [[m.url componentsSeparatedByString:@","]firstObject];
        
        [SPSDWebImage SPImageView:cell.cellImg imageWithURL:first placeholderImage:[UIImage imageNamed:@"暂无图片1@2x"]];
                
    }

    
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
        
        if (m.pubid.length>0) {
            
            vc.pubId = m.pubid;
            
            [self.navigationController pushViewController:vc animated:YES];
        }

    }
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//    return .1f;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//
//    return 10.f;
//}


-(SPUserModulesBusiness *)business{
    
    if (_business==nil) {
        
        _business = [[SPUserModulesBusiness alloc] init];
        
    }
    
    return _business;
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
