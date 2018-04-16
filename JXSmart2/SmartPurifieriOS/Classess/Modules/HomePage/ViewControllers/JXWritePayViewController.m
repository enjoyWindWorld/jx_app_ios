//
//  JXWritePayViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/6.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXWritePayViewController.h"
#import "SPChooseDateView.h"
#import "SPHomePageBusiness.h"
#import "SPUserModulesBusiness.h"

#import "JXProductGroupCell.h"
#import "JXPrpductItemFooterCell.h"
#import "JXWritePayManagerIDCell.h"
#import "JXWritePayChooseTimeCell.h"
#import "JXWritePayAddressCell.h"

#import "spuserAddressListModel.h"
#import "SPUserServiceElectricityEntrance.h"
#import "RxWebViewController.h"
#import "SPChooseDateView.h"
#import "JXShoppingCarModel.h"
#import "SPGoPayDetailViewController.h"

#define MANAGEIDPLACEHOLDER @"输入产品经理编号";
#define CHOOSETIMEPLACEHOLDER @"选择安装时间";

#define FOOTERCELLCOUNT 2

@interface JXWritePayViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong) SPChooseDateView * DateView;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic,strong)  SPHomePageBusiness * busess ;

@property (nonatomic,strong) UIView * agreementView ;

@property (nonatomic,strong) UIButton * checkBT ;

@property (weak, nonatomic) IBOutlet UIView *bottowView;

@property (weak, nonatomic) IBOutlet UIButton *complationPayBtn;

@property (weak, nonatomic) IBOutlet UILabel *allmoneyLabel;


@property (nonatomic,strong) spuserAddressListModel * addressModel ;

@property (nonatomic,copy) NSString * managerID ;

@property (nonatomic,copy) NSString * settleTime ;

@end

@implementation JXWritePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"填写支付详情";
    
    self.myTableView.tableFooterView = self.agreementView;
    
    self.myTableView.backgroundColor  =[UIColor groupTableViewBackgroundColor];
    
    [self compatibleAvailable_ios11:_myTableView];
    
    [self jx_configRegisterNib];

    _allmoneyLabel.text = [NSString stringWithFormat:@"合计:￥%@元",[self fetchAllTotalPrice]];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [self requestDefaultAddress];
    
}

-(void)jx_configRegisterNib{ 
   
    [self.myTableView registerNib:[UINib nibWithNibName:@"JXProductGroupCell" bundle:nil] forCellReuseIdentifier:@"JXProductGroupCell"];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"JXPrpductItemFooterCell" bundle:nil] forCellReuseIdentifier:@"JXPrpductItemFooterCell"];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"JXWritePayManagerIDCell" bundle:nil] forCellReuseIdentifier:@"JXWritePayManagerIDCell"];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"JXWritePayChooseTimeCell" bundle:nil] forCellReuseIdentifier:@"JXWritePayChooseTimeCell"];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"JXWritePayAddressCell" bundle:nil] forCellReuseIdentifier:@"JXWritePayAddressCell"];

}

#pragma mark - 点击确定
- (IBAction)complatonAction:(id)sender {
    
    NSString * adrid = _addressModel.addessid;
    
    if (adrid.length==0 || [adrid isEqual:[NSNull null]]) {
        
        [SPToastHUD makeToast:@"请选择家庭地址" duration:3 position:nil makeView:self.view];
        
        return ;
    }
    if (_managerID.length==0 || [_managerID isEqual:[NSNull null]]) {
        
        [SPToastHUD makeToast:@"请输入产品经理编号" duration:3 position:nil makeView:self.view];
        
        return ;
    }
    
    if (_settleTime.length==0 || [_settleTime isEqual:[NSNull null]]) {
        
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
    
   __block NSMutableString  *  spcidArr = @"".mutableCopy;
    
    [_productListArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        JXShoppingCarModel * mainModel = obj;
        
        [spcidArr appendFormat:@"%ld,",mainModel.sc_id];
        
    }];
    
    if (spcidArr.length==0) {
        
        return;
    }
    
    NSString *  spcid = [spcidArr substringToIndex:spcidArr.length-1];
    
    __weak typeof(self) weakself = self ;
 
    [self.busess getProductAddOrder:@{@"settime":_settleTime,@"adrid":_addressModel.addessid,@"managerNo":_managerID,@"id":spcid} succcess:^(id result) {
        
        [SPSVProgressHUD dismiss];
        
        [weakself performSegueWithIdentifier:@"SPGoPayDetailViewController" sender:result];
        
    } failere:^(NSString *error) {
        
        [SPSVProgressHUD dismiss];
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
        
    }];
    
}


#pragma mark - 获取默认地址
-(void)requestDefaultAddress{
    
    if (_addressModel) {
        
        return;
    }
    
    SPUserModulesBusiness * user = [[SPUserModulesBusiness alloc] init];
    
    [user getUserHomeList:@{@"isdefault":@"0"} success:^(id result) {
        
        if ([result isKindOfClass:[NSArray class]]) {
            
            NSArray * arr = result ;
            
            _addressModel = [arr firstObject];
            
            [_myTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        }
        
        
    } failer:^(NSString *error) {
        
    
    }];

}

#pragma mark - 前往服务协议
-(void)forwardAgreement{
    
    NSURL * url = [NSURL URLWithString:@"http://www.szjxzn.tech:8080/old_jx/pdf/agreement.pdf"];
    
    SPAgreetmentWebViewController* webViewController = [[SPAgreetmentWebViewController alloc] initWithUrl:url];
    
    webViewController.title = @"使用服务协议";
    
    __weak typeof(self) weakself = self;
    
    webViewController.confirmSelect = ^{
        
        weakself.checkBT.selected = YES;
        
    };
    
    [self.navigationController pushViewController:webViewController animated:YES];
    
}

#pragma mark - 更新按钮
-(void)confirmAgreement{
    
    BOOL iselect = _checkBT.selected;
    
    _checkBT.selected = !iselect;
    
}



#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section==0) return 1;
    
    if (section==1) return self.productListArr.count+FOOTERCELLCOUNT;
    
    return 2;
}

#pragma mark - GETTER SETTER
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section==0) {
        //地址
        JXWritePayAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JXWritePayAddressCell"];
        
        cell.addressModel = self.addressModel;
        
        return cell;
    }else
    
    if (indexPath.section==1) {
       
        if (self.productListArr.count>indexPath.row) {
            
            JXProductGroupCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JXProductGroupCell"];
            
            cell.model = self.productListArr[indexPath.row];
            
            return cell;
        }
        JXPrpductItemFooterCell * item = [tableView dequeueReusableCellWithIdentifier:@"JXPrpductItemFooterCell"];
        
        NSString * allple = [self fetchAllPledgeMoney];
        
        NSString * allcount = [NSString stringWithFormat:@"%ld",[self fetchAllProductList]];
        
        NSString * valuestr = indexPath.item==self.productListArr.count?[NSString stringWithFormat:@"共包含押金:%@元",allple]:[NSString stringWithFormat:@"共%@台设备",allcount];
        
        NSMutableAttributedString * attstr = [[NSMutableAttributedString alloc] initWithString:valuestr];
        
        NSRange range = [valuestr rangeOfString:indexPath.item==self.productListArr.count?allple:allcount];
        
        [attstr addAttribute:NSForegroundColorAttributeName
         
                       value:HEXCOLOR(@"F23030")
         
                       range:range];
        
        item.footerLabel.attributedText = attstr;
        
        return item;
    }else{
    
        if (indexPath.row==1) {

            JXWritePayChooseTimeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JXWritePayChooseTimeCell"];
            
            cell.timeLabel.text = _settleTime?_settleTime:@"选择安装时间";
            
            cell.timeLabel.textColor = _settleTime?HEXCOLOR(@"343434"):HEXCOLOR(@"999999");
            
            return cell;
        }
        
        JXWritePayManagerIDCell * cell =[tableView dequeueReusableCellWithIdentifier:@"JXWritePayManagerIDCell"];
        
        cell.manageText.placeholder =MANAGEIDPLACEHOLDER;
        
        cell.manageText.text = _managerID;
        
        cell.manageText.delegate = self ;
        
        return cell;
        
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
   _managerID = textField.text ;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    //地址
    if (indexPath.section==0) {
        
        if (!self.addressModel) return 60;
        
        CGFloat heght = [tableView fd_heightForCellWithIdentifier:@"JXWritePayAddressCell" configuration:^(JXWritePayAddressCell* cell) {
            
            cell.addressModel = self.addressModel;
        }];
        return  heght+10;
    }
    
    if (indexPath.section==1) {
        
        if (self.productListArr.count>indexPath.row) return 130.f;
        
        return 30;
    }
    
    return 55.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0) {
        //切换地址
        [self forwartChooseAddress];
    }
    
    if (indexPath.section==2) {
        
        if (indexPath.row==0) {
        //产品经理编号
    
            
        }else{
        //选择时间
            __weak typeof(self) weakself = self;
            
            [self.DateView setActionTime:^(NSString * time) {
                
                weakself.settleTime = time;
                
                [weakself.myTableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
            }];
            
            [self.DateView dateViewShowAction];
            
        }
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return .1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section==0||section==1) {
        
        return 10.f;
    }
    
    return .1f;
}

-(void)forwartChooseAddress{
    
    __weak typeof(self) weakself = self ;
    //选择地址
    UIViewController * vc  =  [SPUserServiceElectricityEntrance getUserHomeAddressController:^(spuserAddressListModel *model) {
        
        _addressModel = model ;
        
        [weakself.myTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        
    }];
    
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"SPGoPayDetailViewController"]) {
        
        SPGoPayDetailViewController * vc = segue.destinationViewController ;
        
        vc.writePayModel = sender;
        
    }
    
}

#pragma mark - 获取押金额
-(NSString*)fetchAllPledgeMoney{

   __block CGFloat  allpledge = 0 ;
    
    [self.productListArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        JXShoppingCarModel * model = obj;
        
        allpledge += model.pledge;
    }];
    
    return [NSString stringWithFormat:@"%.2f",allpledge];
}

#pragma mark - 获取总台数
-(NSInteger)fetchAllProductList{
    
    __block  NSInteger  allcount = 0 ;
    
    [self.productListArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        JXShoppingCarModel * model = obj;
        
        allcount+= model.number;
        
    }];
    
    return allcount;
}

#pragma mark - 获得总金额
-(NSString*)fetchAllTotalPrice{
    
    __block CGFloat  totalPrice = 0 ;
    
    [self.productListArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        JXShoppingCarModel * model = obj;
        
        totalPrice += model.totalPrice;
    }];
    
    return [NSString stringWithFormat:@"%.2f",totalPrice];
}


-(UIView *)agreementView{

    if (_agreementView == nil) {
        
        _agreementView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        
        UIButton * checkbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [checkbtn setImage:[UIImage imageNamed:@"CheckNormal"] forState:UIControlStateNormal];
        
        [checkbtn setImage:[UIImage imageNamed:@"CheckedBlue"] forState:UIControlStateSelected];
        
        checkbtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        
        [checkbtn addTarget:self action:@selector(confirmAgreement) forControlEvents:UIControlEventTouchUpInside];
        
        checkbtn.frame = CGRectMake(15, 5, 30, 30);
        
        [_agreementView addSubview:checkbtn];
        
        _checkBT = checkbtn;
        
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
        
        [_agreementView addSubview:label];
        
    }
    
    return _agreementView;
}

-(SPChooseDateView *)DateView{

    if (_DateView == nil) {
        
         _DateView = [[SPChooseDateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) dataPickType:UIDatePickerModeDateAndTime dataPickHeght:SCREEN_HEIGHT*0.4];
        
    }
    
    return _DateView;
}

-(SPHomePageBusiness *)busess{

    if (!_busess) {
        
        _busess = [[SPHomePageBusiness alloc] init];
    }
    
    return _busess;
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
