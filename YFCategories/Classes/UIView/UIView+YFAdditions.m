//
//  UIView+YFAdditions.m
//  sqt-ios
//
//  Created by yFeii on 2019/7/10.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import "UIView+YFAdditions.h"

@implementation UIView (YFAdditions)

@end

@implementation UIView (YFFrame)


- (void)setOriginX:(CGFloat)originX {
    CGRect frame = self.frame;
    frame.origin.x = originX;
    self.frame =frame;
}

- (void)setOriginY:(CGFloat)originY {
    CGRect frame = self.frame;
    frame.origin.y= originY;
    self.frame =frame;
}

- (CGFloat)originX {
    return self.frame.origin.x;
}


- (CGFloat)originY {
    return self.frame.origin.y;
}

-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    
    frame.size.width = width;
    self.frame =frame;
    
}
-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame =frame;
}

-(CGFloat)width
{
    return self.frame.size.width;
    
}

-(CGFloat)height
{
    return self.frame.size.height;
    
}

-(void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    
    frame.size = size;
    self.frame =frame;
    
    
}

-(CGSize)size
{
    
    return self.frame.size;
    
}

-(void)setOrigin:(CGPoint)origin
{
    
    CGRect frame =self.frame;
    frame.origin =origin;
    self.frame = frame;
}


-(CGPoint)origin
{
    return self.frame.origin;
    
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}
@end