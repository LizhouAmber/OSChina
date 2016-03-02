//
//  OSCNetworking.m
//  OSChina
//
//  Created by NoPass on 16/2/6.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "OSCNetworking.h"
#import "NewModel.h"
#import "BlogModel.h"
#import "ActivityModel.h"
#import "SoftwareCategoryModel.h"

#import "SoftwareListModel.h"
#import "PostModel.h"
#import "TweetModel.h"
#import "UserModel.h"

@implementation OSCNetworking

+(instancetype)netWorking
{
    static OSCNetworking *netWorking;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorking = [[OSCNetworking alloc]init];
    });
    return netWorking;
}

#pragma mark --------------  News List

+(void)netWorkingWithNewsList:(NSString *)url successBlock:(httpSuccess)httpSuccess failureBlock:(httpFailure)httpFailure
{
    OSCNetworking *netWorking = [OSCNetworking netWorking];
    netWorking.manager = [AFHTTPSessionManager manager];
    netWorking.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [netWorking.manager GET:url
                 parameters:nil
                    success:^(NSURLSessionDataTask *task, id responseObject) {
                        
                        DDXMLDocument *document = [[DDXMLDocument alloc]initWithData:responseObject options:NSUTF8StringEncoding error:nil];
                        
                        DDXMLElement *rootElement = [document rootElement];
                        
                        httpSuccess(url,[self paraseXMLElementOfNewsListByRootElement:rootElement]);
                        
                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        httpFailure(url,error);
                    }];
}


+(NSArray *)paraseXMLElementOfNewsListByRootElement:(DDXMLElement *)rootElement
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    DDXMLElement *newsList = [rootElement elementsForName:@"newslist"][0];
    
    NSArray *newsArray = [newsList elementsForName:@"news"];
    
    for (DDXMLElement *newElement in newsArray) {
        NSString *idp = [self paraseXMLElementByRootElement:newElement andValue:@"id"];
        
        NSString *title = [self paraseXMLElementByRootElement:newElement andValue:@"title"];
        
        NSString *body = [self paraseXMLElementByRootElement:newElement andValue:@"body"];
        
        NSString *commentCount = [self paraseXMLElementByRootElement:newElement andValue:@"commentCount"];
        
        NSString *author = [self paraseXMLElementByRootElement:newElement andValue:@"author"];
        
        NSString *authorid = [self paraseXMLElementByRootElement:newElement andValue:@"authorid"];
        
        NSString *pubDate = [self paraseXMLElementByRootElement:newElement andValue:@"pubDate"];
        
        NSString *url = [self paraseXMLElementByRootElement:newElement andValue:@"pubDate"];
        
        DDXMLElement *newstype = [newElement elementsForName:@"newstype"][0];
        
        NSString *type = [self paraseXMLElementByRootElement:newstype andValue:@"type"];
        NSString *authoruid2 = [self paraseXMLElementByRootElement:newstype andValue:@"authoruid2"];
        NSString *eventurl = [self paraseXMLElementByRootElement:newstype andValue:@"eventurl"];
        
        NSDictionary *tempDic = @{@"type":type,@"authoruid2":authoruid2,@"eventurl":eventurl};
        
        NSDictionary *dic = @{@"idp":idp,@"title":title,@"body":body,@"commentCount":commentCount,@"author":author,@"authorid":authorid,@"pubDate":pubDate,@"url":url,@"newstype":tempDic};
        NewModel *model = [[NewModel alloc]initWithDictionary:dic error:nil];
        
        [dataArray addObject:model];
    }
    
    return dataArray;
}

#pragma mark --------------- Blogs List

+(void)netWorkingWithBlogsList:(NSString *)url successBlock:(httpSuccess)httpSuccess failureBlock:(httpFailure)httpFailure
{
    OSCNetworking *netWorking = [OSCNetworking netWorking];
    netWorking.manager = [AFHTTPSessionManager manager];
    netWorking.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [netWorking.manager GET:url
                 parameters:nil
                    success:^(NSURLSessionDataTask *task, id responseObject) {
                        
                        DDXMLDocument *document = [[DDXMLDocument alloc]initWithData:responseObject options:NSUTF8StringEncoding error:nil];
                        
                        DDXMLElement *rootElement = [document rootElement];
                        
                        httpSuccess(url,[self paraseXMLElementOfBlogsListByRootElement:rootElement]);
                        
                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        
                    }];
}

+(NSArray *)paraseXMLElementOfBlogsListByRootElement:(DDXMLElement *)rootElement
{
    NSMutableArray *tempArr = [NSMutableArray array];
    DDXMLElement *blogsElement = [rootElement elementsForName:@"blogs"][0];
    
    NSArray *blogArr = [blogsElement elementsForName:@"blog"];
    
    for (DDXMLElement *blogElement in blogArr) {
        NSString *idp = [self paraseXMLElementByRootElement:blogElement andValue:@"id"];
        NSString *title = [self paraseXMLElementByRootElement:blogElement andValue:@"title"];
        NSString *body = [self paraseXMLElementByRootElement:blogElement andValue:@"body"];
        NSString *url = [self paraseXMLElementByRootElement:blogElement andValue:@"url"];
        NSString *pubDate = [self paraseXMLElementByRootElement:blogElement andValue:@"pubDate"];
        NSString *authoruid = [self paraseXMLElementByRootElement:blogElement andValue:@"authoruid"];
        NSString *authorname = [self paraseXMLElementByRootElement:blogElement andValue:@"authorname"];
        NSString *commentCount =[self paraseXMLElementByRootElement:blogElement andValue:@"commentCount"];
        NSString *documentType = [self paraseXMLElementByRootElement:blogElement andValue:@"documentType"];
        
        NSDictionary *dic = @{@"idp":idp,@"title":title,@"body":body,@"url":url,@"pubDate":pubDate,@"authoruid":authoruid,@"authorname":authorname,@"commentCount":commentCount,@"documentType":documentType};
        BlogModel *model = [[BlogModel alloc]initWithDictionary:dic error:nil];
        
        [tempArr addObject:model];
    }
    return tempArr;
    
//    NSString *idp = [self paraseXMLElementByRootElement:blogsElement andValue:<#(NSString *)#>]
}

#pragma mark ---------------   Activity 活动

+(void)netWorkingWithEventsList:(NSString *)url successBlock:(httpSuccess)httpSuccess failureBlock:(httpFailure)httpFailure
{
    OSCNetworking *netWorking = [OSCNetworking netWorking];
    netWorking.manager = [AFHTTPSessionManager manager];
    netWorking.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [netWorking.manager GET:url
                 parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                     
                     DDXMLDocument *document = [[DDXMLDocument alloc]initWithData:responseObject options:NSUTF8StringEncoding error:nil];
                     DDXMLElement *rootElement = [document rootElement];
                     
                     httpSuccess(url,[self paraseXMLElementOfEventsListByRootElement:rootElement]);
                     
                 } failure:^(NSURLSessionDataTask *task, NSError *error) {
                     httpFailure(url,error);
                 }];
}

+(NSArray *)paraseXMLElementOfEventsListByRootElement:(DDXMLElement *)rootElement
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    DDXMLElement *events = [rootElement elementsForName:@"events"][0];
    
    NSArray *eventArray = [events elementsForName:@"event"];
    
    for (DDXMLElement *eventElement in eventArray) {
        NSString *uid = [self paraseXMLElementByRootElement:eventElement andValue:@"id"];
        NSString *cover = [self paraseXMLElementByRootElement:eventElement andValue:@"cover"];
        NSString *title = [self paraseXMLElementByRootElement:eventElement andValue:@"title"];
        NSString *url = [self paraseXMLElementByRootElement:eventElement andValue:@"url"];
        NSString *startTime = [self paraseXMLElementByRootElement:eventElement andValue:@"startTime"];
        NSString *endTime = [self paraseXMLElementByRootElement:eventElement andValue:@"endTime"];
        NSString *createTime = [self paraseXMLElementByRootElement:eventElement andValue:@"createTime"];
        NSString *spot = [self paraseXMLElementByRootElement:eventElement andValue:@"spot"];
        NSString *city = [self paraseXMLElementByRootElement:eventElement andValue:@"city"];
        NSString *status = [self paraseXMLElementByRootElement:eventElement andValue:@"status"];
        NSString *applyStatus = [self paraseXMLElementByRootElement:eventElement andValue:@"applyStatus"];
        
        NSDictionary *dic = @{@"uid":uid,@"cover":cover,@"title":title,@"url":url,@"startTime":startTime,@"endTime":endTime,@"createTime":createTime,@"spot":spot,@"city":city,@"status":status,@"applyStatus":applyStatus};
        
        ActivityModel *model = [[ActivityModel alloc]initWithDictionary:dic error:nil];
        
        [dataArray addObject:model];
    }
    
    return dataArray;
}

#pragma mark --------------  SoftwareCategory  软件类别

+(void)netWorkingWithSoftwareCategoryList:(NSString *)url successBlock:(httpSuccess)httpSuccess failureBlock:(httpFailure)httpFailure
{
    OSCNetworking *netWorking = [OSCNetworking netWorking];
    netWorking.manager = [AFHTTPSessionManager manager];
    netWorking.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [netWorking.manager GET:url
                 parameters:nil
                    success:^(NSURLSessionDataTask *task, id responseObject) {
                     
                        
                        DDXMLDocument *document = [[DDXMLDocument alloc]initWithData:responseObject options:NSUTF8StringEncoding error:nil];
                        DDXMLElement *rootElement = [document rootElement];
                        
                        httpSuccess(url,[self paraseXMLElementOfSoftwareTypeListElement:rootElement]);
                    }
                    failure:^(NSURLSessionDataTask *task, NSError *error) {
                       
                        httpFailure(url,error);
                    }];
}

+(NSArray *)paraseXMLElementOfSoftwareTypeListElement:(DDXMLElement *)rootElement
{
    NSMutableArray *tempArr = [NSMutableArray array];
    
    DDXMLElement *softwareTypeElement = [rootElement elementsForName:@"softwareTypes"][0];
    
    NSArray *softwareTypeArr = [softwareTypeElement elementsForName:@"softwareType"];
    
    for (DDXMLElement *element in softwareTypeArr) {
        NSString *name = [self paraseXMLElementByRootElement:element andValue:@"name"];
        NSString *tag = [self paraseXMLElementByRootElement:element andValue:@"tag"];
  
        
        NSDictionary *dic = @{@"name":name,@"tag":tag};
        SoftwareCategoryModel *model = [SoftwareCategoryModel softwareCategoryModelWithDic:dic];
        [tempArr addObject:model];
    }
    
    return tempArr;
}

#pragma mark --------------  Software List   开源软件部分
+(void)netWorkingWithSoftwareList:(NSString *)url successBlock:(httpSuccess)httpSuccess failureBlock:(httpFailure)httpFailure
{
    OSCNetworking *netWorking = [OSCNetworking netWorking];
    netWorking.manager = [AFHTTPSessionManager manager];
    netWorking.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [netWorking.manager GET:url
                 parameters:nil
                    success:^(NSURLSessionDataTask *task, id responseObject) {
                        
                        DDXMLDocument *document = [[DDXMLDocument alloc]initWithData:responseObject options:NSUTF8StringEncoding error:nil];
                        DDXMLElement *rootElement = [document rootElement];
                        
                        httpSuccess(url,[self paraseXMLElementOfSoftwareListElement:rootElement]);
                        
                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        httpFailure(url,error);
                    }];
}

+(NSArray *)paraseXMLElementOfSoftwareListElement:(DDXMLElement *)rootElement
{
    NSMutableArray *arr = [NSMutableArray array];
    DDXMLElement *softwares = [rootElement elementsForName:@"softwares"][0];
    NSArray *softwaresArr = [softwares elementsForName:@"software"];
    
    for (DDXMLElement *element in softwaresArr) {
        NSString *idp ;
        if ([element elementsForName:@"id" ].count == 0) {
            idp = @"";
        }else
        {
            idp = [self paraseXMLElementByRootElement:element andValue:@"id"];
        }
        
        NSString *name = [self paraseXMLElementByRootElement:element andValue:@"name"];
        NSString *descriptionK = [self paraseXMLElementByRootElement:element andValue:@"description"];
        NSString *url = [self paraseXMLElementByRootElement:element andValue:@"url"];
        
        NSDictionary *dic = @{@"idp":idp,@"name":name,@"descriptionK":descriptionK,@"url":url};
        
        SoftwareListModel *model = [SoftwareListModel softwareListModelWithDic:dic];
        
        [arr addObject:model];
    }
    
    return arr;
}

#pragma mark --------------  Post List  技术问答

+(void)netWorkingWithPostList:(NSString *)url successBlock:(httpSuccess)httpSuccess failureBlock:(httpFailure)httpFailure
{
    OSCNetworking *netWorking = [OSCNetworking netWorking];
    netWorking.manager = [AFHTTPSessionManager manager];
    netWorking.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [netWorking.manager GET:url
                 parameters:nil
                    success:^(NSURLSessionDataTask *task, id responseObject) {
                        DDXMLDocument *document = [[DDXMLDocument alloc]initWithData:responseObject options:NSUTF8StringEncoding error:nil];
                        DDXMLElement *rootElement = [document rootElement];
                        
                        httpSuccess(url,[self paraseXMLElementOfPostListElement:rootElement]);
                        
                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        httpFailure(url,error);
                    }];
}

+(NSArray *)paraseXMLElementOfPostListElement:(DDXMLElement *)rootElement
{
    NSMutableArray *arr = [NSMutableArray array];
    
    DDXMLElement *postsElement = [rootElement elementsForName:@"posts"][0];
    
    NSArray *postArr = [postsElement elementsForName:@"post"];
    
    for (DDXMLElement *element in postArr) {
        NSString *idp = [self paraseXMLElementByRootElement:element andValue:@"id"];
        NSString *portrait = [self paraseXMLElementByRootElement:element andValue:@"portrait"];
        NSString *author = [self paraseXMLElementByRootElement:element andValue:@"author"];
        NSString *authorid = [self paraseXMLElementByRootElement:element andValue:@"authorid"];
        NSString *title = [self paraseXMLElementByRootElement:element andValue:@"title"];
        NSString *body = [self paraseXMLElementByRootElement:element andValue:@"body"];
        NSString *answerCount = [self paraseXMLElementByRootElement:element andValue:@"answerCount"];
        NSString *viewCount = [self paraseXMLElementByRootElement:element andValue:@"viewCount"];
        NSString *pubDate = [self paraseXMLElementByRootElement:element andValue:@"pubDate"];
        NSDictionary *answerDic ;
        if ([answerCount integerValue] == 0) {
            answerDic = [NSDictionary dictionary];
        }else{
            DDXMLElement *answer = [element elementsForName:@"answer"][0];
            NSString *name = [self paraseXMLElementByRootElement:answer andValue:@"name"];
            NSString *time = [self paraseXMLElementByRootElement:answer andValue:@"time"];
            answerDic = @{@"name":name,@"time":time};
        }
        
        NSDictionary *dic = @{@"idp":idp,@"portrait":portrait,@"author":author,@"authorid":authorid,@"title":title,@"body":body,@"answerCount":answerCount,@"viewCount":viewCount,@"pubDate":pubDate,@"answer":answerDic};
        PostModel *model = [[PostModel alloc]initWithDictionary:dic error:nil];
        
        [arr addObject:model];
    }
    
    return arr;
}

#pragma mark --------------  Tweets List 动弹
+(void)netWorkingWithTweetList:(NSString *)url successBlock:(httpSuccess)httpSuccess failureBlock:(httpFailure)httpFailure
{
    OSCNetworking *netWorking = [OSCNetworking netWorking];
    netWorking.manager = [AFHTTPSessionManager manager];
    netWorking.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [netWorking.manager GET:url
                 parameters:nil
                    success:^(NSURLSessionDataTask *task, id responseObject) {
                        
                        DDXMLDocument *document = [[DDXMLDocument alloc]initWithData:responseObject options:NSUTF8StringEncoding error:nil];
                        DDXMLElement *rootElement = [document rootElement];
                        
                        httpSuccess(url,[self paraseXMLElementOfTweetListElement:rootElement]);

                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        httpFailure(url,error);
                    }];
}

+(NSArray *)paraseXMLElementOfTweetListElement:(DDXMLElement *)rootElement
{
    NSMutableArray *arr = [NSMutableArray array];
    
    DDXMLElement *tweetsElement = [rootElement elementsForName:@"tweets"][0];
    
    NSArray *tweetArr = [tweetsElement elementsForName:@"tweet"];
    for (DDXMLElement *element in tweetArr) {
        NSString *idp = [self paraseXMLElementByRootElement:element andValue:@"id"];
        NSString *portrait = [self paraseXMLElementByRootElement:element andValue:@"portrait"];
        NSString *author = [self paraseXMLElementByRootElement:element andValue:@"author"];
        NSString *authorid = [self paraseXMLElementByRootElement:element andValue:@"authorid"];
        NSString *body = [self paraseXMLElementByRootElement:element andValue:@"body"];
        NSString *attach = [self paraseXMLElementByRootElement:element andValue:@"attach"];
        NSString *appclient = [self paraseXMLElementByRootElement:element andValue:@"appclient"];
        NSString *commentCount = [self paraseXMLElementByRootElement:element andValue:@"commentCount"];
        NSString *pubDate = [self paraseXMLElementByRootElement:element andValue:@"pubDate"];
        NSString *imgSmall = [self paraseXMLElementByRootElement:element andValue:@"imgSmall"];
        NSString *imgBig = [self paraseXMLElementByRootElement:element andValue:@"imgBig"];
        NSString *likeCount = [self paraseXMLElementByRootElement:element andValue:@"likeCount"];
        NSString *isLike = [self paraseXMLElementByRootElement:element andValue:@"isLike"];
        NSArray *likeList = [element elementsForName:@"likeList"];
        
        NSDictionary *dic = @{@"idp":idp,@"portrait":portrait,@"author":author,@"authorid":authorid,@"body":body,@"attach":attach,@"appclient":appclient,@"commentCount":commentCount,@"pubDate":pubDate,@"imgSmall":imgSmall,@"imgBig":imgBig,@"likeCount":likeCount,@"isLike":isLike,@"likeList":likeList};
        TweetModel *model = [[TweetModel alloc]initWithDictionary:dic error:nil];
        
        [arr addObject:model];
    }
    
    return arr;
}

#pragma mark --------------------   用户信息  User
+(void)netWorkingWithUserList:(NSString *)url successBlock:(httpSuccess)httpSuccess failureBlock:(httpFailure)httpFailure
{
    OSCNetworking *netWorking = [OSCNetworking netWorking];
    netWorking.manager = [AFHTTPSessionManager manager];
    netWorking.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [netWorking.manager GET:url
                 parameters:nil
                    success:^(NSURLSessionDataTask *task, id responseObject) {
                        
                        DDXMLDocument *document = [[DDXMLDocument alloc]initWithData:responseObject options:NSUTF8StringEncoding error:nil];
                        DDXMLElement *rootElement = [document rootElement];
                        
                        httpSuccess(url,[self paraseXMLElementOfUserListElement:rootElement]);
                        
                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        
                    }];
}

+(NSArray *)paraseXMLElementOfUserListElement:(DDXMLElement *)rootElement
{
    NSMutableArray *arr = [NSMutableArray array];
    
    DDXMLElement *usersElement = [rootElement elementsForName:@"users"][0];
    
    NSArray *userListArr = [usersElement elementsForName:@"user"];
    
    for (DDXMLElement *element in userListArr) {
        NSString *name = [self paraseXMLElementByRootElement:element andValue:@"name"];
        NSString *uid = [self paraseXMLElementByRootElement:element andValue:@"uid"];
        NSString *portrait = [self paraseXMLElementByRootElement:element andValue:@"portrait"];
        NSString *gender = [self paraseXMLElementByRootElement:element andValue:@"gender"];
        NSString *from = [self paraseXMLElementByRootElement:element andValue:@"from"];
        NSString *score = @"";
        if ([element elementsForName:@"score"].count != 0) {
            score = [self paraseXMLElementByRootElement:element andValue:@"score"];
        }
        NSString *fans = @"0";
        if ([element elementsForName:@"fans"].count != 0) {
            fans = [self paraseXMLElementByRootElement:element andValue:@"fans"];
        }
        NSString *followers = @"0";
        if ([element elementsForName:@"followers"].count != 0) {
            followers = [self paraseXMLElementByRootElement:element andValue:@"followers"];
        }
        NSString *jointime = @"";
        if ([element elementsForName:@"jointime"].count != 0) {
            jointime = [self paraseXMLElementByRootElement:element andValue:@"jointime"];
        }
        NSString *devplatform = @"";
        if ([element elementsForName:@"devplatform"].count != 0) {
            devplatform = [self paraseXMLElementByRootElement:element andValue:@"devplatform"];
        }
        NSString *expertise = @"";
        if ([element elementsForName:@"expertise"].count != 0) {
            expertise = [self paraseXMLElementByRootElement:element andValue:@"expertise"];
        }
        NSString *relation = @"0";
        if ([element elementsForName:@"relation"].count != 0) {
            relation = [self paraseXMLElementByRootElement:element andValue:@"relation"];
        }
        NSString *latestonline = @"";
        if ([element elementsForName:@"latestonline"].count != 0) {
            latestonline = [self paraseXMLElementByRootElement:element andValue:@"latestonline"];
        }
        
        NSArray *likeList = @[];
        if ([element elementsForName:@"likeList"].count != 0) {
            likeList = [element elementsForName:@"likeList"];
        }
        
        NSDictionary *dic = @{@"name":name,@"uid":uid,@"from":from,@"portrait":portrait,@"gender":gender,@"score":score,@"fans":fans,@"followers":followers,@"jointime":jointime,@"devplatform":devplatform,@"expertise":expertise,@"relation":relation,@"latestonline":latestonline,@"likeList":likeList};
        
        UserModel *model = [[UserModel alloc]initWithDictionary:dic error:nil];
        [arr addObject:model];
    }
    
    return arr;
}

+(NSString *)paraseXMLElementByRootElement:(DDXMLElement *)rootElement andValue:(NSString *)value
{
    DDXMLElement *element = [rootElement elementsForName:value][0];
    return element.stringValue;
}

@end
