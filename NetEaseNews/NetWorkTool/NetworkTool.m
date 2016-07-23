//
//  NetworkTool.m
//  网易新闻5
//
//  Created by zhangjie on 16/6/9.
//  Copyright © 2016年 haoxu. All rights reserved.
//

#import "NetworkTool.h"

@implementation NetworkTool

+ (instancetype)sharedNetworkTool
{
    static NetworkTool *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *baseURL = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        instance = [[NetworkTool alloc] initWithBaseURL:baseURL];
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return instance;
}

@end
