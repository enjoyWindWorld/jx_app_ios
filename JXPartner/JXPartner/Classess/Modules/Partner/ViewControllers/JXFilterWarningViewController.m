//
//  JXFilterWarningViewController.m
//  JXPartner
//
//  Created by windpc on 2017/11/14.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXFilterWarningViewController.h"
#import "JXPartnerBusiness.h"
#import "JXPlanFilterLifeModel.h"
#import "JXFilterTableViewCell.h"
#import "JXFitlerModel.h"
#import "JXAfterFilterTableViewCell.h"
#import "JXFilterLifeTableViewCell.h"

@interface JXFilterWarningViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic,strong) JXPartnerBusiness * business ;

@property (nonatomic,assign) NSInteger currentPage ;

@property (nonatomic,strong) NSMutableArray * datas ;  //下属

@end

@implementation JXFilterWarningViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"滤芯寿命警告";

    if (@available(iOS 11.0, *)) {
        self.myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.myTableView.estimatedRowHeight = 0;
        self.myTableView.estimatedSectionFooterHeight = 0;
        self.myTableView.estimatedSectionHeaderHeight = 0;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    _currentPage = 1 ;

    _datas = [NSMutableArray arrayWithCapacity:0];

    [self request_fetchFilterWarningLis:1];

    [self.myTableView addJXEmptyView];

    __weak typeof(self) weakself = self ;

    [self.myTableView addJX_NormalHeaderRefreshBlock:^{

        [weakself request_fetchFilterWarningLis:1];
    }];

    [self.myTableView addJX_NormalFooterRefreshBlock:^{

        [weakself request_fetchFilterWarningLis:_currentPage+1];

    }];

    self.myTableView.tableFooterView = [UIView new];

    [self.myTableView registerNib:[UINib nibWithNibName:@"JXAfterFilterTableViewCell" bundle:nil] forCellReuseIdentifier:@"JXAfterFilterTableViewCell"];

    [self.myTableView registerNib:[UINib nibWithNibName:@"JXFilterLifeTableViewCell" bundle:nil] forCellReuseIdentifier:@"JXFilterLifeTableViewCell"];

     self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Do any additional setup after loading the view.
}


/**
 获取滤芯警告列表

 @param page
 */
-(void)request_fetchFilterWarningLis:(NSInteger)page{

    _currentPage = page ;

    __weak typeof(self) weakself = self ;

    [self.business fetchFilterWarningList:@{@"page":@(page)} success:^(id result) {

        [weakself.myTableView JXendRefreshing];

        NSArray * resultArr = result ;

        if (weakself.currentPage == 1) {

            [weakself.datas removeAllObjects];
        }

        if (resultArr.count==0) {

            [weakself.myTableView JXfooterEndNoMoreData];
        }

        [weakself.datas addObjectsFromArray:resultArr];

        [weakself.myTableView reloadData];

    } failer:^(id error) {

        [weakself.myTableView JXendRefreshing];

        [weakself makeToast:error duration:3 position:nil];
    }];

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

     return _datas.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    JXPlanFilterLifeModel * model = _datas[section];

    return model.filterWarningViewItemArr.count + model.Filter_state.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    JXPlanFilterLifeModel * model = _datas[indexPath.section];

    if (indexPath.row < model.filterWarningViewItemArr.count) {

        JXAfterFilterTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JXAfterFilterTableViewCell" forIndexPath:indexPath] ;

        cell.rightLabel.lineBreakMode = NSLineBreakByCharWrapping ;

        NSDictionary * dic = model.filterWarningViewItemArr[indexPath.row];

        [self local_configTableViewCell:cell indexPath:indexPath model:dic];

        return cell ;
    }
    JXFilterLifeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JXFilterLifeTableViewCell" forIndexPath:indexPath];

    JXFitlerModel * filterModel = model.Filter_state[indexPath.row - model.filterWarningViewItemArr.count];

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

    if (indexPath.row < model.filterWarningViewItemArr.count) {

        CGFloat height = [tableView fd_heightForCellWithIdentifier:@"JXAfterFilterTableViewCell" configuration:^(id cell) {

            NSDictionary * dic = model.filterWarningViewItemArr[indexPath.row];

            [self local_configTableViewCell:cell indexPath:indexPath model:dic];

        }];

        return height < 45 ? 35 : height ;
    }

    CGFloat height = [tableView fd_heightForCellWithIdentifier:@"JXFilterLifeTableViewCell" configuration:^(id cell) {
        JXFitlerModel * filterModel = model.Filter_state[indexPath.row - model.filterWarningViewItemArr.count];

        [self local_configTableViewCell:cell indexPath:indexPath model:filterModel];

    }];

    return height < 50 ? 35 : height ;

}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return .1f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

-(JXPartnerBusiness *)business{

    if (_business == nil) {

        _business  =[[JXPartnerBusiness alloc] init];

    }
    return  _business;
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
