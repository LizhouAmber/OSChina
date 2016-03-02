//
//  OSCPostListTableViewController.h
//  OSChina
//
//  Created by qianfeng on 16/2/27.
//  Copyright © 2016年 李周. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(int, PostType) {

    PostTypeOfQuestion = 1,                  //提问
    PostTypeOfShare,                         //分享
    PostTypeOfColligate,                     //综合
    PostTypeOfOccupation,                    //职业
    PostTypeOfPost                           //站务
};

@interface OSCPostListTableViewController : UITableViewController

-(instancetype)initWithPostType:(PostType)type;

@end
