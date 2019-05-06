//
//  UIView+KHFrame.m
//  新浪微博
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (UIViewController *)viewController {
    UIResponder *next = self;
    do {
        next = next.nextResponder;
    } while (![next isKindOfClass:[UIViewController class]]);
    return (UIViewController *)next;
}

//set方法
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
//get方法
- (CGFloat)x
{
    return self.frame.origin.x;
}
- (CGFloat)y
{
    return self.frame.origin.y;
}
- (CGFloat)centerX
{
    return self.center.x;
}
- (CGFloat)centerY
{
    return self.center.y;
}
- (CGFloat)width
{
    return self.frame.size.width;
}
- (CGFloat)height
{
    return self.frame.size.height;
}
- (CGSize)size
{
    return self.frame.size;
}
- (CGPoint)origin
{
    return self.frame.origin;
}
@end
