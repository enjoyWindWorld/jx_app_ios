//
//  JXChooseReasonViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/11/10.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXChooseReasonViewController.h"
#import "SPUserModulesBusiness.h"
#import "JXChooseProductTableViewCell.h"

@interface JXChooseReasonViewController ()

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic,strong) SPUserModulesBusiness * business ;

@property (nonatomic,strong) NSMutableArray * datas ;

@end

@implementation JXChooseReasonViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"选择故障现象";

    [self.myTableView addJXEmptyView];
    
    _datas = [NSMutableArray arrayWithCapacity:0];
    
    [self  compatibleAvailable_ios11:_myTableView];
    
    self.myTableView.tableFooterView = [UIView new];
    
    [self request_productReason];
    // Do any additional setup after loading the view.
}


-(void)request_productReason{

    __weak typeof(self) weakself = self ;

    [self.business fetch_faultErrTipList:@{@"is_shelves":@"0"} success:^(id result) {

        NSArray * resultArr = result ;

        weakself.datas = resultArr ;

        [weakself.myTableView reloadData];

    } failer:^(id error) {

        [SPToastHUD makeToast:error makeView:weakself.view];
    }];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    JXChooseProductTableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL0" forIndexPath:indexPath];

    cell.pro_name.text = _datas[indexPath.row];

    return cell ;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (_datas.count > indexPath.row) {

        NSString * texe = _datas[indexPath.row];

        if (_touchBlock) {

            _touchBlock(texe);
        }


        [self.navigationController popViewControllerAnimated:YES];
    }

}

#pragma mark - 业务请求
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
