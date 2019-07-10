//
//  CAGradientLayer+Gradual.m
//  360FI
//
//  Created by Jiansi on 2018/8/23.
//  Copyright © 2018年 Calvien. All rights reserved.
//

#import "CAGradientLayer+Gradual.h"

@implementation CAGradientLayer (Gradual)
+ (CAGradientLayer *)layerWithColors:(NSArray *)colors direction:(CAGradientLayerDirection)direction withFrame:(CGRect)frame {

    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.colors = colors;
    layer.frame = frame;
    layer.locations = @[@0,@1];
    if (direction == CAGradientLayerDirectionVertical) {
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint = CGPointMake(0, 1);
    }else{
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint = CGPointMake(1, 0);
    }
    return layer;
}
@end
