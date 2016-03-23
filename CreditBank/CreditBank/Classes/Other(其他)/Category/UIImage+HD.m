//
//  UIImage+HD.m
//  hudongweibo
//
//  Created by Eric on 15/3/19.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "UIImage+HD.h"
#import "PrefixHeader.pch"

@implementation UIImage (HD)

+ (UIImage *)imageWithName:(NSString *)name
{
    if (iOS7) {
        NSString *newName = [name stringByAppendingString:@"_os7"];
        UIImage *image = [UIImage imageNamed:newName];
        if (image == nil) {// 没有_os7后缀的图片
            image = [UIImage imageNamed:name];
        }
        return image;
    }
    // 非iOS7
    return [UIImage imageNamed:name];
}


+ (UIImage *)resizedImageWithName:(NSString *)name
{
    UIImage *image = [self imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}


+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [self imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

@end
