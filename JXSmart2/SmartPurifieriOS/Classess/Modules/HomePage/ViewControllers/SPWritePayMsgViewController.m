//
//  SPWritePayMsgViewController.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/16.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPWritePayMsgViewController.h"
#import "SPUserServiceElectricityEntrance.h"
#import "SPChooseDateView.h"
#import "SPPurifierModel.h"
#import "SPWritePayTableViewCell.h"
#import "SPWirtePayModel.h"
#import "spuserAddressListModel.h"
#import "SPUserAddressListTableViewCell.h"
#import "SPUserAddressListViewController.h"
#import "SPHomePageBusiness.h"
#import "SPUserModulesBusiness.h"
#import "SPGoPayDetailViewController.h"

#import "RxWebViewController.h"


@interface SPWritePayMsgViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,assign) BOOL isHaveHomeAddress; //是否选择了家庭地址

@property (nonatomic,strong) SPChooseDateView * DateView;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic,strong) SPWirtePayModel * itemModel ;

@property (nonatomic,strong)  SPHomePageBusiness * busess ;

@property (nonatomic,strong) UIButton * checkBT ;

@end

@implementation SPWritePayMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"填写支付详情";

   
    
    _itemModel = [[SPWirtePayModel alloc] init];
    
    _itemModel.payPurifierModel = _payModel ;
    
    _busess = [[SPHomePageBusiness alloc] init];
    
    UIView * viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    
//    viewBack.backgroundColor = [UIColor redColor];
    
    
    _checkBT = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_checkBT setImage:[UIImage imageNamed:@"CheckNormal"] forState:UIControlStateNormal];
    
    [_checkBT setImage:[UIImage imageNamed:@"CheckedBlue"] forState:UIControlStateSelected];
    
    _checkBT.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    
    [_checkBT addTarget:self action:@selector(confirmAgreement) forControlEvents:UIControlEventTouchUpInside];
    
    _checkBT.frame = CGRectMake(15, 5, 30, 30);
    
    [viewBack addSubview:_checkBT];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, 200, 30)];
    
    label.font = [UIFont systemFontOfSize:16];
    
    label.textColor = [UIColor colorWithHexString:@"333333"];
    
    NSString * text = @"同意服务协议";
    
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:text attributes:attribtDic];
    
    [attribtStr addAttribute:NSUnderlineColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:(NSRange){0,[text length]}];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forwardAgreement)];
    
    label.userInteractionEnabled = YES ;
    
    [label addGestureRecognizer:tap];
    
    
    //赋值
    label.attributedText = attribtStr;
   
    [viewBack addSubview:label];
    
    

    self.myTableView.tableFooterView =viewBack;

}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];

    if (!_itemModel.addressModel) {
        
        [self requestDefaultAddress];
        
    }
}




-(void)requestDefaultAddress{

    SPUserModulesBusiness * user = [[SPUserModulesBusiness alloc] init];
    
    [user getUserHomeList:@{@"isdefault":@"0"} success:^(id result) {
        
        if ([result isKindOfClass:[NSArray class]]) {
            
            NSArray * arr = result ;
            
            _itemModel.addressModel = [arr firstObject];
            
            [_myTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        }
        
        
    } failer:^(NSString *error) {
        
        
        
    }];
    

}


#pragma mark - 点击支付
- (IBAction)goPayAction:(id)sender {
    
    
//    [self performSegueWithIdentifier:@"SPGoPayDetailViewController" sender:nil];
//    
//    return ;
    
    NSString * pmcode = _itemModel.payPmCode;
    
    NSString * productTime = _itemModel.payTime ;
    
//    NSString * proID = _itemModel.payPurifierModel.dataIdentifier;
    
    NSString * adrid = _itemModel.addressModel.addessid;
    
    if (adrid.length==0 || [adrid isEqual:[NSNull null]]) {
        
        [SPToastHUD makeToast:@"请选择家庭地址" duration:3 position:nil makeView:self.view];
        
        return ;
    }
    
    if (pmcode.length==0 || [pmcode isEqual:[NSNull null]]) {
        
        [SPToastHUD makeToast:@"请输入产品经理编号" duration:3 position:nil makeView:self.view];
        
        return ;
    }
    
    if (productTime.length==0 || [productTime isEqual:[NSNull null]] ||[productTime isEqualToString:@"选择安装时间"]) {
        
        [SPToastHUD makeToast:@"请选择安装时间" duration:3 position:nil makeView:self.view];
        
        return ;
    }
    
    if (!_checkBT.selected) {
        
        [SPToastHUD makeToast:@"请前往阅读服务协议并同意" duration:3 position:nil makeView:self.view];
        
        return ;
    }
    
    
    [self requestProductAddOrder];


}

#pragma mark - 请求订单
-(void)requestProductAddOrder{
    
    [SPSVProgressHUD showWithStatus:@"正在生成订单中.."];

    NSString * pmcode = _itemModel.payPmCode;
    
    NSString * productTime = _itemModel.payTime ;
    
    NSString * proID = _itemModel.payPurifierModel.dataIdentifier;
    
    NSString * adrid = _itemModel.addressModel.addessid;
    
  __block  NSString * color = @"";
    
  __block  NSString * url = @"";
    
    [_itemModel.payPurifierModel.colorArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        SPProduceColorModel * model = obj;
        
        if (model.isSelect) {
            
            color = model.pic_color;
            
            url  = [[model.url componentsSeparatedByString:@","] firstObject];
            
            *stop = YES;
        }
        
        
    }];
    
    __weak typeof(self) weakself = self ;
    //  _itemModel.payPurifierModel.yearfee
//    [_busess getProductAddOrder:@{@"proid":proID,@"settime":productTime,@"adrid":adrid,@"managerNo":pmcode,@"price":[[self class] getMoneyStringModel:_itemModel],@"proname":_itemModel.payPurifierModel.name,@"color":color,@"url":url,@"paytype":[NSNumber numberWithInteger:_itemModel.payPurifierModel.costType]} succcess:^(id result) {
//        
//        [SPSVProgressHUD dismiss];
//        
//        [weakself performSegueWithIdentifier:@"SPGoPayDetailViewController" sender:result];
//        
//    } failere:^(NSString *error) {
//        
//        [SPSVProgressHUD dismiss];
//        
//        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
//        
//    }];
    
    
    [_busess getProductAddOrder:@{@"settime":productTime,@"adrid":adrid,@"managerNo":pmcode,@"id":@"57,59"} succcess:^(id result) {
        
        [SPSVProgressHUD dismiss];
        
        [weakself performSegueWithIdentifier:@"SPGoPayDetailViewController" sender:result];
        
    } failere:^(NSString *error) {
        
        [SPSVProgressHUD dismiss];
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
        
    }];
    
}

+(NSString*)getMoneyStringModel:(SPWirtePayModel*)model{
    
    NSString * freemoney = @"";
    
    for (SPProducePayTypePriceModel * PriceModel in model.payPurifierModel.PricceArr) {
        
        if (PriceModel.paytype ==model.payPurifierModel.costType) {
            
            if ([PriceModel.pay_pledge floatValue]>0) {
            
                CGFloat producePrice = [PriceModel.price floatValue] +[PriceModel.pay_pledge floatValue];
                
                freemoney = [NSString stringWithFormat:@"%.2f",producePrice];
                
            }else{
            
                freemoney =PriceModel.price;
                
            }

        }
    }
    
    return freemoney;
}

-(void)forwardAgreement{

    
//    NSURL * url = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"1.docx" ofType:nil ]];
    
    NSURL * url = [NSURL URLWithString:@"https://www.jx-inteligent.tech:8877/pdf/agreement.pdf"];
    
    SPAgreetmentWebViewController* webViewController = [[SPAgreetmentWebViewController alloc] initWithUrl:url];
    
    webViewController.title = @"使用服务协议";
    
    __weak typeof(self) weakself = self;
    
    webViewController.confirmSelect = ^{

        weakself.checkBT.selected = YES;
        
    };
    
    [self.navigationController pushViewController:webViewController animated:YES];
    
}

-(void)confirmAgreement{
    
    BOOL iselect = _checkBT.selected;

    _checkBT.selected = !iselect;
    
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section==0) return 1;
    
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SPWritePayTableViewCell * cell =  [SPWritePayTableViewCell tableView:tableView CellWithIndex:indexPath itemModel:_itemModel];
    
    cell.choosePMText.delegate = self ;
    
    return cell;
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    _itemModel.payPmCode = textField.text ;

}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return .1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section==0) {
        
        return 10.f;
    }
    
    return .1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return  [SPWritePayTableViewCell tableView:tableView heightForIndex:indexPath itemModel:_itemModel];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0) {
      
        __weak typeof(self) weakself = self ;
        //选择地址
        UIViewController * vc  =  [SPUserServiceElectricityEntrance getUserHomeAddressController:^(spuserAddressListModel *model) {
            
            _itemModel.addressModel = model ;
            
            [weakself.myTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            
        }];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.section==1&&indexPath.row==3) {
       
        
        if (!_DateView) {
            
            _DateView = [[SPChooseDateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) dataPickType:UIDatePickerModeDateAndTime dataPickHeght:300];
            
        }
        [self.view addSubview:_DateView];
        
        __weak typeof(self) weakself = self ;
        
        [_DateView setActionTime:^(NSString * time) {
            
            weakself.itemModel.payTime = time ;
            
            [weakself.myTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        }];
        
        [_DateView dateViewShowAction];
        
    }


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SPGoPayDetailViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"SPGoPayDetailViewController"]) {
        
        SPGoPayDetailViewController * vc = segue.destinationViewController ;
        
        vc.writePayModel = sender;
        
    }

}



@end
