//
//  OSCNewsCell.m
//  OSChina
//
//  Created by NoPass on 16/2/6.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "OSCNewsCell.h"

@interface OSCNewsCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconLeftConstraints;

@end

@implementation OSCNewsCell


-(void)setModel:(NewModel *)model
{
    _model = model;
    
    _nameLabel.text = model.title;
    _contentLabel.text = model.body;
    _pubNameLabel.text = model.author;
    
    //yyyy年mm月dd日 mm－ss
    NSString *judgeDateStr = [OSCJudgmentOfDate returnJudgmentStrOfDateStr:model.pubDate];
    _pubDateLabel.text = judgeDateStr;
    _pubNumLabel.text = model.commentCount;
    if ([OSCJudgmentOfDate judgeDateStrWetherToday:model.pubDate]) {
        //如果是今天的话
        _iconImageView.image = [UIImage imageNamed:@"widget_taday"];
    }else{
        _iconImageView.image = [UIImage new];
        self.iconLeftConstraints.constant=0;
        [self.contentView layoutIfNeeded];
    }
}

-(void)setBlogModel:(BlogModel *)blogModel
{
    
    _blogModel = blogModel;
    
    _nameLabel.text = blogModel.title;
    _contentLabel.text = blogModel.body;
    //日期的判断部分
    NSString *judgeDateStr = [OSCJudgmentOfDate returnJudgmentStrOfDateStr:blogModel.pubDate];
    _pubDateLabel.text = judgeDateStr;
    _pubNumLabel.text = blogModel.commentCount;
    
    if ([blogModel.documentType integerValue] == 0) {
        _iconImageView.image = [UIImage imageNamed:@"widget_repost"];
    }else if([blogModel.documentType integerValue] == 1){
        _iconImageView.image = [UIImage imageNamed:@"widget-original"];
    }else if([blogModel.documentType integerValue] == 2){
        _iconImageView.image = [UIImage imageNamed:@"recommend_tag"];
    }else{
        _iconImageView.image = [UIImage new];
        self.iconLeftConstraints.constant=0;
        [self.contentView layoutIfNeeded];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
