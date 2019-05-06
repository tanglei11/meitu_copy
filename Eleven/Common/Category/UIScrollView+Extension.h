//
//  UIScrollView+Extension.h
//  ZhangLOL
//
//  Created by mac on 17/4/6.
//  Copyright © 2017年 rengukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,UIScrollViewScrollDirection) {
    UIScrollViewScrollDirectionNone = 0, 
    UIScrollViewScrollDirectionUp   = 1 << 0,  // 1
    UIScrollViewScrollDirectionDown = 1 << 1,  // 10
    UIScrollViewScrollDirectionLeft = 1 << 2,  // 100
    UIScrollViewScrollDirectionRight= 1 << 3   // 1000
};

@interface UIScrollView (Extension)

@end
