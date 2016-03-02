//
//  DiscoverViewController.m
//  OSChina
//
//  Created by NoPass on 16/2/6.
//  Copyright © 2016年 lizhou. All rights reserved.
//

#import "DiscoverViewController.h"

#import "OSCActivityViewController.h"
#import "OSCSwipeViewController.h"
#import "OSCLookForSbViewController.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    
    cell.textLabel.textColor = [UIColor blackColor];
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = @"好友圈";
            cell.imageView.image = [UIImage imageNamed:@"discover-events"];
            break;
        case 1:
            cell.textLabel.text = @[@"找人",@"活动"][indexPath.row];
            cell.imageView.image = [UIImage imageNamed:@[@"discover-search",@"discover-activities"][indexPath.row]];
            break;
        case 2:
            cell.textLabel.text = @[@"扫一扫",@"摇一摇"][indexPath.row];
            cell.imageView.image = [UIImage imageNamed:@[@"discover-scan",@"discover-shake"][indexPath.row]];
            break;
        default:
            break;
    }
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.bounds];
    cell.selectedBackgroundView.backgroundColor = [UIColor lightGrayColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
                //  好友圈
            break;
        case 1:
        {
            if (indexPath.row == 0) {
                OSCLookForSbViewController *lookForSbVC = [[OSCLookForSbViewController alloc]init];
                self.navigationController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:lookForSbVC animated:YES];
                self.navigationController.hidesBottomBarWhenPushed = NO;
            }else{
                OSCActivityViewController *activity_1 = [[OSCActivityViewController alloc]initWithType:0];
                
                OSCActivityViewController *activity_2 = [[OSCActivityViewController alloc]initWithType:2];
                OSCSwipeViewController *swipe = [[OSCSwipeViewController alloc]initWithTitle:@"发现" andSubTitle:@[@"近期活动",@"我的活动"] andSubController:@[activity_1,activity_2] underTabbar:YES];
                self.navigationController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:swipe animated:YES];
                self.navigationController.hidesBottomBarWhenPushed = NO;
            }
            break;
        }
            
        default:
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 23;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
