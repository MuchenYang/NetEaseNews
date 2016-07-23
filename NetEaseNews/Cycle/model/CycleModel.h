//
//  CycleModel.h
//  NetEaseNews
//
//  Created by Xuwei Yang on 16/7/21.
//  Copyright © 2016年 Xuwei Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CycleModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imgsrc;

+ (void)loadCycleModelDataWithUrlstr:(NSString *)urlstr successBlock:(void(^)(NSArray *listArr))successBlock failBlack:(void(^)(NSError *error))failBlock;

@end
