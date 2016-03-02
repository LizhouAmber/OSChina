//
//  OSCHorizoralTableViewController.m
//  OSChina
//
//  Created by NoPass on 16/2/6.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "OSCHorizoralTableViewController.h"

static NSString *reuseIdentifier = @"UITableViewCell";

@interface OSCHorizoralTableViewController ()

@end

@implementation OSCHorizoralTableViewController


-(instancetype)initWithSubControllers:(NSArray *)controllers
{
    if (self = [super init]) {
        
        _subControllers = [NSMutableArray arrayWithArray:controllers];
        for (UIViewController *controller in controllers) {
            [self addChildViewController:controller];
        }
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView = [UITableView new];
    self.tableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    self.tableView.bounces = YES;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.pagingEnabled = YES;
    self.tableView.scrollsToTop = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_WIDTH;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _subControllers.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    cell.transform = CGAffineTransformMakeRotation(M_PI_2);
    UIViewController *controller = _subControllers[indexPath.row];
    controller.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:controller.view];
    
    return cell;
}

#pragma mark ---------------   UIScollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollStop:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self scrollStop:NO];
    
    if (_viewDidScroll) {
        _viewDidScroll();
    }
}

-(void)scrollStop:(BOOL)stop
{
    CGFloat offsetX = self.tableView.contentOffset.y;
    CGFloat offsetRatio = (offsetX/SCREEN_WIDTH)/ SCREEN_WIDTH;
    NSInteger focusIndex = (offsetX +SCREEN_WIDTH/2.0)/SCREEN_WIDTH;
    
    if (offsetX != focusIndex*SCREEN_WIDTH) {
        NSInteger animationIndex = offsetX > focusIndex*SCREEN_WIDTH?focusIndex+1:focusIndex-1;
        if (animationIndex < 0 || animationIndex >= _subControllers.count) {
            return ;
        }
        if (focusIndex >animationIndex) {
            offsetRatio = 1-offsetRatio;
        }
        if (_scrollView) {
            _scrollView (offsetRatio,focusIndex,animationIndex);
        }
    }
    if (stop) {
        _currentIndex =focusIndex;
        if (_changeIndex) {
            _changeIndex(_currentIndex);
        }
    }
    
}

-(void)scrollToViewAtIndex:(NSInteger)index
{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
    _currentIndex = index;
    if (_viewDidAppear) {
        _viewDidAppear(index);
    }
}



@end
