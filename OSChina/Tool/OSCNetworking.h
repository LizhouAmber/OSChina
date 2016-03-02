//
//  OSCNetworking.h
//  OSChina
//
//  Created by NoPass on 16/2/6.
//  Copyright © 2016年 李周. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^httpSuccess)(NSString *url,NSArray *dataArr);
typedef void(^httpFailure)(NSString *url,NSError *error);

@interface OSCNetworking : NSObject

@property (nonatomic, copy) AFHTTPSessionManager *manager;

+(instancetype)netWorking;

/*
            首页news部分
 */
+(void)netWorkingWithNewsList:(NSString *)url successBlock:(httpSuccess)httpSuccess failureBlock:(httpFailure)httpFailure;
/*
            首页的blog部分
 */
+(void)netWorkingWithBlogsList:(NSString *)url successBlock:(httpSuccess)httpSuccess failureBlock:(httpFailure)httpFailure;
/*
            发现中的活动部分
 */
+(void)netWorkingWithEventsList:(NSString *)url successBlock:(httpSuccess)httpSuccess failureBlock:(httpFailure)httpFailure;
/*
            侧滑中的开源软件第一部分::根据不同的catalog获取不同的数据
 */
+(void)netWorkingWithPostList:(NSString *)url successBlock:(httpSuccess)httpSuccess failureBlock:(httpFailure)httpFailure;
/*
            侧滑中的开源软件第二部分::分类(所有的软件类别)
 */
+(void)netWorkingWithSoftwareCategoryList:(NSString *)url successBlock:(httpSuccess)httpSuccess failureBlock:(httpFailure)httpFailure;
/*
            侧滑中的开源软件第二部分::根据不同的searchTag获取不同的数据
 */
+(void)netWorkingWithSoftwareList:(NSString *)url successBlock:(httpSuccess)httpSuccess failureBlock:(httpFailure)httpFailure;
/*
            侧滑中的开源软件第三部分:tweet
 
 */
+(void)netWorkingWithTweetList:(NSString *)url successBlock:(httpSuccess)httpSuccess failureBlock:(httpFailure)httpFailure;
/*
             user 用户的信息
 */
+(void)netWorkingWithUserList:(NSString *)url successBlock:(httpSuccess)httpSuccess failureBlock:(httpFailure)httpFailure;

@end
