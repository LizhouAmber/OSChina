//
//  OSCSlideSlipViewController.m
//  OSChina
//
//  Created by qianfeng on 16/2/23.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "OSCSlideSlipViewController.h"  

#import "OSCSwipeViewController.h"
#import "OSCSoftTableViewController.h"

#import "OSCPostListTableViewController.h"
#import "OSCBlogViewController.h"


static NSString *const tableViewCellStr = @"UITableViewCell";

@interface OSCSlideSlipViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *titleArray;



@end

@implementation OSCSlideSlipViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.667 alpha:0.1];
    _imageArray = @[@"sidemenu_QA",@"sidemenu-software",@"sidemenu_blog",@"dest_basicinfo_icon2"];
    _titleArray = @[@"技术问答",@"开源软件",@"博客区",@"Git客户端"];
    
    _tableView = ({
    
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2.0+SCREEN_WIDTH/6.0, self.view.frame.size.height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView;
    });
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewCellStr];
    [self.view addSubview:_tableView];
    
    [self addButtomView];
}

-(UIView *)addButtomView
{
    CGFloat widthOfButtomView = 44*8+30;
    UIView *buttomView = [[UIView alloc]initWithFrame:CGRectMake(0, widthOfButtomView - 40, self.tableView.frame.size.width, 40)];
    
    UIImageView *iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sidemenu_setting"]];
    iconImageView.frame = CGRectMake(30, 10+widthOfButtomView, 25, 25);
    [buttomView addSubview:iconImageView];
    
    UILabel *settintLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame)+10, 15+widthOfButtomView, 30, 20)];
    settintLabel.text = @"设置";
    settintLabel.font = [UIFont systemFontOfSize:13];
    settintLabel.textColor = [UIColor lightGrayColor];
    [buttomView addSubview:settintLabel];
    
    UIImageView *rightIconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sidemenu-night"]];
    rightIconImageView.frame = CGRectMake(30+CGRectGetMaxX(settintLabel.frame)+30, 10+widthOfButtomView, 25, 25);
    [buttomView addSubview:rightIconImageView];
    
    UILabel *timeSetLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(rightIconImageView.frame)+10, 15+widthOfButtomView, 30, 20)];
    timeSetLabel.text = @"夜间";
    timeSetLabel.font = [UIFont systemFontOfSize:13];
    timeSetLabel.textColor = [UIColor lightGrayColor];
    [buttomView addSubview:timeSetLabel];
    
    
    
    return buttomView;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dimissCurrentViewController];
}

-(void)dimissCurrentViewController
{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromRight;
    transition.duration = 3.0;
    [self.view.layer addAnimation:transition forKey:@""];

    [self.view removeFromSuperview];
}


#pragma  mark ----------------- UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellStr];
    cell.imageView.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return SCREEN_HEIGHT-44*5;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [self addButtomView];
//    CGFloat widthOfButtomView = SCREEN_HEIGHT-44*5;
    footerView.frame = CGRectMake(0, 80, self.tableView.frame.size.width, 40);
    return footerView;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            OSCPostListTableViewController *questionVC = [[OSCPostListTableViewController alloc]initWithPostType:PostTypeOfQuestion];
            OSCPostListTableViewController *shareVC = [[OSCPostListTableViewController alloc]initWithPostType:PostTypeOfShare];
            OSCPostListTableViewController *colligateVC = [[OSCPostListTableViewController alloc]initWithPostType:PostTypeOfColligate];
            OSCPostListTableViewController *occupationVC = [[OSCPostListTableViewController alloc]initWithPostType:PostTypeOfOccupation];
            OSCPostListTableViewController *postVC = [[OSCPostListTableViewController alloc]initWithPostType:PostTypeOfPost];
            OSCSwipeViewController *swipeVC = [[OSCSwipeViewController alloc]initWithTitle:@"技术问答" andSubTitle:@[@"提问",@"分享",@"综合",@"职业",@"站务"] andSubController:@[questionVC,shareVC,colligateVC,occupationVC,postVC] underTabbar:NO];
            [self setContentView:swipeVC];
            
            break;
        }
        case 1:
        {
            OSCSoftTableViewController *categoryVC = [[OSCSoftTableViewController alloc]initWithSoftType:SoftTypeOfCategory];
            OSCSoftTableViewController *recommendVC = [[OSCSoftTableViewController alloc]initWithSoftType:SoftTypeOfRecommend];
            OSCSoftTableViewController *newestVC = [[OSCSoftTableViewController alloc]initWithSoftType:SoftTypeOfNewest];
            OSCSoftTableViewController *hottestVC = [[OSCSoftTableViewController alloc]initWithSoftType:SoftTypeOfHottest];
            OSCSoftTableViewController *madeInChinaVC = [[OSCSoftTableViewController alloc]initWithSoftType:SoftTypeOfCurrentArea];
            OSCSwipeViewController *swipeVC = [[OSCSwipeViewController alloc]initWithTitle:@"开源软件"
                                                andSubTitle:@[@"分类",@"推荐",@"最新",@"热门",@"国产"]
                                                andSubController:@[categoryVC,recommendVC,newestVC,hottestVC,madeInChinaVC] underTabbar:NO];
            
            [self setContentView:swipeVC];
            break;
        }
        case 2:
        {
            OSCBlogViewController *lastestVC = [[OSCBlogViewController alloc]initWithBlogListType:BlogListTypeLatest];
            OSCBlogViewController *recommendVC = [[OSCBlogViewController alloc]initWithBlogListType:BlogListTypeRecommand];
            OSCSwipeViewController *swipeVC = [[OSCSwipeViewController alloc]initWithTitle:@"博客区" andSubTitle:@[@"最新博客",@"推荐阅读"] andSubController:@[lastestVC,recommendVC] underTabbar:NO];
            
            [self setContentView:swipeVC];
            break;
        }
            
            
        default:
            break;
    }
}

-(void)setContentView:(UIViewController *)viewControl
{
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewControl animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

-(UINavigationController *)addNavigationOfviewControl:(UIViewController *)viewControl title:(NSString *)title
{
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewControl];
    UIImage *leftImage = [[UIImage imageNamed:@"icon_back_button"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnPressed)];
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, self.view.frame.size.width-100, 40)];
    titleLable.font = [UIFont systemFontOfSize:20];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.text = title;
    nav.navigationItem.titleView = titleLable;
    
    return nav;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
