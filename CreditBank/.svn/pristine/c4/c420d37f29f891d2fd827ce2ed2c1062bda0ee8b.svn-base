//
//  AnRequest.h
//  CreditBank
//
//  Created by Eric on 15/4/9.
//  Copyright (c) 2015年 Eric. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class AFHTTPRequestOperation;

/**
 *  接口请求成功回调
 *
 *  @param obj 回调的字典对象
 */
typedef void (^Success)(AFHTTPRequestOperation *operation, id responseObject);
/**
 *  接口请求失败回调
 *
 *  @param obj 回调的字典对象
 */
typedef void (^Error)(AFHTTPRequestOperation *operation, id responseObject);
/**
 *  接口请求失败回调
 *
 *  @param obj 回调的字典对象
 */
typedef void (^Fail)(AFHTTPRequestOperation *operation, NSError *error);


@interface AnRequest : NSObject

/**
*  post 请求
*
*  @param url        请求的URL
*  @param paramsDic  请求的参数
*  @param succBlock  数据正常回调
*  @param errorBlock 数据错误回调
*  @param failBlock  失败错误回调
*/
- (void)post:(NSString *)url params:(NSDictionary *)paramsDic successBlock:(Success) succBlock errorBlock:(Error) errorBlock failBlock:(Fail) failBlock;
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
- (void)post:(NSString *)url params:(NSDictionary *)paramsDic image:(UIImage *)image compression:(CGFloat)compression successBlock:(Success)succBlock errorBlock:(Error)errorBlock failBlock:(Fail)failBlock;
/**
 *  get 请求
 *
 *  @param url        请求的URL
 *  @param paramsDic  请求的参数
 *  @param succBlock  数据正常回调
 *  @param errorBlock 数据错误回调
 *  @param failBlock  失败错误回调
 */
- (void)get:(NSString *)url params:(NSDictionary *)paramsDic successBlock:(Success) succBlock errorBlock:(Error) errorBlock failBlock:(Fail) failBlock;
/**
 *  拼接完整的URL
 *
 *  @param url 需要拼合的URL
 *
 *  @return 返回完整的URL
 */
- (NSString *)httpBindUrl:(NSString *) url;

/**
 *  POSTURL 请求，部分关键参数即可
 *
 *  @param url        请求的URL
 *  @param paramsDic  请求的参数
 *  @param succBlock  数据正常回调
 *  @param errorBlock 数据错误回调
 *  @param failBlock  失败错误回调
 */
- (void)postUrl:(NSString *)url params:(NSDictionary *)paramsDic successBlock:(Success)succBlock errorBlock:(Error)errorBlock failBlock:(Fail)failBlock;
/**
 *  POSTURL 请求，部分关键参数即可
 *
 *  @param url        请求的URL
 *  @param paramsDic  请求的参数
 *  @param succBlock  数据正常回调
 *  @param errorBlock 数据错误回调
 *  @param failBlock  失败错误回调
 */
- (void)postUrl:(NSString *)url params:(NSDictionary *)paramsDic image:(UIImage *)image compression:(CGFloat)compression successBlock:(Success)succBlock errorBlock:(Error)errorBlock failBlock:(Fail)failBlock;

/**
 *  get 请求
 *
 *  @param url        请求的URL
 *  @param paramsDic  请求的参数
 *  @param succBlock  数据正常回调
 *  @param errorBlock 数据错误回调
 *  @param failBlock  失败错误回调
 */
- (void)getUrl:(NSString *)url params:(NSDictionary *)paramsDic successBlock:(Success)succBlock errorBlock:(Error)errorBlock failBlock:(Fail)failBlock;

@end
