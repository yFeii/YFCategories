//
//  UIImage+HGUI.h
//  HGOrderingMerchant
//
//  Created by Tianbiao Wang on 17/9/21.
//  Copyright © 2017年 Tianbiao Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HGUI)
+ (UIImage *)imageFromLayer:(CALayer *)layer;

- (UIImage *)scaleFillToSize:(CGSize)size;
- (UIImage *)scaleFitToSize:(CGSize)size;
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

- (UIImage *)imageWithColor:(UIColor *)color;
@end
