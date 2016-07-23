//
//  ChannelModel.m
//  NetEaseNews
//
//  Created by Xuwei Yang on 16/7/19.
//  Copyright © 2016年 Xuwei Yang. All rights reserved.
//

#import "ChannelModel.h"

@implementation ChannelModel

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@",_tid,_tname];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSArray *)channels{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"topic_news.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    NSArray *arr = [dic objectForKey:@"tList"];
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ChannelModel *model = [self channelWithDic:obj];
        [arrM addObject:model];
    }];
    
    [arrM sortUsingComparator:^NSComparisonResult(ChannelModel * obj1, ChannelModel * obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
    
    return arrM.copy;
}

+(instancetype)channelWithDic:(NSDictionary *)dic
{
    ChannelModel *model = [[ChannelModel alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

@end
