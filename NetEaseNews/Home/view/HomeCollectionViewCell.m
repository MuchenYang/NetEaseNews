//
//  HomeCollectionViewCell.m
//  NetEaseNews
//
//  Created by Xuwei Yang on 16/7/19.
//  Copyright © 2016年 Xuwei Yang. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "NewsTableViewController.h"

@interface HomeCollectionViewCell ()

@property (nonatomic,strong) NewsTableViewController *newsVC;
@end

@implementation HomeCollectionViewCell

- (void)awakeFromNib{

    UIStoryboard *newsStoryboard = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    
    self.newsVC = [newsStoryboard instantiateInitialViewController];
    self.newsVC.tableView.frame = self.contentView.bounds;
    self.newsVC.tableView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.newsVC.tableView];
}

/// 重写主页传入的URLString的setter方法
- (void)setUrlstr:(NSString *)urlstr
{
    _urlstr = urlstr;
    
    self.newsVC.urlstr = urlstr;
}

@end
