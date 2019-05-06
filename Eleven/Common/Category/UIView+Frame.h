//
//  UIView+KHFrame.h
//  新浪微博
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

- (UIViewController *)viewController;

@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;             
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGPoint origin;

@end
