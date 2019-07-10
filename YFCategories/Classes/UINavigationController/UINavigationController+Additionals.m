
//
//  UINavigationController+Additionals.m
//  360FI
//
//  Created by Jiansi on 2018/8/22.
//  Copyright © 2018年 Calvien. All rights reserved.
//

#import "UINavigationController+Additionals.h"


@implementation UINavigationController (Additionals)


+ (void)load {
    
    swizzled_Method([self class], @selector(pushViewController:animated:), @selector(fi_pushViewController:animated:));
}

- (void)fi_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count>=1) {

        viewController.hidesBottomBarWhenPushed = YES;
    }
    [self fi_pushViewController:viewController animated:animated];
}
@end
