//
//  RoomListObject.m
//  Eleven
//
//  Created by Peanut on 2019/1/29.
//  Copyright © 2019 coderyi. All rights reserved.
//

#import "RoomListObject.h"

@implementation RoomListObject

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"room_id"];
    }
    [super setValue:value forKey:key];
}

@end
