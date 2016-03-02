//
//  PostModel.h
//  OSChina
//
//  Created by qianfeng on 16/2/27.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "JSONModel.h"

@interface PostModel : JSONModel

@property (nonatomic, copy) NSString <Optional>*idp;
@property (nonatomic, copy) NSString <Optional>*portrait;
@property (nonatomic, copy) NSString <Optional>*author;
@property (nonatomic, copy) NSString <Optional>*authorid;
@property (nonatomic, copy) NSString <Optional>*title;
@property (nonatomic, copy) NSString <Optional>*body;
@property (nonatomic, copy) NSString <Optional>*answerCount;
@property (nonatomic, copy) NSString <Optional>*viewCount;
@property (nonatomic, copy) NSString <Optional>*pubDate;
@property (nonatomic, copy) NSDictionary *answer;

@end
