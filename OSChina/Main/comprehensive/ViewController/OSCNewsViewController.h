//
//  OSCNewsViewController.h
//  OSChina
//
//  Created by NoPass on 16/2/6.
//  Copyright © 2016年 李周. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(int, NewsListType){
    NewsListTypeOfAllType = 0,
    NewsListTypeOfNews,
    NewsListTypeSynthesis,
    NewsListTypeSoftwareRenew,
    NewsListTypeAllTypeWeekHottest,
    NewsListTypeAllTypeMonthHottest,

};

@interface OSCNewsViewController : UITableViewController

-(instancetype)initWithNewsListType:(NewsListType )type;

@end
