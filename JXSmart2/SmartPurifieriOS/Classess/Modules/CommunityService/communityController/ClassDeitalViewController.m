//
//  ClassDeitalViewController.m
//  EBaby
//
//  Created by Mray-mac on 16/11/15.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "ClassDeitalViewController.h"
//#import "UzysAssetsPickerController.h"
#import <AVFoundation/AVFoundation.h>
#import "ReleaseViewController.h"
#import "PushBtnModel.h"
#import "ClassDeitalModel.h"
#import "SPUserModel.h"
#import "SPMainLoginBusiness.h"
#import <UIButton+WebCache.h>
#import "ShieldEmoji.h"


#import "MAddImageCollectionView.h"
#import "JXCommunityTopItemView.h"
#import "GCPlaceholderTextView.h"
#import "SPBaseNetWorkRequst.h"

@interface ClassDeitalViewController ()<UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,MAddImageCollectionViewDelegate>

@property (nonatomic,strong) ClassDeitalModel * model;

@property (nonatomic,strong)  JXCommunityTopMenuView * menu ; ;

@property (nonatomic, strong)  MAddImageCollectionView *photoView;

@property (nonatomic,strong) UIScrollView * backView ; // 背景

@property (nonatomic,strong) GCPlaceholderTextView * textView ;




@end

@implementation ClassDeitalViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"选择分类及内容";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWithUI];
}

//创建视图
-(void)initWithUI
{

    [self.view addSubview:self.backView];
    
    [_backView addSubview:self.menu];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, self.menu.bottom+1, SCREEN_WIDTH-30, 1)];
    
    label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [_backView addSubview:label];

    [_backView addSubview:self.photoView];
    
    [_backView addSubview:self.textView];
    
    UIButton *yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    yesBtn.frame = CGRectMake(15, _textView.bottom+10, SCREEN_WIDTH-30, 0.064*SCREEN_HEIGHT);
    
    [yesBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    yesBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    yesBtn.layer.cornerRadius = 3;
    
    yesBtn.layer.masksToBounds = YES;
    
    yesBtn.backgroundColor = [UIColor colorWithRed:46/255.0 green:182/255.0 blue:237/255.0 alpha:1.0];
    
    [yesBtn addTarget:self action:@selector(yesClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_backView addSubview:yesBtn];
 
}

-(void)yesClick{
    
    if ([self privateContentIsInvalid]) {
      
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
    
        __weak typeof(self) weakself =  self;
      
        if (self.complationBlock) {
            
            self.complationBlock(weakself.categoryId, weakself.textView.text, weakself.photoView.getImages);
        }
#pragma clang diagnostic pop
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 判断内容是否合法
-(BOOL)privateContentIsInvalid{
    
    BOOL isok = YES ;
    
    if (!_categoryId) {
        
        [SPToastHUD makeToast:@"请选择要发布分类类别" duration:3 position:nil makeView:self.view];
        
        return NO;
    }
    if (_photoView.getImages.count==0) {
        
        [SPToastHUD makeToast:@"请添加要发布的图片" duration:3 position:nil makeView:self.view];
        
        return NO;
    }
    //_textView.text.length == 0
    
    if ([_textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        
        [SPToastHUD makeToast:@"请输入服务内容" duration:3 position:nil makeView:self.view];
        
        return NO;
    }
    
    if ([ShieldEmoji isContainsNewEmoji:_textView.text]) {
        
        [SPToastHUD makeToast:@"内容不能包含表情" duration:3 position:nil makeView:self.view];
        
        return NO;
    }
    
    return isok;
}



-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    //键盘相应回车健
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
    }
    return YES;
}

#pragma mark - GETTER SETTER

-(UIScrollView *)backView{

    if (!_backView) {
        
        _backView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        _backView.backgroundColor = [UIColor whiteColor];
        
        _backView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        
    }
    return _backView;
}

-(JXCommunityTopMenuView *)menu{

    if (!_menu) {
        
        NSData * model  = [[NSUserDefaults standardUserDefaults] objectForKey:COMMUNITYPUSHBTNKEY];
        
        NSArray * listArr ;
        
        if (model) {
            
            listArr = [NSKeyedUnarchiver unarchiveObjectWithData:model];
        }
        
        _menu = [[JXCommunityTopMenuView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.3) andData:listArr];
        
        [_menu chooseIdentifier:_categoryId];
        
        __weak typeof(self) weakself = self ;
        
        [_menu setComplationHandle:^(PushBtnModel* model){
            
            weakself.categoryId = model.dataIdentifier;
            
        }];
        
    }
    
    return _menu;
}


-(MAddImageCollectionView *)photoView{

    if (!_photoView) {
        
        _photoView = [[MAddImageCollectionView alloc] initWithFrame:CGRectMake(0,_menu.bottom + 5, SCREEN_WIDTH, 120) images:_imageArr delegate:self];
        
        [_photoView setMaxImageCount:4];
        
        _photoView.addImageViewHeight.constant = 120;
        
        _photoView.addImage = [UIImage imageNamed:@"上传照片-拷贝@3x.png"];
    }
    
    return _photoView;
}


-(GCPlaceholderTextView *)textView{

    if (!_textView) {
        
        float textViewHeight = SCREEN_HEIGHT*0.23;
        
        _textView = [[GCPlaceholderTextView alloc] initWithFrame:CGRectMake(15, _photoView.bottom + 10, SCREEN_WIDTH-30, textViewHeight)];
        
        _textView.text = _serviceContent;
        
        _textView.backgroundColor=[UIColor groupTableViewBackgroundColor]; //背景色
        
        _textView.scrollEnabled = YES;
        
        _textView.editable = YES;
        
        _textView.delegate = self;
        
        _textView.font=[UIFont fontWithName:@"Arial" size:15.0];
        
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.dataDetectorTypes = UIDataDetectorTypeAll;
        
        _textView.textColor = [UIColor grayColor];
        
        _textView.placeholder = @"✎ 输入服务内容";
        
        _textView.layer.cornerRadius = 3;
        
        _textView.layer.masksToBounds = YES;
        
    }
    
    return _textView;
}

@end
