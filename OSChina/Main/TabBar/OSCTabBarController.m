//
//  OSCTabBarController.m
//  OSChina
//
//  Created by NoPass on 16/2/6.
//  Copyright © 2016年 lizhou. All rights reserved.
//

#import "OSCTabBarController.h"

#import "OSCNewsViewController.h"
#import "OSCBlogViewController.h"
#import "TweetViewController.h"

#import "MineViewController.h"
#import "DiscoverViewController.h"

#import "OSCSwipeViewController.h"

#import "OSCSlideSlipViewController.h"
#import "OSCSearchViewController.h"

@interface OSCTabBarController ()
{
    OSCNewsViewController *newsViewCtl;
    OSCNewsViewController *hotNewsViewCtl;
    OSCBlogViewController *blogViewCtl;
    OSCBlogViewController *recommendBlogViewCtl;
    
    TweetViewController *lasterViewCtl;
    TweetViewController *hotterViewCtl;
    TweetViewController *mineViewCtl;
    
    BOOL _isPressed;
    
}

@property (nonatomic, strong) UIButton *centerButton;

@property (nonatomic, strong) OSCSlideSlipViewController *slideSlipVC;

@end

@implementation OSCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    newsViewCtl = [[OSCNewsViewController alloc]initWithNewsListType:NewsListTypeOfAllType];
    newsViewCtl.view.backgroundColor = [UIColor yellowColor];
    hotNewsViewCtl = [[OSCNewsViewController alloc]initWithNewsListType:NewsListTypeAllTypeWeekHottest];
    hotNewsViewCtl.view.backgroundColor = [UIColor redColor];
    blogViewCtl = [[OSCBlogViewController alloc]initWithBlogListType:BlogListTypeLatest];
    blogViewCtl.view.backgroundColor = [UIColor blackColor];
    recommendBlogViewCtl = [[OSCBlogViewController alloc]initWithBlogListType:BlogListTypeRecommand];
    recommendBlogViewCtl.view.backgroundColor = [UIColor orangeColor];
    
    lasterViewCtl = [[TweetViewController alloc]initWithType: TweetTypeOfLaster];
    hotterViewCtl = [[TweetViewController alloc] initWithType:TweetTypeOfHotter];
    mineViewCtl = [[TweetViewController alloc]initWithType:TweetTypeOfMine];
    
    OSCSwipeViewController *swipeVC_1 = [[OSCSwipeViewController alloc]initWithTitle:@"综合" andSubTitle:@[@"资讯",@"热点",@"博客",@"推荐"]andSubController:@[newsViewCtl,hotNewsViewCtl,blogViewCtl,recommendBlogViewCtl] underTabbar:NO];
    
//    UINavigationController *nav_1 = [[UINavigationController alloc]initWithRootViewController:swipeVC_1];
    

    
    [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:0.093 green:0.400 blue:0.134 alpha:1.000]];
    [[UITabBar appearance]setBarTintColor:[UIColor whiteColor]];
    
    
    OSCSwipeViewController *tweetsVC = [[OSCSwipeViewController alloc]initWithTitle:@"动弹" andSubTitle:@[@"最新动弹",@"热门动弹",@"我的动弹"] andSubController:@[lasterViewCtl,hotterViewCtl,mineViewCtl] underTabbar:NO];
//    UINavigationController *nav_2 = [[UINavigationController alloc]initWithRootViewController:tweetsVC];

   
    UIStoryboard *discoverStoryboard = [UIStoryboard storyboardWithName:@"Discover" bundle:nil];
    DiscoverViewController *discoverVC = [discoverStoryboard instantiateViewControllerWithIdentifier:@"discoverViewController"];
//    UINavigationController *nav_3 = [[UINavigationController alloc]initWithRootViewController:discoverVC];
    
    UIStoryboard *mineStoryboard = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    MineViewController *mine = [mineStoryboard instantiateViewControllerWithIdentifier:@"mineViewController"];
//    UINavigationController *nav_4 = [[UINavigationController alloc]initWithRootViewController:mine];
    
    
    self.viewControllers = @[[self setNavigationItemForViewControl:swipeVC_1],[self setNavigationItemForViewControl:tweetsVC] ,[UIViewController new],[self setNavigationItemForViewControl:discoverVC],[self setNavigationItemForViewControl:mine]];
    
    self.tabBar.translucent = NO;
    NSArray *titleArr = @[@"综合",@"动弹",@"",@"发现",@"我"];
    NSArray *imageArr = @[@"tabbar-news",@"tabbar-tweet",@"",@"tabbar-discover",@"tabbar-me"];
    NSArray *selectedArr = @[@"tabbar-news-selected",@"tabbar-tweet-selected",@"",@"tabbar-discover-selected",@"tabbar-me-selected"];
    
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [obj setTitle:titleArr[idx]];
        [obj setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.086 green:0.557 blue:0.224 alpha:1.000]} forState:UIControlStateSelected];
        
        UIImage *image = [[UIImage imageNamed:imageArr[idx]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [obj setImage:image];
        UIImage *selectedImage = [[UIImage imageNamed:selectedArr[idx]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [obj setSelectedImage:selectedImage];
    }];
    
    [self.tabBar.items[2] setEnabled:NO];
    
    [self addCenterButtonWithImage:[UIImage imageNamed:@"tabbar-more"]];
    [self.tabBar addObserver:self
                  forKeyPath:@"selectedItem" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    
}

-(void)addCenterButtonWithImage:(UIImage *)buttonImage
{
    _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGPoint origin = [self.view convertPoint:self.tabBar.center fromView:self.tabBar];
    CGSize buttonSize = CGSizeMake(self.tabBar.frame.size.width/5-6, self.tabBar.frame.size.height-4);
    
    _centerButton.frame = CGRectMake(origin.x, origin.y, buttonSize.width, buttonSize.height);
    
    _centerButton.layer.cornerRadius = CGRectGetHeight(_centerButton.frame)/2.0;
    _centerButton.layer.masksToBounds = YES;
    
    [_centerButton setBackgroundColor:[UIColor colorWithRed:0.086 green:0.557 blue:0.224 alpha:1.000]];
    [_centerButton setImage:buttonImage forState:UIControlStateNormal];
    [_centerButton addTarget:self action:@selector(centerBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBar addSubview:_centerButton];
}

-(UINavigationController *)setNavigationItemForViewControl:(UIViewController *)viewControl
{
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewControl];
    UIImage *leftImage = [[UIImage imageNamed:@"navigationbar-sidebar"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewControl.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(sliderSlipBtnPressed)];
    UIImage *rightImage = [[UIImage imageNamed:@"navigationbar-search"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewControl.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(searchBtnPressed)];
    
    return nav;
    
}

-(void)sliderSlipBtnPressed
{
    self.slideSlipVC = [[OSCSlideSlipViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self.slideSlipVC];
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromLeft;
    [self.view.layer addAnimation:transition forKey:@""];

    self.slideSlipVC.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.selectedViewController.view addSubview:self.slideSlipVC.view];
    [self.selectedViewController addChildViewController:self.slideSlipVC];
    
}

-(void)searchBtnPressed
{
    [(UINavigationController *)self.selectedViewController pushViewController:[OSCSearchViewController new] animated:YES];
}

-(void)centerBtnPressed:(UIButton *)sender
{
    NSLog(@"xxxxxxx");
    [self changeTheButtonStateAnimatedToOpen:_isPressed];
    
    _isPressed = !_isPressed;
}

-(void)changeTheButtonStateAnimatedToOpen:(BOOL)isPressed
{
    if (isPressed) {
        
    }else{
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
