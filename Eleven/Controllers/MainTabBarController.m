//
//  MenuTableViewController.m
//  Eleven
//
//  Created by coderyi on 15/8/18.
//  Copyright (c) 2015年 coderyi. All rights reserved.
//

#import "MainTabBarController.h"
#import "MovieNavigationController.h"
#import "HomePageController.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>

@end

@implementation MainTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self;
    
    [self setUpAllChildVc];
    
    self.tabBar.backgroundColor =[UIColor clearColor];
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar setShadowImage:[UIImage new]];
    
    self.tabBarController.tabBar.translucent = YES;
}

-(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)setUpAllChildVc
{
    
    HomePageController *homePageController = [[HomePageController alloc] init];
    UIImage *homeImage = [ToolClass imageWithIcon:[NSString changeISO88591StringToUnicodeString:@"&#xe6b8;"] inFont:ICONFONT size:25 color:[UIColor whiteColor]];
    UIImage *homeSelectImage = [ToolClass imageWithIcon:[NSString changeISO88591StringToUnicodeString:@"&#xe6bb;"] inFont:ICONFONT size:25 color:[UIColor whiteColor]];
    
    [self setUpOneChildVcWithVc:homePageController Image:homeImage selectedImage:homeSelectImage title:@"首页"];
}

#pragma mark - 初始化设置tabBar上面单个按钮的方法

/**
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    MovieNavigationController *nav = [[MovieNavigationController alloc] initWithRootViewController:Vc];

    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = image;

    Vc.tabBarItem.selectedImage = selectedImage;

    Vc.tabBarItem.title = title;

    //    Vc.tabBarItem.imageInsets = UIEdgeInsetsMake(-5, 0, 0, 0);

    Vc.navigationItem.title = title;

    Vc.tabBarItem.enabled = YES;

    // 设置tabbar的文字样式
    NSMutableDictionary *normalTextAttrs = [NSMutableDictionary dictionary];
    normalTextAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [nav.tabBarItem setTitleTextAttributes:normalTextAttrs forState:UIControlStateNormal];
    [nav.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    [nav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    [self addChildViewController:nav];
}

@end
