//
//  OSCTitleBarView.h
//  OSChina
//
//  Created by NoPass on 16/2/6.
//  Copyright © 2016年 李周. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OSCTitleBarView : UIScrollView

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, copy) NSMutableArray *subButtons;

@property (nonatomic, copy) void (^backSelectedIndex)(NSInteger index);

-(instancetype)initWithFrame:(CGRect)frame andSubTitle:(NSArray *)subTitles;



@end
