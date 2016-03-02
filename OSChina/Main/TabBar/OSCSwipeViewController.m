//
//  OSCSwipeViewController.m
//  OSChina
//
//  Created by NoPass on 16/2/6.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "OSCSwipeViewController.h"

@interface OSCSwipeViewController ()

@end

@implementation OSCSwipeViewController

-(instancetype)initWithTitle:(NSString *)title andSubTitle:(NSArray *)subTitles andSubController:(NSArray *)controllers underTabbar:(BOOL)underTabbar
{
    if (self = [super init]) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        CGFloat titleBarHeight = 36;
        _titleBar = [[OSCTitleBarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, titleBarHeight) andSubTitle:subTitles];
        [self.view addSubview:_titleBar];
        
        _horizoralTableVC = [[OSCHorizoralTableViewController alloc]initWithSubControllers:controllers];
        CGFloat horizoralHeight = SCREEN_HEIGHT - titleBarHeight - (underTabbar?49:0);
        _horizoralTableVC.view.frame = CGRectMake(0, titleBarHeight, SCREEN_WIDTH, horizoralHeight);
        _horizoralTableVC.view.backgroundColor = [UIColor lightGrayColor];
        
        [self.view addSubview:_horizoralTableVC.view];
        [self addChildViewController:_horizoralTableVC];
        
        __weak OSCTitleBarView *weakTitleBar = _titleBar;
        __weak OSCHorizoralTableViewController *weakHorizoralTableVC = _horizoralTableVC;
        
        _horizoralTableVC.changeIndex = ^(NSInteger index){
          
            weakTitleBar.currentIndex = index;
            
            for (UIButton *button in weakTitleBar.subButtons) {
                if (button.tag != index) {
                    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                    button.transform = CGAffineTransformIdentity;
                }else{
                    [button setTitleColor:[UIColor colorWithRed:37.0/255 green:147.0/255 blue:58.0/255 alpha:1.0] forState:UIControlStateNormal];
                    button.transform = CGAffineTransformMakeScale(1.2, 1.2);
                }
            }
            [weakHorizoralTableVC scrollToViewAtIndex:index];
        };
        //参数的含义：第一个是相对于下面tableview的滚动，上面scrollview上滚动的位置，第二个是当前页，animation是下一页。
        _horizoralTableVC.scrollView = ^(CGFloat offsetRatio,NSInteger offsetIndex,NSInteger animationIndex){
          
            UIButton *titleForm = weakTitleBar.subButtons[offsetIndex];
            UIButton *titleTo = weakTitleBar.subButtons[animationIndex];
            
            CGFloat colorValue = (CGFloat)0x90 / (CGFloat)0xFF;
            
            [UIView transitionWithView:titleForm duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                
                [titleForm setTitleColor:[UIColor colorWithRed:colorValue*(1-offsetRatio) green:colorValue blue:colorValue*(1-offsetRatio) alpha:1.0] forState:UIControlStateNormal];
                titleForm.transform = CGAffineTransformMakeScale(1 + 0.2 * offsetRatio, 1 + 0.2 * offsetRatio);
            } completion:nil];
            
            [UIView transitionWithView:titleTo duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                
                [titleTo setTitleColor:[UIColor colorWithRed:colorValue*offsetRatio green:colorValue blue:colorValue*offsetRatio alpha:1.0] forState:UIControlStateNormal];
                titleTo.transform = CGAffineTransformMakeScale(1 + 0.2 * (1-offsetRatio), 1 + 0.2 * (1-offsetRatio));
            } completion:nil];
            
        };
        
        _titleBar.backSelectedIndex = ^(NSInteger index){
            [weakHorizoralTableVC scrollToViewAtIndex:index];
        };
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
