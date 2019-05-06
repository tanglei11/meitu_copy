//
//  AVNetRequest.h
//  Eleven
//
//  Created by Peanut on 2019/1/28.
//  Copyright © 2019 coderyi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVNetRequest : NSObject

@property (nonatomic, strong) NSString *httpUrl;
@property (nonatomic, strong) NSString *httpMethod;
@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) id params;

@end

NS_ASSUME_NONNULL_END
