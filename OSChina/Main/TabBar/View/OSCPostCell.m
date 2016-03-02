//
//  OSCPostCell.m
//  OSChina
//
//  Created by qianfeng on 16/2/27.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "OSCPostCell.h"

@interface OSCPostCell ()
{
    UIImageView *_iconImageView;
    UILabel *_topTitleLabel;
    UILabel *_contentLabel;
    UILabel *_authorNameLabel;
    UILabel *_dateLabel;
    UILabel *_commentLabel;
    
    UIImageView *_dateIcon;
    UIImageView *_commentIcon;
}

@end

@implementation OSCPostCell

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
    
    UIColor *color_1 = [UIColor lightGrayColor];
    
    _topTitleLabel = [[UILabel alloc]init];
    _topTitleLabel.numberOfLines = 2;
    _topTitleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_topTitleLabel];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.font = [UIFont systemFontOfSize:13];
    _contentLabel.textColor = color_1;
    _contentLabel.numberOfLines = 2;
    [self.contentView addSubview:_contentLabel];
    
    _authorNameLabel = [[UILabel alloc]init];
    _authorNameLabel.font = [UIFont systemFontOfSize:11];
    _authorNameLabel.textColor = color_1;
    [self.contentView addSubview:_authorNameLabel];
    
    _dateIcon = [[UIImageView alloc]init];
    _dateIcon.image = [UIImage imageNamed:@"ch_pending_clock"];
    [self.contentView addSubview:_dateIcon];
    
    _dateLabel = [[UILabel alloc]init];
    _dateLabel.font = [UIFont systemFontOfSize:11];
    _dateLabel.textColor = color_1;
    [self.contentView addSubview:_dateLabel];
    
    _commentIcon = [[UIImageView alloc]init];
    _commentIcon.image = [UIImage imageNamed:@"dest_basicinfo_icon6"];
    [self.contentView addSubview:_commentIcon];
    
    _commentLabel = [[UILabel alloc]init];
    _commentLabel.textColor = color_1;
    _commentLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:_commentLabel];
}

-(void)setFrame:(CGRect)frame
{
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    
    [super setFrame:frame];
}

-(void)setModel:(PostModel *)model
{
    _model = model;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@"default-portrait"]];
    
    CGFloat labelWidth = self.frame.size.width - (CGRectGetMaxX(_iconImageView.frame)+15);
    
    CGSize titleSize = [model.title boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    _topTitleLabel.frame = CGRectMake(CGRectGetMaxX(_iconImageView.frame)+15, 15, titleSize.width, titleSize.height);
    _topTitleLabel.text = model.title;
    
    CGSize bodySize = [model.body boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]} context:nil].size;
    
    _contentLabel.frame = CGRectMake(CGRectGetMaxX(_iconImageView.frame)+15, CGRectGetMaxY(_topTitleLabel.frame)+15, bodySize.width, bodySize.height);
    _contentLabel.text = model.body;
    
    CGSize authorNameSize = [model.author sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];
    _authorNameLabel.frame = CGRectMake(CGRectGetMaxX(_iconImageView.frame)+15, CGRectGetMaxY(_contentLabel.frame)+15,authorNameSize.width, authorNameSize.height);
    _authorNameLabel.text = model.author;
    
    _dateIcon.frame = CGRectMake(CGRectGetMaxX(_authorNameLabel.frame) +15, CGRectGetMaxY(_contentLabel.frame)+15, 15, 15);
    
    NSString *dateStr = [model.pubDate componentsSeparatedByString:@" "][0];
    CGSize dateSize = [dateStr sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:11]}];
    
    _dateLabel.frame = CGRectMake(CGRectGetMaxX(_dateIcon.frame)+5, CGRectGetMaxY(_contentLabel.frame)+15, dateSize.width, dateSize.height);
    _dateLabel.text = dateStr;
    
    _commentIcon.frame = CGRectMake(CGRectGetMaxX(_dateLabel.frame)+10, CGRectGetMaxY(_contentLabel.frame)+15, 15, 15);
    
    _commentLabel.text = [NSString stringWithFormat:@"%@回/%@阅",model.answerCount,model.viewCount];
    _commentLabel.frame = CGRectMake(CGRectGetMaxX(_commentIcon.frame)+5, CGRectGetMaxY(_contentLabel.frame)+15, 100, dateSize.height);
}

@end
