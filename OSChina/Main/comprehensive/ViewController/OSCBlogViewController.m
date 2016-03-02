//
//  OSCBlogViewController.m
//  OSChina
//
//  Created by NoPass on 16/2/6.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "OSCBlogViewController.h"
#import "OSCNewsCell.h"

static NSString *blogsCell = @"OSCBlogsCell";

@interface OSCBlogViewController ()
{
    NSUInteger _currentPage;
    NSString *_urlStr;
    NSString *_currentType;
}

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation OSCBlogViewController

-(instancetype)initWithBlogListType:(BlogListType)type
{
    if (self = [super init]) {
        
        NSString *blogType = type== BlogListTypeLatest?@"latest":@"recommend";
        
        _currentType = blogType;
        
        [self requestForDataOfType:blogType];
        
    }
    return self;
}

-(void)requestForDataOfType:(NSString *)type
{
    _urlStr = [NSString stringWithFormat:@"%@%@?type=%@&pageIndex=%lu&%@",OSCAPI_HTTPS_PREFIX,OSCAPI_BLOG_LIST,type,_currentPage,OSCAPI_SUFFIX];

    [OSCNetworking netWorkingWithBlogsList:_urlStr
                              successBlock:^(NSString *url, NSArray *dataArr) {
                                  if (_currentPage == 0) {
                                      if (!_dataArray) {
                                          _dataArray = [NSMutableArray array];
                                      }else{
                                          [_dataArray removeAllObjects];
                                      }
                                      _dataArray = [dataArr mutableCopy];
                                  }else{
                                      [_dataArray addObject:dataArr];
                                  }
                                  [self.tableView reloadData];
                                  
                              } failureBlock:^(NSString *url, NSError *error) {
                                  
                              }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OSCNewsCell" bundle:nil] forCellReuseIdentifier:blogsCell];
}


#pragma mark ------------------   UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OSCNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:blogsCell];
    
    BlogModel *model = _dataArray[indexPath.row];
    cell.blogModel = model;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BlogModel *model = _dataArray[indexPath.row];
    
    //顶头标题、下面的发布情况都是固定的
    
    
    CGSize cellSize = [model.body boundingRectWithSize:CGSizeMake(359,MAXFLOAT ) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(8, 36, cellSize.width, cellSize.height)];
    label.numberOfLines = 2;
    label.font = [UIFont systemFontOfSize:13];
    
    CGFloat cellHeight = CGRectGetMaxY(label.frame) +35;
    
    return cellHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
