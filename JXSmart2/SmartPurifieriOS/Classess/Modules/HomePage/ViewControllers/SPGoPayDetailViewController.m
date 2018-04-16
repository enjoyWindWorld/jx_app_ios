//
//  SPGoPayDetailViewController.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/16.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPGoPayDetailViewController.h"
#import "SPGoPayTypeModel.h"
#import "SPGoPayDetailPayTypeTableViewCell.h"
#import "SPAppPayManger.h"
#import "SPUserServiceElectricityEntrance.h"
#import "SPHomePageBusiness.h"
#import "SPAddOrderModel.h"
#import "OrderDetailModel.h"
#import "SPUserModulesBusiness.h"
#import "SPPayResultViewController.h"
#import "OrderDeitalViewController.h"
#import "UPPaymentControl.h"
#import "SPUserModel.h"
#import "CustomMyOrderListViewController.h"
#import "JXCommunityGoPay.h"
#import "SPComServiceModulesBusiness.h"
#import "SPCommunityServiceElectricityEntrance.h"
#import "JXShopingCarViewController.h"
#import "SPHomeDetailViewController.h"

#define UNIONPAY_MODE @"00"
#define UNIONPAY_URLSCHME @"SmartPurifieriOS"

@interface SPGoPayDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property(nonatomic,strong) NSMutableArray * cellArr ;

@property (nonatomic,assign) SP_AppPay_Type chooseType ;

@property (nonatomic,assign) BOOL isOpenApp ;

@property (nonatomic,strong) SPComServiceModulesBusiness * communityBusiness ;

@property (nonatomic,strong) SPHomePageBusiness * homepageBusiness ;

@end

@implementation SPGoPayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationItem.title = @"支付详情";
    
    self.navigationItem.hidesBackButton = YES ;
    

    UIBarButtonItem * btn_Item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back_left"] style:UIBarButtonItemStylePlain target:self action:@selector(canclePay)];

    self.navigationItem.leftBarButtonItems = @[btn_Item];
 
    _chooseType = SP_AppPay_TypeAli;
    
    SPGoPayTypeModel * typeAli = [[SPGoPayTypeModel alloc] initWithIcoName:@"ali_pay" titlename:@"支付宝" isselect:YES type:SP_AppPay_TypeAli];
   
    SPGoPayTypeModel * typeWechat = [[SPGoPayTypeModel alloc] initWithIcoName:@"wechat_pay" titlename:@"微信" isselect:NO type:SP_AppPay_TypeWeChat];
    
    
    SPGoPayTypeModel * typeUnion= [[SPGoPayTypeModel alloc] initWithIcoName:@"unionpay" titlename:@"银联支付" isselect:NO type:SP_AppPay_TypeAli];
    
    _cellArr = [[NSMutableArray alloc] initWithObjects:typeAli,typeWechat, typeUnion,nil ];
    
    // Do any additional setup after loading the view.
}





-(void)canclePay{
    
    if (!_isOpenApp) {
        
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"提示"message:@"确定取消付款吗"preferredStyle:UIAlertControllerStyleAlert];
        
        __weak typeof(self) weakself = self ;
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
            
        }];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self jx_privateMethod_backView];
            
        }];
        
        [alertController addAction:cancelAction];
        
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else{
    
        [self jx_privateMethod_backView];
    }
}

-(void)jx_privateMethod_backView{
   
    __block  UIViewController * vc = nil ;
    
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[JXShopingCarViewController class]]||[obj isKindOfClass:[SPHomeDetailViewController class]]) {
            
            vc = obj;
            
            *stop = YES;
        }else if ([obj isKindOfClass:[SPHomeDetailViewController class]]){
            
            vc = obj;
            
            *stop = YES;
        }
        
    }];
    
    if (vc) {
        
        [self.navigationController popToViewController:vc animated:YES];
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark - 通知来了
-(void)notificationPayResult:(NSNotification*)not{

    NSLog(@"notificationPayResult");
    
    _isOpenApp = YES ;
    
    NSDictionary * dic  =  not.userInfo ;
    
    if ([[dic objectForKey:@"result"] boolValue]) {
        
        if (_communityPay) {
            
          UIViewController * vc  =  [SPCommunityServiceElectricityEntrance fetchCommunityDetailViewController:_communityPay.pubid];
            
            [self.navigationController pushViewController:vc animated:YES];
        }else{
        
            __weak typeof(self) weakself  = self ;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [weakself fetchOrderPayResoult];
                
            });
            
        }
        
    }else{
        
        if (_communityPay) {
            
            
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            
            if ([[self fetchOrderTag] isEqualToString:@"0"]) {
                
                CustomMyOrderListViewController * vc = [[CustomMyOrderListViewController alloc] init];
                
                vc.selectIndex = 0 ;
                
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                
                //UIViewController * vc  = [SPUserServiceElectricityEntrance orderDeitalController:[self getpayOrd_no]];
                OrderDeitalViewController *vc =[[OrderDeitalViewController alloc]init];
                //订单详情id：OrderId
                vc.OrderId = [self getpayOrd_no];
                
                vc.status = OrderState_NonPayment;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            
        }
    
        
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - 查找状态
-(void)fetchOrderPayResoult{

    [SPSVProgressHUD showWithStatus:@"请稍候..."];
    
    __weak typeof(self) weakself = self ;
    
    SPUserModulesBusiness * bussiness = [[SPUserModulesBusiness  alloc] init];
    
    [bussiness getUserMyOrderDetail:@{@"ord_no":[self getpayOrd_no]} success:^(id result) {
        
        [SVProgressHUD dismiss];
        
        if ([result isKindOfClass:[NSArray class]]) {
            
            OrderDetailModel * model = [result firstObject];
            
            //已支付 已续费
            if ([model.status integerValue]==1|| [model.status integerValue]==4) {
                
                [weakself performSegueWithIdentifier:@"SPPayResultViewController" sender:model];
            }else{
                
                if ([[self fetchOrderTag] isEqualToString:@"0"]) {
                    
                    CustomMyOrderListViewController * vc = [[CustomMyOrderListViewController alloc] init];
                    
                    vc.selectIndex = 0 ;
                    
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    
                    //UIViewController * vc  = [SPUserServiceElectricityEntrance orderDeitalController:[self getpayOrd_no]];
                    OrderDeitalViewController *vc =[[OrderDeitalViewController alloc]init];
                    //订单详情id：OrderId
                    vc.OrderId = [self getpayOrd_no];
                    
                    vc.status = OrderState_NonPayment;
                    
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                
            }
        }
        
    } failer:^(NSString *error) {
        
        [SVProgressHUD dismiss];
        
        [SPToastHUD makeToast:error duration:2.5 position:nil makeView:weakself.view];
    }];
    
}

#pragma mark - 确认支付
- (IBAction)confirmPayAction:(id)sender {
    
    if (!_orderModel && !_writePayModel&& !_communityPay) {
        
         [SPToastHUD makeToast:@"数据错误" duration:3 position:nil makeView:self.view];
        return;
    }

    if (_chooseType == SP_AppPay_TypeAli) {
        
        [self privateRequestAliPay];
        
    }else if (_chooseType==SP_AppPay_TypeWeChat){
        
        
        [self privateRequestWeChatPay];
        //[SPAppPayManger spAppManger:SP_AppPay_TypeWeChat param:@{}];
    }else if (_chooseType == SP_AppPay_TypeUnionpay){
        
        [self privateRequestUnionPay];
    }
    
    


    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPayResult:) name:SPElectricityPayResult object:nil];
   
}

#pragma mark - 支付宝支付
-(void)privateRequestAliPay{
    
    __weak typeof(self) weakself = self ;


    [SPSVProgressHUD showWithStatus:@"正在请求中..."];
    
    if (_communityPay) {
        
        [self.communityBusiness fetchCommunityAliPAY:@{@"ord_no":_communityPay.ord_no,@"seller":_communityPay.seller,@"price":[self getpayPrice]} success:^(id result) {
            
            [SPSVProgressHUD dismiss];
            
            [SPAppPayManger spAppManger:SP_AppPay_TypeAli param:result];
            
        } failer:^(id error) {
           
            [SPSVProgressHUD dismiss];
            
            [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
            
        }];
        
    }else{
    
        
        [self.homepageBusiness getAliPayParamCode:@{@"ord_no":[self getpayOrd_no],@"context":[self getpayContext],@"price":[self getpayPrice],@"isAgain":[self getpayisAgain],@"tag":[self fetchOrderTag]} succcess:^(id result) {
            
            [SPSVProgressHUD dismiss];
            
            [SPAppPayManger spAppManger:SP_AppPay_TypeAli param:result];
            
        } failere:^(NSString *error) {
            
            [SPSVProgressHUD dismiss];
            
            [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
            
        }];
    }
}

#pragma mark - 微信支付
-(void)privateRequestWeChatPay{
    
    __weak typeof(self) weakself = self ;
    
    [SPSVProgressHUD showWithStatus:@"正在请求中..."];
    
    if (_communityPay) {
        
        [self.communityBusiness fetchCommunityWeChatPay:@{@"ord_no":_communityPay.ord_no,@"seller":_communityPay.seller,@"price":[self getpayPrice]} success:^(id result) {
            
            [SPSVProgressHUD dismiss];
            
            [SPAppPayManger spAppManger:SP_AppPay_TypeWeChat param:result];
            
        } failer:^(id error) {
            [SPSVProgressHUD dismiss];
            
            [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
            
        }];
        
    }else{
    
        [self.homepageBusiness getWeChatPayParamCode:@{@"ord_no":[self getpayOrd_no],@"context":[self getpayContext],@"price":[self getpayPrice],@"isAgain":[self getpayisAgain],@"tag":[self fetchOrderTag]} succcess:^(id result) {
            
            [SPSVProgressHUD dismiss];
            
            [SPAppPayManger spAppManger:SP_AppPay_TypeWeChat param:result];
            
        } failere:^(NSString *error) {
            
            [SPSVProgressHUD dismiss];
            
            [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
            
        }];
        
    }
    
    
    
}

#pragma mark - 银联支付
-(void)privateRequestUnionPay{
    
    __weak typeof(self) weakself = self ;
    
    [SPSVProgressHUD showWithStatus:@"正在请求中..."];
    
    if (_communityPay) {
        
        [self.communityBusiness fetchCommunityUnionPay:@{@"ord_no":_communityPay.ord_no,@"seller":_communityPay.seller,@"price":[self getpayPrice]} success:^(id result) {
            
            [SPSVProgressHUD dismiss];
            
            [[UPPaymentControl defaultControl] startPay:result fromScheme:UNIONPAY_URLSCHME mode:UNIONPAY_MODE viewController:self];
            
            [SPAppPayManger spAppManger:SP_AppPay_TypeUnionpay param:nil];
            
        } failer:^(id error) {
            
            [SPSVProgressHUD dismiss];
            
            [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
            
        }];
        
        
    }else{
        
        
        [self.homepageBusiness getUnionPayParamCode:@{@"ord_no":[self getpayOrd_no],@"context":[self getpayContext],@"price":[self getpayPrice],@"isAgain":[self getpayisAgain],@"tag":[self fetchOrderTag]} succcess:^(id result) {
            
            [SPSVProgressHUD dismiss];
            
            [[UPPaymentControl defaultControl] startPay:result fromScheme:UNIONPAY_URLSCHME mode:UNIONPAY_MODE viewController:self];
            
            [SPAppPayManger spAppManger:SP_AppPay_TypeUnionpay param:nil];
            
        } failere:^(NSString *error) {
            
            [SPSVProgressHUD dismiss];
            
            [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
            
        }];
    }
    

    

}




-(NSString*)getpayPrice{

    if ([SPUserModel getUserLoginModel]&&[[SPUserModel getUserLoginModel].userid isEqualToString:JX_TEST_USER_ID]) {
        
        return @"0";
    }
    if (_orderModel)    return [NSString stringWithFormat:@"%.2f",_orderModel.price];
    
    if (_writePayModel) return _writePayModel.price;
    
    if (_communityPay) {
        
        return _communityPay.price;
    }
    
    return @"";
    
}

-(NSString*)getpayContext{

    if (_orderModel) return  _orderModel.name;
    
    if (_writePayModel)  return   _writePayModel.context;
    
    return @"";
    
}

-(NSString*)getpayOrd_no{

    if (_orderModel)  return   _orderModel.ordNo;
    
    if (_writePayModel) return _writePayModel.ord_no;
    
    if (_communityPay) {
        
        return _communityPay.ord_no;
    }
    
    return @"";
   
}

-(NSInteger)getpayType{
    
    if (_orderModel)  return   _orderModel.paytype;
    
    if (_writePayModel) return _writePayModel.paytype;
    
    return 0;
    
}

-(NSString*)getpayisAgain{
    
 
    if (_orderModel){
    
        return [NSString stringWithFormat:@"%ld",_orderModel.isagain];
    }
    
    if (_writePayModel){
    
        return [NSString stringWithFormat:@"%ld",_writePayModel.type];
    }
    
    return @"";
    
}

-(NSString*)fetchOrderTag{

    
    if (_orderModel){
        
        return @"1";
    }
    
    if (_writePayModel){
        
        return _writePayModel.tag;
    }
    
    return @"1";
}

/**
 更改支付类别
 */
-(void)changeCheckPayType:(NSInteger)type{
    
    _chooseType = type ;
    
    [_cellArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        SPGoPayTypeModel * model = obj ;
        
        model.isSelect = NO;
        
        if (idx==type-1) {
            
            model.isSelect = YES;
            
        }
    }];
    
    [_myTableView reloadData];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section==0) {
        
        return 1;
    }
    return _cellArr.count+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0||(indexPath.section==1&&indexPath.row==0)) {
        
        SPHomeGoPayDeatailTableViewCell * cell  = [tableView dequeueReusableCellWithIdentifier:@"CELL0" forIndexPath:indexPath];
        
        if (_communityPay) {
            
           cell.PayDetailLabel.text = indexPath.section==0?@"总支付金额":@"请选择支付方式";
            
            cell.payCostLabel.text = indexPath.section==0?[NSString stringWithFormat:@"¥ %.2f",[[self getpayPrice] floatValue]]:@"";
            
            return cell;
        }else{
        
            if ([[self getpayisAgain] integerValue]==SPAddorder_Type_PAY) {
                
                cell.PayDetailLabel.text = indexPath.section==0?[self getpayType]==ClarifierCostType_YearFree?@"总支付金额":@"总支付金额":@"请选择支付方式";
            }else if ([[self getpayisAgain] integerValue]==SPAddorder_Type_Renewal){
                
                
                cell.PayDetailLabel.text = indexPath.section==0?[self getpayType]==ClarifierCostType_YearFree?@"总支付金额":@"总支付金额":@"请选择支付方式";
            }
            
            cell.payCostLabel.text = indexPath.section==0?[NSString stringWithFormat:@"¥ %.2f",[[self getpayPrice] floatValue]]:@"";
            
            return cell;
            
        }
    }
    
    SPGoPayDetailPayTypeTableViewCell * cell  = [tableView dequeueReusableCellWithIdentifier:@"CELL1" forIndexPath:indexPath];
    
    SPGoPayTypeModel * model = _cellArr[indexPath.row-1];
    
    cell.isCheck = model.isSelect ;
    
    cell.typeName.text = model.titleName;
    
    cell.iconView.image = [UIImage imageNamed:model.icoName];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (indexPath.section==1&&indexPath.row>0) {
        
        [self changeCheckPayType:indexPath.row];
    }
}





-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return indexPath.section==0?60:45;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section==0) {
        
        return 10.f;
    }
    
    return .1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 10.f;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"SPPayResultViewController"]) {
       
        SPPayResultViewController * vc = segue.destinationViewController;
        
        vc.orderModel = sender;
        
    }

}

-(SPComServiceModulesBusiness *)communityBusiness{

    if (!_communityBusiness) {
        
        _communityBusiness = [[SPComServiceModulesBusiness alloc] init];
    }
    
    return _communityBusiness;
}

-(SPHomePageBusiness *)homepageBusiness{

    if (!_homepageBusiness) {
        
        _homepageBusiness = [[SPHomePageBusiness alloc] init];
    }
    return _homepageBusiness;
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
