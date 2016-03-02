//
//  OSCTitleBarView.m
//  OSChina
//
//  Created by NoPass on 16/2/6.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "OSCTitleBarView.h"

@implementation OSCTitleBarView

-(instancetype)initWithFrame:(CGRect)frame andSubTitle:(NSArray *)subTitles
{
    if (self = [super initWithFrame:frame]) {
        
        _subButtons = [NSMutableArray array];
//        _subTitles = [NSMutableArray arrayWithArray:subTitles];
        
        CGFloat btnWidth = frame.size.width/subTitles.count;
        
//        __weak typeof(self) weekSelf = self;
        
        [subTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(idx*btnWidth, 0, btnWidth, frame.size.height);
            button.tag = idx;
            [button setTitle:subTitles[idx] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            button.transform = CGAffineTransformIdentity;
            [button addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            [_subButtons addObject:button];
            
            [self addSubview:button];
            [self sendSubviewToBack:button];
        }];
        
        self.contentSize = CGSizeMake(btnWidth * subTitles.count, 0);
        self.showsHorizontalScrollIndicator = NO;
        
        UIButton *firstBtn = _subButtons[0];
        [firstBtn setTitleColor:[UIColor  colorWithRed:37.0/255 green:147.0/255 blue:58.0/255 alpha:1.0] forState:UIControlStateNormal];
        firstBtn.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
    }
    return self;
}

-(void)btnPressed:(UIButton *)sender
{
    if (_currentIndex != sender.tag) {
        
        UIButton *preBtn = _subButtons[_currentIndex];
        [preBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        preBtn.transform = CGAffineTransformIdentity;
        
        [sender setTitleColor:[UIColor colorWithRed:37.0/255 green:147.0/255 blue:58.0/255 alpha:1.0] forState:UIControlStateNormal];
        sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
        _currentIndex = sender.tag;
        if (_backSelectedIndex) {
            _backSelectedIndex(_currentIndex);
        }
    }
    
    
}

@end
