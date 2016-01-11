//
//  UIColor+FlatUI.h
//  FlatUI
//
//  Created by Jack Flintermann on 5/3/13.
//  Copyright (c) 2013 Jack Flintermann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extend)


/**
 *  将16进制转为 UIColor
 */
+ (UIColor *)colorFromHexCode:(NSString *)hexString;

@end
