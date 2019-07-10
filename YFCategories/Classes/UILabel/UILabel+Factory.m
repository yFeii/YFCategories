//
//  UILabel+Factory.m
//  HaveCar
//
//  Created by yzl on 17/9/17.
//  Copyright © 2017年 lwk. All rights reserved.
//

#import "UILabel+Factory.h"

@implementation UILabel (Factory)
+ (UILabel *)labelWithFont:(CGFloat)font textColor:(UIColor *)textColor {
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = textColor;
    label.numberOfLines = 0;
    [label sizeToFit];
    return label;
}
+ (UILabel *)labelWithFont:(CGFloat)font textColor:(UIColor *)textColor text:(NSString *)text {
    UILabel *label = [UILabel labelWithFont:font textColor:textColor];
    label.text = text;
    return label;
}
+ (UILabel *)labelWithFont:(CGFloat)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = [UILabel labelWithFont:font textColor:textColor];
    label.textAlignment = textAlignment;
    return label;
}
+ (UILabel *)labelWithFont:(CGFloat)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text {
    UILabel *label = [UILabel labelWithFont:font textColor:textColor text:text];
    label.textAlignment = textAlignment;
    return label;
}
+ (UILabel *)labelWithFontName:(NSString *)font fontSize:(CGFloat)size textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text
{
    
    UILabel *label = [UILabel labelWithUserFont:[UIFont fontWithName:font size:size] textColor:textColor textAlignment:textAlignment text:text];
    return label;
}
+ (UILabel *)labelWithUserFont:(UIFont *)userFont textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text
{
    UILabel *label = [UILabel new];
    label.font = userFont;
    label.textColor = textColor;
    label.numberOfLines = 0;
    label.textAlignment = textAlignment;
    label.text = text;
    [label sizeToFit];
    
    return label;
}


@end
