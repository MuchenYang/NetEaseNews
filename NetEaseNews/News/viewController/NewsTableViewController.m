//
//  NewsTableViewController.m
//  NetEaseNews
//
//  Created by Xuwei Yang on 16/7/19.
//  Copyright © 2016年 Xuwei Yang. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"


@interface NewsTableViewController ()

// 数据源数组
@property (nonatomic,strong) NSArray *dataArr;

@end

@implementation NewsTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUrlstr:(NSString *)urlstr{
    
   // _urlstr = urlstr;
    [NewsModel downloadWithUrlstr:urlstr successBlock:^(NSArray *arr) {
        
        // 在这里给数据源数组赋值,
        self.dataArr = arr;
        // 拿到数据源数组之后,就手动刷新一遍列表
        [self.tableView reloadData];
        
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NewsModel *model = self.dataArr[indexPath.row];
    
    
    NSString *identifier;
    if (model.imgType) {
        identifier = @"bigCell";
    }else if(model.imgextra.count == 2){
         identifier = @"ImagesCell";
    }else{
        identifier = @"baseCell";
    }
    
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.model = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewsModel *model = self.dataArr[indexPath.row];
    
    if (model.imgType) {
        return 180;
    }else if(model.imgextra.count == 2){
        return 150;
    }else{
        return 80;
    }
}

@end









