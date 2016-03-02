//
//  BlogModel.m
//  OSChina
//
//  Created by NoPass on 16/2/7.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "BlogModel.h"

@implementation BlogModel

+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"idp"}];
}

@end
