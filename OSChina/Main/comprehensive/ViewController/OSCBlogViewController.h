//
//  OSCBlogViewController.h
//  OSChina
//
//  Created by NoPass on 16/2/6.
//  Copyright © 2016年 李周. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(int ,BlogListType) {
    BlogListTypeLatest = 0,
    BlogListTypeRecommand
};

@interface OSCBlogViewController : UITableViewController



-(instancetype)initWithBlogListType:(BlogListType)type;

@end
