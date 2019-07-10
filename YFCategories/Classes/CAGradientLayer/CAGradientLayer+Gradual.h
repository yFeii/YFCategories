//
//  CAGradientLayer+Gradual.h
//  360FI
//
//  Created by Jiansi on 2018/8/23.
//  Copyright © 2018年 Calvien. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSUInteger, CAGradientLayerDirection) {
    CAGradientLayerDirectionVertical,
    CAGradientLayerDirectionHorizontal,
};

@interface CAGradientLayer (Gradual)

+ (CAGradientLayer *)layerWithColors:(NSArray *)colors direction:(CAGradientLayerDirection)direction withFrame:(CGRect)frame;
@end
