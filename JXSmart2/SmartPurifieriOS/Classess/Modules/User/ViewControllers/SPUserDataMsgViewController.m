//
//  SPUserDataMsgViewController.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/17.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPUserDataMsgViewController.h"
#import "ChooseValuePickerView.h"
#import "SPUserModulesBusiness.h"
#import "SPUserModel.h"
#import "SPPersonalSignatureViewController.h"
#import "SPMainLoginBusiness.h"
#import "HMScanerCardViewController.h"
#import "SPSmartInterfaceEncryption.h"
#import "SPBaseNetWorkRequst.h"

@interface SPUserDataMsgViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    NSString *value;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *icoImageView;

@property (weak, nonatomic) IBOutlet UILabel *nickName;

@property (weak, nonatomic) IBOutlet UILabel *sexLabel;

@property (weak, nonatomic) IBOutlet UILabel *signLabel;

@property (nonatomic,strong) SPUserModel * userModel;


@end

@implementation SPUserDataMsgViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     [self.navigationController setNavigationBarHidden:NO animated:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人信息";
    

    _userModel = [SPUserModel getUserLoginModel];
    
    _icoImageView.layer.masksToBounds = YES ;
    
    _icoImageView.layer.cornerRadius = _icoImageView.width/2;
    
    if (_userModel) {
        
        _nickName.text = _userModel.nickname ;
        
        _signLabel.text = _userModel.sign ;
        
        _sexLabel.text = _userModel.sexstring;
        
        [SPSDWebImage SPImageView:_icoImageView imageWithURL:_userModel.userImg placeholderImage:[UIImage imageNamed:@"user-ico-placehorder"]];
    }
    
}

#pragma mark  网络代理
-(void)initNetwork
{

    [SPSVProgressHUD showWithStatus:@"修改中..."];
    
    NSString *sex;
    if ([value isEqualToString:@"男"]) {
        sex = @"1";
    }
 
    if ([value isEqualToString:@"女"]) {
        sex = @"0";
    }
    
    if ([value isEqualToString:@"保密"]) {
        sex = @"2";
    }
    
    NSDictionary * dic = @{@"value":sex};
     __weak typeof(self) weakself  = self ;
    [[[SPUserModulesBusiness alloc]init] getUserInfo:dic success:^(id result) {
        NSLog(@"arrcount is %@",result);

        [SPSVProgressHUD dismiss];
        
        _sexLabel.text = value;
         [SPToastHUD makeToast:@"修改成功" duration:2.5 position:nil makeView:weakself.view];
        
        _userModel.sex = [sex intValue];
        
        [_userModel saveUserLoginModel];
        

    } failer:^(NSString *error) {
        [SPSVProgressHUD dismiss];
       
        [SPToastHUD makeToast:error duration:2.5 position:nil makeView:weakself.view];
        
    }];

}


#pragma mark - Table view data source

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    NSString * cellid  = [NSString stringWithFormat:@"CELL%ld%ld",indexPath.section,indexPath.row];
//    
//    UITableViewCell * cell =[ tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
//
//    return cell ;
//}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            //头像
            [self selectIcon];
        }
        if (indexPath.row==3) {
            
            //个人签名
            _userModel = [SPUserModel getUserLoginModel];

            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            [defaults setObject:@"签名" forKey:@"userInfo"];
            [defaults synchronize];
            
            SPPersonalSignatureViewController *vc =[[SPPersonalSignatureViewController alloc]init];
            vc.userid = _userModel.userid;
            vc.textStr = _signLabel.text;
            vc.titleStr = @"修改签名";
            vc.contentBlock = ^(NSString *content){
                
                self.signLabel.text = content;
            };
            
            [self.navigationController pushViewController:vc animated:YES];
            //[self performSegueWithIdentifier:@"SPPersonalSignatureViewController" sender:nil];
        }
        if (indexPath.row==1) {
            
            //昵称
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            [defaults setObject:@"昵称" forKey:@"userInfo"];
            [defaults synchronize];
            
            SPPersonalSignatureViewController *vc =[[SPPersonalSignatureViewController alloc]init];
            vc.userid = _userModel.userid;
            vc.textStr = _nickName.text;
            vc.titleStr = @"修改昵称";
            vc.contentBlock = ^(NSString *content){

                self.nickName.text = content;
            };
            
            //[self presentViewController:vc animated:YES completion:nil];
            [self.navigationController pushViewController:vc animated:YES];
           //[self performSegueWithIdentifier:@"SPPersonalSignatureViewController" sender:nil];
        }
        if (indexPath.row==2) {
            
            ChooseValuePickerView * pickView = [[ChooseValuePickerView alloc] init];
            //性别
            pickView.dataSource =@[@"男",@"女",@"保密"];
           
            pickView.pickerTitle = @"性别";
        
            pickView.valueDidSelect = ^(NSInteger chooseIndex){
                
                NSLog(@"choose  %ld",chooseIndex);
                if (chooseIndex == 0) {
                    value = @"男";
                }else if (chooseIndex == 1){
                    value = @"女";
                }else{
                    value = @"保密";
                }
                
                NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                [defaults setObject:@"性别" forKey:@"userInfo"];
                [defaults synchronize];
                
                [self initNetwork];
            };
            
            [pickView show];
        }
        
        
    }else{
    
        if (indexPath.row==0){

            NSString * useridEncry = [SPSmartInterfaceEncryption encryptionRequestWithParam:[SPUserModel getUserLoginModel].userid isEncrypation:YES url:nil];
            
            NSString * encryString = [NSString stringWithFormat:@"%@%@",INTERPROMOTION,useridEncry];

            HMScanerCardViewController * vc  =  [[HMScanerCardViewController alloc] initWithCardName:encryString avatar:nil];;
           
            
            [self.navigationController pushViewController:vc animated:YES];
            //地址
            
        }
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return .1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 10.f;
}



#pragma mark- SelectIcONAction
-(void)selectIcon
{
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择头像方式"
                                                            delegate:self
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"拍照",@"从相册中选", nil];
    actionSheet.tag = 88;
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}

#pragma mark- UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag ==88)//选择头像
    {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            if (buttonIndex ==0||buttonIndex==1)
            {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
                imagePicker.delegate = self;
                imagePicker.allowsEditing = YES;
                imagePicker.sourceType = buttonIndex==0?UIImagePickerControllerSourceTypeCamera:UIImagePickerControllerSourceTypePhotoLibrary;
                imagePicker.navigationBar.tintColor = [UIColor whiteColor];
                [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
            }
            
        }else{
            if (buttonIndex == 0 || buttonIndex == 1)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                               message:@"不支持调用系统照相机"
                                                              delegate:nil
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil, nil];
                [alert show];
            }
            
        }
        
        
    }
}
#pragma mark- UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *theImage = nil;
   
//    if ([picker allowsEditing])
//    {
//        //获取用户编辑之后的图像
//        theImage = [info objectForKey:UIImagePickerControllerEditedImage];
//    } else {
//        // 照片的元数据参数
//        theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
//    }
    
    theImage = [info objectForKey:UIImagePickerControllerEditedImage];

    [picker dismissViewControllerAnimated:YES completion:nil];
    

    if (_userModel) {
        
        [SPSVProgressHUD showWithStatus:@"上传图片中..."];
        
        __weak typeof(self) weakself = self ;
        
        [SPMainLoginBusiness uploadImageFile:theImage parma:nil success:^(id result) {
            NSString *imgurl = result;
            
            NSDictionary * dic = @{@"value":imgurl};
            __weak typeof(self) weakself  = self ;
            
             [[[SPUserModulesBusiness alloc]init] uploadUserICO:dic success:^(id result) {
                 
                [SPToastHUD makeToast:@"上传成功" duration:2.5 position:nil makeView:weakself.view];
                 
                 _icoImageView.image = theImage;
            } failer:^(NSString *error) {
                [SPSVProgressHUD dismiss];
                
                [SPToastHUD makeToast:error duration:2.5 position:nil makeView:weakself.view];
                
            }];
            
            
            _userModel.userImg = imgurl;
            
            [_userModel saveUserLoginModel];
            
            [SPSVProgressHUD dismiss];
            
        } failere:^(NSString *error) {
            
            [SPSVProgressHUD dismiss];
            
            [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
            
        }];
        
    }
}

//上传头像url
-(void)requestUploadUserICO{

    
    
}


// 当用户取消时，调用该方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
