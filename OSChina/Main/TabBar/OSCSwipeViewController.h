//
//  OSCSwipeViewController.h
//  OSChina
//
//  Created by NoPass on 16/2/6.
//  Copyright © 2016年 李周. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OSCTitleBarView.h"
#import "OSCHorizoralTableViewController.h"

@interface OSCSwipeViewController : UIViewController

@property (nonatomic, copy) OSCTitleBarView *titleBar;

@property (nonatomic, copy) OSCHorizoralTableViewController *horizoralTableVC;


-(instancetype)initWithTitle:(NSString *)title andSubTitle:(NSArray *)subTitles andSubController:(NSArray *)controllers underTabbar:(BOOL)underTabbar;

@end
