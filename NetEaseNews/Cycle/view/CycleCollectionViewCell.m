//
//  CycleCollectionViewCell.m
//  NetEaseNews
//
//  Created by Xuwei Yang on 16/7/21.
//  Copyright © 2016年 Xuwei Yang. All rights reserved.
//

#import "CycleCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface CycleCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgsrcImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@end


@implementation CycleCollectionViewCell

- (void)setModel:(CycleModel *)model
{
    _model = model;
    //轮播图图片
    [self.imgsrcImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    //轮播图title
    self.titleLable.text = model.title;
}


@end
