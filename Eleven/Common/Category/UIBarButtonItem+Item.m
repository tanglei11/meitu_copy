//
//  UIBarButtonItem+KHBarButtonItem.m
//  新浪微博
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIBarButtonItem+Item.h"
//#import "IconButton.h"

@implementation UIBarButtonItem (Item)
/**
 *  创建一个item
 *
 *  @param action      点击item后调用的方法
 *  @param imageNormal 默认图片
 *  @param imageHighed 高亮图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target Action:(SEL)action imageNormal:(UIImage *)imageNormal imageHighed:(UIImage *)imageHighed
{
    UIButton *btn = [[UIButton alloc]init];
    //监听按钮点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //设置图片
    [btn setBackgroundImage:imageNormal forState:UIControlStateNormal];
    [btn setBackgroundImage:imageHighed forState:UIControlStateHighlighted];
    //设置尺寸
    btn.size = CGSizeMake(22, 22);
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target Action:(SEL)action imageNormal:(UIImage *)imageNormal size:(CGSize)size
{
    UIButton *btn = [[UIButton alloc]init];
    //监听按钮点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //设置图片
    [btn setBackgroundImage:imageNormal forState:UIControlStateNormal];
    //设置尺寸
    btn.size = size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target Action:(SEL)action title:(NSString *)title titleColor:(UIColor *)titleColor
{
    UIButton *btn = [[UIButton alloc]init];
    //监听按钮点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    CGSize size = [title sizeWithFont:btn.titleLabel.font];
    btn.size = size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target Action:(SEL)action imageName:(NSString *)imageName imageColor:(UIColor *)imageColor
{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    UIImage *image = [ToolClass imageWithIcon:[NSString changeISO88591StringToUnicodeString:imageName] inFont:ICONFONT size:22 color:imageColor];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
@end
