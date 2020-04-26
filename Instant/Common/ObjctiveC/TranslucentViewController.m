//
//  TranslucentViewController.m
//  MyUtils
//
//  Created by apple on 2018/9/12.
//  Copyright © 2018年 diaoshihao. All rights reserved.
//

#import "TranslucentViewController.h"

@interface TranslucentViewController () <UIGestureRecognizerDelegate>

@end

@implementation TranslucentViewController

- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationOverFullScreen;
}

- (void)present {
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [self presenting:viewController];
}

- (void)presenting:(UIViewController *)presenting {
    [presenting presentViewController:self animated:self.animated completion:nil];
}

- (void)dismissTranslucent {
    [self dismissViewControllerAnimated:self.animated completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exitTranslucent:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
}

- (BOOL)customViewShouldReceiveTouch:(UITouch *)touch {
    if (self.refuseTapViews.count > 0) {
        for (UIView *view in self.refuseTapViews) {
            if ([view isKindOfClass:[UIView class]] && [touch.view isDescendantOfView:view]) {
                return NO;
            }
        }
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(nonnull UITouch *)touch {
    if (_contentView && [touch.view isDescendantOfView:_contentView]) {
        return NO;
    }
    if (self.refuseTapViews.count > 0) {
        return [self customViewShouldReceiveTouch:touch];
    }
    return YES;
}

- (void)exitTranslucent:(UITapGestureRecognizer *)tap {
    [self dismissTranslucent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - lazy load

- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_contentView];
    }
    return _contentView;
}

- (void)setAlpha:(CGFloat)alpha {
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:alpha];
}

@end
