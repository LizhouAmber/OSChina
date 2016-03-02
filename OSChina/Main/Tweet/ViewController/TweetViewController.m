//
//  TweetViewController.m
//  OSChina
//
//  Created by NoPass on 16/2/6.
//  Copyright © 2016年 lizhou. All rights reserved.
//

#import "TweetViewController.h"

@interface TweetViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSUInteger _uid;
    NSUInteger _currentPage;
    BOOL _isTopToFresh;
}

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation TweetViewController

-(instancetype)initWithType:(TweetType)type
{
    if (self = [super init]) {
        switch (type) {
            case TweetTypeOfLaster:
                _uid = 0;
                break;
            case TweetTypeOfHotter:
                _uid = -1;
                break;
            case TweetTypeOfMine:
                _uid =2;
                break;
                
            default:
                break;
        }
    }
    return self;
}

-(void)requestForData{
    NSString *url = [NSString stringWithFormat:@"%@%@?%@&pageIndex=%ld&uid=%ld",OSCAPI_HTTPS_PREFIX,OSCAPI_TWEETS_LIST,OSCAPI_SUFFIX,_currentPage,_uid];
    
    [OSCNetworking netWorkingWithTweetList:url
                              successBlock:^(NSString *url, NSArray *dataArr) {
                                  if (_isTopToFresh) {
                                      if (_dataArr == nil) {
                                          _dataArr = [NSMutableArray array];
                                      }else{
                                          [_dataArr removeAllObjects];
                                      }
                                  }
                                  
                                  [_dataArr addObjectsFromArray:dataArr];
                                  
                                  [self.tableView reloadData];
                                  
                              } failureBlock:^(NSString *url, NSError *error) {
                                  
                              }];
}

#pragma mark ----------------------   UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestForData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
