//
//  AVNetApi.m
//  Eleven
//
//  Created by Peanut on 2019/1/28.
//  Copyright © 2019 coderyi. All rights reserved.
//

#import "AVNetApi.h"

@implementation AVNetApi

+ (void)request:(AVNetRequest *)param files:(NSArray *)files success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue
{
    AVNetRequest *request = [[AVNetRequest alloc]init];
    request.method = param.method;
    request.httpMethod = param.httpMethod;
    request.httpUrl = param.httpUrl;
    param.method = nil;//这步一定要操作
    param.httpMethod = nil;//这步一定要操作
    param.httpUrl = nil;//这步一定要操作
    request.params = param.mj_keyValues;
    
    if ( [request.httpMethod isEqualToString:@"GET"]) {
        [AVNetApi GET_request:request success:success failure:failue];
    }else if ( [request.httpMethod isEqualToString:@"POST"] ) {
        [AVNetApi POST_request:request success:success failure:failue];
    }else if ( [request.httpMethod isEqualToString:@"PUT"] ) {
        [AVNetApi PUT_request:request success:success failure:failue];
    }else if ( [request.httpMethod isEqualToString:@"DELETE"] ) {
        [AVNetApi DELETE_request:request success:success failure:failue];
    }else if ([request.httpMethod isEqualToString:@"FILE"]){
        [AVNetApi POST_request:request files:files success:success failure:failue];
    }else if ([request.httpMethod isEqualToString:@"MULTI_FILE"]){
        [AVNetApi POST_request:request multiFiles:files success:success failure:failue];
    }
}

+ (void)request:(AVNetRequest *)param params:(NSDictionary *)params success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue
{
    AVNetRequest *request = [[AVNetRequest alloc]init];
    request.method = param.method;
    request.httpMethod = param.httpMethod;
    request.httpUrl = param.httpUrl;
    param.method = nil;//这步一定要操作
    param.httpMethod = nil;//这步一定要操作
    param.httpUrl = nil;//这步一定要操作
    request.params = param.mj_keyValues;
    
    [AVNetApi POST_request:request params:params success:success failure:failue];
}

+ (void)GET_request:(AVNetRequest *)request success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue
{
    // 1、创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2、数据反序列化（因为在进行请求服务器之前会对参数进行一次参数序列化）
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plian"];
    NSString *httpUrl = request.httpUrl;
    NSString *URLString = [NSString stringWithFormat:@"%@/%@", httpUrl , request.method];
    NSLog(@"urlSTRING%@",URLString);
    //    SkNetRequest *obj = request.params;
    
    // 3、开始请求
    [manager GET:URLString parameters:request.params progress:^(NSProgress *_Nonnull uploadProgress) {
        // 上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        //解析数据
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success) success(json);
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        if (failue) failue(error);
    }];
    
}

+ (void)POST_request:(AVNetRequest *)request success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue
{
    // 1、创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2、数据反序列化（因为在进行请求服务器之前会对参数进行一次参数序列化）
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plian"];
    NSString *httpUrl = request.httpUrl;
    NSString *URLString = [NSString stringWithFormat:@"%@/%@", httpUrl , request.method];
    NSLog(@"urlSTRING%@",URLString);
    //    SkNetRequest *obj = request.params;
    
    // 3、开始请求
    [manager POST:URLString parameters:request.params progress:^(NSProgress *_Nonnull uploadProgress) {
        // 上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        //解析数据
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success) success(json);
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        if (failue) failue(error);
    }];
}

+ (void)POST_request:(AVNetRequest *)request files:(NSArray *)files success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue
{
    // 1、创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2、数据反序列化（因为在进行请求服务器之前会对参数进行一次参数序列化）
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plian"];
    NSString *httpUrl = request.httpUrl;
    NSString *URLString = [NSString stringWithFormat:@"%@/%@", httpUrl , request.method];
    
    //    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    request.params = [request.params mutableCopy];
    for (NSDictionary *dict in files) {
        if (![dict[@"fileValue"] isKindOfClass:[UIImage class]]) {
            [request.params setValue:dict[@"fileValue"] forKey:dict[@"fileKey"]];
        }
    }
    //    request.params = dic;
    
    // 3、开始请求
    [manager POST:URLString parameters:request.params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        formatter.dateFormat = @"yyyyMMddHHmmss";
        
        NSString *str = [formatter stringFromDate:[NSDate date]];
        for (NSDictionary *dict in files) {
            if ([dict[@"fileValue"] isKindOfClass:[UIImage class]]) {
                NSData *data = UIImageJPEGRepresentation(dict[@"fileValue"],0.5);
                NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
                [formData appendPartWithFileData:data name:dict[@"fileKey"] fileName:fileName mimeType:@"image/jpg"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 上传进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //解析数据
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success) success(json);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failue) failue(error);
    }];
}

+ (void)POST_request:(AVNetRequest *)request multiFiles:(NSArray *)files success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue
{
    // 1、创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2、数据反序列化（因为在进行请求服务器之前会对参数进行一次参数序列化）
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plian"];
    NSString *httpUrl = request.httpUrl;
    NSString *URLString = [NSString stringWithFormat:@"%@/%@", httpUrl , request.method];
    
    // 3、开始请求
    [manager POST:URLString parameters:request.params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        formatter.dateFormat = @"yyyyMMddHHmmss";
        
        NSString *str = [formatter stringFromDate:[NSDate date]];
        
        NSDictionary *dict = files[0];
        for (id obj in dict[@"fileValue"]) {
            if ([obj isKindOfClass:[UIImage class]]) {
                NSData *data = UIImageJPEGRepresentation(obj,0.5);
                NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
                [formData appendPartWithFileData:data name:dict[@"fileKey"] fileName:fileName mimeType:@"image/jpg"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 上传进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //解析数据
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success) success(json);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failue) failue(error);
    }];
}

+ (void)POST_request:(AVNetRequest *)request params:(NSDictionary *)params success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue
{
    // 1、创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2、数据反序列化（因为在进行请求服务器之前会对参数进行一次参数序列化）
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plian"];
    NSString *httpUrl = request.httpUrl;
    NSString *URLString = [NSString stringWithFormat:@"%@/%@", httpUrl , request.method];
    NSLog(@"urlSTRING%@",URLString);
    [manager POST:URLString parameters:params progress:^(NSProgress *_Nonnull uploadProgress) {
        // 上传进度
        
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        //解析数据
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success) success(json);
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        if (failue) failue(error);
    }];
}

+ (void)PUT_request:(AVNetRequest *)request success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue
{
    
}

+ (void)DELETE_request:(AVNetRequest *)request success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failue
{
}

+ (instancetype)sharedInstance
{
    NSString *className = [NSString stringWithFormat:@"%@", [self class] ];
    Class class = NSClassFromString( className );
    static dispatch_once_t once;
    static id singleton;
    dispatch_once(&once, ^ {
        singleton = [[class alloc] init];
    });
    return singleton;
}

@end
