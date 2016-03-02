//
//  ActivityCell.m
//  OSChina
//
//  Created by NoPass on 16/2/12.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "ActivityCell.h"

@interface ActivityCell ()

@property (strong, nonatomic)  UIImageView *leftImageView;
@property (strong, nonatomic)  UILabel *topLabel;

@property (strong, nonatomic)  UILabel *dateLabel;
@property (strong, nonatomic)  UILabel *addressLabel;

@end

@implementation ActivityCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUpCell];
    }
    return self;
}
-(void)setUpCell
{
    _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 76, 87)];
    [self.contentView addSubview:_leftImageView];
    
    _topLabel = [[UILabel alloc]init];
    _topLabel.numberOfLines = 0;
    _topLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.contentView addSubview:_topLabel];
    
    UIFont *font = [UIFont systemFontOfSize:13];
    UIColor *color = [UIColor lightGrayColor];
    _dateLabel = [[UILabel alloc]init];
    _dateLabel.textColor = color;
    _dateLabel.font = font;
    [self.contentView addSubview:_dateLabel];
    
    _addressLabel = [[UILabel alloc]init];
    _addressLabel.textColor = color;
    _addressLabel.font = font;
    _addressLabel.numberOfLines = 0;
    [self.contentView addSubview:_addressLabel];
    
}

-(void)setFrame:(CGRect)frame
{
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    
    [super setFrame:frame];
}

-(void)setModel:(ActivityModel *)model
{
    _model = model;
    
    CGFloat width = self.frame.size.width - 30-CGRectGetMaxX(_leftImageView.frame);
    
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    
    CGSize titleSize = [model.title boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]} context:nil].size;
    _topLabel.frame = CGRectMake(CGRectGetMaxX(_leftImageView.frame)+15, 15, titleSize.width, titleSize.height);
    _topLabel.text = model.title;

    CGSize timeSize = [model.startTime boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    _dateLabel.frame = CGRectMake(CGRectGetMaxX(_leftImageView.frame)+15, CGRectGetMaxY(_topLabel.frame)+15, timeSize.width, timeSize.height);
    _dateLabel.text = model.startTime;
    
    CGSize addressSize = [model.spot boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13]} context:nil].size;
    _addressLabel.frame = CGRectMake(CGRectGetMaxX(_leftImageView.frame)+15, CGRectGetMaxY(_dateLabel.frame)+15, addressSize.width, addressSize.height);
    _addressLabel.text = model.spot;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
