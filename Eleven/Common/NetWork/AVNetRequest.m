//
//  AVNetRequest.m
//  Eleven
//
//  Created by Peanut on 2019/1/28.
//  Copyright © 2019 coderyi. All rights reserved.
//

#import "AVNetRequest.h"

@implementation AVNetRequest

- (id)init
{
    self = [super init];
    if (self) {
        self.httpUrl = @"";
        self.method = @"";
        self.httpMethod = @"POST";
    }
    return self;
}

@end
