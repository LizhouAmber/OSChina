//
//  OSCNewsViewController.m
//  OSChina
//
//  Created by NoPass on 16/2/6.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "OSCNewsViewController.h"

#import "OSCNewsCell.h"

static NSString *newsCell = @"OSCNewsCell";

@interface OSCNewsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSUInteger _currentPage;
    NewsListType currentType;
}

@property (nonatomic, copy) NSString *urlStr;
@property (nonatomic, copy) NSMutableArray *dataArray;

@end

@implementation OSCNewsViewController

-(instancetype)initWithNewsListType:(NewsListType)type
{
    if (self = [super init]) {
        
//        __weak OSCNewsViewController *weakSelf = self;
//        self.generateURL = ^NSString *(NSUInteger page){
        _dataArray = [NSMutableArray array];
        
        currentType = type;
        [self requestForDataOfType:type];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor yellowColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"OSCNewsCell" bundle:nil] forCellReuseIdentifier:newsCell];
    
}
-(void)requestForDataOfType:(NewsListType)type
{
    if (type < 4) {
        _urlStr = [NSString stringWithFormat:@"%@%@?pageIndex=%lu&catalog=%d&%@",OSCAPI_HTTPS_PREFIX,OSCAPI_NEWS_LIST,_currentPage,type,OSCAPI_SUFFIX];
    }
    else if( type== NewsListTypeAllTypeMonthHottest){
        _urlStr = [NSString stringWithFormat:@"%@%@?show=month",OSCAPI_HTTPS_PREFIX,OSCAPI_NEWS_LIST];
    }
    else{
        _urlStr = [NSString stringWithFormat:@"%@%@?show=week",OSCAPI_HTTPS_PREFIX,OSCAPI_NEWS_LIST];
    }
    //        };
    [OSCNetworking netWorkingWithNewsList:_urlStr
                             successBlock:^(NSString *url, NSArray *dataArr) {
                                 if (_currentPage ==0) {
                                     if (_dataArray) {
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

#pragma mark --------------------   UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OSCNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:newsCell];
    
    NewModel *model = _dataArray[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewModel *model = _dataArray[indexPath.row];
    
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
