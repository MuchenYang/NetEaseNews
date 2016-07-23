//
//  HomeViewController.m
//  NetEaseNews
//
//  Created by Xuwei Yang on 16/7/19.
//  Copyright © 2016年 Xuwei Yang. All rights reserved.
//

#import "HomeViewController.h"
#import "ChannelLable.h"
#import "ChannelModel.h"
#import "HomeCollectionViewCell.h"

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *ChannelScollView;
@property (weak, nonatomic) IBOutlet UICollectionView *NewsCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@property (strong, nonatomic) NSArray *dataArr;
//标签数组
@property (nonatomic, strong) NSMutableArray *labM;
@end

@implementation HomeViewController

- (NSArray *)dataArr{
    
    if (_dataArr == nil) {
        _dataArr = [ChannelModel channels];
    }
    return _dataArr;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //设置item的大小
    self.flowLayout.itemSize = self.NewsCollectionView.bounds.size;
}


- (void)viewDidLoad {
    [super viewDidLoad];
     self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatChannelLable];
}

- (void)creatChannelLable{

    CGFloat lableH = self.ChannelScollView.bounds.size.height;
    CGFloat lableW = 80;
    for (int i = 0; i < self.dataArr.count; i++) {
        ChannelLable *lable = [[ChannelLable alloc]init];
        lable.frame = CGRectMake(lableW * i, 0, lableW, lableH);
        [self.ChannelScollView addSubview:lable];
        ChannelModel *model = self.dataArr[i];
        lable.text = model.tname;
        lable.tag = i;
        self.ChannelScollView.contentSize = CGSizeMake(lableW * self.dataArr.count, 0);
        lable.userInteractionEnabled = YES;
        UITapGestureRecognizer *lableTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLable:)];
        [lable addGestureRecognizer:lableTap];
        //把lab添加到频道数组里面
        [self.labM addObject:lable];
        
        // 创建标签时,默认把第0个标签缩放到最大
        if (i == 0) {
            lable.scale = 1.0;
        }
    }
}

//lable的点击事件
- (void)clickLable:(UITapGestureRecognizer *)lableTap
{
    ChannelLable *selectedLable = (ChannelLable *)lableTap.view;
    CGFloat labelOffsetX = selectedLable.center.x - (self.view.bounds.size.width * 0.5);
    CGFloat maxOffsetX = self.ChannelScollView.contentSize.width - self.view.bounds.size.width;
     CGFloat minOffsetX = 0;
    // 判断偏移量的临界值
    if (labelOffsetX < minOffsetX) {
        labelOffsetX = 0;
    } else if (labelOffsetX > maxOffsetX) {
        labelOffsetX = maxOffsetX;
    }
    
    // 设置频道滚动视图的滚动
    [self.ChannelScollView setContentOffset:CGPointMake(labelOffsetX, 0) animated:YES];
    
#pragma mark - 点击频道标签剧中时,collectionView也跟着联动
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:selectedLable.tag inSection:0];
    [self.NewsCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];

    
#pragma mark - 点击label时选中的缩放比例最大,其余的保持
    // 获取选中label的tag
    NSInteger index = selectedLable.tag;
    for (int i = 0; i < self.labM.count; ++i) {
        // 遍历出所有的label
        ChannelLable *lable = self.labM[i];
        // 把选中的缩放到最大
        if (index == i) {
            lable.scale = 1.0;
        } else {
            lable.scale = 0;
        }
    }

}


#pragma mark - 监听底部conllectionView的滚动 : 实时滚动的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat W = self.view.bounds.size.width;
    
    // 获取浮点数的索引
    CGFloat index_float = offsetX / W;
    
    // 整数整型索引
    NSInteger index = offsetX / W;
    
    // 浮点数的索引 减 整型的索引 = 百分比
    CGFloat percent = index_float - index;
    //    NSLog(@"浮点数索引=%f 整型索引=%zd 百分比=%f",index_float,index,percent);
    
    // 要实现左右滚动的缩放,需要确定四个值 : 左边的索引,右边的索引,左边的缩放比,右边的缩放比
    
    // 左边的索引,就是当前的索引
    NSInteger left_index = index;
    // 右边的索引,就是左边的索引加1
    NSInteger right_index = left_index + 1;
    
    // 右边的缩放比
    CGFloat right_scale = percent;
    // 左边的缩放比
    CGFloat left_scale = 1 - right_scale;
    
    NSLog(@"左边索引=%zd 左边缩放比=%f 右边=索引%zd 右边缩放比=%f",left_index,left_scale,right_index,right_scale);
    
    // 取出左边索引对应的标签,设置对应的缩放比
    ChannelLable *left_label = self.labM[left_index];
    left_label.scale = left_scale;
    // 取出右边索引对应的标签,设置对应的缩放比
    if (right_index < self.labM.count) {
        ChannelLable *right_Label = self.labM[right_index];
        right_Label.scale = right_scale;
    }
}





#pragma mark - 监听底部conllectionView的滚动 : 滚动结束的代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算滚动到第几个索引
    NSInteger index = scrollView.contentOffset.x /scrollView.bounds.size.width;
    //根据标签去找lab
    ChannelLable *lab = self.labM[index];
    
    //lab滚动的偏移量
    CGFloat labOffSetX = lab.center.x - self.view.bounds.size.width/2;
    // 限制最大和最小的偏移量
    CGFloat minOffsetX = 0;
    CGFloat maxOffsetX = self.ChannelScollView.contentSize.width - self.view.bounds.size.width;
    
    if (labOffSetX < minOffsetX) {
        labOffSetX = 0;
    }else if(labOffSetX > maxOffsetX)
    {
        labOffSetX = maxOffsetX;
    }
    
    //真正的滚动channelScollview
    [self.ChannelScollView setContentOffset:CGPointMake(labOffSetX, 0) animated:YES];
    
    
}

//collectionView的数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
    ChannelModel *model = self.dataArr[indexPath.item];
    NSString *urlstr = [NSString stringWithFormat:@"article/headline/%@/0-20.html",model.tid];
    cell.urlstr = urlstr;
    return cell;
}

- (NSMutableArray *)labM
{
    if (_labM == nil) {
        _labM = [NSMutableArray array];
    }
    return _labM;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
