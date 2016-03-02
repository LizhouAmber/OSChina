//
//  OSCLookForSbCell.m
//  OSChina
//
//  Created by qianfeng on 16/2/29.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "OSCLookForSbCell.h"

@interface OSCLookForSbCell ()
{
    UIImageView *_userIcon;
    UILabel *_nameLabel;
    
    UIImageView *_iconImageView;
    UILabel *_locationLabel;
}

@end

@implementation OSCLookForSbCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUpCell];
    }
    return self;
}

-(void)setUpCell
{
    _userIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    _userIcon.layer.masksToBounds = YES;
    _userIcon.layer.cornerRadius = CGRectGetHeight(_userIcon.frame)/2.0;
    [self.contentView addSubview:_userIcon];
    
    UIFont *font = [UIFont systemFontOfSize:15];
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.font = font;
    _nameLabel.textColor = [UIColor colorWithRed:0.000 green:0.552 blue:0.000 alpha:1.000];
    [self.contentView addSubview:_nameLabel];
    
    _iconImageView = [[UIImageView alloc]init];
    _iconImageView.image = [UIImage imageNamed:@"userinfo_icon_female"];
    [self.contentView addSubview:_iconImageView];
    
    _locationLabel = [[UILabel alloc]init];
    _locationLabel.font = font;
    _locationLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_locationLabel];
}

-(void)setModel:(UserModel *)model
{
    _model = model;
    [_userIcon sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@"default-portrait"]];
    CGSize nameSize = [model.name sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15]}];
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_userIcon.frame)+10, 10, nameSize.width, nameSize.height);
    _nameLabel.text = model.name;
    
    _iconImageView.frame = CGRectMake(CGRectGetMaxX(_nameLabel.frame)+15, 10, 12, 12);
    if ([model.gender isEqualToString:@"男"]) {
        _iconImageView.image = [UIImage imageNamed:@"userinfo_icon_male"];
    }
    _locationLabel.text = model.from;
    _locationLabel.frame = CGRectMake(CGRectGetMaxX(_userIcon.frame), CGRectGetMaxY(_nameLabel.frame)+10, 150, 15);
    
}


@end
