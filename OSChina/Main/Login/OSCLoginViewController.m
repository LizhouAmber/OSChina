//
//  OSCLoginViewController.m
//  OSChina
//
//  Created by NoPass on 16/2/8.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "OSCLoginViewController.h"

#import "UserModel.h"

@interface OSCLoginViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (strong, nonatomic) IBOutlet UIView *userNameView;
@property (weak, nonatomic) IBOutlet UIView *passwordView;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic, strong) UserModel *model;
@end

@implementation OSCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpSubViews];
}

-(void)setUpSubViews
{
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = 5.0;
    
    _userNameTextField.delegate = self;
    _passwordTextField.delegate = self;
    
    [_userNameTextField addTarget:self action:@selector(returnOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_passwordTextField addTarget:self action:@selector(returnOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidenKeyboard)];
    tap.numberOfTapsRequired = 1;
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSDictionary *dic=  [Utils backFrontUserNameAndPwd];
        if (dic[USERNAME] != nil && ![dic[USERNAME] isEqualToString:@""]) {
        self.userNameTextField.placeholder = dic[USERNAME];
        self.passwordTextField.placeholder = dic[USERPSW];
    }else{
        self.userNameTextField.placeholder = @"请输入用户名";
        self.passwordTextField.placeholder = @"请输入用户密码";
        
    }

}

//这个手势的作用：：：delegate

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (![_userNameTextField isFirstResponder] && ![_passwordTextField isFirstResponder]) {
        return NO;
    }
    return YES;
}

#pragma mark ----------- 键盘处理

-(void)hidenKeyboard
{
    [_userNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

-(void)returnOnKeyboard:(UITextField *)sender
{
    if (sender == _userNameTextField) {
        [_passwordTextField becomeFirstResponder];
    }else if(sender == _passwordTextField){
        [self hidenKeyboard];
        if (_loginBtn.enabled) {
            [self loginBtnPressed:_loginBtn];
        }
    }
}
- (IBAction)loginBtnPressed:(id)sender {
    
    _hud = [Utils createHUD];
    [self hidenKeyboard];
    
    NSString *userName = [_userNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password = [_passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (userName.length <=0 || password.length <= 0) {
        _hud.labelText = @"请输入完整的信息";
        _hud.userInteractionEnabled = NO;
        [_hud hide:YES afterDelay:3];
        
        return;
    }
    
    _hud.labelText = @"正在登录";
    _hud.userInteractionEnabled = NO;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",OSCAPI_HTTPS_PREFIX,OSCAPI_LOGIN_VALIDATE];
    
    NSDictionary *paramDic = @{@"username":userName,@"pwd":password,@"keep_login":@(1)};
    
    [manager POST:urlStr
       parameters:paramDic
          success:^(NSURLSessionDataTask *task, id responseObject) {
              DDXMLDocument *document = [[DDXMLDocument alloc]initWithData:responseObject options:NSUTF8StringEncoding error:nil];
              
              DDXMLElement *rootElement = [document rootElement];
              
              //先是判断登录是否成功
              NSString *errorCode = @"/oschina/result/errorCode";
              NSString *errorMessage = @"/oschina/result/errorMessage";
              
              NSString *error = [[rootElement nodesForXPath:errorCode error:nil][0] stringValue];
              
              if (![error integerValue]) {
                  //这是登录失败的判断
                  _hud.mode = MBProgressHUDModeCustomView;
                  
                  _hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HUD-error"]];
                  _hud.labelText = [[rootElement nodesForXPath:errorMessage error:nil][0] stringValue];
                  [_hud hide:YES afterDelay:1];
                  
                  return ;
              }
              
              [Utils setLoginUserName:userName pwd:password];
              [Utils setLoginState:YES];
              
              DDXMLElement *element = [rootElement elementsForName:@"user"][0];
              
              [self paraseXMLDataOfLoginUser:element];
              
              _model = [[UserModel alloc]init];
              
              _model = [self paraseXMLDataOfLoginUser:element];
              
              [[NSNotificationCenter defaultCenter]postNotificationName:USER_LOGIN_NOTI object:_model];
              
              _hud.mode = MBProgressHUDModeCustomView;
              _hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HUD-done"]];
              [_hud hide:YES afterDelay:1];
              
              [self backToFrontPage];
              
          } failure:^(NSURLSessionDataTask *task, NSError *error) {
              _hud.mode = MBProgressHUDModeCustomView;
              _hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HUD-error"]];
              _hud.labelText = error.localizedDescription;
              [_hud hide:YES afterDelay:1];
          }];
}



-(UserModel *)paraseXMLDataOfLoginUser:(DDXMLElement *)rootElement
{
    NSString *uid = [self paraseXMLDataOfRootElement:rootElement value:@"uid"];
    NSString *location = [self paraseXMLDataOfRootElement:rootElement value:@"location"];
    NSString *name = [self paraseXMLDataOfRootElement:rootElement value:@"name"];
    NSString *followers = [self paraseXMLDataOfRootElement:rootElement value:@"followers"];
    NSString *fans = [self paraseXMLDataOfRootElement:rootElement value:@"fans"];
    NSString *score = [self paraseXMLDataOfRootElement:rootElement value:@"score"];
    NSString *portrait = [self paraseXMLDataOfRootElement:rootElement value:@"portrait"];
    NSString *favoritecount = [self paraseXMLDataOfRootElement:rootElement value:@"favoritecount"];
    NSString *gender = [self paraseXMLDataOfRootElement:rootElement value:@"gender"];
    
    NSArray *likeList = [NSArray array];
    if ([rootElement elementsForName:@"likeList"].count != 0) {
        likeList = [rootElement elementsForName:@"likeList"];
    }
    
    NSDictionary *dic = @{@"uid":uid,@"from":location,@"name":name,@"followers":followers,@"fans":fans,@"score":score,@"portrait":portrait,@"favoritecount":favoritecount,@"gender":gender,@"likeList":likeList};
    
    UserModel *model = [[UserModel alloc]initWithDictionary:dic error:nil];
    
    [Utils saveUserInfo:model];
    [Utils setLoginState:YES];
    
    return model;
    
}

-(void)backToFrontPage
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSString *)paraseXMLDataOfRootElement:(DDXMLElement *)rootElement value:(NSString *)value
{
    DDXMLElement *element = [rootElement elementsForName:value][0];
    
    return element.stringValue;
}

#pragma mark -----------  第三方登录
- (IBAction)loginByQQ:(id)sender {
}
- (IBAction)loginByWeChat:(id)sender {
}
- (IBAction)loginBySina:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
