//
//  SPUserChangeAddressViewController.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/17.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPUserChangeAddressViewController.h"
#import "GCPlaceholderTextView.h"
#import "ChooseLocationView.h"
#import "SPMapAroundInfoViewController.h"
#import "SPAddressInfoModel.h"
#import "SPUserModulesBusiness.h"
#import "spuserAddressListModel.h"
#import "NSString+Verification.h"
#import "ShieldEmoji.h"

@interface SPUserChangeAddressViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *chooseAddressTextField;
@property (weak, nonatomic) IBOutlet GCPlaceholderTextView *detailAddressTextFileld;

@property (nonatomic,strong) SPUserModulesBusiness * business ;

@property (weak, nonatomic) IBOutlet UISwitch *switchDefault;


@end

@implementation SPUserChangeAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"地址管理";
   
    if (_listModel) {
        
        self.title = @"修改地址";
        
        //恶心的后台给的判断居然与代码判断相反
        [_switchDefault setOn:!_listModel.isdefault];
        
        _nameTextField.text = _listModel.name;
        
        _phoneTextField.text = _listModel.phone;
        
        _chooseAddressTextField.text = _listModel.area;
        
        _detailAddressTextFileld.text = _listModel.detail;
        
    }
    
    
    self.tableView.tableFooterView = [UIView new];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleClick)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(confirmAddressModel)];
    
    self.chooseAddressTextField.enabled = NO ;
    
     _business = [[SPUserModulesBusiness alloc] init];
    

}

#pragma mark - 点击取消

-(void)cancleClick{

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -点击确定
-(void)confirmAddressModel{

    if (_nameTextField.text.length==0) {
        
        [SPToastHUD makeToast:@"请输入联系人" duration:3 position:nil makeView:self.view];
        
        return ;
    }
    
    NSString * nameText = [_nameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (nameText.length==0) {
        
        [SPToastHUD makeToast:@"请输入联系人" duration:3 position:nil makeView:self.view];
        
        return ;
    }
    
    if ([ShieldEmoji isContainsNewEmoji:nameText]) {
        
        [SPToastHUD makeToast:@"内容不能包含表情，请检查后输入" duration:3 position:nil makeView:self.view];
        
        return;
    }
    
    if (_phoneTextField.text.length==0) {
        
        [SPToastHUD makeToast:@"请输入手机号" duration:3 position:nil makeView:self.view];
        
        return ;
    }
    
    if (![_phoneTextField.text predicateStringWithPhone]) {
        
        [SPToastHUD makeToast:@"请检查您输入的手机号" duration:3 position:nil makeView:self.view];
        
        return ;
    }

    
    if (_chooseAddressTextField.text.length==0) {
        
        [SPToastHUD makeToast:@"请输入地区信息" duration:3 position:nil makeView:self.view];
        
        return ;
    }
    
     NSString * detailText = [_detailAddressTextFileld.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (detailText.length==0) {
        
        [SPToastHUD makeToast:@"请输入详细地址信息" duration:3 position:nil makeView:self.view];
        
        return ;
    }
    
    if ([ShieldEmoji isContainsNewEmoji:detailText]) {
        
        
        [SPToastHUD makeToast:@"内容不能包含表情，请检查后输入" duration:3 position:nil makeView:self.view];
        
        return;
    }
    
    
    if (_listModel) {
       
         [self requestModifHomeAddress];
       
    }else{
    
        [self requestAddHomeAddress];
        
    }
    

}


#pragma mark - 请求添加地址
-(void)requestAddHomeAddress{
    
    [SPSVProgressHUD showWithStatus:@"请稍后.."];
    
    NSString * detailText = [_detailAddressTextFileld.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //区分新增跟编辑是根据有无地址id
    __weak typeof(self) weakself = self ;
    
    [_business getModifyHomeAddress:@{@"name":_nameTextField.text,@"phone":_phoneTextField.text,@"area":_chooseAddressTextField.text,@"detail":detailText,@"code":@"111",@"isdefault":[NSNumber numberWithInteger:!_switchDefault.isOn]} success:^(id result) {
        
        [SPSVProgressHUD showSuccessWithStatus:@"添加成功"];
        
        [weakself dismissViewControllerAnimated:YES completion:nil];
        
        
    } failer:^(NSString *error) {
        
        [SPSVProgressHUD dismiss];
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
        
    }];
    
}

-(void)requestModifHomeAddress{

    [SPSVProgressHUD showWithStatus:@"请稍后.."];
    
    //区分新增跟编辑是根据有无地址id
    __weak typeof(self) weakself = self ;
    
    NSString * detailText = [_detailAddressTextFileld.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [_business getModifyHomeAddress:@{@"id":_listModel.addessid,@"name":_nameTextField.text,@"phone":_phoneTextField.text,@"area":_chooseAddressTextField.text,@"detail":detailText,@"code":@"111",@"isdefault":[NSNumber numberWithInteger:!_switchDefault.isOn]} success:^(id result) {
        
        [SPSVProgressHUD showSuccessWithStatus:@"修改成功"];
        
        [weakself dismissViewControllerAnimated:YES completion:nil];
        
        
    } failer:^(NSString *error) {
        
        [SPSVProgressHUD dismiss];
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
        
    }];
    
}




- (IBAction)defaultChange:(UISwitch *)sender {
    
   
    
}

- (IBAction)goToMapAroundClick:(id)sender {
    
    [self performSegueWithIdentifier:@"SPMapAroundInfoViewController" sender:nil];
    
}


#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10.f;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.row==2) {
        
        [self.view endEditing:YES];
        
        ChooseLocationView * chac = [[ChooseLocationView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT*0.5)];
        
        [chac setChooseFinish:^(NSArray *arrData) {
            
            NSMutableString * string = [[NSMutableString alloc] initWithCapacity:0];
            
            [arrData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [string appendFormat:@"%@-",obj];
            }];
            
            NSString* addressStr = [string substringToIndex:string.length-1];
            
            _chooseAddressTextField.text = addressStr ;
            
            NSLog(@"数据为  %@",arrData);
        }];
        
        
        [chac showInView:self.view];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"SPMapAroundInfoViewController"]) {
        
        
        SPMapAroundInfoViewController * vc = segue.destinationViewController ;
    
        [vc setHandleAction:^(SPAddressInfoModel *model) {
            
            
            _chooseAddressTextField.text = [NSString stringWithFormat:@"%@%@",model.city,model.thoroughfare] ;
            
        }];
   
    }

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
