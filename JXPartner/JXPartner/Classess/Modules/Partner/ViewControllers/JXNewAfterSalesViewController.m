//
//  JXNewAfterSalesViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/11/3.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXNewAfterSalesViewController.h"
#import "JXNewAfterSalesModel.h"
#import "JXNewAfterTableViewCell.h"
#import "JXAfterListModel.h"
#import "JXPartnerBusiness.h"
#import "JXEvaluateViewController.h"


#define AFTERSALES_LEFTTITLE @"AFTERSALES_LEFTTITLE"
#define AFTERSALES_RIGHTTITLE @"AFTERSALES_RIGHTTITLE"
#define AFTERSALES_RIGHTPLACEHOLDER @"AFTERSALES_RIGHTPLACEHOLDER"

@interface JXNewAfterSalesViewController ()<UITableViewDataSource,UITableViewDelegate,MAddImageCollectionViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic,strong) JXPartnerBusiness * business ;

@property (nonatomic,strong) NSMutableArray * datas ;

@property (nonatomic,strong) JXNewAfterSalesModel * afterModel ;

@property (nonatomic,strong)  JXNewAfterTableViewCell * imageCell ;

@property (nonatomic,assign) BOOL  isTouch;

@end

@implementation JXNewAfterSalesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.myTableView addJXEmptyView];

    if (_model) {

        if (_model.fas_state == 200) {

            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"查看评价" style:UIBarButtonItemStylePlain target:self action:@selector(forward_rightNowAppraise)];
        }else{

        }

         [self request_afterListDetails];
    }
        

    // Do any additional setup after loading the view.
}



-(void)local_viewDataSource{
    
    NSString * title  = @"";

    _datas = [NSMutableArray arrayWithCapacity:0];

    if (_afterSalesType == AfterSalesType_ProductRepair) {
        title = @"设备报修";
        
        NSDictionary * dic1 = @{AFTERSALES_LEFTTITLE:@"选择设备",AFTERSALES_RIGHTTITLE:self.afterModel.pro_name};
        NSDictionary * dic2 = @{AFTERSALES_LEFTTITLE:@"故障现象",AFTERSALES_RIGHTTITLE:self.afterModel.fault_cause};
        NSDictionary * dic3 = @{AFTERSALES_LEFTTITLE:@"具体说明",AFTERSALES_RIGHTTITLE:self.afterModel.specific_reason};
        
        [_datas addObject:@[dic1,dic2,dic3]];
    }else if (_afterSalesType == AfterSalesType_ChangeFilter){
        title = @"滤芯更换";
        NSDictionary * dic1 = @{AFTERSALES_LEFTTITLE:@"选择设备",AFTERSALES_RIGHTTITLE:self.afterModel.pro_name};

        NSDictionary * dic2 = @{AFTERSALES_LEFTTITLE:@"更换滤芯",AFTERSALES_RIGHTTITLE:self.afterModel.filter_name};
        
        [_datas addObject:@[dic1,dic2]];
    }else if (_afterSalesType == AfterSalesType_Others){
        title = @"其他";
        NSDictionary * dic1 = @{AFTERSALES_LEFTTITLE:@"选择设备",AFTERSALES_RIGHTTITLE:self.afterModel.pro_name};
        NSDictionary * dic2 = @{AFTERSALES_LEFTTITLE:@"具体说明",AFTERSALES_RIGHTTITLE:self.afterModel.specific_reason};
        [_datas addObject:@[dic1,dic2]];
    }
    
    NSDictionary * dic1 = @{AFTERSALES_LEFTTITLE:@"预约时间",AFTERSALES_RIGHTTITLE:self.afterModel.make_time};
    NSDictionary * dic2 = @{AFTERSALES_LEFTTITLE:@"联系人",AFTERSALES_RIGHTTITLE:self.afterModel.contact_person};
    NSDictionary * dic3 = @{AFTERSALES_LEFTTITLE:@"联系方式",AFTERSALES_RIGHTTITLE:self.afterModel.contact_way};
    NSDictionary * dic4 = @{AFTERSALES_LEFTTITLE:@"所在地区",AFTERSALES_RIGHTTITLE:self.afterModel.user_address};
    NSDictionary * dic5 = @{AFTERSALES_LEFTTITLE:@"详细",AFTERSALES_RIGHTTITLE:self.afterModel.address_details};
    [_datas addObject:@[dic1,dic2,dic3,dic4,dic5]];
    
    self.navigationItem.title = title ;
    
}



-(void)request_afterListDetails{

    __weak typeof(self) weakself = self ;

    [self.business fetchAfterSalesDetails:@{@"id":_model.dataIdentifier}  success:^(id result) {

        weakself.afterModel = result;
        
         [weakself local_viewDataSource];

        [weakself.myTableView reloadData];

    } failer:^(id error) {

         [weakself makeToast:error];

    }];



}

-(void)forward_rightNowAppraise{

    [self performSegueWithIdentifier:@"JXEvaluateViewController" sender:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _datas.count ;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray * sectionArr = _datas[section];
    
    if (section == 0 && _afterSalesType != AfterSalesType_ChangeFilter) return sectionArr.count +1 ;
    
    return sectionArr.count ;

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

     NSArray * sectionArr = _datas[indexPath.section];

    JXNewAfterTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL0"];

    if (indexPath.section == 0) {

        if (indexPath.row >= sectionArr.count) {

            _imageCell= [tableView dequeueReusableCellWithIdentifier:@"CELL1"];

            _imageCell.accessoryType = UITableViewCellAccessoryNone;

            _imageCell.addImage.maxImageCount = 4 ;

            _imageCell.addImage.delegate = self ;

            _imageCell.addImage.isShowEdit = YES;

            NSArray * arr = [self.afterModel.fautl_url componentsSeparatedByString:@","];

            [_imageCell.addImage setImages:[self.afterModel.fautl_url componentsSeparatedByString:@","]];

            if (_model) {

                _imageCell.addImage.maxImageCount = arr.count ;
            }

            _imageCell.addImage.addImage = [UIImage imageNamed:@"上传照片-拷贝@3x.png"];

            return _imageCell ;
        }
    }

    if (_model) {

        cell.accessoryType = UITableViewCellAccessoryNone;
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSDictionary * dic = sectionArr[indexPath.row];
    
    cell.left_label.text = dic[AFTERSALES_LEFTTITLE];

    cell.right_label.text = dic[AFTERSALES_RIGHTTITLE];

    return cell ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSArray * sectionArr = _datas[indexPath.section];
    
    if (indexPath.section == 0 && indexPath.row >= sectionArr.count) return 120.f;

   CGFloat height  = [tableView fd_heightForCellWithIdentifier:@"CELL0" configuration:^(JXNewAfterTableViewCell* cell) {

       NSArray * sectionArr = _datas[indexPath.section];

       NSDictionary * dic = sectionArr[indexPath.row];

       cell.left_label.text = dic[AFTERSALES_LEFTTITLE];

       cell.right_label.text = dic[AFTERSALES_RIGHTTITLE];

    }];
    
    return height <= 45 ? 45 : height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10.f;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"JXEvaluateViewController"]) {

        JXEvaluateViewController * vc = segue.destinationViewController ;

        vc.afterModel = self.afterModel;

    }

}



-(JXPartnerBusiness *)business{
    
    if (_business==nil) {
        
        _business = [[JXPartnerBusiness alloc] init];
        
    }
    return _business;
}

-(JXNewAfterSalesModel *)afterModel{
    
    if (!_afterModel) {
        
        _afterModel = [[JXNewAfterSalesModel alloc] init];
    }
    
    return _afterModel ;
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
