//
//  JXNewAfterSalesViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/11/3.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXNewAfterSalesViewController.h"
#import "SPUserModulesBusiness.h"
#import "JXChooseProductViewController.h"
#import "JXAfterProductModel.h"
#import "JXChooseFitlerViewController.h"
#import "JXFitlerModel.h"
#import "JXNewAfterSalesModel.h"
#import "JXNewAfterTableViewCell.h"
#import "SPChooseDateView.h"
#import "ChooseLocationView.h"
#import "JXEdidingTextTableViewController.h"
#import "JXChooseReasonViewController.h"
#import "JXAfterListModel.h"
#import "JXEvaluateViewController.h"

#define AFTERSALES_LEFTTITLE @"AFTERSALES_LEFTTITLE"
#define AFTERSALES_RIGHTTITLE @"AFTERSALES_RIGHTTITLE"
#define AFTERSALES_RIGHTPLACEHOLDER @"AFTERSALES_RIGHTPLACEHOLDER"

@interface JXNewAfterSalesViewController ()<UITableViewDataSource,UITableViewDelegate,MAddImageCollectionViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic,strong) SPUserModulesBusiness * business ;

@property (nonatomic,strong) NSMutableArray * datas ;

@property (nonatomic,strong) JXNewAfterSalesModel * afterModel ;

@property (nonatomic,strong) SPChooseDateView * DateView;

@property (nonatomic,strong) ChooseLocationView * chac ;

@property (nonatomic,strong)  JXNewAfterTableViewCell * imageCell ;

@property (nonatomic,assign) BOOL  isTouch;

@end

@implementation JXNewAfterSalesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self local_viewDataSource];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(request_insertNewAfterSales)];
    
    [self  compatibleAvailable_ios11:_myTableView];

    if (_model) {

        if (_model.fas_state == 200) {

            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"查看评价" style:UIBarButtonItemStylePlain target:self action:@selector(forward_rightNowAppraise)];
        }else{

            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(forward_rightNowAppraise)];
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

        NSDictionary * dic3 = @{AFTERSALES_LEFTTITLE:@"具体说明",AFTERSALES_RIGHTTITLE:self.afterModel.specific_reason};
        
        [_datas addObject:@[dic1,dic2,dic3]];
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

-(void)request_insertNewAfterSales{

    if (!self.afterModel.pro_no) {

        [SPToastHUD makeToast:@"请选择对应设备" duration:3 position:nil makeView:self.view];

        return ;
    }

    [SPSVProgressHUD showWithStatus:@"请稍后..."];

    NSMutableDictionary * dic =  [NSMutableDictionary dictionary];
    
    [dic setObject:self.afterModel.pro_id forKey:@"pro_id"];
    [dic setObject:self.afterModel.pro_name forKey:@"pro_name"];
    [dic setObject:self.afterModel.ord_color forKey:@"ord_color"];
    [dic setObject:self.afterModel.pro_no forKey:@"pro_no"];
    [dic setObject:self.afterModel.ord_no forKey:@"ord_no"];
    [dic setObject:self.afterModel.ord_managerno forKey:@"ord_managerno"];
    [dic setObject:self.afterModel.make_time forKey:@"make_time"];
    [dic setObject:self.afterModel.contact_person forKey:@"contact_person"];
    [dic setObject:self.afterModel.contact_way forKey:@"contact_way"];
    [dic setObject:self.afterModel.user_address forKey:@"user_address"];
    [dic setObject:self.afterModel.address_details forKey:@"address_details"];
    [dic setObject:@(_afterSalesType) forKey:@"fas_type"];
     [dic setObject:self.afterModel.proflt_life forKey:@"proflt_life"];
     [dic setObject:self.afterModel.filter_name forKey:@"filter_name"];
     [dic setObject:self.afterModel.fault_cause forKey:@"fault_cause"];
     [dic setObject:self.afterModel.specific_reason forKey:@"specific_reason"];

    __weak typeof(self) weakself = self ;

    [self.business fetch_updateNewAfterSales:dic images:_imageCell.addImage.getImages success:^(id result) {
        [SPSVProgressHUD showSuccessWithStatus:@"售后任务发布成功，待处理"];

        if (weakself.navigationController.viewControllers.count>2) {

            [weakself.navigationController  popToViewController:weakself.navigationController.viewControllers[1] animated:YES];

        }
    } failer:^(id error) {

        [SPSVProgressHUD showErrorWithStatus:error];

    }];
}

-(void)request_afterListDetails{

    __weak typeof(self) weakself = self ;

    [self.business fetch_AfterSalesDetails:@{@"id":_model.dataIdentifier}  success:^(id result) {

        weakself.afterModel = result;
        
         [weakself local_viewDataSource];

        [weakself.myTableView reloadData];

    } failer:^(id error) {

        [SPSVProgressHUD showErrorWithStatus:error];

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

    if (_model)  return ;

    if (indexPath.section == 0) {

        if (indexPath.row == 0) {
            //选择设备
            [self performSegueWithIdentifier:@"JXChooseProductViewController" sender:nil];

        }else if (indexPath.row == 1){
            //换滤芯
            if (_afterSalesType == AfterSalesType_ChangeFilter) {

                if (!self.afterModel.pro_no) {

                    [SPToastHUD makeToast:@"请先选择对应的设备" makeView:self.view];

                    return;
                }

                [self performSegueWithIdentifier:@"JXChooseFitlerViewController" sender:nil];

            }else if (_afterSalesType == AfterSalesType_ProductRepair){

                //故障现象
                [self performSegueWithIdentifier:@"JXChooseReasonViewController" sender:indexPath];

            }else{
                //具体说明
              [self performSegueWithIdentifier:@"JXEdidingTextTableViewController" sender:indexPath];
            }
        }else if (indexPath.row == 2 && (_afterSalesType == AfterSalesType_ProductRepair||_afterSalesType == AfterSalesType_ChangeFilter)){
            //具体说明

              [self performSegueWithIdentifier:@"JXEdidingTextTableViewController" sender:indexPath];
        }
    }

    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {

          __weak typeof(self) wealself = self ;
            
            [self.DateView setActionTime:^(NSString * time) {

                NSDateFormatter * formater  = [[NSDateFormatter alloc]init];
                //设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
                [formater setDateFormat:@"YYYY/MM/dd HH:mm"];

                NSDate * date = [formater  dateFromString:time];

                [formater setDateFormat:@"YYYY-MM-dd HH:mm:ss"];

                NSString * time1  = [formater stringFromDate:date];

                wealself.afterModel.make_time = time1 ;

                [wealself local_viewDataSource];

                [wealself.myTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];

            }];
            
            [self.DateView dateViewShowAction];
        }else
        if (indexPath.row == 3) {

             __weak typeof(self) wealself = self ;

            [self.chac setChooseFinish:^(NSArray *arrData) {

                NSMutableString * string = [[NSMutableString alloc] initWithCapacity:0];

                [arrData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                    [string appendFormat:@"%@-",obj];
                }];

                NSString* addressStr = [string substringToIndex:string.length-1];

                wealself.afterModel.user_address = addressStr ;

                [wealself local_viewDataSource];

                [wealself.myTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];

                NSLog(@"数据为  %@",arrData);
            }];


            [self.chac showInView:self.view];

        }else{

            //bianji
            [self performSegueWithIdentifier:@"JXEdidingTextTableViewController" sender:indexPath];
        }

    }
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"JXChooseProductViewController"]) {
        
        JXChooseProductViewController * vc = segue.destinationViewController ;
        
        __weak typeof(self) wealself = self ;
        
        [vc setTouchBlock:^(id model) {

            JXAfterProductModel * pro = model;
            
            wealself.afterModel.pro_no = pro.pro_no ;

            wealself.afterModel.pro_name = pro.name;

            wealself.afterModel.pro_id = pro.pro_id;

            wealself.afterModel.ord_color = pro.color;

            wealself.afterModel.ord_managerno = pro.ord_managerno ;

            wealself.afterModel.ord_no = pro.ord_no;

            [wealself local_viewDataSource];

            [wealself.myTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];

        }];
    }
    
    if ([segue.identifier isEqualToString:@"JXChooseFitlerViewController"]) {
        
        JXChooseFitlerViewController * vc = segue.destinationViewController ;
        
        vc.prono = self.afterModel.pro_no ;
        
        __weak typeof(self) wealself = self ;
        
        [vc setTouchBlock:^(id model) {

            NSArray * fiterArr = model ;

            NSMutableString * string1  =[NSMutableString string];

            NSMutableString * string2  =[NSMutableString string];

            for (JXFitlerModel * modelF in fiterArr) {

                [string1 appendFormat:@"%@,",modelF.proflt_life];

                [string2 appendFormat:@"%@,",modelF.name];
            }
            string1 = string1.length > 1 ? [string1 substringToIndex:string1.length-1] : string1 ;

            string2 = string2.length > 1 ? [string2 substringToIndex:string2.length-1] : string2 ;
            
            wealself.afterModel.filter_name = string2 ;

            wealself.afterModel.proflt_life = string1 ;

            [wealself local_viewDataSource];

            [wealself.myTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            
        }];
    }

    if ([segue.identifier isEqualToString:@"JXEdidingTextTableViewController"]) {

          __weak typeof(self) wealself = self ;

        JXEdidingTextTableViewController * vc = segue.destinationViewController ;

        vc.indexPath = sender;

        vc.defaultString = _datas[vc.indexPath.section][vc.indexPath.row][AFTERSALES_RIGHTTITLE];

        vc.type = [vc.indexPath isEqual:[NSIndexPath indexPathForRow:2 inSection:1]] ? UIKeyboardTypePhonePad : UIKeyboardTypeDefault;

        [vc setComplationBlock:^(NSString *text, NSIndexPath *index) {
            NSLog(@"---------------- %@  %@",text,index);
            if (index.section == 0) {
                //具体说明
                wealself.afterModel.specific_reason = text;

            }else if (index.section == 1){

                if (index.row == 1) {
                    //联系人
                    wealself.afterModel.contact_person = text;

                }else if (index.row == 2){
                    //联系方式
                    wealself.afterModel.contact_way = text;

                }else if (index.row == 4){
                    //详细
                    wealself.afterModel.address_details = text;
                }
            }

            [wealself local_viewDataSource];

            [wealself.myTableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }


    if ([segue.identifier isEqualToString:@"JXChooseReasonViewController"]) {

         __weak typeof(self) wealself = self ;

        JXChooseReasonViewController  * vc = segue.destinationViewController ;

        [vc setTouchBlock:^(id model) {

            wealself.afterModel.fault_cause = model;

            [wealself local_viewDataSource];

            [wealself.myTableView reloadRowsAtIndexPaths:@[sender] withRowAnimation:UITableViewRowAnimationNone];

        }];
    }

    if ([segue.identifier isEqualToString:@"JXEvaluateViewController"]) {

        JXEvaluateViewController * vc = segue.destinationViewController ;

        vc.afterModel = self.afterModel;

    }

}



-(SPUserModulesBusiness *)business{
    
    if (_business==nil) {
        
        _business = [[SPUserModulesBusiness alloc] init];
        
    }
    return _business;
}

-(JXNewAfterSalesModel *)afterModel{
    
    if (!_afterModel) {
        
        _afterModel = [[JXNewAfterSalesModel alloc] init];
    }
    
    return _afterModel ;
}

-(SPChooseDateView *)DateView{
    
    if (_DateView == nil) {
        
        _DateView = [[SPChooseDateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) dataPickType:UIDatePickerModeDateAndTime dataPickHeght:SCREEN_HEIGHT*0.4];
        
        _DateView.datePicker.minimumDate = [NSDate date];
        
    }
    return _DateView;
}

-(ChooseLocationView *)chac{
    
    if (!_chac) {
        
       _chac =  [[ChooseLocationView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT*0.5)];
    }
    
    return _chac ;
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
