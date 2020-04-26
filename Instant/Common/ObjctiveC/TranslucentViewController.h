//
//  TranslucentViewController.h
//  MyUtils
//
//  Created by apple on 2018/9/12.
//  Copyright © 2018年 diaoshihao. All rights reserved.
//

//全屏半透明

#import <UIKit/UIKit.h>

@interface TranslucentViewController : UIViewController

@property (nonatomic, assign) CGFloat alpha; // default is 0.3

@property (nonatomic, assign) BOOL animated; // default is NO

@property (nonatomic, strong) UIView *contentView; //lazy load, if it used, won't dismiss when tap the contentView

// default is nil, won't dismiss when tap these view, you may need add your custom contentView while not using the provided contentView
@property (nonatomic, strong) NSArray *refuseTapViews;

// present by key window's root view controller
- (void)present;

- (void)presenting:(UIViewController *)presenting;

- (void)dismissTranslucent;

@end
