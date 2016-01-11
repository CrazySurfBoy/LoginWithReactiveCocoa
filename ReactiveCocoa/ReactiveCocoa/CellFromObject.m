//
//  QuicklyObject.m
//  TripMaster
//
//  Created by SurfBoy on 4/2/15.
//  Copyright (c) 2015 com.987trip. All rights reserved.
//

#import "CellFromObject.h"

@implementation CellFromObject


/**
 *  UITextField
 *  
 * 
 *  @return UITextField
 */
+ (UITextField *)textField {

    // 创建
    UITextField *qTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 0.0, SCREEN_WDITH - 80, 50.0)];
    qTextField.text = @"";
    qTextField.borderStyle = UITextBorderStyleNone;
    qTextField.backgroundColor = [UIColor clearColor];
    qTextField.font = [UIFont systemFontOfSize:14];
    qTextField.textColor = [UIColor colorFromHexCode:@"666666"];
    qTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    qTextField.keyboardType = UIKeyboardTypeDefault;
    qTextField.returnKeyType = UIReturnKeyNext;
    qTextField.textAlignment = NSTextAlignmentLeft;

    return qTextField;
}



// Cell左边Label
+ (UILabel *)leftLabel {

    // 标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 0.0, SCREEN_WDITH, 50.0)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor colorFromHexCode:@"666666"];

    return titleLabel;
}



// 圆角的提交按扭
+ (UIButton *)submitButtonWithTitle:(NSString *)title offsetY:(float)offsetY {

    // 提交按扭
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [actionButton setTitle:title forState:UIControlStateNormal];
    actionButton.frame = CGRectMake(25.0, offsetY, SCREEN_WDITH - 50, 47.0);
    [actionButton setBackgroundColor:[UIColor colorFromHexCode:@"1cbf61"]];
    [actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    actionButton.layer.masksToBounds = YES;
    actionButton.layer.cornerRadius = 5;
    return actionButton;
}





@end
