//
//  JXSubPartnerUpdateTableViewController.m
//  JXPartner
//
//  Created by windpc on 2017/8/30.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXSubPartnerUpdateTableViewController.h"
#import "JXPartnerBusiness.h"
#import "JXSubPartnerModel.h"

@interface JXSubPartnerUpdateTableViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) JXPartnerBusiness * business ;

@property (weak, nonatomic) IBOutlet UITextField *fanliText;

@property (weak, nonatomic) IBOutlet UITextField *installText;

@property (weak, nonatomic) IBOutlet UITextField *alltext;

@property (nonatomic,assign) NSInteger isEdit ;

@property (nonatomic,assign) BOOL isHaveDian ;

@end

@implementation JXSubPartnerUpdateTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@返利比例修改",_model.par_name];
    
    _fanliText.delegate = self ;
    
    _installText.delegate = self ;
    
    [self fetchBarButtonItem];
    
    [self fetchPartnerPermissions];
    
    
    [self.tableView addJXEmptyView];
    

}

#pragma mark - item 点击
-(void)updatePermissionsAction{
    
    if (_isEdit) {
        
        
        NSString * rebates = _fanliText.text ;
        
        NSString* install = _installText.text ;
        
        if ([rebates floatValue] == 0) {
            
            [self makeToast:@"返利比例不能过低"];
            
            return ;
        }
        
       CGFloat all  = [rebates floatValue]+ [install floatValue];
        
        if (all > 1) {
            
            [self makeToast:@"请输入在合法的范围内"];
            
            return ;
        }
        
        
        
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"提示"message:@"确认修改?"preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            
            
        }];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            BOOL  isok = _isEdit ;
            
            _isEdit = !isok ;
            
            [self fetchBarButtonItem];
            
            [self updatePartnerPermissions];
        }];

        [alertController addAction:cancelAction];
        
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
   
    }else{
    
        
        BOOL  isok = _isEdit ;
        
        _isEdit = !isok ;
        
        [self fetchBarButtonItem];
    }
    
    
}

-(void)fetchPartnerPermissions{

    
    [self showWithStatus:@"获取中..."];
    
    __weak  typeof(self)  weakself = self ;
    
    [self.business  fetchSubPermissions:@{@"par_level":@(_model.par_level),@"username":_model.par_id} success:^(id result) {
        
        [UIViewController dismiss];
        
        NSDictionary *dic = result ;
        
        _fanliText.text = [NSString stringWithFormat:@"%.2f",[dic[@"service_fee"]floatValue]];
        
        _installText.text = [NSString stringWithFormat:@"%.2f",[dic[@"install"]floatValue]];
        
        _alltext.text = [NSString stringWithFormat:@"%.2f",[dic[@"total_rebate"]floatValue]];
        
    } failer:^(id error) {
        
        [UIViewController dismiss];
        
        [weakself makeToast:error];
    }];
    
}

-(void)updatePartnerPermissions{
    
    [self showWithStatus:@"更新中..."];
    
    __weak  typeof(self)  weakself = self ;
    
    NSString * total = _alltext.text ;
    //{"install":0.4000000059604645,"username":"13010000019","service_fee":0.03999999910593033,"total_rebate":0.4399999976158142}
    [self.business  updateSubPermissions:@{@"username":_model.par_id,@"rebates":_fanliText.text,@"installed":_installText.text,@"total":total} success:^(id result) {
        
        [weakself showSuccessWithStatus:@"更新成功"];
        
        NSDictionary *dic = result ;
        
        _fanliText.text = [NSString stringWithFormat:@"%.2f",[dic[@"service_fee"]floatValue]];
        
        _installText.text = [NSString stringWithFormat:@"%.2f",[dic[@"install"]floatValue]];
        
        _alltext.text = [NSString stringWithFormat:@"%.2f",[dic[@"total_rebate"]floatValue]];
        
    } failer:^(id error) {
        
        [UIViewController dismiss];
        
        [weakself makeToast:error];
        
    }];
    
}



-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    // 判断是否有小数点
    if ([textField.text containsString:@"."]) {
      
        self.isHaveDian = YES;
    }else{
        
        self.isHaveDian = NO;
    }
    
    if (string.length > 0) {
        
        //当前输入的字符
        unichar single = [string characterAtIndex:0];
       
        NSLog(@"single = %c",single);
        
        // 不能输入.0-9以外的字符
        if (!((single >= '0' && single <= '9') || single == '.'))
        {
          
            
            return NO;
        }
        
        // 只能有一个小数点
        if (self.isHaveDian && single == '.') {
          
            
            return NO;
        }
        
        // 如果第一位是.则前面加上0.
        if ((textField.text.length == 0) && (single == '.')) {
            
            textField.text = @"0";
        }
        
        // 如果第一位是0则后面必须输入点，否则不能输入。
        if ([textField.text hasPrefix:@"0"]) {
            if (textField.text.length > 1) {
                NSString *secondStr = [textField.text substringWithRange:NSMakeRange(1, 1)];
                if (![secondStr isEqualToString:@"."]) {
              
                    return NO;
                }
            }else{
                if (![string isEqualToString:@"."]) {
                  
                    return NO;
                }
            }
        }
        
        // 小数点后最多能输入两位
        if (self.isHaveDian) {
            NSRange ran = [textField.text rangeOfString:@"."];
            // 由于range.location是NSUInteger类型的，所以这里不能通过(range.location - ran.location)>2来判断
            if (range.location > ran.location) {
                if ([textField.text pathExtension].length > 1) {
                
                    return NO;
                }
            }
        }
        
    }
    
    return YES;
    
 
}

-(void)textFieldDidEndEditing:(UITextField *)textField{

    NSString * rebates = _fanliText.text ;
    
    NSString* install = _installText.text ;
    
    _alltext.text = [NSString stringWithFormat:@"%.2f",[rebates floatValue]+ [install floatValue]];
        
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.f;
}

#pragma mark - 更新barBittonitem
-(void)fetchBarButtonItem{
    
    if (_isEdit) {
        
        self.navigationItem.rightBarButtonItem = [self complationItem];
        
        _fanliText.enabled = YES ;
        
        _installText.enabled = YES ;
        
        [_fanliText becomeFirstResponder];
    }else{
        
        self.navigationItem.rightBarButtonItem = [self updateItem];
        
        _fanliText.enabled = NO;
        
        _installText.enabled = NO ;
        
        [_fanliText resignFirstResponder];
    }

}



-(UIBarButtonItem*)complationItem{
    
    return [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(updatePermissionsAction)];
    
}

-(UIBarButtonItem*)updateItem{
    
    return [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(updatePermissionsAction)];
}

#pragma mark - GETTER SETTER
-(JXPartnerBusiness *)business{
    
    if (!_business) {
        
        _business = [[JXPartnerBusiness alloc] init];
        
    }
    return _business ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



@end
