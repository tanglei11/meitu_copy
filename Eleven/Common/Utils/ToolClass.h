//
//  ToolClass.h
//  Eleven
//
//  Created by Peanut on 2019/1/28.
//  Copyright © 2019 coderyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToolClass : NSObject

//iconfont 转化 image
+ (UIImage *)imageWithIcon:(NSString*)iconCode inFont:(NSString*)fontName size:(NSUInteger)size color:(UIColor*)color;

@end

NS_ASSUME_NONNULL_END
