//
//  NewModel.h
//  OSChina
//
//  Created by NoPass on 16/2/6.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "JSONModel.h"

typedef NS_ENUM(int , NewsType) {

    NewsTypeOfConsultation = 0,
    NewModelOfBlog,
    NewsTypeOf
};


@interface NewModel : JSONModel

@property (nonatomic, copy) NSString <Optional>*idp;
@property (nonatomic, copy) NSString <Optional>*title;
@property (nonatomic, copy) NSString <Optional>*body;
@property (nonatomic, copy) NSString <Optional>*commentCount;
@property (nonatomic, copy) NSString <Optional>*author;
@property (nonatomic, copy) NSString <Optional>*authorid;
@property (nonatomic, copy) NSString <Optional>*pubDate;
@property (nonatomic, copy) NSString <Optional>*url;

@property (nonatomic, copy) NSDictionary *newstype;

@end
