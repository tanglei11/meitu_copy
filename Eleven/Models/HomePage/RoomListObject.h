//
//  RoomListObject.h
//  Eleven
//
//  Created by Peanut on 2019/1/29.
//  Copyright © 2019 coderyi. All rights reserved.
//

#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface RoomListObject : BaseObject

@property (nonatomic,copy) NSString *cover;
@property (nonatomic,copy) NSString *created_at;
@property (nonatomic,copy) NSString *from;
@property (nonatomic,copy) NSString *room_id;
@property (nonatomic,copy) NSString *is_vip;
@property (nonatomic,copy) NSString *live_id;
@property (nonatomic,copy) NSString *live_src;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *updated_at;

@property (nonatomic,copy) NSString *video_src;

@end

NS_ASSUME_NONNULL_END
