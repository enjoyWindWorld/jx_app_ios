//
//  FillAddressViewController.m
//  SmartPurifieriOS
//
//  Created by yuan on 2016/11/23.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "FillAddressViewController.h"
//#import "STPickerArea.h"
#import "ReleaseViewController.h"
#import "ChooseLocationView.h"

@interface FillAddressViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    UITableView *tableV;
    
    NSString *cityStr;
    
    UITextField *addressField;
    
    ShieldEmoji *emojim;
}

@end

@implementation FillAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"服务地址";
   
    NSUserDefaults *_defaults = [NSUserDefaults standardUserDefaults];
    cityStr = [_defaults objectForKey:@"fillCity"];
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewCellFocusStyleCustom];
    tableV.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.separatorStyle = YES;
    [self.view addSubview:tableV];
    
    [self  compatibleAvailable_ios11:tableV];
    
    UIView *clearView = [[UIView alloc]initWithFrame:CGRectMake(0, 1, tableV.frame.size.width, 1)];
    clearView.backgroundColor= [UIColor clearColor];
    [tableV setTableFooterView:clearView];
    
    emojim = [ShieldEmoji alloc];
}

-(void)yesClick
{
   //提交点击事件
    BOOL flag = [emojim isContainsTwoEmoji:addressField.text];
    
    if (flag)
    {
        __weak typeof(self) weakself  = self ;
        [SPToastHUD makeToast:@"内容请勿输入表情" duration:2.0 position:nil makeView:weakself.view];
    }else{
        if (self.block) {
            
            //判断此字符串不为空
            if (cityStr == nil || cityStr == NULL) {
                cityStr = @"";
            }
            if ([cityStr isKindOfClass:[NSNull class]]) {
                cityStr = @"";
            }
            if ([[cityStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
                cityStr = @"";
            }
            
            NSUserDefaults *_defaults =[NSUserDefaults standardUserDefaults];
            [_defaults setObject:cityStr forKey:@"fillCity"];
            [_defaults setObject:addressField.text forKey:@"fillAddress"];
            
            [_defaults synchronize];
            
            
            NSString *address = [NSString stringWithFormat:@"%@ %@",cityStr,addressField.text];
            self.block(address);
        }
        
        // block 是基于C语言的函数，直接传参调用<具体的实现在消息的接收方A>
        
        [self.navigationController popViewControllerAnimated:YES];

    }
    
}

#pragma  mark UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    label.text = @"    为了更好地为您服务，请填写服务地址";
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:12];
    
    return label;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backview = [[UIView alloc]init];
    backview.backgroundColor = [UIColor clearColor];
    
    UIButton *yesbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    yesbtn.frame = CGRectMake(15, 20, SCREEN_WIDTH-30, 0.064*SCREEN_HEIGHT);
    yesbtn.backgroundColor = [UIColor clearColor];
    [yesbtn setTitle:@"确定" forState:UIControlStateNormal];
    yesbtn.backgroundColor = SPNavBarColor;
    [yesbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [yesbtn addTarget:self action:@selector(yesClick) forControlEvents:UIControlEventTouchUpInside];
    yesbtn.layer.cornerRadius = 3;
    [backview addSubview:yesbtn];
    
    return backview;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
    
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    NSUserDefaults *_defaults = [NSUserDefaults standardUserDefaults];
    
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"writepayAddress"];
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            
            if (cityStr.length > 0) {
                cell.textLabel.text = cityStr;
            }else{
                cell.textLabel.text = @"请选择地区信息";
               
            }
            
            cell.textLabel.textColor = [UIColor lightGrayColor];
        }else{
            
            cell.imageView.image = [UIImage imageNamed:@"address_samll@2x"];
            
            addressField = [[UITextField alloc]initWithFrame:CGRectMake(0.125*SCREEN_WIDTH, 0, SCREEN_WIDTH-cell.imageView.frame.size.width-cell.imageView.frame.origin.x-66, 50)];
            //addressField.clearButtonMode = UITextFieldViewModeWhileEditing;
            addressField.placeholder = @"请填写街道门牌信息";
            addressField.text =  [_defaults objectForKey:@"fillAddress"];
            addressField.font = [UIFont systemFontOfSize:16];
            [addressField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
            addressField.backgroundColor = [UIColor whiteColor];
            addressField.delegate = self;
            addressField.leftViewMode = UITextFieldViewModeAlways;
            [addressField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [cell.contentView addSubview:addressField];

            
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(0, 0, SCREEN_WIDTH, cell.contentView.frame.size.height);
        label.text = @"退出登录";
        label.textColor = [UIColor redColor];
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
        
    }
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleDefault;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell高度代理
    return 50;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //cell点击事件
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
           //[[[STPickerArea alloc]initWithDelegate:self]show];
            
            [self.view endEditing:YES];
            
            ChooseLocationView * chac = [[ChooseLocationView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT*0.5)];
            
            [chac setChooseFinish:^(NSArray *arrData) {
                
                NSMutableString * string = [[NSMutableString alloc] initWithCapacity:0];
                
                [arrData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    [string appendFormat:@"%@-",obj];
                }];
                
                NSString* addressStr = [string substringToIndex:string.length-1];
                
                cityStr = addressStr;
                
                [tableV reloadData];
            }];
            
            
            [chac showInView:self.view];

        }
    }
    
}

#pragma  mark - textFieldDElegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    NSInteger pointLength = existedLength - selectedLength + replaceLength;
    
    if (pointLength > 130) {
        
        [SPToastHUD makeToast:@"你已超过有效数字" duration:2.5 position:nil makeView:self.view];
        
        return NO;
        
    }else{
        return YES;
    }
    
}

-(void)textFieldDidChange :(UITextField *)theTextField{
//    BOOL flag = [emojim isContainsTwoEmoji:theTextField.text];
//    
//    if (flag)
//    {
//        theTextField.text = [theTextField.text substringToIndex:theTextField.text.length -2];
//        __weak typeof(self) weakself  = self ;
//        [SPToastHUD makeToast:@"请勿输入表情" duration:2.0 position:nil makeView:weakself.view];
//    }
}
//- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
//{
//    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
//    cityStr = text;
//    [tableV reloadData];
//}

@end
