//
//  UIButton+Factory.m
//  HaveCar
//
//  Created by yzl on 17/9/17.
//  Copyright © 2017年 lwk. All rights reserved.
//

#import "UIButton+Factory.h"

const CGFloat defalutTitleSize = 14;
//const UIColor *defalutTitleColor = [UIColor blackColor];

@implementation UIButton (Factory)
+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(CGFloat)titleFont titleColor:(UIColor *)titleColor {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:(titleFont)];
    return button;
}

+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(CGFloat)titleFont titleColor:(UIColor *)titleColor bgColor:(UIColor *)bgColor {
    UIButton *btn = [UIButton buttonWithTitle:title titleFont:titleFont titleColor:titleColor];
    [btn setBackgroundColor:bgColor];
    return btn;
}

+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(CGFloat)titleFont titleColor:(UIColor *)titleColor normalImage:(NSString *)normalImage highlightImage:(NSString *)highlightImage {
    UIButton *button = [UIButton buttonWithTitle:title titleFont:titleFont titleColor:titleColor];
    [button setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightImage?:normalImage] forState:UIControlStateHighlighted];
    return button;
}
+ (UIButton *)buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    return button;
}
+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(CGFloat)titleFont titleColor:(UIColor *)titleColor bgImage:(NSString *)bgImage
{
    UIButton *btn = [self buttonWithTitle:title font:[UIFont systemFontOfSize:titleFont] titleColor:titleColor];
    [btn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    return btn;
}


@end
