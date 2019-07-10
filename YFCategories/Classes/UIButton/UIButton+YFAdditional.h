//
//  UIButton+YFAdditional.h
//  sqt-ios
//
//  Created by yFeii on 2019/7/10.
//  Copyright © 2019 yFeii. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, MKButtonEdgeInsetsStyle) {
    MKButtonEdgeInsetsStyleTop, // image在上，label在下
    MKButtonEdgeInsetsStyleLeft, // image在左，label在右
    MKButtonEdgeInsetsStyleBottom, // image在下，label在上
    MKButtonEdgeInsetsStyleRight // image在右，label在左
};


@interface UIButton (YFAdditional)

@end

@interface UIButton (ImageTitleSpacing)

@end

NS_ASSUME_NONNULL_END
