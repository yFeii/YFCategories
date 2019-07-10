//
//  UIImage+WMAdditions.m
//  withMe
//
//  Created by lorabit on 15/12/1.
//  Copyright © 2015年 从来网络. All rights reserved.
//

#import "UIImage+WMAdditions.h"


@implementation UIImage (WMAdditions)


CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};

+ (UIImage *)imageWithShadowSize:(CGSize)shadowSize blur:(float)blur andColor:(UIColor *)color{

    CGContextRef drawRef = UIGraphicsGetCurrentContext();
    CGContextSetShadowWithColor(drawRef, shadowSize, blur, color.CGColor);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{
  // calculate the size of the rotated view's containing box for our drawing space
  UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
  CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
  rotatedViewBox.transform = t;
  CGSize rotatedSize = rotatedViewBox.frame.size;
  
  // Create the bitmap context
  UIGraphicsBeginImageContext(rotatedSize);
  CGContextRef bitmap = UIGraphicsGetCurrentContext();
  
  // Move the origin to the middle of the image so we will rotate and scale around the center.
  CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
  
  //   // Rotate the image context
  CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
  
  // Now, draw the rotated/scaled image into the context
  CGContextScaleCTM(bitmap, 1.0, -1.0);
  CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
  
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
  
}
+ (UIImage *)screenShoot:(UIView *)view {
  
  UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.);
  [view.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

+ (UIImage *)imageWithRenderColor:(UIColor *)color renderSize:(CGSize)size {
  
  UIImage *image = nil;
  UIGraphicsBeginImageContextWithOptions(size, NO, 0.);
  [color setFill];
  UIRectFill(CGRectMake(0, 0, size.width, size.height));
  image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

+ (UIImage *)opaqueImageWithRenderColor:(UIColor *)color renderSize:(CGSize)size {
  UIImage *image = nil;
  UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
  [color setFill];
  UIRectFill(CGRectMake(0, 0, size.width, size.height));
  image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
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

+ (UIImage *)imageWithSize:(CGSize)renderSize CornerRadius:(float)radius fillColor:(UIColor *)fillColor StrokeColor:(UIColor *)strokeColor {
  UIGraphicsBeginImageContextWithOptions(renderSize, NO, 0.);
  CGContextRef drawCtx = UIGraphicsGetCurrentContext();
  CGPathRef borderPath = CGPathCreateWithRoundedRect((CGRect){CGPointZero,renderSize}, radius, radius, NULL);
  CGContextAddPath(drawCtx, borderPath);
  if (strokeColor) {
    [strokeColor setStroke];
    CGContextDrawPath(drawCtx, kCGPathStroke);
  }
  if (fillColor) {
    [fillColor setFill];
    CGContextDrawPath(drawCtx, kCGPathFill);
  }
  UIImage *resImage = [UIGraphicsGetImageFromCurrentImageContext() resizableImageWithCapInsets:UIEdgeInsetsMake(radius, radius, radius, radius)];
  UIGraphicsEndImageContext();
  CGPathRelease(borderPath);
  
  return resImage;
}

-(UIImage *)imageWithCornerRadius:(float)radius{
  // 开始图形上下文
  UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
  
  // 获得图形上下文
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  // 设置一个范围
  CGRect innerRect = CGRectMake(0, 0, self.size.width, self.size.height);
  // 根据一个rect创建一个椭圆
  
  CGContextMoveToPoint(ctx, radius, 0);

  CGContextAddLineToPoint(ctx, innerRect.size.width - radius,0);
  CGContextAddArc(ctx, innerRect.size.width - radius, radius, radius, -0.5 *M_PI,0.0, 0);

  CGContextAddLineToPoint(ctx, innerRect.size.width, innerRect.size.height - radius);
  CGContextAddArc(ctx, innerRect.size.width - radius, innerRect.size.height - radius, radius,0.0,0.5 * M_PI,0);


  CGContextAddLineToPoint(ctx, radius, innerRect.size.height);
  CGContextAddArc(ctx, radius, innerRect.size.height - radius, radius,0.5 *M_PI, M_PI,0);

  CGContextAddLineToPoint(ctx, 0, radius);
  CGContextAddArc(ctx, radius, radius, radius,M_PI,1.5 * M_PI,0);

// 闭合路径
CGContextClosePath(ctx);
  // 裁剪
  CGContextClip(ctx);
  // 将原照片画到图形上下文
  [self drawInRect:innerRect];
  // 从上下文上获取剪裁后的照片
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  
  // 关闭上下文
  UIGraphicsEndImageContext();
  
  return newImage;
}

+ (UIImage *)imageWithSize:(CGSize)size lineWidth:(CGFloat)lineWidth cornerRadius:(CGFloat)radius fillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor {
  
  CGRect circleRect = CGRectMake(lineWidth , lineWidth, size.width-lineWidth*2, size.height-lineWidth*2);
  UIGraphicsBeginImageContextWithOptions(size, NO, 0.);
  CGContextRef drawCtx = UIGraphicsGetCurrentContext();
  CGPathRef renderPath = CGPathCreateWithRoundedRect(circleRect, radius, radius, NULL);
  CGContextAddPath(drawCtx, renderPath);
  
  if (strokeColor && fillColor) {
    [fillColor setFill];
    [strokeColor setStroke];
    
    CGContextDrawPath(drawCtx, kCGPathFillStroke);
  } else {
    if (fillColor) {
      [fillColor setFill];
      CGContextDrawPath(drawCtx, kCGPathFill);
    } else if (strokeColor) {
      [strokeColor setStroke];
      CGContextDrawPath(drawCtx, kCGPathStroke);
    }
  }
  
  UIImage *resImage = [UIGraphicsGetImageFromCurrentImageContext() resizableImageWithCapInsets:UIEdgeInsetsMake(lineWidth+radius, lineWidth+radius, lineWidth+radius, lineWidth+radius)];
  UIGraphicsEndImageContext();
  CGPathRelease(renderPath);
  
  return resImage;
}

-(NSData*)jpegDataWithQuality:(float )quality Size:(int) size{
  NSData* data;
  if(size == 0){
    data = UIImageJPEGRepresentation(self, quality);
    return data;
  }else{
    CGSize  newSize;
    if(self.size.height>self.size.width){
      newSize = CGSizeMake(size, size/self.size.width*self.size.height);
    }else{
      newSize = CGSizeMake(size/self.size.height*self.size.width, size);
    }
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    data = UIImageJPEGRepresentation(newImage, quality);
    return data;
  }
}


- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius {
    return [self imageByRoundCornerRadius:radius borderWidth:0 borderColor:nil];
}

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor {
    return [self imageByRoundCornerRadius:radius
                                  corners:UIRectCornerAllCorners
                              borderWidth:borderWidth
                              borderColor:borderColor
                           borderLineJoin:kCGLineJoinMiter];
}

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                              corners:(UIRectCorner)corners
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
                       borderLineJoin:(CGLineJoin)borderLineJoin {
    
    if (corners != UIRectCornerAllCorners) {
        UIRectCorner tmp = 0;
        if (corners & UIRectCornerTopLeft) tmp |= UIRectCornerBottomLeft;
        if (corners & UIRectCornerTopRight) tmp |= UIRectCornerBottomRight;
        if (corners & UIRectCornerBottomLeft) tmp |= UIRectCornerTopLeft;
        if (corners & UIRectCornerBottomRight) tmp |= UIRectCornerTopRight;
        corners = tmp;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -rect.size.height);
    
    CGFloat minSize = MIN(self.size.width, self.size.height);
    if (borderWidth < minSize / 2) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:CGSizeMake(radius, borderWidth)];
        [path closePath];
        
        CGContextSaveGState(context);
        [path addClip];
        CGContextDrawImage(context, rect, self.CGImage);
        CGContextRestoreGState(context);
    }
    
    if (borderColor && borderWidth < minSize / 2 && borderWidth > 0) {
        CGFloat strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale;
        CGRect strokeRect = CGRectInset(rect, strokeInset, strokeInset);
        CGFloat strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:strokeRect byRoundingCorners:corners cornerRadii:CGSizeMake(strokeRadius, borderWidth)];
        [path closePath];
        
        path.lineWidth = borderWidth;
        path.lineJoinStyle = borderLineJoin;
        [borderColor setStroke];
        [path stroke];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (UIImage *)cutImage:(CGRect)rect
{
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}


//等比例缩放
-(UIImage*)scaleToSize:(CGSize)size
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}


+ (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    // Get a CMSampleBuffer's Core Video image buffer for the media data
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    // Get the number of bytes per row for the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // Get the pixel buffer width and height
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Create a bitmap graphics context with the sample buffer data
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    // Create a Quartz image from the pixel data in the bitmap graphics context
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    // Unlock the pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    // Free up the context and color space
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // Create an image object from the Quartz image
    //UIImage *image = [UIImage imageWithCGImage:quartzImage];
    UIImage *image = [UIImage imageWithCGImage:quartzImage scale:1.0f orientation:UIImageOrientationRight];
    
    // Release the Quartz image
    CGImageRelease(quartzImage);
    
    return (image);
}

-(UIImage *)addImageLogo:(NSString *)logoStr
{
//       UIImage * images = [self videoImage];
        UIImage * videoIcon = [UIImage imageNamed:logoStr];
//    UIImageView * imageView = [[UIImageView alloc] initWithImage:self];
////    UIView* ba = [[UIView alloc] initWithFrame:imageView.bounds];
////    ba.backgroundColor = [UIColor redColor];
////    [imageView addSubview:ba];
//    UIImageView * logo =  [[UIImageView alloc] initWithImage:videoIcon];
//    logo.frame = CGRectMake((imageView.width - logo.width) / 2, (imageView.height - logo.height) / 2, logo.width, logo.height);
//    [imageView addSubview:logo];
//    NSLog(@"111");
//    return [self imageWithUIView:imageView];
        return [self addImageLogo:self text:videoIcon];
}

- (UIImage*) imageWithUIView:(UIView*) view{
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}
//增加视频水印
-(UIImage *)addImageLogo:(UIImage *)img text:(UIImage *)logo
{
    
    int w = img.size.width;
    int h = img.size.height;
    CGRect rect = CGRectMake((w - w / 2) / 2, (h - h / 2) / 2, w / 2, h / 2);
    UIGraphicsBeginImageContext(img.size);
    [img drawInRect:CGRectMake(0, 0, w, h)];
    [logo drawInRect:rect];
    
    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return aimg;
    //get image width and height
//    int w = img.size.width;
//    int h = img.size.height;
//    int logoWidth = logo.size.width;
//    int logoHeight = logo.size.height;
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    //create a graphic context with CGBitmapContextCreate
//    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
//    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
//    CGContextDrawImage(context, CGRectMake(10, 30, logoWidth, logoHeight), [logo CGImage]);
//    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
//    CGContextRelease(context);
//    CGColorSpaceRelease(colorSpace);
//    return [UIImage imageWithCGImage:imageMasked];
    //  CGContextDrawImage(contextRef, CGRectMake(100, 50, 200, 80), [smallImg CGImage]);
}

- (UIImage *)originalRenderingMode {
    
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
