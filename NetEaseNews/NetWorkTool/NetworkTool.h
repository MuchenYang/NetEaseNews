//
//  NetworkTool.h
//  网易新闻5
//
//  Created by zhangjie on 16/6/9.
//  Copyright © 2016年 haoxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface NetworkTool : AFHTTPSessionManager

+ (instancetype)sharedNetworkTool;

@end
