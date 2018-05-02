//
//  JXSubParnerViewController.m
//  JXPartner
//
//  Created by windpc on 2017/8/16.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXSubParnerViewController.h"
#import "JXPartnerBusiness.h"
#import "SPUserModel.h"
#import "JXSubParnerTableViewCell.h"
#import "JXSubPartnerModel.h"
#import "JXSubPartnerDetailTableViewController.h"

#define SUBPARNER_NAME_KEY      @"SUBPARNER_NAME_KEY"
#define SUBPARNER_NAME_VALUE      @"SUBPARNER_NAME_VALUE"


@interface JXSubParnerViewController ()

@property (nonatomic,assign) NSInteger readPage ;

@property (nonatomic,strong) NSMutableArray * subparListArr ;  //下属

@property (nonatomic,strong) JXPartnerBusiness * business ;

@property (nonatomic,assign) NSInteger  permissions;

@end

@implementation JXSubParnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.tableView addJXEmptyView];
    

    __weak __typeof (self)weakself = self;
    
    [self.tableView addJX_NormalHeaderRefreshBlock:^{
        
        [weakself requestSubparnernList:1];
    }];
    
    [self.tableView addJX_NormalFooterRefreshBlock:^{
        
        [weakself requestSubparnernList:_readPage+1];
    }];
    
    
    [self.tableView jxHeaderStartRefresh];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.title = @"我的e家";
}

-(void)requestSubparnernList:(NSInteger)page{

    _readPage = page ;
    
     __weak typeof(self) weakself  = self;
    
    [self.business fetchPartnerSublist:@{@"page":[NSString stringWithFormat:@"%ld",page],@"tag":[NSString stringWithFormat:@"%ld",_tag]} success:^(id result) {
        
        __strong __typeof(weakself)strongSelf = weakself;
        
        [strongSelf.tableView JXendRefreshing ];
        
        JXSubPartnerModel * model = result ;
        
        strongSelf.permissions = model.permissions;
        
        if (page == 1) {
            
            [strongSelf.subparListArr removeAllObjects];
        }
        
        if (model.date.count == 0) {
            
            [strongSelf.tableView JXfooterEndNoMoreData];
        }
        
        __block   NSMutableArray * arr = @[].mutableCopy ;
        
        [model.date enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            JXPartnerModel * model = obj;
        
            NSMutableArray * modelArr = @[].mutableCopy;
            
            if (_tag == 0) {
                

                [modelArr addObject:@{SUBPARNER_NAME_KEY:@"名称",SUBPARNER_NAME_VALUE:model.par_name}];
                
                [modelArr addObject:@{SUBPARNER_NAME_KEY:@"编号",SUBPARNER_NAME_VALUE:model.par_id}];
                
                [modelArr addObject:@{SUBPARNER_NAME_KEY:@"级别",SUBPARNER_NAME_VALUE:[JXPartnerModulesMacro fetchParnerLevelString:model.par_level]}];
                
            }else{

                
                [modelArr addObject:@{SUBPARNER_NAME_KEY:@"名称",SUBPARNER_NAME_VALUE:model.par_name}];
                
                [modelArr addObject:@{SUBPARNER_NAME_KEY:@"编号",SUBPARNER_NAME_VALUE:model.par_id}];
                
                [modelArr addObject:@{SUBPARNER_NAME_KEY:@"级别",SUBPARNER_NAME_VALUE:[JXPartnerModulesMacro fetchParnerLevelString:model.par_level]}];
                
                [modelArr addObject:@{SUBPARNER_NAME_KEY:@"上级合伙人",SUBPARNER_NAME_VALUE:model.super_par_name}];
                
                [modelArr addObject:@{SUBPARNER_NAME_KEY:@"上级合伙人编号",SUBPARNER_NAME_VALUE:model.super_id}];

            }
            
            [arr addObject:modelArr];
        }];
        
        
        [strongSelf.subparListArr addObjectsFromArray:arr];
        
        
        [strongSelf.tableView reloadData];
        
    } failer:^(id error) {
        
        [weakself.tableView JXendRefreshing ];
        
        [weakself makeToast:error];
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    
    return self.subparListArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    
    NSArray *arr = self.subparListArr[section];
    
    return arr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    JXSubParnerTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL0" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (self.subparListArr.count >indexPath.section) {
        
        NSArray * modelArr = self.subparListArr[indexPath.section];
        
        NSDictionary * dic = modelArr[indexPath.row];
        
        cell.textLabel.textColor = HEXCOLORS(@"333333");
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@:%@",dic[SUBPARNER_NAME_KEY],dic[SUBPARNER_NAME_VALUE]];
        
        cell.accessoryType = modelArr.count /2 == indexPath.row ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
        
    }
    
    return cell ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 40.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 10.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return .1f;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (self.subparListArr.count >indexPath.section) {
        
        NSArray * modelArr = self.subparListArr[indexPath.section];
        
        JXPartnerModel * model = [[JXPartnerModel alloc] init];
        
        model.permissions = _permissions ;
        
        model.par_id = modelArr[1][SUBPARNER_NAME_VALUE];
        
        model.par_name = modelArr[0][SUBPARNER_NAME_VALUE];
        
        model.par_level =[JXPartnerModulesMacro fetchParnerLevelInter: modelArr[2][SUBPARNER_NAME_VALUE]] ;

        [self  performSegueWithIdentifier:@"JXSubPartnerDetailTableViewController" sender:model];
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"JXSubPartnerDetailTableViewController"]) {
        
        JXSubPartnerDetailTableViewController * vc = segue.destinationViewController ;
        
        vc.model = sender ;
        
    }
    
}

#pragma mark - GETTER SETTER
-(JXPartnerBusiness *)business{

    if (!_business) {
     
        _business = [[JXPartnerBusiness alloc] init];
        
    }
    return _business ;
}


-(NSMutableArray *)subparListArr{

    if (!_subparListArr) {
        
        _subparListArr = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _subparListArr ;
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
