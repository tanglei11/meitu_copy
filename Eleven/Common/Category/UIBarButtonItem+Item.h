
//
//  UIBarButtonItem+KHBarButtonItem.h
//  新浪微博
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)
+ (UIBarButtonItem *)itemWithTarget:(id)target Action:(SEL)action imageNormal:(UIImage *)imageNormal imageHighed:(UIImage *)imageHighed;
+ (UIBarButtonItem *)itemWithTarget:(id)target Action:(SEL)action imageNormal:(UIImage *)imageNormal size:(CGSize)size;
+ (UIBarButtonItem *)itemWithTarget:(id)target Action:(SEL)action title:(NSString *)title titleColor:(UIColor *)titleColor;
+ (UIBarButtonItem *)itemWithTarget:(id)target Action:(SEL)action imageName:(NSString *)imageName imageColor:(UIColor *)imageColor;
@end
