//
//  ViewController.h
//  ReactiveCocoa
//
//  Created by SurfBoy on 9/1/15.
//  Copyright (c) 2015 com.987trip. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void (^RWSignInResponse)(BOOL);

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>



/**
 *  设置表格元素信息
 *
 */
- (void)setTableViewData;



/**
 *  验证用户名
 *
 *  @param NSString  用户名
 *  @return BOOL
 */
- (BOOL)isValidUsername:(NSString *)username;



/**
 *  验证密码的长度
 *
 *  @param NSString  密码
 *  @return BOOL
*/
- (BOOL)isValidPassword:(NSString *)password;



/**
 *  登录
 */
- (void)login;



@end

