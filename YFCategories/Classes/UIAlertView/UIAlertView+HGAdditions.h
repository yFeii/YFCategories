//
//  UIAlertView+WMAdditions.h
//  WithMe
//
//  Created by wypstone on 15/11/18.
//  Copyright © 2015年 conglai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (HGAdditions)

+ (instancetype)customAlertViewWithTitle:(NSString *)title
                                 message:(NSString *)message
                       cancelButtonTitle:(NSString *)cancelBtnTitle
                                   click:(void (^) (NSString *clickBtnTitle))clickBlock
                       otherButtonTitles:(NSString *)otherBtnTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
