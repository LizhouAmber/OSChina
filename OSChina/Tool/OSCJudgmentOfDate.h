//
//  OSCJudgmentOfDate.h
//  OSChina
//
//  Created by qianfeng on 16/2/27.
//  Copyright © 2016年 李周. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSCJudgmentOfDate : NSObject

+(NSString *)returnJudgmentStrOfDateStr:(NSString *)dateStr;

+(BOOL)judgeDateStrWetherToday:(NSString *)dateStr;

@end
