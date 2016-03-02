//
//  OSCActivityViewController.m
//  OSChina
//
//  Created by NoPass on 16/2/8.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "OSCActivityViewController.h"

#import "ActivityCell.h"


static NSString *const cellReuseIdentifier = @"ActivityCell";

@interface OSCActivityViewController ()
{
    NSInteger _currentPage;
    NSUInteger _type;
}

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation OSCActivityViewController


-(instancetype)initWithType:(NSUInteger)type
{
    if (self = [super init]) {
        
        _type = type;
        [self requestForActivityData];
        
    }
    return self;
}

-(void)requestForActivityData
{
    MBProgressHUD *hud = [Utils createHUD];
    hud.labelText =@"正在加载中";
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@?uid=%lu&pageIndex=%ld&%@",OSCAPI_HTTPS_PREFIX,OSCAPI_EVENT_LIST,(unsigned long)_type,(long)_currentPage,OSCAPI_SUFFIX];
    
    [OSCNetworking netWorkingWithEventsList:urlStr
                               successBlock:^(NSString *url, NSArray *dataArr) {
                                   if (_currentPage == 0) {
                                       if (_dataArray == nil) {
                                           _dataArray = [NSMutableArray array];
                                       }else{
                                           [_dataArray removeAllObjects];
                                       }
                                       [_dataArray addObjectsFromArray:dataArr];
                                   }else{
                                       
                                   }
                                   [self.tableView reloadData];
                                   
                               } failureBlock:^(NSString *url, NSError *error) {
                                   
                               }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[ActivityCell class] forCellReuseIdentifier:cellReuseIdentifier];
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

    return _dataArray.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 20)];
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"已加载全部";
    
    return label;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = SCREEN_WIDTH - 30-15-76;
    
    CGFloat height = 15;
    ActivityModel *model = _dataArray[indexPath.row];
    CGSize titleSize = [model.title boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]} context:nil].size;
    height = height +titleSize.height+15;
    
    CGSize timeSize = [model.startTime boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
 
    height = height+timeSize.height+15;
    
    CGSize addressSize = [model.spot boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13]} context:nil].size;
    height = height + addressSize.height +15;
    
    return height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    
    ActivityModel *model = _dataArray[indexPath.row];
    
    cell.model = model;
    
    return cell;
}

@end
