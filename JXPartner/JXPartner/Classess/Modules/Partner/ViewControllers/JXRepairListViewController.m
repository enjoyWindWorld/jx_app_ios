//
//  JXRepairListViewController.m
//  JXPartner
//
//  Created by windpc on 2017/11/16.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXRepairListViewController.h"
#import "JXPartnerBusiness.h"
#import "JXPlanFilterLifeModel.h"

@interface JXRepairListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic,strong) JXPartnerBusiness * business ;

@property (nonatomic,assign) NSInteger currentPage ;

@property (nonatomic,strong) NSMutableArray * datas ;  

@end

@implementation JXRepairListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"维修记录";

    [self  request_fetchRepairList:1];
    // Do any additional setup after loading the view.
}


/**
 获得维修记录

 @param page
 */
-(void)request_fetchRepairList:(NSInteger)page{

    [self.business fetchProductRepairList:@{@"page":@"1",@"pro_no":@"5c1663e5-39b7-4026-8ab3-67c3aa506786",@"ord_no":@"217350914141949"} success:^(id result) {



    } failer:^(id error) {


    }];

}



-(JXPartnerBusiness *)business{

    if (!_business) {

        _business = [[JXPartnerBusiness alloc] init];
    }
    return _business ;
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
