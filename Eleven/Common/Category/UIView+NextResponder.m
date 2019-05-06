//
//  UIView+NextResponder.m
//  StepCity
//
//  Created by 吴桐 on 16/3/28.
//  Copyright © 2016年 吴桐. All rights reserved.
//

#import "UIView+NextResponder.h"

@implementation UIView (NextResponder)

//获取响应者
- (UIViewController *)viewController
{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    
    return nil;
}

//获取响应者
//- (UITableView *)tableView
//{
//    UIResponder *next = [self nextResponder];
//    do {
//        if ([next isKindOfClass:[UITableView class]]) {
//            return (UITableView *)next;
//        }
//        next = [next nextResponder];
//    } while (next != nil);
//    
//    return nil;
//}

@end
