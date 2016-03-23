//
//  AnRequest.m
//  CreditBank
//
//  Created by Eric on 15/4/9.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "AnRequest.h"
#import "PrefixHeader.pch"
#import "NSDictionary+Expand.h"
#import "NetWorkTools.h"

@interface AnRequest()
@property(nonatomic, strong) AFHTTPRequestOperationManager *manager;
@end

@implementation AnRequest

/**
 *  懒加载manager
 *
 *  @return <#return value description#>
 */
- (AFHTTPRequestOperationManager *)manager {
    
    if (_manager == nil) {
        _manager = [AFHTTPRequestOperationManager manager];
        
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        // 设置超时时间
        _manager.requestSerializer.timeoutInterval = 10;
        
        // 设置解析类型
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    }
    return _manager;
}

/**
 *  开始网络请求的状态
 */
- (void)startNetworkActivity {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

/**
 *  关闭网络请求的状态
 */
- (void)stopNetworkActivity {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

/**
 *  post 请求
 *
 *  @param url        请求的URL
 *  @param paramsDic  请求的参数
 *  @param succBlock  数据正常回调
 *  @param errorBlock 数据错误回调
 *  @param failBlock  失败错误回调
 */
- (void)post:(NSString *)url params:(NSDictionary *)paramsDic successBlock:(Success)succBlock errorBlock:(Error)errorBlock failBlock:(Fail)failBlock {
    
    // 网络被禁用
    if ([NetWorkTools isDisabledNetWork]) {
        return;
    }
    
    // 网络请求开始
    [self startNetworkActivity];
    
    [self.manager POST:[self httpBindUrl:url] parameters:paramsDic success: ^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 网络请求结束
        [self stopNetworkActivity];

        NSString *status = [responseObject objectForKey:@"status"];
        
        if (![status isEqualToString: @"error"]) {
            // 数据正常
            succBlock(operation,responseObject);
        } else {
            // 错误处理
            errorBlock(operation,responseObject);
            ANLog(@"%@", [responseObject toNSString]);
        }
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        // 网络请求结束
        [self stopNetworkActivity];
        
        failBlock(operation,error);
        ANLog( @"接口错误信息: %@" , error);
        ANLog( @"接口原装数据: %@" , operation.responseString);
    }];
}

/**
 *  post 请求
 *
 *  @param url        请求的URL
 *  @param paramsDic  请求的参数
 *  @param succBlock  数据正常回调
 *  @param errorBlock 数据错误回调
 *  @param failBlock  失败错误回调
 */
- (void)postUrl:(NSString *)url params:(NSDictionary *)paramsDic successBlock:(Success)succBlock errorBlock:(Error)errorBlock failBlock:(Fail)failBlock {
    
    // 网络被禁用
    if ([NetWorkTools isDisabledNetWork]) {
        return;
    }
    
    // 网络请求开始
    [self startNetworkActivity];
    
    NSDictionary *buildParamsDict = [self buildParams:paramsDic];
    
    [self.manager POST:[self httpBindUrl:url] parameters:buildParamsDict success: ^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 网络请求结束
        [self stopNetworkActivity];
        
        NSString *status = [responseObject objectForKey:@"status"];
        
        if (![status isEqualToString: @"error"]) {
            // 数据正常
            succBlock(operation,responseObject);
        } else {
            // 错误处理
            errorBlock(operation,responseObject);
            ANLog(@"%@", [responseObject toNSString]);
        }
        
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        // 网络请求结束
        [self stopNetworkActivity];
        
        failBlock(operation,error);
        ANLog( @"接口错误信息: %@" , error);
        ANLog( @"接口原装数据: %@" , operation.responseString);
    }];
}

/**
 *  上传图片
 *
 *  @param url         请求的URL
 *  @param paramsDic   提交的参数
 *  @param image       上传的图片
 *  @param compression 图片的压缩质量
 *  @param succBlock  数据正常回调
 *  @param errorBlock 数据错误回调
 *  @param failBlock  失败错误回调
 */
- (void)post:(NSString *)url params:(NSDictionary *)paramsDic image:(UIImage *)image compression:(CGFloat)compression successBlock:(Success)succBlock errorBlock:(Error)errorBlock failBlock:(Fail)failBlock {
    
    // 网络被禁用
    if ([NetWorkTools isDisabledNetWork]) {
        return;
    }
    
    // 网络请求开始
    [self startNetworkActivity];
    
    // 3.发送请求
    [self.manager POST:[self httpBindUrl:url] parameters:paramsDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) { // 在发送请求之前调用这个block
        // 必须在这里说明要上传哪些文件
        NSData *data = UIImageJPEGRepresentation(image, compression);
//        NSString *encodeResult = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        [formData appendPartWithFileData:data name:@"pic" fileName:@"" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 网络请求结束
        [self stopNetworkActivity];
        
        NSString *status = [responseObject objectForKey:@"status"];
        
        if (![status isEqualToString: @"error"]) {
            // 数据正常
            succBlock(operation,responseObject);
        } else {
            // 错误处理
            errorBlock(operation,responseObject);
            ANLog(@"%@", [responseObject toNSString]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 网络请求结束
        [self stopNetworkActivity];
        
        failBlock(operation,error);
        ANLog( @"接口错误信息: %@" , error);
        ANLog( @"接口原装数据: %@" , operation.responseString);
    }];
    
}

/**
 *  上传图片
 *
 *  @param url         请求的URL
 *  @param paramsDic   提交的参数
 *  @param image       上传的图片
 *  @param compression 图片的压缩质量
 *  @param succBlock  数据正常回调
 *  @param errorBlock 数据错误回调
 *  @param failBlock  失败错误回调
 */
- (void)postUrl:(NSString *)url params:(NSDictionary *)paramsDic image:(UIImage *)image compression:(CGFloat)compression successBlock:(Success)succBlock errorBlock:(Error)errorBlock failBlock:(Fail)failBlock
{
    // 网络被禁用
    if ([NetWorkTools isDisabledNetWork]) {
        return;
    }
    
    // 网络请求开始
    [self startNetworkActivity];
    
    NSDictionary *buildParamsDict = [self buildParams:paramsDic];
    
    // 3.发送请求
    [self.manager POST:[self httpBindUrl:url] parameters:buildParamsDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) { // 在发送请求之前调用这个block
        // 必须在这里说明要上传哪些文件
        NSData *data = UIImageJPEGRepresentation(image, compression);
        //        NSString *encodeResult = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        [formData appendPartWithFileData:data name:@"pic" fileName:@"" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 网络请求结束
        [self stopNetworkActivity];
        
        NSString *status = [responseObject objectForKey:@"status"];
        
        if (![status isEqualToString: @"error"]) {
            // 数据正常
            succBlock(operation,responseObject);
        } else {
            // 错误处理
            errorBlock(operation,responseObject);
            ANLog(@"%@", [responseObject toNSString]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 网络请求结束
        [self stopNetworkActivity];
        
        failBlock(operation,error);
        ANLog( @"接口错误信息: %@" , error);
        ANLog( @"接口原装数据: %@" , operation.responseString);
    }];
    
}


/**
 *  get 请求
 *
 *  @param url        请求的URL
 *  @param paramsDic  请求的参数
 *  @param succBlock  数据正常回调
 *  @param errorBlock 数据错误回调
 *  @param failBlock  失败错误回调
 */
- (void)get:(NSString *)url params:(NSDictionary *)paramsDic successBlock:(Success)succBlock errorBlock:(Error)errorBlock failBlock:(Fail)failBlock {
    
    // 网络被禁用
    if ([NetWorkTools isDisabledNetWork]) {
        return;
    }
    
    // 网络请求开始
    [self startNetworkActivity];
    
    [self.manager GET:[self httpBindUrl:url] parameters:paramsDic success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 网络请求结束
        [self stopNetworkActivity];
        
        NSString *status = [responseObject objectForKey:@"status"];
        
        if (![status isEqualToString: @"error"]) {
            // 数据正常
            succBlock(operation,responseObject);
        } else {
            // 错误处理
            errorBlock(operation,responseObject);
            ANLog(@"%@", [responseObject toNSString]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 网络请求结束
        [self stopNetworkActivity];
        
        failBlock(operation,error);
        ANLog( @"接口错误信息: %@" , error);
        ANLog( @"接口原装数据: %@" , operation.responseString);
    }];
}


/**
 *  get 请求
 *
 *  @param url        请求的URL
 *  @param paramsDic  请求的参数
 *  @param succBlock  数据正常回调
 *  @param errorBlock 数据错误回调
 *  @param failBlock  失败错误回调
 */
- (void)getUrl:(NSString *)url params:(NSDictionary *)paramsDic successBlock:(Success)succBlock errorBlock:(Error)errorBlock failBlock:(Fail)failBlock {
    
    // 网络被禁用
    if ([NetWorkTools isDisabledNetWork]) {
        return;
    }
    
    // 网络请求开始
    [self startNetworkActivity];
    
    NSDictionary *buildParamsDict = [self buildParams:paramsDic];
    
    [self.manager GET:[self httpBindUrl:url] parameters:buildParamsDict success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 网络请求结束
        [self stopNetworkActivity];
        
        NSString *status = [responseObject objectForKey:@"status"];
        
        if (![status isEqualToString: @"error"]) {
            // 数据正常
            succBlock(operation,responseObject);
        } else {
            // 错误处理
            errorBlock(operation,responseObject);
            ANLog(@"%@", [responseObject toNSString]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 网络请求结束
        [self stopNetworkActivity];
        
        failBlock(operation,error);
        ANLog( @"接口错误信息: %@" , error);
        ANLog( @"接口原装数据: %@" , operation.responseString);
    }];
}
/**
 *  组合完整的URL
 *
 *  @param url 短路径
 *
 */
- (NSString *)httpBindUrl:(NSString *) url {
    return [NSString stringWithFormat:@"%@/%@", HOSTURL, url];
}

/**
 *  补全参数所需要的必要参数
 *
 *  @param dict <#dict description#>
 *
 *  @return <#return value description#>
 */
- (NSDictionary *) buildParams:(NSDictionary *)dict;
{
    
    NSString *time = [NSDate getTime];
    
    // 缺少了ksort 排序悲剧，加密参数排序之后，就更好了。
    
    NSArray  *arr  = [dict allValues];
    
    NSString *sign = [Common paramsSign:arr];
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       time, @"time",
                                       sign, @"sign",
                                       PLATFORMID, @"app_id", nil];
    
    
    NSArray *keys = [dict allKeys];
    for (int i = 0; i < keys.count; i++) {
        
        NSString *key = keys[i];
        NSString *val = [dict objectForKey:key];
        
        // 组合参数
        [mutableDict setObject:val forKey:key];
    }

    return mutableDict;
}
@end
