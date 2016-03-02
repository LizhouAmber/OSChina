//
//  Utils.h
//  OSChina
//
//  Created by NoPass on 16/2/8.
//  Copyright © 2016年 李周. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MBProgressHUD.h"
#import "UserModel.h"

@interface Utils : NSObject

+(MBProgressHUD *)createHUD;

+(void)createTopActivityIndicatorVisible:(BOOL)visible;

+(NSDictionary *)backFrontUserNameAndPwd;

+(void)saveUserInfo:(UserModel *)model;
+(UserModel *)backUserModel;

+(BOOL)isUserLogin;
+(void)setLoginState:(BOOL)isLogin;
+(void)setLoginUserName:(NSString *)userName pwd:(NSString *)pwd;
+(NSInteger)returnLoginId;

@end
