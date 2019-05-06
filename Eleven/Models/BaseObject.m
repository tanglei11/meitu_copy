//
//  BaseObject.m
//  Eleven
//
//  Created by Peanut on 2019/1/29.
//  Copyright © 2019 coderyi. All rights reserved.
//

#import "BaseObject.h"

@implementation BaseObject

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //    NSLog(@"%@类缺少%@属性",NSStringFromClass([self class]),key);
}

@end
