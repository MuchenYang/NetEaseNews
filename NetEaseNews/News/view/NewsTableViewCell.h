//
//  NewsTableViewCell.h
//  NetEaseNews
//
//  Created by Xuwei Yang on 16/7/19.
//  Copyright © 2016年 Xuwei Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NewsTableViewCell : UITableViewCell

/// 接收新闻VC传入的新闻模型
@property (nonatomic,strong)NewsModel *model;

@end
