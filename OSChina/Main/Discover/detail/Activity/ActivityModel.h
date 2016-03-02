//
//  ActivityModel.h
//  OSChina
//
//  Created by NoPass on 16/2/8.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "JSONModel.h"

@interface ActivityModel : JSONModel

@property (nonatomic, copy) NSString <Optional>*uid;
@property (nonatomic, copy) NSString <Optional>*cover;
@property (nonatomic, copy) NSString <Optional>*title;
@property (nonatomic, copy) NSString <Optional>*url;
@property (nonatomic, copy) NSString <Optional>*startTime;
@property (nonatomic, copy) NSString <Optional>*endTime;
@property (nonatomic, copy) NSString <Optional>*createTime;
@property (nonatomic, copy) NSString <Optional>*spot;
@property (nonatomic, copy) NSString <Optional>*city;
@property (nonatomic, copy) NSString <Optional>*status;
@property (nonatomic, copy) NSString <Optional>*applyStatus;



@end
