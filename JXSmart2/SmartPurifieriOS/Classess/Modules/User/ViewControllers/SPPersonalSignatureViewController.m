//
//  SPPersonalSignatureViewController.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/18.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPPersonalSignatureViewController.h"
#import "SPUserModulesBusiness.h"
#import "AppDelegate.h"
#import "SPUserModel.h"
#import "ShieldEmoji.h"

@interface SPPersonalSignatureViewController ()<UITextViewDelegate>
{
    UITextView *textview;
    
    ShieldEmoji *emojim;
}

//@property (weak, nonatomic) IBOutlet UITextView *myTextView;


@end

@implementation SPPersonalSignatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SPViewBackColor;
    self.title = self.titleStr;
    
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH, 100)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    textview = [[UITextView alloc] initWithFrame:CGRectMake(10, 15, SCREEN_WIDTH-20, 100)];
    textview.backgroundColor=[UIColor clearColor]; //背景色
    textview.scrollEnabled = YES;    //当文字超过视图的边框时是否允许滑动，默认为“YES"
    textview.editable = YES;        //是否允许编辑内容，默认为“YES”
    textview.delegate = self;       //设置代理方法的实现类
    textview.font=[UIFont fontWithName:@"Arial" size:15.0]; //设置字体名字和字体大小;
    //textview.returnKeyType = UIReturnKeyDefault;//return键的类型
    //textview.keyboardType = UIKeyboardTypeDefault;//键盘类型
    textview.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
    textview.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
    textview.textColor = [UIColor grayColor];
    if (self.textStr) {
        textview.text = self.textStr;
    }else{
        textview.text = @"✎ 输入内容";
    }
    
    textview.layer.cornerRadius = 0;
    textview.layer.masksToBounds = YES;
    
    [self.view addSubview:textview];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(ConfirmComplaction)];
    // Do any additional setup after loading the view.
    
    emojim = [ShieldEmoji alloc];
}

#pragma mark  网络代理
-(void)initNetwork
{
    [SPSVProgressHUD showWithStatus:@"修改中..."];
    
    NSDictionary * dic;
    
    textview.text = [textview.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([_titleStr isEqualToString:@"意见反馈"]) {
        SPUserModel *m = [SPUserModel getUserLoginModel];
      dic = @{@"context":textview.text,
              @"phoneNum":m.UserPhone};
    }else{
        dic = @{@"value":textview.text};
    }
    
    __weak typeof(self) weakself  = self ;
    [[[SPUserModulesBusiness alloc]init] getUserInfo:dic success:^(id result) {
        NSLog(@"arrcount is %@",result);
        [SPSVProgressHUD dismiss];
        [SPSVProgressHUD showSuccessWithStatus:@"修改成功"];

        if (![textview.text isEqualToString:@"✎ 输入内容"]) {
            if (self.contentBlock) {
                self.contentBlock(textview.text);
            }
        }else{
            if (self.contentBlock) {
                self.contentBlock(@"");
            }
        }
        
        SPUserModel* user = [SPUserModel getUserLoginModel];

        if ([self.titleStr isEqualToString:@"修改昵称"]) {
            user.nickname = textview.text;
        }else if ([self.titleStr isEqualToString:@"修改签名"]){
            user.sign = textview.text;
        }else if ([self.titleStr isEqualToString:@"意见反馈"]){
            
        }
        [user saveUserLoginModel];

        [self.navigationController popViewControllerAnimated:YES];
    } failer:^(NSString *error) {
        [SPSVProgressHUD dismiss];
        
        [SPToastHUD makeToast:error duration:2.5 position:nil makeView:weakself.view];
        
    }];

}


-(void)ConfirmComplaction{
    
    [self.view endEditing:YES];
    
    NSString *str = [textview.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    BOOL flag = [emojim isContainsTwoEmoji:str];
    
    if (flag)
    {
        
        [SPToastHUD makeToast:@"内容请勿输入表情" duration:2.0 position:nil makeView:self.view];
    }else{
        if (![str isEqualToString:@"✎ 输入内容"] && str.length != 0) {
            [self initNetwork];
        }else{
           
            
            [SPToastHUD makeToast:@"输入内容不能为空" duration:2.5 position:nil makeView:self.view];
        }

    }
    
}

#pragma textViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    NSString *str = textView.text;
    
    if ([str isEqualToString:@"✎ 输入内容"]) {
        textView.text = @"";
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    NSString *str = textView.text;
   
    if (str.length == 0) {
        textView.text = @"✎ 输入内容";
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    
//    BOOL flag = [emojim isContainsTwoEmoji:textView.text];
//    
//    if (flag)
//    {
//        textView.text = [textView.text substringToIndex:textView.text.length -2];
//        //[SPSVProgressHUD showErrorWithStatus:@"不能输入表情"];
//        
//    }

}

@end
