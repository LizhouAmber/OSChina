//
//  SoftwareListModel.h
//  OSChina
//
//  Created by qianfeng on 16/2/26.
//  Copyright © 2016年 李周. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoftwareListModel : NSObject

@property (nonatomic, copy) NSString *idp;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *descriptionK;
@property (nonatomic, copy) NSString *url;

+(instancetype)softwareListModelWithDic:(NSDictionary *)dic;

-(instancetype)initWithDic:(NSDictionary *)dic;
@end
