//
//  CycleModel.m
//  NetEaseNews
//
//  Created by Xuwei Yang on 16/7/21.
//  Copyright © 2016年 Xuwei Yang. All rights reserved.
//

#import "CycleModel.h"
#import "NetworkTool.h"

@implementation CycleModel

+ (instancetype)CycleModelWithDic:(NSDictionary *)dic{

    CycleModel *model = [[CycleModel alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

+ (void)loadCycleModelDataWithUrlstr:(NSString *)urlstr successBlock:(void(^)(NSArray *listArr))successBlock failBlack:(void(^)(NSError *error))failBlock{

    [[NetworkTool sharedNetworkTool]GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        NSString *key = responseObject.keyEnumerator.nextObject;
        NSArray *arr = [responseObject objectForKey:key];
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
        
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CycleModel *modle = [self CycleModelWithDic:obj];
            [arrM addObject:modle];
        }];
        
        if (successBlock) {
            successBlock(arrM.copy);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failBlock) {
            failBlock(error);
        }
    }];


}
@end
