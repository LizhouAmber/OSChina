//
//  OSCObjViewController.h
//  OSChina
//
//  Created by NoPass on 16/2/6.
//  Copyright © 2016年 李周. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OSCObjViewController : UITableViewController

@property (nonatomic, strong) NSString*(^generateURL)(NSUInteger page);

@end
