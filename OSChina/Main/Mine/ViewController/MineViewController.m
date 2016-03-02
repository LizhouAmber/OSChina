//
//  MineViewController.m
//  OSChina
//
//  Created by NoPass on 16/2/6.
//  Copyright © 2016年 lizhou. All rights reserved.
//

#import "MineViewController.h"

#import "OSCLoginViewController.h"
#import "UserModel.h"

@interface MineViewController ()
{
    NSString *_userID;
}
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;
@property (weak, nonatomic) IBOutlet UILabel *focusLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;
@property (weak, nonatomic) IBOutlet UIView *userBackView;
@property (weak, nonatomic) IBOutlet UIImageView *genderImageView;

@property (nonatomic, strong) UserModel *userModel;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _iconImageView.userInteractionEnabled = YES;
    [_iconImageView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [_iconImageView.layer setBorderWidth:2.0];
    
    _userID = [[NSUserDefaults standardUserDefaults]objectForKey:USERID];
    [self refreshUserInfo];
    
}
- (IBAction)loginBtnPressed:(id)sender {
    
    UIStoryboard *loginStoryBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    OSCLoginViewController *loginVC = [loginStoryBoard instantiateViewControllerWithIdentifier:@"oSCLoginViewController"];

    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:loginVC animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
    
}

-(void)refreshUserInfo
{
    if ([_userID integerValue] == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateOwnUserInfo];
        });
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self updateOwnUserInfo];
}

-(void)updateOwnUserInfo
{
    if ([Utils isUserLogin]) {
        //如果是登录的状态
        self.userBackView.hidden = NO;
        self.genderImageView.hidden = NO;
        UserModel *model = [Utils backUserModel];
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@"default-portrait"]];
        self.loginLabel.text = model.name;
        self.scoreLabel.text = [NSString stringWithFormat:@"%@",model.score];
        self.favoriteLabel.text = [NSString stringWithFormat:@"%@",model.favoritecount];
        self.focusLabel.text = [NSString stringWithFormat:@"%@",model.followers];
        self.fansLabel.text = [NSString stringWithFormat:@"%@",model.fans];
        if ([model.gender isEqualToString:@"男"]) {
            _genderImageView.image = [UIImage imageNamed:@"userinfo_icon_male"];
        }else{
            _genderImageView.image = [UIImage imageNamed:@"userinfo_icon_female"];
        }
    }
    else{
        self.userBackView.hidden = YES;
        self.loginLabel.text = @"未登录";
        self.genderImageView.hidden = YES;
    }

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor blackColor];
    
    cell.textLabel.text = @[@"消息",@"博客",@"便签",@"团队"][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@[@"me-message",@"me-blog",@"me-feedback",@"me-team"][indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    return backView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
