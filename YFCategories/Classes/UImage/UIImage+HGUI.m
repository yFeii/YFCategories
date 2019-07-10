//
//  UIImage+HGUI.m
//  HGOrderingMerchant
//
//  Created by Tianbiao Wang on 17/9/21.
//  Copyright © 2017年 Tianbiao Wang. All rights reserved.
//

#import "UIImage+HGUI.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (HGUI)
+ (UIImage *)imageFromLayer:(CALayer *)layer
{
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, layer.opaque, 0);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

- (UIImage *)scaleFitToSize:(CGSize)size {
    
    CGFloat scaleRate = MIN(size.width / self.size.width, size.height / self.size.height);
    return [self scaleImageToSize:size rate:scaleRate];
}

- (UIImage *)scaleFillToSize:(CGSize)size {
    
    CGFloat scaleRate = MAX(size.width / self.size.width, size.height / self.size.height);
    return [self scaleImageToSize:size rate:scaleRate];
}

+ (UIImage*)scaleDown:(UIImage*)image withSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContextWithOptions(newSize, YES, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

- (UIImage *)scaleImageToSize:(CGSize)size rate:(CGFloat)scaleRate {
    
    UIImage *image = nil;
    CGSize renderSize = CGSizeMake(self.size.width * scaleRate, self.size.height * scaleRate);
    CGFloat startX = size.width * 0.5 - renderSize.width * 0.5;
    CGFloat startY = size.height * 0.5 - renderSize.height * 0.5;
    
    CGImageAlphaInfo info = CGImageGetAlphaInfo(self.CGImage);
    BOOL opaque = (info == kCGImageAlphaNone) || (info == kCGImageAlphaNoneSkipFirst) || (info == kCGImageAlphaNoneSkipLast);
    
    UIGraphicsBeginImageContextWithOptions(size, opaque, 0.);
    UIColor *backgroundColor = opaque ? [UIColor whiteColor] : [UIColor clearColor];
    [backgroundColor setFill];
    UIRectFillUsingBlendMode(CGRectMake(0, 0, size.width, size.height), kCGBlendModeNormal);
    
    [self drawInRect:CGRectMake(startX, startY, renderSize.width, renderSize.height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur
{
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    NSInteger boxSize = (NSInteger)(blur * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer;
    vImage_Buffer outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * inBuffer.height);
    if (pixelBuffer == NULL) {
        NSLog(@"No pixelbuffer");
    }
    outBuffer.data = pixelBuffer;
    outBuffer.width = inBuffer.width;
    outBuffer.height = inBuffer.height;
    outBuffer.rowBytes = inBuffer.rowBytes;
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, kCGImageAlphaPremultipliedLast);
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    return returnImage;
}


- (UIImage *)imageWithColor:(UIColor *)color {
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
