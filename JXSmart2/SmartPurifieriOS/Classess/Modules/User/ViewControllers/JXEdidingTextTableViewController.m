//
//  JXEdidingTextTableViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/11/10.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXEdidingTextTableViewController.h"

@interface JXEdidingTextTableViewController ()

@property (weak, nonatomic) IBOutlet UITextView *editingTextView;

@property (weak, nonatomic) IBOutlet UIButton *comptionBtn;

@end

@implementation JXEdidingTextTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];

    _editingTextView.keyboardType = _type;

    _editingTextView.text = _defaultString ;
}


- (IBAction)comationAction:(id)sender {

    if (_editingTextView.text.length > 0 ) {

        if (_complationBlock) {

            _complationBlock(_editingTextView.text,_indexPath);
        }

        [self.navigationController popViewControllerAnimated:YES];
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
