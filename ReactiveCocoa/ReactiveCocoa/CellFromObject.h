//
//  QuicklyObject.h
//  TripMaster
//
//  Created by SurfBoy on 4/2/15.
//  Copyright (c) 2015 com.987trip. All rights reserved.
//

@interface CellFromObject : NSObject



#pragma mark -
#pragma mark -# Cell创建基础对象



/**
 *  UITextField
 *  
 * 
 *  @return UITextField
 */
+ (UITextField *)textField;


/**
 *  Cell 左边Label
 *  
 * 
 *  @return UILabel
 */
+ (UILabel *)leftLabel;


/**
 *  圆角的提交按扭
 *
 *  @return UIButton
 */
+ (UIButton *)submitButtonWithTitle:(NSString *)title offsetY:(float)offsetY;








@end
