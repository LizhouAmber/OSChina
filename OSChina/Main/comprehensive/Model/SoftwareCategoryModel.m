//
//  SoftwareCategoryModel.m
//  OSChina
//
//  Created by qianfeng on 16/2/26.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "SoftwareCategoryModel.h"

@implementation SoftwareCategoryModel

+(instancetype)softwareCategoryModelWithDic:(NSDictionary *)dic
{
    return [[self alloc]initWithDic:dic];
}


-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end
