//
//  OSCHorizoralTableViewController.h
//  OSChina
//
//  Created by NoPass on 16/2/6.
//  Copyright © 2016年 李周. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OSCHorizoralTableViewController : UITableViewController

@property (nonatomic, copy) NSMutableArray *subControllers;

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, copy) void (^viewDidAppear)(NSInteger index);

@property (nonatomic, copy) void (^scrollView)(CGFloat offsetRatio,NSInteger focusindex,NSInteger animationIndex);

@property (nonatomic, copy) void (^changeIndex)(NSInteger index);

@property (nonatomic, copy) void (^viewDidScroll)();

-(instancetype)initWithSubControllers:(NSArray *)controllers;

-(void)scrollToViewAtIndex:(NSInteger)index;

@end
