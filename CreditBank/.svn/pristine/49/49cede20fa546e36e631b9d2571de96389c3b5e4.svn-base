//
//  NSDictionary+Expand.m
//  CreditBank
//
//  Created by Eric on 15/4/10.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "NSDictionary+Expand.h"

@implementation NSDictionary (Expand)
// log NSSet with UTF8
- (NSString *) toNSString{
    
    if (![self count]) {
        return nil;
    }
    
    NSString *tempStr1 =
    [[self description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}
@end
