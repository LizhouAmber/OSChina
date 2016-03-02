//
//  OSCSoftTableViewController.m
//  OSChina
//
//  Created by qianfeng on 16/2/26.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "OSCSoftTableViewController.h"

#import "SoftwareCategoryModel.h"
#import "SoftwareListModel.h"

static NSString *const categoryListCellStr = @"UITableViewCellStr1";
static NSString *const softListCellStr = @"UITableViewCellStr2";

@interface OSCSoftTableViewController ()
{
    NSUInteger _type;
    NSInteger _currentPage;
    BOOL _hasMoveTpFresh;
}

@property (nonatomic, strong) NSMutableArray *categoryArr;
@property (nonatomic, strong) NSArray *softTypeArr;
@property (nonatomic, strong) NSMutableArray *softwareArr;
@end

@implementation OSCSoftTableViewController

-(instancetype)initWithSoftType:(SoftType)type
{
    if (self = [super init]) {
        _type = type;
        
    }
    return self;
}

-(void)requestForCategoryListDataWithTag:(NSInteger)tag
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",OSCAPI_HTTPS_PREFIX,OSCAPI_SOFTWARE_CATALOG_LIST];
    [OSCNetworking netWorkingWithSoftwareCategoryList:urlStr
                                     successBlock:^(NSString *url, NSArray *dataArr) {
                                         
                                         if (_categoryArr == nil) {
                                             _categoryArr = [NSMutableArray array];
                                         }else{
                                             [_categoryArr removeAllObjects];
                                         }
                                         
                                         [_categoryArr addObjectsFromArray:dataArr];
                                         
                                         [self.tableView reloadData];
                                         
                                     } failureBlock:^(NSString *url, NSError *error) {
                                         
                                     }];
}
-(void)requestForListData
{
    _softTypeArr = @[@"",@"recommend",@"time",@"view",@"list_cn"];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@?%@&pageIndex=%ld&searchTag=%@",OSCAPI_HTTPS_PREFIX,OSCAPI_SOFTWARE_LIST,OSCAPI_SUFFIX,_currentPage,_softTypeArr[_type]];
    
    [OSCNetworking netWorkingWithSoftwareList:urlStr
                                 successBlock:^(NSString *url, NSArray *dataArr) {
                                     if (_hasMoveTpFresh) {
                                         if (_softwareArr == nil) {
                                             _softwareArr = [NSMutableArray array];
                                         }else{
                                             [_softwareArr removeAllObjects];
                                         }
                                     }
                                     [_softwareArr addObjectsFromArray:dataArr];
                                     
                                     [self.tableView reloadData];
                                 }
                                 failureBlock:^(NSString *url, NSError *error) {
                                     
                                 }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _hasMoveTpFresh = YES;
    
    
   
    
    if (_type == 0) {
        self.tableView.bounces = YES;
        [self requestForCategoryListDataWithTag:0];
    }else{
        self.tableView.bounces = NO;
        [self requestForListData];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if (_type == 0) {
        return _categoryArr == nil?0:1;
    }
    return _softwareArr==nil?0:1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (_type == 0) {
        return _categoryArr.count;
    }
    return _softwareArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_type == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryListCellStr];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:categoryListCellStr];
        }
        
        SoftwareCategoryModel *model = _categoryArr[indexPath.row];
        
        cell.textLabel.text = model.name;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:softListCellStr];
        if (cell == nil) {
           
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:softListCellStr];
        }
        SoftwareListModel *model = _softwareArr[indexPath.row];
        cell.textLabel.text = model.name;
        cell.textLabel.font = [UIFont systemFontOfSize:20];
        cell.detailTextLabel.text = model.descriptionK;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_type == 0) {
        return 44;
    }
    return 64;
}

@end
