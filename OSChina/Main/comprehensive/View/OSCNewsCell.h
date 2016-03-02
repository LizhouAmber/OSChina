//
//  OSCNewsCell.h
//  OSChina
//
//  Created by NoPass on 16/2/6.
//  Copyright © 2016年 李周. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NewModel.h"
#import "BlogModel.h"

@interface OSCNewsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *pubNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *pubDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubNumLabel;

@property (nonatomic, copy) NewModel *model;

@property (nonatomic, copy) BlogModel *blogModel;

@end
