//
//  OSCLookForSbViewController.m
//  OSChina
//
//  Created by qianfeng on 16/2/29.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "OSCLookForSbViewController.h"

#import "OSCLookForSbCell.h"

static NSString *lookForSbCellStr = @"OSCLookForSbCell";

@interface OSCLookForSbViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation OSCLookForSbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 55;
    [self registerNavigationBar];
    [self.tableView registerClass:[OSCLookForSbCell class] forCellReuseIdentifier:lookForSbCellStr];
}

-(void)requestForCellInfo:(NSString *)searchName
{
    MBProgressHUD *progressView = [Utils createHUD];
    progressView.labelText = @"加载中";
    [progressView show:YES];
    [Utils createTopActivityIndicatorVisible:YES];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@?name=%@",OSCAPI_HTTPS_PREFIX,OSCAPI_FIND_USER,searchName];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [OSCNetworking netWorkingWithUserList:urlStr
                             successBlock:^(NSString *url, NSArray *dataArr) {
                                 
                                 if (_dataArr == nil) {
                                     _dataArr = [NSMutableArray array];
                                 }else{
                                     [_dataArr removeAllObjects];
                                 }
                                 [_dataArr addObjectsFromArray:dataArr];
                                 [self.tableView reloadData];
                                 [progressView hide:YES];
                                 [progressView removeFromSuperViewOnHide];
                                 [Utils createTopActivityIndicatorVisible:NO];
                                 
                             } failureBlock:^(NSString *url, NSError *error) {
                                 [Utils createTopActivityIndicatorVisible:NO];
                                 [progressView hide:YES];
                                 [progressView removeFromSuperViewOnHide];
                                 //还要出现一个错误的提示,
                                 
                             }];
}

-(void)registerNavigationBar
{
    UIImage *leftImage = [[UIImage imageNamed:@"icon_back_button"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(backBtnPressed)];
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2.0, 40)];
    self.searchBar.transform = CGAffineTransformMakeScale(0.8, 1);
    self.searchBar.placeholder = @"输入用户昵称";
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
}


-(void)backBtnPressed
{
    [self.searchBar resignFirstResponder];
    if (self.navigationController.viewControllers.count <= 1 ) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma  mark        ---------------    UISearchBarDelegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (self.searchBar.text.length > 0 ) {
        [self requestForCellInfo:self.searchBar.text];
    }
    
}


-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _searchBar.text = @"";
    [_searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (self.searchBar.text.length > 0 ) {
        [self requestForCellInfo:self.searchBar.text];
    }
    
    [_searchBar resignFirstResponder];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OSCLookForSbCell *cell = [tableView dequeueReusableCellWithIdentifier:lookForSbCellStr];
    
    UserModel *model = _dataArr[indexPath.row];
    
    cell.model = model;
    
    return cell;
}



@end
