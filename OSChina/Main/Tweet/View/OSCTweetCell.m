//
//  OSCTweetCell.m
//  OSChina
//
//  Created by qianfeng on 16/2/27.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "OSCTweetCell.h"

@interface OSCTweetCell ()
{
    UIImageView *_iconImageView;
    UILabel *_nameLabel;
    UILabel *_contentLabel;
    UIImageView *_imageView;
    
    UIImageView *_dateImageView;
    
}

@end

@implementation OSCTweetCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUpCell];
    }
    return self;
}

-(void)setUpCell
{
    _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 40, 40)];
    _iconImageView.layer.cornerRadius = CGRectGetHeight(_iconImageView.frame)/2.0;
    _iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_iconImageView];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame)+15, 15, self.frame.size.width-30-CGRectGetMaxX(_iconImageView.frame), 15)];
    _nameLabel.textColor = [UIColor  colorWithRed:37.0/255 green:147.0/255 blue:58.0/255 alpha:1.0] ;
    _nameLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_nameLabel];
    
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame)+15, CGRectGetMaxY(_nameLabel.frame)+15, 0, 0)];
    _contentLabel.font = [UIFont systemFontOfSize:13];
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
    
    
}

@end
