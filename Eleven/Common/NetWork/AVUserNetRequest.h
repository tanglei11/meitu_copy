//
//  AVUserNetRequest.h
//  Eleven
//
//  Created by Peanut on 2019/1/28.
//  Copyright © 2019 coderyi. All rights reserved.
//

#import "AVNetRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface AVUserNetRequest : AVNetRequest

@end

//接口名    获取直播列表
//地址    /room/list
@interface AVNetApiMethodRoomListRequest : AVNetRequest

@end

//接口名    获取视频列表
//地址    /video/list
@interface AVNetApiMethodVideoListRequest : AVNetRequest

@property (nonatomic,strong) NSNumber *type;

@end

NS_ASSUME_NONNULL_END
