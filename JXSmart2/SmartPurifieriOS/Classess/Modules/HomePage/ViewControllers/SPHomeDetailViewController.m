//
//  SPHomeDetailViewController.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/16.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPHomeDetailViewController.h"
#import "SPPurifierModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "SPHomePageBusiness.h"
#import "SPHomePageListModel.h"

#import "RxWebViewController.h"

#import "JXDetailChooseDataCell.h"
#import "JXDetailTableHeaderView.h"
#import "UIButton+WEdgeInSets.h"
#import "JXDetailChooseDataView.h"
#import "JXDetailProdescView.h"
#import "SPUserServiceElectricityEntrance.h"
#import "SDCycleScrollView.h"

NSString * const itemNewContent = @"itemContent";
NSString * const itemNewSubContent = @"itemSubContent";


#define CostFreeTag 10

#define TrafficFreeTag 20

#import "JXWritePayViewController.h"
#import "UIView+WZLBadge.h"
#define DETAILCHOOSECOLOR @"选择 颜色 交易类型"
#define DETAILSELECTCOSTTYPEANDCOLOR  @"已选:"
#define DETAILPRODUCTDESC @"产品参数"
#define DETAILPRODUCTSERVICES  @"净水机介绍及服务说明"
#define BADGECENTEROFFSET CGPointMake(-25, 10);


@interface SPHomeDetailViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,JXDetailChooseDataViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic,strong) NSMutableArray* itemDataArr;


@property (nonatomic,strong) SPPurifierModel * PurifierModel ;

@property (nonatomic,strong)  SDCycleScrollView * newcolorImageView ;

@property (nonatomic,strong) SPHomePageBusiness * busess;

@property (weak, nonatomic) IBOutlet UIButton *CarBtn;

@property (nonatomic,strong)  JXDetailChooseDataView * head ;  //选择数据

@property (nonatomic,strong) JXDetailProdescView * productDesc ;

@property (nonatomic,strong)  JXDetailTableHeaderView  * header ;


@end

@implementation SPHomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.navigationItem.title = @"商品详情";
    
    [self.myTableView addJXEmptyView];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"JXDetailChooseDataCell" bundle:nil] forCellReuseIdentifier:@"JXDetailChooseDataCell"];
    
    [self configViewWithCarButton];
    
    [self requestProductDetail];
    
    [self compatibleAvailable_ios11:_myTableView];
}


-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self requestCarNum];
}

-(void)configViewWithCarButton{

    [_CarBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsImageStyleTop imageTitlespace:5];
    
    [_CarBtn showBadgeWithStyle:WBadgeStyleNumber value:0 animationType:WBadgeAnimTypeScale];  //购物车提示数
    
    _CarBtn.badgeCenterOffset =BADGECENTEROFFSET;
    
    _CarBtn.badgeBgColor = [UIColor redColor];
    
    _CarBtn.badgeTextColor = [UIColor whiteColor];
}


#pragma mark - 获取详情数据
-(void)requestProductDetail{
    
   
    [SPSVProgressHUD showWithStatus:@"正在获取中..."];
    
    __weak typeof(self) weakslef = self ;
    
    [self.busess getProductDetailData:@{@"id":_listModel.dataIdentifier} success:^(id result) {
        
        [SPSVProgressHUD dismiss];
        
        weakslef.header = [[JXDetailTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.4+110)];
        
        self.myTableView.tableHeaderView =  weakslef.header;
        
        weakslef.PurifierModel = result ;
        
        weakslef.header.name = weakslef.PurifierModel.name;

        weakslef.header.colorArr = weakslef.PurifierModel.colorArr;

        weakslef.header.priceArr = weakslef.PurifierModel.PricceArr;
        
        [weakslef.myTableView reloadData];
        
    } failere:^(NSString *error) {
        
        [SPSVProgressHUD dismiss];
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakslef.view];
        
    }];

}




#pragma mark - 构造页面数据
-(void)getViewItemData{

    [self.itemDataArr removeAllObjects];

    [self.itemDataArr addObject:@{itemNewContent:DETAILCHOOSECOLOR,itemNewSubContent:@""}];
   
    [self.itemDataArr addObject:@{itemNewContent:DETAILPRODUCTDESC,itemNewSubContent:@""}];
   
    [self.itemDataArr addObject:@{itemNewContent:DETAILPRODUCTSERVICES,itemNewSubContent:@""}];
    
    [self.myTableView reloadData];
    

}

#pragma mark - 获得购物车数量
-(void)requestCarNum{

    __weak typeof(self) weakself = self;
  
    [self.busess fetchShoppingCarNum:@{} success:^(id result) {
        

        [weakself.CarBtn showBadgeWithStyle:WBadgeStyleNumber value:[result integerValue] animationType:WBadgeAnimTypeScale];  //购物车提示数s
        
    } failere:^(id error) {
        
        
    }];
}


#pragma mark - 点击立即购买
- (IBAction)goPayAction:(id)sender {

    if (!self.PurifierModel) {
        
        return ;
    }
    
    self.head.model = self.PurifierModel;
    
    [self.head show];
    
}
#pragma mark - 点击加入购物车
- (IBAction)addShoppingCarAction:(id)sender {
    
    if (!self.PurifierModel) {
        
        return ;
    }
    
    self.head.model = self.PurifierModel;
    
   
    [self.head show];
}

#pragma mark- 前往购物车
- (IBAction)forwardShopingAction:(id)sender {
    
    UIViewController * vc  = [SPUserServiceElectricityEntrance  fetchShoppingCarVC];
    
    
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark -UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    if (!self.PurifierModel) {
        
        return 0;
    }

    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
    
        return self.itemDataArr.count;

    }
    
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        JXDetailChooseDataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JXDetailChooseDataCell"];
        
        NSDictionary * dic = self.itemDataArr[indexPath.row];
        
        cell.nameDesc.text = dic[itemNewContent];
        
        NSString * imgname = indexPath.row==2?@"nav_back_right":@"more";
        
        [cell.descRight setImage:[UIImage imageNamed:imgname] forState:UIControlStateNormal];
     
        return cell ;
    }
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"imagecell"] ;
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"imagecell"];
        
        CGFloat scale = 1080  / 2430;
        
        UIImageView * backimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 852)];
        backimageView.tag = 10001 ;
        backimageView.contentMode = UIViewContentModeScaleAspectFit ;
        [cell.contentView addSubview:backimageView];
    }
    
    UIImageView * imageview = [cell.contentView viewWithTag:10001];\
    
    NSString * imageName = [NSString stringWithFormat:@"detailimage%ld.jpg",indexPath.row];
    
    imageview.image = [UIImage imageNamed:imageName];
    

    return cell;
    
}


-(void)changeCostype:(UIButton*)bt{

    if (bt.tag==CostFreeTag) {
        
        _PurifierModel.costType = ClarifierCostType_YearFree;
        
    }else if (bt.tag ==TrafficFreeTag){
    
    
        _PurifierModel.costType = ClarifierCostType_TrafficFree;
    }

    [_myTableView reloadData];

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    CGFloat scale = 1080  / 2430;

    return indexPath.section == 0 ? 55.f : 852;
    
//    return 55.f;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  
    return 10.f ;

}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 10.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (!self.PurifierModel || indexPath.section == 1) {
        
        return ;
    }
    
    if (indexPath.row==0) {
        
        self.head.model = self.PurifierModel;
        
        [self.head show];
    
    }else if (indexPath.row==1){
        
        self.productDesc.model = self.PurifierModel;
    
        [self.productDesc show];
    }else{
    
        RxWebViewController * web = [[RxWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://www.szjxzn.tech:8080/jx/pdf/promise.pdf"]];
        
        [self.navigationController pushViewController:web animated:YES];
    }

    
}

#pragma mark - JXDetailChooseDataViewDelegate

-(void)dataview_datachangewithPrice:(NSString *)price url:(NSString *)url number:(NSInteger)number ppdnumber:(NSInteger)ppdnumber costpay:(NSInteger)costpay color:(NSString *)color actionType:(ButtonActionType)actionType{

    __weak typeof(self) weakself = self ;
    
    
//     [self performSegueWithIdentifier:@"SPWritePayMsgViewController" sender:nil];
//    
//    return;
    
    if (actionType == ButtonActionType_ADDSHOPCAR) {
        
        [self.busess insertShoppingCar:@{@"price":price,@"name":_PurifierModel.name,@"url":url,@"number":[NSString stringWithFormat:@"%ld",number],@"ppdnum":[NSString stringWithFormat:@"%ld",ppdnumber],@"color":color,@"proid":_PurifierModel.dataIdentifier,@"type":[NSString stringWithFormat:@"%ld",costpay]} success:^(id result) {
            
            [SPSVProgressHUD showSuccessWithStatus:@"添加购物车成功"];
            
            
            [weakself.CarBtn showBadgeWithStyle:WBadgeStyleNumber value:[result integerValue] animationType:WBadgeAnimTypeScale];  //购物车提示数s
            
        } failere:^(id error) {
            
            [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
            
        }];
    }else if (actionType==ButtonActionType_RIGHTPAY){
    
        [self.busess fetchShoppingCarProdesc:@{@"type":[NSString stringWithFormat:@"%ld",costpay],@"typename":_PurifierModel.dataTypename,@"url":url,@"number":[NSString stringWithFormat:@"%ld",number],@"ppdnum":[NSString stringWithFormat:@"%ld",ppdnumber],@"color":color,@"proid":_PurifierModel.dataIdentifier} success:^(id result) {
            
            if (result) {
                
                [weakself performSegueWithIdentifier:@"JXWritePayViewController" sender:result];

            }
        } failere:^(id error) {
            
            [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
        }];
        
    }
    
}




#pragma mark - prepareForSegue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"JXWritePayViewController"]) {
        
        JXWritePayViewController * vc = segue.destinationViewController;
        
        vc.productListArr = sender;
    }
    
}


#pragma mark - getter setter 

-(NSMutableArray *)itemDataArr{

    if (_itemDataArr ==nil) {
        
        _itemDataArr = [[NSMutableArray alloc] initWithCapacity:0];
        
        [_itemDataArr addObject:@{itemNewContent:DETAILCHOOSECOLOR,itemNewSubContent:@""}];
       
        [_itemDataArr addObject:@{itemNewContent:DETAILPRODUCTDESC,itemNewSubContent:@""}];
        
        [_itemDataArr addObject:@{itemNewContent:DETAILPRODUCTSERVICES,itemNewSubContent:@""}];
    }
    
    return _itemDataArr;
}

-(SPHomePageBusiness *)busess{

    if (_busess == nil) {
        
        _busess = [[SPHomePageBusiness alloc] init];
    }
    
   return _busess ;
}

-(JXDetailChooseDataView *)head{

    if (_head == nil) {
        
        _head = [[JXDetailChooseDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        _head.delegate = self;
        
    }
    return _head;
}

-(JXDetailProdescView *)productDesc{

    if (_productDesc == nil) {
        
        _productDesc = [[JXDetailProdescView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
    }
    
    return _productDesc;
}


-(void)dealloc{

    NSLog(@"");
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
