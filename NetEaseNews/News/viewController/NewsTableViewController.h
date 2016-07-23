//
//  NewsTableViewController.h
//  NetEaseNews
//
//  Created by Xuwei Yang on 16/7/19.
//  Copyright © 2016年 Xuwei Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewController : UITableViewController

// 接收HomeCollectionViewCell传入的urlstr
@property (nonatomic,copy) NSString *urlstr;

@end
