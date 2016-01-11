//
//  ViewController.m
//  ReactiveCocoa
//
//  Created by SurfBoy on 9/1/15.
//  Copyright (c) 2015 com.987trip. All rights reserved.
//


#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CellFromObject.h"

@interface ViewController ()

@property(nonatomic, strong) UITableView *listTableView;
@property(nonatomic, strong) NSMutableArray *sectionList;  // 区域
@property(nonatomic, strong) UITextField *usernameTextField;
@property(nonatomic, strong) UITextField *passwordTextField;
@property(nonatomic, strong) UIButton *loginButton;
@property(nonatomic, strong) NSMutableArray *sList;

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    // Init
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"首页";

    // 初始化表格
    self.listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WDITH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    self.listTableView.delegate =self;
    self.listTableView.dataSource = self;
    [self.listTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.listTableView setSeparatorColor:[UIColor colorWithRed:207/255.0 green:205/255.0 blue:205/255.0 alpha:0.75]];
    [self.view addSubview:self.listTableView];
    [self setTableViewData];


    // 登录
    self.loginButton = [CellFromObject submitButtonWithTitle:@"登录" offsetY:160];
    [self.loginButton setBackgroundColor:[UIColor grayColor]];
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];


    // 创建验证用户名的信道
    RACSignal *validUsernameSignal = [self.usernameTextField.rac_textSignal
        map:^id(NSString *text) {
            return @([self isValidUsername:text]);
        }]; 

    // 创建验证密码的信号
    RACSignal *validPasswordSignal = [self.passwordTextField.rac_textSignal 
        map:^id(NSString *text) { 
            return @([self isValidPassword:text]);
        }];


    // 通过信道返回的值，设置文本框的文字色
    RAC(self.usernameTextField, textColor) = [validUsernameSignal
        map:^id(NSNumber *usernameValid) {
            return [usernameValid boolValue] ? [UIColor colorFromHexCode:@"666666"]:[UIColor redColor];
    }];


    // 通过信道返回的值，设置文本框的文字色
    RAC(self.passwordTextField, textColor) = [validPasswordSignal
        map:^id(NSNumber *passwordValid) {
            return [passwordValid boolValue] ? [UIColor colorFromHexCode:@"666666"]:[UIColor redColor];
        }];


    // 创建登录按扭的信号，把用户名与密码合成一个信道
    RACSignal *loginActiveSignal = [RACSignal 
        combineLatest:@[
            validUsernameSignal, 
            validPasswordSignal
        ]
        reduce:^id(NSNumber*usernameValid, NSNumber *passwordValid) {
            return @([usernameValid boolValue] && [passwordValid boolValue]);
        }];


    // 订阅 loginActiveSignal, 使按扭是否可用
    [loginActiveSignal subscribeNext:^(NSNumber*loginActiveSignal) {

        if ([loginActiveSignal boolValue]) {

            self.loginButton.enabled = YES;
            [self.loginButton setBackgroundColor:[UIColor colorFromHexCode:@"1cbf61"]];
        }
        else {
            self.loginButton.enabled = NO;
            [self.loginButton setBackgroundColor:[UIColor grayColor]];
        }
    }];
}


// 登录
- (void)login {

    NSLog(@"btn click");
}


// 验证用户名
- (BOOL)isValidUsername:(NSString *)username {

    // 验证用户名 - 邮箱
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];      

    return [emailTest evaluateWithObject:username];
}



// 验证密码的长度
- (BOOL)isValidPassword:(NSString *)password {

    return password.length > 5;
}


// 设置表格元素信息
- (void)setTableViewData {

    // Section
    self.sList = [[NSMutableArray alloc] init];

//* section 1
    NSMutableArray *dateRowList = [[NSMutableArray alloc] init];
    NSMutableDictionary *dateData = [[NSMutableDictionary alloc] init];

    // 用户名
    NSMutableDictionary *usernameData = [[NSMutableDictionary alloc] init];
    usernameData[@"title"] = @"用户名：";
    usernameData[@"key"] = @"username";
    usernameData[@"object"] = self.usernameTextField = [CellFromObject textField];
    self.usernameTextField.placeholder = @"请输入用户名";
    [dateRowList addObject:usernameData];

    // 密码
    NSMutableDictionary *passwordData = [[NSMutableDictionary alloc] init];
    passwordData[@"title"] = @"密码：";
    passwordData[@"key"] = @"password";
    passwordData[@"object"] = self.passwordTextField = [CellFromObject textField];
    self.passwordTextField.placeholder = @"请输入密码";
    self.passwordTextField.secureTextEntry = YES;
    [dateRowList addObject:passwordData];

    // Add
    dateData[@"key"] = @"date";
    dateData[@"rows"] = [NSString stringWithFormat:@"%ld", [dateRowList count]];
    dateData[@"list"] = dateRowList;
    [self.sList addObject:dateData];

}




#pragma mark -
#pragma mark -#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.sList count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger rows = [self.sList[section][@"rows"] intValue];

    return rows;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    // 自定义 Cell
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

        // 标题
        UILabel *titleLabel = [CellFromObject leftLabel];
        titleLabel.tag = 31;
        [cell.contentView addSubview:titleLabel];
    }

    // 设置
    NSMutableDictionary *itemData = self.sList[indexPath.section][@"list"][indexPath.row];

    // 标题
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:31];
    titleLabel.text = itemData[@"title"];

    // 对象
    [cell.contentView addSubview:itemData[@"object"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.0;
}

@end
