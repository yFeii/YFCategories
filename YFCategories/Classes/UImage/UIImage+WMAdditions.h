//
//  UIImage+WMAdditions.h
//  withMe
//
//  Created by lorabit on 15/12/1.
//  Copyright © 2015年 从来网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreMedia/CMSampleBuffer.h"

@interface UIImage (WMAdditions)

+ (UIImage *)imageWithShadowSize:(CGSize)shadowSize blur:(float)blur andColor:(UIColor *)color;

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

+ (UIImage *)screenShoot:(UIView *)view;

- (UIImage *)scaleFitToSize:(CGSize)size;

- (UIImage *)scaleFillToSize:(CGSize)size;

+ (UIImage*)scaleDown:(UIImage*)image withSize:(CGSize)newSize;

+ (UIImage *)imageWithRenderColor:(UIColor *)color renderSize:(CGSize)size;

+ (UIImage *)opaqueImageWithRenderColor:(UIColor *)color renderSize:(CGSize)size;

+ (UIImage *)imageWithSize:(CGSize)renderSize CornerRadius:(float)radius fillColor:(UIColor *)fillColor StrokeColor:(UIColor *)strokeColor;

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius;

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                                   borderWidth:(CGFloat)borderWidth
                                   borderColor:(UIColor *)borderColor;

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                                       corners:(UIRectCorner)corners
                                   borderWidth:(CGFloat)borderWidth
                                   borderColor:(UIColor *)borderColor
                                borderLineJoin:(CGLineJoin)borderLineJoin;
+ (UIImage *)imageWithSize:(CGSize)size lineWidth:(CGFloat)lineWidth cornerRadius:(CGFloat)radius fillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor;

-(NSData*)jpegDataWithQuality:(float )quality Size:(int) size;
- (UIImage *)cutImage:(CGRect)rect;//给定区域裁剪
//等比例缩放
-(UIImage*)scaleToSize:(CGSize)size;

- (UIImage*) imageWithCornerRadius:(float)radius;

+ (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer;

//增加视频水印
-(UIImage *)addImageLogo:(NSString *)logoStr;


- (UIImage *)originalRenderingMode;
@end
