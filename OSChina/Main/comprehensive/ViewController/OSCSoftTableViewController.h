//
//  OSCSoftTableViewController.h
//  OSChina
//
//  Created by qianfeng on 16/2/26.
//  Copyright © 2016年 李周. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(int,SoftType) {

    SoftTypeOfCategory = 0,
    SoftTypeOfRecommend,
    SoftTypeOfNewest,
    SoftTypeOfHottest,
    SoftTypeOfCurrentArea
};



@interface OSCSoftTableViewController : UITableViewController

-(instancetype)initWithSoftType:(SoftType)type;

@end
