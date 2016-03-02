//
//  SoftwareCategoryModel.h
//  OSChina
//
//  Created by qianfeng on 16/2/26.
//  Copyright © 2016年 李周. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoftwareCategoryModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *tag;


+(instancetype)softwareCategoryModelWithDic:(NSDictionary *)dic;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
