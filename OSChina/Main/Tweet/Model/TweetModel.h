//
//  TweetModel.h
//  OSChina
//
//  Created by qianfeng on 16/2/27.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "JSONModel.h"

@interface TweetModel : JSONModel

@property (nonatomic, copy) NSString <Optional>*idp;
@property (nonatomic, copy) NSString <Optional>*portrait;
@property (nonatomic, copy) NSString <Optional>*author;
@property (nonatomic, copy) NSString <Optional>*authorid;
@property (nonatomic, copy) NSString <Optional>*body;
@property (nonatomic, copy) NSString <Optional>*attach;
@property (nonatomic, copy) NSString <Optional>*appclient;
@property (nonatomic, copy) NSString <Optional>*commentCount;
@property (nonatomic, copy) NSString <Optional>*pubDate;
@property (nonatomic, copy) NSString <Optional>*imgSmall;
@property (nonatomic, copy) NSString <Optional>*imgBig;
@property (nonatomic, copy) NSString <Optional>*likeCount;
@property (nonatomic, copy) NSString <Optional>*isLike;
@property (nonatomic, copy) NSArray *likeList;



@end
