//
//  NewsModel.m
//  NetEaseNews
//
//  Created by Xuwei Yang on 16/7/19.
//  Copyright © 2016年 Xuwei Yang. All rights reserved.
//

#import "NewsModel.h"
#import "NetworkTool.h"

@implementation NewsModel

+ (instancetype)newsModelWithDict:(NSDictionary *)dict
{
    NewsModel *model = [[NewsModel alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

//网络请求的方法
+(void)downloadWithUrlstr:(NSString *)urlstr successBlock:(void(^)(NSArray *arr))successBlock failureBlock:(void(^)(NSError *error))failureBlock{
    
    [[NetworkTool sharedNetworkTool]GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"%@",responseObject);
        NSDictionary *dic = responseObject;
        NSString *key = dic.keyEnumerator.nextObject;
        
        //        [dic.allKeys lastObject];
        //        NSLog(@"key %@",key);
        NSArray *arr = [dic objectForKey:key];
        //可变数组
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
        //遍历arr
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NewsModel *model = [self newsModelWithDict:obj];
            [arrM addObject:model];
        }];
        
        if (successBlock) {
            successBlock(arrM.copy);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failureBlock) {
            failureBlock(error);
        }
        
    }];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ -- %@",self.title,self.source];
}

@end
