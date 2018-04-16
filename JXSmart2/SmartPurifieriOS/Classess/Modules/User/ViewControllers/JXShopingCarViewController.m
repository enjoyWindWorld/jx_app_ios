//
//  JXShopingCarViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/14.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXShopingCarViewController.h"
#import "SPUserModulesBusiness.h"
#import "JXShoppingCarModel.h"
#import "JXShoppingCarHeadView.h"
#import "JXShoppingItemTableViewCell.h"
#import "UIButton+WEdgeInSets.h"
#import "SPHomePageElectricityEntrance.h"

#define HEADERSELECTBTNTAG 10
#define NORMALIMAGE @"check_normal"
#define SELECTIMAGE @"check_orange"

@interface JXShopingCarViewController ()<UITableViewDelegate,UITableViewDataSource,JXShoppingItemTableViewCellDelegate>

@property (nonatomic,strong) SPUserModulesBusiness * business ;

@property (nonatomic,strong) NSMutableArray * carListArr ;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;


@property (weak, nonatomic) IBOutlet UIButton *allSelectBtn;



@property (weak, nonatomic) IBOutlet UILabel *priceCountLabel; //总计或者删除的个数

@property (weak, nonatomic) IBOutlet UIButton *settleDeleteBtn; // 结算或者删除

@property (nonatomic,assign) BOOL  isDel;

@end

@implementation JXShopingCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的购物车";
    
    self.myTableView.delegate = self;
    
    self.myTableView.dataSource = self;
    
    [_allSelectBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsImageStyleLeft imageTitlespace:0];
    
    [_allSelectBtn setImage:[UIImage imageNamed:NORMALIMAGE] forState:UIControlStateNormal];
    
    [_allSelectBtn setImage:[UIImage imageNamed:SELECTIMAGE] forState:UIControlStateSelected];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"JXShoppingCarHeadView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"JXShoppingCarHeadView"];
    
    [self fetchBarButtonItem];
   
    [self.myTableView addJXEmptyView];
    
    [self.myTableView addJX_NormalHeaderRefreshBlock:^{
        
        [self requestShoppingCarList];;
        
    }];

    [self compatibleAvailable_ios11:_myTableView];
    
    self.view.backgroundColor = [UIColor  groupTableViewBackgroundColor];
    
   
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
     [self requestShoppingCarList];
    
     _allSelectBtn.selected = NO;
    
//    [self  updateAllSelectBtn];
}

#pragma mark - 请求购物车数据
-(void)requestShoppingCarList{

    __weak typeof(self)  weakself = self;
    
    [self.business fetchMyShoppingCarAllList:@{} success:^(id result) {
        
        [weakself.myTableView JXendRefreshing];
        
        [weakself.carListArr removeAllObjects];
        
        weakself.carListArr = result;
        
        [weakself.myTableView reloadData];
        
        [weakself fetchBarButtonItem];
        
        [weakself updateAllMoneyState];
        
    } failer:^(id error) {
        
         [weakself.myTableView JXendRefreshing];
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
        
    }];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

//    return 2;
    
    return self.carListArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    JXShoppingCarMainModel * mainModel = self.carListArr[section];
    
    return mainModel.list.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    JXShoppingItemTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL0" forIndexPath:indexPath];
    
    JXShoppingCarMainModel * mainModel = self.carListArr[indexPath.section];
    
    if (mainModel.list.count>indexPath.row) {
        
        JXShoppingCarModel * carModel = mainModel.list[indexPath.row];
        
        cell.selectBtn.selected = carModel.isSelect;
        
        cell.countLabel.hidden = _isDel;
        
        cell.countNumber.hidden = !_isDel;
        
        cell.model = carModel;
        
        [cell.selectBtn setImage:[UIImage imageNamed:NORMALIMAGE] forState:UIControlStateNormal];
        
        [cell.selectBtn setImage:[UIImage imageNamed:SELECTIMAGE] forState:UIControlStateSelected];
        
        cell.index = indexPath;
        
        cell.delegate = self;
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 130.f;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 45.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 10.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    JXShoppingCarHeadView * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"JXShoppingCarHeadView"];
    
    UIView * whiteView = [[UIView alloc] initWithFrame:header.frame];
    
    whiteView.backgroundColor = [UIColor whiteColor];
    
    header.contentView.backgroundColor = [UIColor whiteColor];
    
    header.backgroundView = whiteView;
    
    JXShoppingCarMainModel * model = self.carListArr[section];
    
    header.proNameLabel.text = [model  fetchShoppingCarName];
    
    header.selectBtn.tag = section+HEADERSELECTBTNTAG;
    
    [header.selectBtn addTarget:self action:@selector(shopcar_productAllSelect:) forControlEvents:UIControlEventTouchUpInside];
    
    header.selectBtn.selected = model.isSelect;
    
    [header.selectBtn setImage:[UIImage imageNamed:NORMALIMAGE] forState:UIControlStateNormal];
    
     [header.selectBtn setImage:[UIImage imageNamed:SELECTIMAGE] forState:UIControlStateSelected];
    
    return header;
}


#pragma mark - 点击头部选中
-(void)shopcar_productAllSelect:(UIButton*)btn{

    [self.carListArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        JXShoppingCarMainModel * model = obj;
        
        if (idx==btn.tag-HEADERSELECTBTNTAG) {
            
           BOOL isAllStateSelect  = model.isSelect ;
            
            model.isSelect = !isAllStateSelect;
            
            [model.list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                JXShoppingCarModel * model = obj;
                
                model.isSelect = !isAllStateSelect;
            }];

            *stop = YES;
        }
        
    }];
    
    [self.myTableView  reloadData];
    
    [self updateAllSelectBtn];
    
    [self updateAllMoneyState];
    
    
}

#pragma mark - 点击全选
- (IBAction)shopcar_AllProductChange:(id)sender {
    
    BOOL state = _allSelectBtn.selected;
    
    _allSelectBtn.selected = !state;
    
    [self.carListArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        JXShoppingCarMainModel * model = obj;
    
        model.isSelect = !state;
            
        [model.list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            JXShoppingCarModel* itemModel = obj;
            
            itemModel.isSelect = !state;
        }];
    }];
    
    [_myTableView reloadData];

     [self updateAllMoneyState];
}




#pragma mark - 部分item更新选中
-(void)shopcar_selectBtnChange:(NSIndexPath *)inexPath select:(BOOL)select{

   JXShoppingCarMainModel * mainModel  = self.carListArr[inexPath.section];
    
    __block BOOL isAllSelect = YES;
    
   [mainModel.list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
       JXShoppingCarModel * item = obj;
       
       if (idx==inexPath.row) {
           
           JXShoppingCarModel * itemModel = obj;
           
           BOOL isState = itemModel.isSelect;
           
           itemModel.isSelect = !isState;
           
           if (isState && mainModel.isSelect) {
               
               mainModel.isSelect = NO;
           }
           
           if (!item.isSelect) {
               
               isAllSelect =NO;
           }
           
       }else{
       
           if (!item.isSelect) {
               
               isAllSelect =NO;
           }
           
       }
       
   }];

    mainModel.isSelect = isAllSelect;
    

    [self updateAllSelectBtn];
    
    [self.myTableView reloadData];
   
    [self updateAllMoneyState];
}


-(void)updateAllSelectBtn{
    
    __block BOOL allChoose = YES;
    
    [self.carListArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        JXShoppingCarMainModel * main = obj;
        
        if (main.isSelect==NO) {
            
            allChoose = NO;
            
            *stop = YES;
        }
        
    }];
    
    _allSelectBtn.selected = allChoose;
    
}

#pragma mark - 更新商品数量
-(void)shopcar_numberButtnChange:(NSIndexPath *)indexPath number:(NSInteger)number{
    
    JXShoppingCarMainModel * mainModel  = self.carListArr[indexPath.section];
    
    __block NSString * spcid =@"";
    
    [mainModel.list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx==indexPath.row) {
            
            JXShoppingCarModel * mdoel = obj;
            
            spcid = [NSString stringWithFormat:@"%ld",mdoel.sc_id];
        }
    }];
    
    if (spcid.length==0) return;
    
 
    __weak typeof(self)  weakself = self;
    
    [self.business updateMyShoppingCar:@{@"id":spcid,@"number":[NSString stringWithFormat:@"%ld",number]} success:^(id result) {
        
        [SPSVProgressHUD showSuccessWithStatus:@"更新成功"];
        
        [weakself requestShoppingCarList];
        
    } failer:^(id error) {
        
        [SPToastHUD makeToast:error makeView:weakself.view];
    }];
    
}

#pragma mark - 删除
-(void)deleteShoppingCar:(UIButton*)btn{

    //删除
    
    NSLog(@"点击删除");
    
    __block NSMutableString  *  spcid = @"".mutableCopy;
    
    [self.carListArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        JXShoppingCarMainModel * mainModel = obj;
        
        [mainModel.list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            JXShoppingCarModel * mdoel = obj;
            
            if (mdoel.isSelect) {
              
                [spcid appendFormat:@"%ld,",(long)mdoel.sc_id];
            }
        }];
        
    }];
    
    if (spcid.length==0) {
        
        [SPSVProgressHUD showErrorWithStatus:@"当前暂无.."];
        
        return;
    }
    
    NSString *  spcidArr = [spcid substringToIndex:spcid.length-1];
    
    __weak typeof(self)  weakself = self;
    
    [self.business deleteMyShoppingCar:@{@"id":spcidArr} success:^(id result) {
        
         [SPSVProgressHUD showSuccessWithStatus:@"删除成功"];
        
//         [weakself updateShoppinngCarState];
        //要改一下
         [weakself requestShoppingCarList];
        
        
    } failer:^(id error) {
        
        [SPToastHUD makeToast:error makeView:weakself.view];
    }];
}

#pragma mark - 去结算
-(void)settleShoppingCar:(UIButton*)btn{

    
    NSMutableArray  *  spcidArr = @[].mutableCopy;
    
    [self.carListArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        JXShoppingCarMainModel * mainModel = obj;
        
        [mainModel.list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            JXShoppingCarModel * mdoel = obj;
            
            if (mdoel.isSelect) {
                
                
                [spcidArr addObject:mdoel];
            }
        }];
        
    }];
    
    if (spcidArr.count==0) {
        
        [SPSVProgressHUD showErrorWithStatus:@"当前没有商品"];
        
        return;
    }
    
   
    
   UIViewController* vc  = [SPHomePageElectricityEntrance  fetchWirtePayViewController:spcidArr];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 更改全局编辑状态
-(void)updateShoppinngCarState{

    BOOL  isok  = _isDel ;
    
    _isDel  = !isok;
   
    [self fetchBarButtonItem];
    
    [self.myTableView reloadData];
    
}

#pragma mark - 更新选中价格
-(void)updateAllMoneyState{

    
    if (!_isDel) {
        
        __block CGFloat money = 0 ;
        
        [self.carListArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            JXShoppingCarMainModel * main = obj;
            
            money+= [main fetchShoppingProductMoney];

        }];
        
        NSLog(@"更新后的 金额为 %.2f",money);
        
        NSString * valuestr = [NSString stringWithFormat:@"总计￥%.2f元",money];
        
        NSRange range = [valuestr rangeOfString:[NSString stringWithFormat:@"￥%.2f",money]];
        
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:valuestr];
        
        [attStr addAttribute:NSFontAttributeName
         
                              value:[UIFont systemFontOfSize:16.0]
         
                              range:range];
        
        [attStr addAttribute:NSForegroundColorAttributeName
         
                              value:HEXCOLOR(@"f49f2b")
         
                              range:range];
        
        _priceCountLabel.attributedText = attStr;
    
    }else{
    
        __block NSInteger count = 0;
        
        [self.carListArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            JXShoppingCarMainModel * main = obj;

            count+= [main fetchShoppingSelectNumber];

        }];
        
        NSString * valuestr = [NSString stringWithFormat:@"已选%ld项",(long)count];
        
        NSRange range = [valuestr rangeOfString:[NSString stringWithFormat:@"%ld",(long)count]];
        
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:valuestr];
        
        [attStr addAttribute:NSFontAttributeName
         
                       value:[UIFont systemFontOfSize:16.0]
         
                       range:range];
        
        [attStr addAttribute:NSForegroundColorAttributeName
         
                       value:HEXCOLOR(@"f49f2b")
         
                       range:range];
        
        NSLog(@"更新后的个数为 %ld",(long)count);
        
        _priceCountLabel.attributedText = attStr;
    }
    
    
}

#pragma mark - 更新barBittonitem
-(void)fetchBarButtonItem{

    if (_isDel) {
       
        self.navigationItem.rightBarButtonItem = [self complationItem];
        
        [_settleDeleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        
        [_settleDeleteBtn removeTarget:self action:@selector(settleShoppingCar:) forControlEvents:UIControlEventTouchUpInside];
    
        [_settleDeleteBtn addTarget:self action:@selector(deleteShoppingCar:) forControlEvents:UIControlEventTouchUpInside];
    }else{
    
        self.navigationItem.rightBarButtonItem = [self updateItem];
        
        [_settleDeleteBtn setTitle:@"结算" forState:UIControlStateNormal];
        
        [_settleDeleteBtn removeTarget:self action:@selector(deleteShoppingCar:) forControlEvents:UIControlEventTouchUpInside];
        
        [_settleDeleteBtn addTarget:self action:@selector(settleShoppingCar:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self  updateAllMoneyState];
}



-(UIBarButtonItem*)complationItem{

   return [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(updateShoppinngCarState)];

}

-(UIBarButtonItem*)updateItem{

    return [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(updateShoppinngCarState)];
}

#pragma mark - GETTER SETTER

-(SPUserModulesBusiness *)business{

    if (_business==nil) {
        
        _business = [[SPUserModulesBusiness alloc] init];
        
    }
    
    return _business;
}
-(NSMutableArray *)carListArr{

    if (_carListArr == nil) {
        
        _carListArr = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _carListArr;
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
