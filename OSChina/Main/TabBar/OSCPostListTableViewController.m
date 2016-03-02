//
//  OSCPostListTableViewController.m
//  OSChina
//
//  Created by qianfeng on 16/2/27.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "OSCPostListTableViewController.h"

#import "OSCPostCell.h"

static NSString *const postCellStr = @"OSCPostCell";

@interface OSCPostListTableViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSUInteger _postType;
    NSInteger  _currentPage;
    BOOL _isTopToFresh;
}

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation OSCPostListTableViewController

-(instancetype)initWithPostType:(PostType)type
{
    if (self = [super init]) {
        _postType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isTopToFresh = YES;
    
    [self registerForCell];
    
    [self requesetForPostData];
}

-(void)requesetForPostData
{
    NSString *url = [NSString stringWithFormat:@"%@%@?%@&pageIndex=%ld&catalog=%ld",OSCAPI_HTTPS_PREFIX,OSCAPI_POST_LIST,OSCAPI_SUFFIX,_currentPage,_postType];
    [OSCNetworking netWorkingWithPostList:url
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

-(void)registerForCell
{
    [self.tableView registerClass:[OSCPostCell class] forCellReuseIdentifier:postCellStr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OSCPostCell *cell = [tableView dequeueReusableCellWithIdentifier:postCellStr];
    
    PostModel *model = _dataArr[indexPath.row];
    cell.model = model;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostModel *model = _dataArr[indexPath.row];
    
    CGFloat height = 0;
    
    CGFloat labelWidth = SCREEN_WIDTH - (10+15+40);
    
    CGSize titleSize = [model.title boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    height = height + 15+titleSize.height;

    
    CGSize bodySize = [model.body boundingRectWithSize:CGSizeMake(labelWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13]} context:nil].size;
    height = height +15+bodySize.height;
    
    CGSize authorNameSize = [model.author sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];
    height = height +15+authorNameSize.height+10;
    
    return height;
}

@end
