//
//  AccountSecurityTableViewController.m
//  SmartPurifieriOS
//
//  Created by yuan on 2016/12/12.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "AccountSecurityTableViewController.h"
#import "BindingPhoneViewController.h"
#import "ModifyPassowordViewController.h"

@interface AccountSecurityTableViewController ()

@end

@implementation AccountSecurityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账户安全";

    self.view.backgroundColor = SPViewBackColor;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = @"手机号";
    }else{
        cell.detailTextLabel.text = @"修改密码";
    }
    cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *headview = [[UILabel alloc]init];
    headview.backgroundColor = [UIColor clearColor];
    
    headview.textColor = [UIColor colorWithHexString:@"777777"];
    
    headview.text = @"    账户安全";
    
    headview.font = [UIFont systemFontOfSize:14];
    
    return headview;
}


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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        BindingPhoneViewController *detailViewController = [[BindingPhoneViewController alloc] initWithNibName:@"BindingPhoneViewController" bundle:nil];
        
        [self.navigationController pushViewController:detailViewController animated:YES];
    }else{
        
        ModifyPassowordViewController *detailViewController = [[ModifyPassowordViewController alloc] initWithNibName:@"ModifyPassowordViewController" bundle:nil];
        
        [self.navigationController pushViewController:detailViewController animated:YES];
    }

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
