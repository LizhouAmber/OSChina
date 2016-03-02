//
//  TweetViewController.h
//  OSChina
//
//  Created by NoPass on 16/2/6.
//  Copyright © 2016年 lizhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (int, TweetType){
    TweetTypeOfLaster,
    TweetTypeOfHotter,
    TweetTypeOfMine
    
};

@interface TweetViewController : UITableViewController

-(instancetype)initWithType:(TweetType)type;

@end
