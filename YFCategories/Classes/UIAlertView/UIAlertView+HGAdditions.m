//
//  UIAlertView+WMAdditions.m
//  WithMe
//
//  Created by wypstone on 15/11/18.
//  Copyright © 2015年 conglai. All rights reserved.
//

#import "UIAlertView+HGAdditions.h"
#import <objc/runtime.h>


@implementation UIAlertView (HGAdditions)
static char *btnTitlesArrKey;
static char *clickBlockKey;

+ (instancetype)customAlertViewWithTitle:(NSString *)title
                                 message:(NSString *)message
                       cancelButtonTitle:(NSString *)cancelBtnTitle
                                   click:(void (^) (NSString *clickBtnTitle))clickBlock
                       otherButtonTitles:(NSString *)otherBtnTitles, ... NS_REQUIRES_NIL_TERMINATION {
    
    UIAlertView *customAlertView = [[UIAlertView alloc] initWithTitle:title
                                                              message:message
                                                             delegate:nil
                                                    cancelButtonTitle:cancelBtnTitle
                                                    otherButtonTitles: nil];
    customAlertView.delegate = (id<UIAlertViewDelegate>)customAlertView;
    
    NSMutableArray *btnTitlesArr = [NSMutableArray array];
    if(![XHTools isStringEmpty:cancelBtnTitle]){

        [btnTitlesArr addObject:cancelBtnTitle];
    }
    
    va_list args;
    va_start(args, otherBtnTitles);
    
    for (NSString *otherBtnTitle = otherBtnTitles; otherBtnTitle != nil; otherBtnTitle = va_arg(args,NSString*)) {
        
        [customAlertView addButtonWithTitle:otherBtnTitle];
        [btnTitlesArr addObject:otherBtnTitle];
    }
    
    va_end(args);
    
    if(clickBlock) {
        
        objc_setAssociatedObject(customAlertView, &clickBlockKey, clickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    objc_setAssociatedObject(customAlertView, &btnTitlesArrKey, btnTitlesArr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return customAlertView;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSMutableArray *btnTitlesArr = objc_getAssociatedObject(self , &btnTitlesArrKey);
    if (buttonIndex < btnTitlesArr.count) {
        
        NSString *clickBtnTitle = [btnTitlesArr objectAtIndex:buttonIndex];
        void (^clickBlock) (NSString *clickBtnTitle) = objc_getAssociatedObject(self, &clickBlockKey);
        
        if (clickBlock) {
            
            clickBlock(clickBtnTitle);
        }
    }
}
@end
