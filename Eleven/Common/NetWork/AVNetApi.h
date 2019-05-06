//
//  AVNetApi.h
//  Eleven
//
//  Created by Peanut on 2019/1/28.
//  Copyright © 2019 coderyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MJExtension.h"
#import "AVUserNetRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface AVNetApi : NSObject

+ (void)request:(AVNetRequest *)param files:(NSArray *)files success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue;

+ (void)request:(AVNetRequest *)param params:(NSDictionary *)params success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue;

+ (instancetype) sharedInstance;

@end

NS_ASSUME_NONNULL_END
