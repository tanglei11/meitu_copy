//
//  AVUserNetRequest.m
//  Eleven
//
//  Created by Peanut on 2019/1/28.
//  Copyright © 2019 coderyi. All rights reserved.
//

#import "AVUserNetRequest.h"

@implementation AVUserNetRequest

@end

//接口名    获取直播列表
//地址    /room/list
@implementation AVNetApiMethodRoomListRequest
- (id)init
{
    self = [super init];
    if (self) {
        self.httpUrl = DEMAIN;
        self.method = @"room/list";
    }
    return self;
}

@end

//接口名    获取视频列表
//地址    /video/list
@implementation AVNetApiMethodVideoListRequest
- (id)init
{
    self = [super init];
    if (self) {
        self.httpUrl = DEMAIN;
        self.method = @"video/list";
    }
    return self;
}

@end
