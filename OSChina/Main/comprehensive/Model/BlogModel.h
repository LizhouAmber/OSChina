//
//  BlogModel.h
//  OSChina
//
//  Created by NoPass on 16/2/7.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "JSONModel.h"

@interface BlogModel : JSONModel

@property (nonatomic, copy) NSString <Optional>*idp;
@property (nonatomic, copy) NSString <Optional>*title;
@property (nonatomic, copy) NSString <Optional>*body;
@property (nonatomic, copy) NSString <Optional>*url;
@property (nonatomic, copy) NSString <Optional>*pubDate;
@property (nonatomic, copy) NSString <Optional>*authoruid;
@property (nonatomic, copy) NSString <Optional>*authorname;
@property (nonatomic, copy) NSString <Optional>*commentCount;
@property (nonatomic, copy) NSString <Optional>*documentType;


@end
