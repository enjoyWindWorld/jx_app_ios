//
//  JXPlanFilterLifeViewController.m
//  JXPartner
//
//  Created by windpc on 2017/11/14.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXPlanFilterLifeViewController.h"
#import "JXPartnerBusiness.h"
#import "JXPlanFilterLifeModel.h"
#import "JXFilterTableViewCell.h"
#import "JXFitlerModel.h"
#import "EVNCustomSearchBar.h"
#import "JXPartnerViewElectricityEntrance.h"
#import "JXAfterSalesViewController.h"
#import "JXAfterFilterTableViewCell.h"
#import "JXFilterLifeTableViewCell.h"

@interface JXPlanFilterLifeViewController ()<UITableViewDataSource,UITableViewDelegate,EVNCustomSearchBarDelegate,UISearchResultsUpdating, UISearchControllerDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic,strong) JXPartnerBusiness * business ;

@property (nonatomic,assign) NSInteger currentPage ;

@property (nonatomic,strong) NSMutableArray * datas ;  //下属

@property (nonatomic,strong) NSMutableArray * searchDatas ;  //下属

@property (strong, nonatomic) EVNCustomSearchBar *searchBar;

@property (nonatomic,strong) UISearchController * searchController ;

@end

@implementation JXPlanFilterLifeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"套餐滤芯状况统计";

    [self local_congfigInitView];
    // Do any additional setup after loading the view.
}

-(void)local_congfigInitView{


    if (@available(iOS 11.0, *)) {
        self.myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.myTableView.estimatedRowHeight = 0;
        self.myTableView.estimatedSectionFooterHeight = 0;
        self.myTableView.estimatedSectionHeaderHeight = 0;
        [self.searchBar.heightAnchor constraintLessThanOrEqualToConstant:44].active = YES;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    [self.myTableView registerNib:[UINib nibWithNibName:@"JXAfterFilterTableViewCell" bundle:nil] forCellReuseIdentifier:@"JXAfterFilterTableViewCell"];

    [self.myTableView registerNib:[UINib nibWithNibName:@"JXFilterLifeTableViewCell" bundle:nil] forCellReuseIdentifier:@"JXFilterLifeTableViewCell"];

    _currentPage = 1 ;

    _datas = [NSMutableArray array];

    [self.myTableView addJXEmptyView];

    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    __weak __typeof (self)weakself = self;

    if (!_currentSearch) {

        self.myTableView.tableHeaderView = self.searchBar ;

        [self request_fetchPlanFilterLifeList:_currentPage];

        [self.myTableView addJX_NormalHeaderRefreshBlock:^{

            [weakself request_fetchPlanFilterLifeList:1];
        }];

        [self.myTableView addJX_NormalFooterRefreshBlock:^{

            [weakself request_fetchPlanFilterLifeList:_currentPage+1];
        }];

    }else{

        [self.myTableView addJX_NormalHeaderRefreshBlock:^{

            [weakself request_fetchPlanFilterKeyWorld:weakself.searchBar.text page:1];
        }];

        [self.myTableView addJX_NormalFooterRefreshBlock:^{

            [weakself request_fetchPlanFilterKeyWorld:weakself.searchBar.text page:weakself.currentPage+1];
        }];

    }

    [self.myTableView jxHeaderStartRefresh];

    self.myTableView.tableFooterView = [UIView new];

}


-(void)request_fetchPlanFilterLifeList:(NSInteger)page{

    _currentPage = page ;

    __weak typeof(self) weakself  = self;

    [self.business fetchPlanFilterLifeList:@{@"page":@(_currentPage)} success:^(id result) {

        __strong __typeof(weakself)strongSelf = weakself;

        [strongSelf.myTableView JXendRefreshing ];

        NSArray * resultArr = result ;

        if (weakself.currentPage==1) {

            [strongSelf.datas removeAllObjects];
        }

        if (resultArr.count==0) {

            [strongSelf.myTableView JXfooterEndNoMoreData];
        }

        [strongSelf.datas addObjectsFromArray:resultArr];

        [strongSelf.myTableView reloadData];

    } failer:^(id error) {

        [weakself.myTableView JXendRefreshing ];

        [weakself makeToast:error];

    }];
}

-(void)request_fetchPlanFilterKeyWorld:(NSString*)keyWorld page:(NSInteger)page{

    if (keyWorld.length <= 0) return ;

    _currentPage = page ;

    __weak typeof(self) weakself  = self;

    [self.business fetchPlanFilterSearchKeyWorld:@{@"page":@(_currentPage),@"search":keyWorld} success:^(id result) {

        __strong __typeof(weakself)strongSelf = weakself;

        [strongSelf.myTableView JXendRefreshing ];

        NSArray * resultArr = result ;

        if (weakself.currentPage == 1) {

            [strongSelf.datas removeAllObjects];
        }

        if (resultArr.count==0) {

            [strongSelf.myTableView JXfooterEndNoMoreData];
        }

        [strongSelf.datas addObjectsFromArray:resultArr];

        [strongSelf.myTableView reloadData];

    } failer:^(id error) {

        [weakself.myTableView JXendRefreshing ];

        [weakself makeToast:error];

    }];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _datas.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    JXPlanFilterLifeModel * model = _datas[section];

    return model.viewItemArr.count + model.Filter_state.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

     JXPlanFilterLifeModel * model = _datas[indexPath.section];

    if (indexPath.row < model.viewItemArr.count) {

        JXAfterFilterTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JXAfterFilterTableViewCell" forIndexPath:indexPath] ;

        cell.rightLabel.lineBreakMode = NSLineBreakByCharWrapping ;

        NSDictionary * dic = model.viewItemArr[indexPath.row];

        [self local_configTableViewCell:cell indexPath:indexPath model:dic];

        return cell ;
    }
    JXFilterLifeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JXFilterLifeTableViewCell" forIndexPath:indexPath];

    JXFitlerModel * filterModel = model.Filter_state[indexPath.row - model.viewItemArr.count];

    [self local_configTableViewCell:cell indexPath:indexPath model:filterModel];

    return cell ;

}

-(void)local_configTableViewCell:(id)cell indexPath:(NSIndexPath*)index model:(id)model{

    if ([cell isKindOfClass:[JXAfterFilterTableViewCell class]]) {

        JXAfterFilterTableViewCell * baseCell = cell ;

        baseCell.leftLabel.text = model[PLAN_FILTER_LEFTTITLE];

        baseCell.rightLabel.text = model[PLAN_FILTER_RIGHTTITLE];

    }else if ([cell isKindOfClass:[JXFilterLifeTableViewCell class]]){

        JXFilterLifeTableViewCell * baseCell = cell ;

        JXFitlerModel * filterModel  = model ;

        baseCell.filter_Name.text = filterModel.name ;

        baseCell.filter_Life.text = [NSString stringWithFormat:@"%.2f%%",filterModel.proportion];
    }

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

     JXPlanFilterLifeModel * model = _datas[indexPath.section];

    if (indexPath.row < model.viewItemArr.count) {

        CGFloat height = [tableView fd_heightForCellWithIdentifier:@"JXAfterFilterTableViewCell" configuration:^(id cell) {

             NSDictionary * dic = model.viewItemArr[indexPath.row];

            [self local_configTableViewCell:cell indexPath:indexPath model:dic];

        }];

        return height < 45 ? 35 : height ;
    }

    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"JXFilterLifeTableViewCell" configuration:^(id cell) {
         JXFitlerModel * filterModel = model.Filter_state[indexPath.row - model.viewItemArr.count];

        [self local_configTableViewCell:cell indexPath:indexPath model:filterModel];

    }];

    return height < 50 ? 35 : height ;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    JXPlanFilterLifeModel * model = _datas[indexPath.section];

    [self performSegueWithIdentifier:@"JXAfterSalesViewController" sender:model];

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return .1f ;
}

- (BOOL)searchBarShouldBeginEditing:(EVNCustomSearchBar *)searchBar
{
//    UIViewController * vc  = [JXPartnerViewElectricityEntrance  fetchPlanFilterViewControllerWithCurrentSearch:YES];
//
//    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
//
//    _searchController.dimsBackgroundDuringPresentation = NO ;
//    _searchController.hidesNavigationBarDuringPresentation = YES;
//    // 搜索框检测代理
//    _searchController.searchResultsUpdater = self;
//    _searchController.delegate = self;
//    _searchController.searchBar.placeholder = @"输入名字/订单号/地址查找";
//
//    // KVC
//    UITextField *searchField = [_searchController.searchBar valueForKey:@"_searchField"];
//    [searchField setValue:self.searchBar.placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
//    searchField.textColor = self.searchBar.textColor;
//    searchField.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
//    [_searchController.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
////    [[[_searchController.searchBar.subviews.firstObject subviews] firstObject] removeFromSuperview]; // 直接把背景imageView干掉。在iOS8,9是没问题的，7没测试过。
//
//    [self presentViewController:_searchController animated:YES completion:^{
//
//    }];
    return YES;
}

- (void)searchBarTextDidEndEditing:(EVNCustomSearchBar *)searchBar{



    if (searchBar.text) {

        [self request_fetchPlanFilterKeyWorld:searchBar.text page:1];
    }else{

        [self request_fetchPlanFilterLifeList:1];
    }
}

-(void)searchBar:(EVNCustomSearchBar *)searchBar textDidChange:(NSString *)searchText{

   [self request_fetchPlanFilterKeyWorld:searchBar.text page:1];
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{

    [self  request_fetchPlanFilterKeyWorld:searchController.searchBar.text page:1];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"JXAfterSalesViewController"]) {

        JXAfterSalesViewController * vc = segue.destinationViewController ;

        vc.title = @"维修记录";

        vc.currentRepairList  = YES ;

        vc.model = sender ;

    }


}


-(JXPartnerBusiness *)business{

    if (_business == nil) {

        _business  =[[JXPartnerBusiness alloc] init];

    }
    return  _business;
}

-(NSMutableArray *)searchDatas{

    if (!_searchDatas) {

        _searchDatas = [NSMutableArray arrayWithCapacity:0];
    }

    return _searchDatas;
}

- (EVNCustomSearchBar *)searchBar
{
    if (!_searchBar)
    {
        _searchBar = [[EVNCustomSearchBar alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
        _searchBar.backgroundColor = [UIColor whiteColor]; // 清空searchBar的背景色
        NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"EVNCustomSearchBar.bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        NSString *img_path = [bundle pathForResource:@"EVNCustomSearchBar.png" ofType:@"png"];
        _searchBar.iconImage = [UIImage imageWithContentsOfFile:img_path];
        _searchBar.iconAlign = EVNCustomSearchBarIconAlignCenter;
        [_searchBar setPlaceholder:@"输入名字/订单号/地址查找"];  // 搜索框的占位符
        _searchBar.placeholderColor = HEXCOLORS(@"666666");
        _searchBar.delegate = self; // 设置代理
        [_searchBar sizeToFit];
    }
    return _searchBar;
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
