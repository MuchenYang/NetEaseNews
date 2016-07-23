//
//  NewsTableViewCell.m
//  NetEaseNews
//
//  Created by Xuwei Yang on 16/7/19.
//  Copyright © 2016年 Xuwei Yang. All rights reserved.
//

#import "NewsTableViewCell.h"
#import <UIImageView+WebCache.h>


@interface NewsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgsrcImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *sourceLable;
@property (weak, nonatomic) IBOutlet UILabel *replaycountLable;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgsrcImageViews;


@end

@implementation NewsTableViewCell

- (void)setModel:(NewsModel *)model{

    _model = model;
    
    [self.imgsrcImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    self.titleLable.text = model.title;
    self.sourceLable.text = model.source;
    self.replaycountLable.text = [NSString stringWithFormat:@"%@",model.replyCount];
    
    for (int i = 0; i < model.imgextra.count; i ++) {
        
        UIImageView *img = self.imgsrcImageViews[i];
        NSDictionary *dic = model.imgextra[i];
        NSString *imgsrc = [dic objectForKey:@"imgsrc"];
        [img sd_setImageWithURL:[NSURL URLWithString:imgsrc]];
    }
}
@end
