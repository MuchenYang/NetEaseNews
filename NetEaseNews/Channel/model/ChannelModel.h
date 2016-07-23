//
//  ChannelModel.h
//  NetEaseNews
//
//  Created by Xuwei Yang on 16/7/19.
//  Copyright © 2016年 Xuwei Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelModel : NSObject

@property (nonatomic, copy) NSString *tname;
@property (nonatomic, copy) NSString *tid;

+(NSArray *)channels;

@end
