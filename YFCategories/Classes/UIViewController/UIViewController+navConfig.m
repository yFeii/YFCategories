//
//  UIViewController+navConfig.m
//  360FI
//
//  Created by Jiansi on 2018/8/18.
//  Copyright © 2018年 Calvien. All rights reserved.
//

#import "UIViewController+navConfig.h"
#import <objc/message.h>
#import <UIViewController+CYLTabBarControllerExtention.h>

@implementation UIViewController (navConfig)

- (void)goBackWithAnimation:(BOOL)animation {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.navigationController.childViewControllers.count>1){
            
            [self.navigationController popViewControllerAnimated:animation];
        }else{
            [self dismissViewControllerAnimated:animation completion:NULL];
        }
    });
}

- (void)setupDefalutBack{
    
    [self setBackBtn:@"nav_btn_back" tintColor:nil];
}

- (void)setupDefalutBackTintColor:(UIColor *)tintColor{
    
    if (tintColor) {
        self.navigationItem.leftBarButtonItem.tintColor = tintColor;
    }else{
        self.navigationItem.leftBarButtonItem.tintColor = UIColorHexMake(@"#444444");
    }
}

- (void)setBackBtn:(NSString *)imageName tintColor:(UIColor *)tintColor{
    
    if (!self.presentingViewController && self.navigationController.viewControllers.count<=1) return;
    UIImage *backImg = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImg style:UIBarButtonItemStylePlain target:self action:@selector(defaultBack)];
    if (tintColor) {
        self.navigationItem.leftBarButtonItem.tintColor = tintColor;
    }else{
        self.navigationItem.leftBarButtonItem.tintColor = UIColorHexMake(@"#444444");
    }
}
- (void)defaultBack {
    
    SEL customBack = NSSelectorFromString(@"customBack");
    if ([self respondsToSelector:customBack]) {
        ((void(*)(id, SEL))objc_msgSend)(self, customBack);
    }else{
        
        [self goBackWithAnimation:YES];
    }
}

- (void)setDelayBack:(NSTimeInterval)time{
    
    [self performSelector:@selector(defaultBack) withObject:nil afterDelay:time];
}

- (void)presentVC:(UIViewController *)vc needNav:(BOOL)isNeed animated:(BOOL)flag completion:(void (^)(void))completion {
    
    if (isNeed) {
        [self presentVC:vc animated:flag completion:completion];
    }else{
        [self presentViewController:vc animated:flag completion:completion];
    }
}


- (void)presentVC:(UIViewController *)vc animated:(BOOL)flag completion:(void (^)(void))completion {
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:flag completion:completion];
}

- (void)popToHomePage {

    dispatch_async_mainQueue(^{
        
        [self rootNavigationControllerSubViewControllerPopToFirstPage];
        UITabBarController *tabVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        [tabVc cyl_popSelectTabBarChildViewControllerAtIndex:0 animated:YES];
    });
}

- (void)popToMiningPage {
    

}

- (void)popToVideoPage {
  
}

- (void)popToMinePage {
    
   
}

- (void)rootNavigationControllerSubViewControllerPopToFirstPage{
    
    UITabBarController *tabVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    NSInteger index =  tabVc.selectedIndex;
    if (index < tabVc.viewControllers.count) {
        UINavigationController *nav = (UINavigationController *)tabVc.viewControllers[index];
        [nav popToRootViewControllerAnimated:NO];
    }
}
@end
