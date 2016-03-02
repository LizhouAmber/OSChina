//
//  OSCJudgmentOfDate.m
//  OSChina
//
//  Created by qianfeng on 16/2/27.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "OSCJudgmentOfDate.h"

@implementation OSCJudgmentOfDate

+(NSString *)formatDateFormOfDifferenceDay:(NSUInteger)day
{
    if (day == 1) {
        return @"昨天";
    }else if(day == 2){
        return @"前天";
    }else{
        return [NSString stringWithFormat:@"%ld天前",day];
    }
}


+(NSString *)returnJudgmentStrOfDateStr:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    NSDate *date = [dateFormatter dateFromString:dateStr];
    
    NSDate *today = [NSDate date];
    NSString *todayStr = [dateFormatter stringFromDate:today];
    
    //第一个为:年  第二个为:月  第三个为:天  第四个为:小时
    NSArray *dateArr = [dateStr componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" -:"]];
    NSArray *todayArr = [todayStr componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" -:"]];
    
    NSString *monthOfBefore = dateArr[1];
    NSString *monthOfToday = todayArr[1];
    
    NSString *dayOfBefore = dateArr[2];
    NSString *dayOfToday = todayArr[2];
    
    NSString *hourOfBefore = dateArr[3];
    NSString *hourOfToday = todayArr[3];
    //如果是同一天的话,返回 的是小时 ; 如果不是同一天的话,返回1;
    if ([monthOfBefore integerValue] != [monthOfToday integerValue]) {
        NSUInteger countOfInterOfMonth = labs([monthOfBefore integerValue] - [monthOfToday integerValue]);
        return [NSString stringWithFormat:@"%ld月之前",countOfInterOfMonth];
    }else{
         if ([dayOfBefore isEqualToString:dayOfToday]) {
        NSUInteger countOfInterOfHour = labs([hourOfBefore integerValue] - [hourOfToday integerValue]);
        return [NSString stringWithFormat:@"%ld小时前",(countOfInterOfHour)];
         }else{
        
        NSUInteger countBetweenOfDay = labs([dayOfBefore integerValue] - [dayOfToday integerValue]);
        return [self formatDateFormOfDifferenceDay:countBetweenOfDay];
         }

    }
   
}

+(BOOL)judgeDateStrWetherToday:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    NSDate *date = [dateFormatter dateFromString:dateStr];
    
    NSDate *today = [NSDate date];
    NSString *todayStr = [dateFormatter stringFromDate:today];
    
    //第一个为:年  第二个为:月  第三个为:天  第四个为:小时
    NSArray *dateArr = [dateStr componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" -:"]];
    NSArray *todayArr = [todayStr componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" -:"]];
    
    NSString *dayOfBefore = dateArr[2];
    NSString *dayOfToday = todayArr[2];
    
    if ([dayOfBefore isEqualToString:dayOfToday]) {
        //如果是今天的话 会返回1;
        return 1;
    }else{
        return 0;
    }
}

@end
