//
//  OSCLoginViewController.h
//  OSChina
//
//  Created by NoPass on 16/2/8.
//  Copyright © 2016年 李周. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"

@interface OSCLoginViewController : UIViewController

@property (nonatomic, weak)void (^backLoginUserModel)(UserModel *model);
@end
