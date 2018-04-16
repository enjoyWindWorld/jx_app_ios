//
//  MyClarifierViewController.m
//  SmartPurifieriOS
//
//  Created by yuan on 2016/11/22.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "MyClarifierViewController.h"
#import "MyClarifierTableViewCell.h"
#import "FilterViewController.h"
#import "SPUserModulesBusiness.h"
#import "OrderLitModel.h"
#import "UserPurifierListModel.h"
#import "UIImageView+WebCache.h"
#import "SPUserModel.h"
#import "MyClarifierDetailViewController.h"
//#import "SPDZNEmptYView.h"


@interface MyClarifierViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UIScrollViewDelegate>


@property(nonatomic,strong) SPUserModulesBusiness * clarifierRequest;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property(nonatomic,strong) NSMutableArray * clarifierData;

@property(nonatomic,assign) NSInteger  currentPage;

@end

@implementation MyClarifierViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的净水机";
    
    self.view.backgroundColor = SPViewBackColor;
    
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.myTableView.emptyDataSetDelegate = self;
    
    self.myTableView.emptyDataSetSource = self;
    
    _currentPage = 1;
    
//    [self reuestMessageListData:1];
    [self addMJRefreshView];
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}


-(void)addMJRefreshView{
    
    __weak typeof(self) weakself = self ;
    
    [SPMJRefresh normalHeader:self.myTableView refreshBlock:^{
        
   
       [weakself reuestMessageListData:1];
        
    }];
    
    [SPMJRefresh autoNormalFooter:self.myTableView refreshBlock:^{
        
        [weakself reuestMessageListData:_currentPage+1];
        
    }];
    
    [SPMJRefresh headerBeginRefreshing:self.myTableView];
    
}
#pragma mark - 网络请求
-(void)reuestMessageListData:(NSInteger)page{
    
    _currentPage = page ;
        
    __weak typeof(self) weakself = self ;
    
    [self.clarifierRequest getUserPurifierList:@{@"page":[NSNumber numberWithInteger:page],@"type":[NSNumber numberWithInteger:_clarifierType]} success:^(id result) {
        
        NSArray * resultArr = result ;
        
        [SPMJRefresh endRefreshing:weakself.myTableView];
        
        if (page==1) {
            
            [weakself.clarifierData removeAllObjects];
        }
        
        [weakself.clarifierData addObjectsFromArray:resultArr];
        
        if(resultArr.count==0){
            
            [SPMJRefresh footerEndNoMoreData:weakself.myTableView];
            
        }
        
        [weakself.myTableView reloadData];
        
        [weakself.myTableView reloadEmptyDataSet];
        
    } failer:^(NSString *error) {
        
        [SPMJRefresh endRefreshing:weakself.myTableView];
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
        
    }];
    
}



#pragma  mark UITableViewDelegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.clarifierData.count;
 
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyClarifierTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL0" forIndexPath:indexPath];
    
    if (self.clarifierData.count>indexPath.row) {
        
        UserPurifierListModel *m = self.clarifierData[indexPath.row];
        
        cell.cellTitle.text = m.pro_alias.length>0?m.pro_alias:m.name;
        
        cell.celldeital.text = m.color;
        
        [SPSDWebImage SPImageView:cell.cellImg imageWithURL:m.url placeholderImage:[UIImage imageNamed:@"productplaceholderImage"]];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.selectionStyle=UITableViewCellSelectionStyleDefault;
        
    }
    
    return cell;

    

    
}
//
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    return 70;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UserPurifierListModel *m = self.clarifierData[indexPath.row];
    
    if (m.pro_no.length>0) {
    
        m.type = _clarifierType;
        
    UIStoryboard * story = [UIStoryboard storyboardWithName:@"User" bundle:nil];
        
    MyClarifierDetailViewController * vc  = [story instantiateViewControllerWithIdentifier:@"MyClarifierDetailViewControllerXBID"];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    vc.model = m;
        
    [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString * title = @"暂无数据";
    
    return [[NSAttributedString alloc] initWithString:title attributes:nil];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"NoData@2x"];
}

-(BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    
    return YES ;
}

#pragma mark - getter setter

-(NSMutableArray *)clarifierData{

    if (_clarifierData == nil) {
        
        _clarifierData = [NSMutableArray arrayWithCapacity:0];
        
    }
    return _clarifierData;
}

-(SPUserModulesBusiness *)clarifierRequest{

    if (!_clarifierRequest) {
        
        _clarifierRequest = [[SPUserModulesBusiness alloc] init];
        
    }
    return _clarifierRequest;
}



@end
