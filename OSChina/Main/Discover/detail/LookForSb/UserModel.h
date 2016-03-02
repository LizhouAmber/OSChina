//
//  UserModel.h
//  OSChina
//
//  Created by qianfeng on 16/2/29.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "JSONModel.h"

@interface UserModel : JSONModel

@property (nonatomic, copy) NSString <Optional>*name;
@property (nonatomic, copy) NSString <Optional>*uid;
@property (nonatomic, copy) NSString <Optional>*portrait;
@property (nonatomic, copy) NSString <Optional>*score;
@property (nonatomic, copy) NSString <Optional>*fans;
@property (nonatomic, copy) NSString <Optional>*followers;
@property (nonatomic, copy) NSString <Optional>*jointime;
@property (nonatomic, copy) NSString <Optional>*gender;
@property (nonatomic, copy) NSString <Optional>*from;
@property (nonatomic, copy) NSString <Optional>*devplatform;
@property (nonatomic, copy) NSString <Optional>*expertise;
@property (nonatomic, copy) NSString <Optional>*relation;
@property (nonatomic, copy) NSString <Optional>*latestonline;
@property (nonatomic, copy) NSString <Optional>*favoritecount;

@property (nonatomic, copy) NSArray *likeList;

@end
