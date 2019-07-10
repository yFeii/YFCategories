//
//  UIButton+Factory.h
//  HaveCar
//
//  Created by yzl on 17/9/17.
//  Copyright © 2017年 lwk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Factory)
+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(CGFloat)titleFont titleColor:(UIColor *)titleColor;
+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(CGFloat)titleFont titleColor:(UIColor *)titleColor bgColor:(UIColor *)bgColor;
+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(CGFloat)titleFont titleColor:(UIColor *)titleColor normalImage:(NSString *)normalImage highlightImage:(NSString *)highlightImage;
+ (UIButton *)buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor;
+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(CGFloat)titleFont titleColor:(UIColor *)titleColor bgImage:(NSString *)bgImage;

@end
