//
//  JXEvaluateViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/11/10.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXEvaluateViewController.h"
#import "MAddImageCollectionView.h"
#import "JXPartnerBusiness.h"
#import "JXNewAfterSalesModel.h"
#import "GCPlaceholderTextView.h"
#import "TggStarEvaluationView.h"
#import "JXEvaluateModel.h"

@interface JXEvaluateViewController ()<MAddImageCollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *serives_type;
@property (weak, nonatomic) IBOutlet GCPlaceholderTextView *serives_content;

@property (weak, nonatomic) IBOutlet MAddImageCollectionView *addImage;

@property (nonatomic,strong) JXPartnerBusiness * business ;

@property (weak, nonatomic) IBOutlet UISwitch * getGongPai;

@property (weak, nonatomic) IBOutlet UISwitch * getGongFu;

@property (weak, nonatomic) IBOutlet UISwitch * getGongNiming;

@property (weak, nonatomic) IBOutlet TggStarEvaluationView *tgg1;

@property (weak, nonatomic) IBOutlet TggStarEvaluationView *tgg2;

@property (nonatomic,strong) JXEvaluateModel * evaModel ;


@end

@implementation JXEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    _addImage.maxImageCount = 4 ;

    _addImage.delegate = self ;

    _addImage.addImage = [UIImage imageNamed:@"上传照片-拷贝@3x.png"];

    _serives_content.placeholder = @"填写你对这次服务的评价吧";

    _serives_type.text = [NSString stringWithFormat:@"服务类型:%@",_afterModel.fas_type == 1 ? @"滤芯更换": _afterModel.fas_type == 2?@"设备报修":@"其他"];

    if (_afterModel.fas_state != 200) {

        self.title = @"发表评价";

        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(request_insertPingJia)];
    }else{
        //查询详情
        self.title = @"评价详情";

        [_serives_content setEditable:NO];
        _getGongNiming.enabled = NO;
        _getGongFu.enabled = NO;
        _getGongPai.enabled = NO;
        _tgg1.tapEnabled = NO;
        _tgg2.tapEnabled = NO ;


        [self request_fetchPingJiaDetail];
    }

    if (_afterModel.fas_state == 200) {

        _addImage.isShowEdit = YES;

    }



}



//获取数据
-(void)request_fetchPingJiaDetail{

     __weak typeof(self) weakself = self ;

    NSMutableDictionary * dic = [NSMutableDictionary dictionary];

    [dic setObject:_afterModel.dataIdentifier forKey:@"id"];

    [self.business fetchAfterSalesPingJia:dic success:^(id result) {

        weakself.evaModel = result ;

        weakself.serives_content.text = weakself.evaModel.ae_content;

        NSArray * arr = [weakself.evaModel.appraise_url componentsSeparatedByString:@","];

        [weakself.addImage setImages:arr];

        weakself.addImage.maxImageCount = arr.count ;

        [weakself.getGongPai setOn:weakself.evaModel.is_badge];

         [weakself.getGongFu setOn:weakself.evaModel.is_overalls];

         [weakself.getGongNiming setOn:weakself.evaModel.is_anonymous];

        [weakself.tgg1 setStarCount:weakself.evaModel.ae_satisfaction];

         [weakself.tgg2 setStarCount:weakself.evaModel.service_attitude];


    } failer:^(id error) {

        [UIViewController dismiss];

        [weakself makeToast:error duration:3];
    }];

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return .1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 10.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0 && indexPath.row ==0)  return 60.f;

    if (indexPath.section == 1 && indexPath.row ==0)  return 140.f;

    if (indexPath.section == 1 && indexPath.row ==1)  return 100.f;

    return 40.f;
}


-(JXPartnerBusiness *)business{

    if (_business==nil) {

        _business = [[JXPartnerBusiness alloc] init];

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
