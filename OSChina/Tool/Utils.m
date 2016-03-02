//
//  Utils.m
//  OSChina
//
//  Created by NoPass on 16/2/8.
//  Copyright © 2016年 李周. All rights reserved.
//

#import "Utils.h"

@implementation Utils


+(MBProgressHUD *)createHUD
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithWindow:window];
    
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    [window addSubview:hud];
    [hud show:YES];
    hud.removeFromSuperViewOnHide = YES;
    
    return hud;
}

+(void)createTopActivityIndicatorVisible:(BOOL)visible
{
   
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = visible;
}

+(BOOL)isUserLogin
{
    
    return [[NSUserDefaults standardUserDefaults]boolForKey:USER_IS_LOGIN];
  
}

+(void)setLoginUserName:(NSString *)userName pwd:(NSString *)pwd
{
    [[NSUserDefaults standardUserDefaults]setObject:userName forKey:USERNAME];
    [[NSUserDefaults standardUserDefaults]setObject:pwd forKey:USERPSW];
}

+(NSInteger)returnLoginId
{
    NSString *uid = [[NSUserDefaults standardUserDefaults]objectForKey:USERID];
    
    return [uid integerValue];
}

#warning 之前没有存密码,导致出现nil的情况.

+(NSDictionary *)backFrontUserNameAndPwd
{
    NSString *userName = @"";
    NSString *userPwd = @"";
    if ([[NSUserDefaults standardUserDefaults]objectForKey:USERNAME] != nil) {
        userName = [[NSUserDefaults standardUserDefaults]objectForKey:USERNAME];
      
        userPwd = [[NSUserDefaults standardUserDefaults]objectForKey:USERPSW];
    }

    return @{USERNAME:userName,USERPSW:userPwd};
}
+(void)saveUserInfo:(UserModel *)model
{
    [[NSUserDefaults standardUserDefaults]setObject:model.uid forKey:USERID];
//    [[NSUserDefaults standardUserDefaults]setObject:model.name forKey:USERNAME];
    [[NSUserDefaults standardUserDefaults]setObject:model.from forKey:USERFROM];
    [[NSUserDefaults standardUserDefaults]setObject:model.followers forKey:USERFOLLOWERS];
    [[NSUserDefaults standardUserDefaults]setObject:model.fans forKey:USERFANS];
    [[NSUserDefaults standardUserDefaults]setObject:model.score forKey:USERSCORE];
    [[NSUserDefaults standardUserDefaults]setObject:model.portrait forKey:USERPORTRAIT];
    [[NSUserDefaults standardUserDefaults]setObject:model.favoritecount forKey:USERFAVORITE_COUNT];
    [[NSUserDefaults standardUserDefaults]setObject:model.gender forKey:USERGENDER];
}

+(UserModel *)backUserModel
{
    UserModel *model = [[UserModel alloc]init];
    if ([[NSUserDefaults standardUserDefaults]objectForKey:USERID] == nil) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        model.uid = [userDefault objectForKey:USERID];
        model.name = [userDefault objectForKey:USERNAME];
        model.from = [userDefault objectForKey:USERFROM];
        model.followers = [userDefault objectForKey:USERFOLLOWERS];
        model.fans = [userDefault objectForKey:USERFANS];
        model.score = [userDefault objectForKey:USERSCORE];
        model.portrait = [userDefault objectForKey:USERPORTRAIT];
        model.favoritecount = [userDefault objectForKey:USERFAVORITE_COUNT];
        model.gender = [userDefault objectForKey:USERGENDER];
        
    }
    return model;
}

+(void)setLoginState:(BOOL)isLogin
{
    [[NSUserDefaults standardUserDefaults]setBool:isLogin forKey:USER_IS_LOGIN];
}

@end
